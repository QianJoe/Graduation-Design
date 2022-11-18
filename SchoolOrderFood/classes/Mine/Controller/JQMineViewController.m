//
//  JQMineViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/5.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQMineViewController.h"
#import "JQMineHeadView.h"
#import "JQOrderFoodHeadView.h"
#import "JQMenuView.h"
#import "JQTitleIconAction.h"
#import "JQPageScrollView.h"
#import "JQPageData.h"
#import <MJExtension/MJExtension.h>
#import "JQLoginRegisterViewController.h"
#import "JQSettingTableViewController.h"
#import "JQMineShopModel.h"
#import "PCH.h"
#import "JQUserTool.h"
#import "JQUser.h"

@interface JQMineViewController () <JQMineHeadViewDelegate>

/**headView*/
@property (nonatomic, weak) JQMineHeadView *headView;
/**中间滚动的View*/
@property (nonatomic, weak) UIScrollView *mainScrollView;

/**中间头view*/
@property (nonatomic, weak) JQOrderFoodHeadView *orderFoodHeadView;
/**订餐菜单*/
@property (nonatomic, weak) JQMenuView *orderMenuView;
@property (nonatomic, weak) JQMenuView *mineMenuView;

/**用底部轮播器的*/
@property (nonatomic, weak) UIView *footerView;
/**pageview*/
@property (nonatomic, weak) JQPageScrollView *pageView;

/**数据模型*/
@property (nonatomic, strong) NSArray<JQTitleIconAction *> *orderMenus;
@property (nonatomic, strong) NSArray<JQTitleIconAction *> *mineMenus;

/**pagedata*/
@property (nonatomic, strong) JQPageData *pageData;

/**昵称*/
@property (nonatomic, copy) NSString *username;
/**头像url*/
@property (nonatomic, copy) NSString *headImgUrl;

@end

@implementation JQMineViewController

#pragma mark - 订单的数据模型数组
- (NSArray<JQTitleIconAction *> *)orderMenus{
    
    if (!_orderMenus) {
        _orderMenus = @[
                       [JQTitleIconAction titleIconWith:@"待取餐" icon:[UIImage imageNamed:@"icon_daishouhuo"] controller:self tag:0],
                       [JQTitleIconAction titleIconWith:@"待评价" icon:[UIImage imageNamed:@"icon_daipingjia"] controller:self tag:1],
                       [JQTitleIconAction titleIconWith:@"星期单" icon:[UIImage imageNamed:@"icon_bangdai"] controller:self tag:2]
                        ];
    }
    return _orderMenus;
}

#pragma mark - 我的的数据模型数组
- (NSArray<JQTitleIconAction *> *)mineMenus{
    
    if (!_mineMenus) {
        _mineMenus = @[
                       [JQTitleIconAction titleIconWith:@"我的代送" icon:[UIImage imageNamed:@"v2_my_address_icon"] controller:self tag:3],
                       [JQTitleIconAction titleIconWith:@"代送列表" icon:[UIImage imageNamed:@"icon_daisong_list"] controller:self tag:4],
                       [JQTitleIconAction titleIconWith:@"意见反馈" icon:[UIImage imageNamed:@"v2_my_feedback_icon"] controller:self tag:5],
                       [JQTitleIconAction titleIconWith:@"我的餐店" icon:[UIImage imageNamed:@"icon_mystore"] controller:self tag:6],
                       [JQTitleIconAction titleIconWith:@"分享给朋友" icon:[UIImage imageNamed:@"icon_share"] controller:self tag:7],
                       [JQTitleIconAction titleIconWith:@"帮助中心" icon:[UIImage imageNamed:@"icon_help"] controller:self tag:8]
                        ];
    }
    return _mineMenus;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
    IMP_BLOCK_SELF(JQMineViewController);
    
    [self loadHeadData:^{
        
        block_self.headView.username = block_self.username;
    }];
    
//    [self loadJSONData:^{
    
    // 发送get请求
    JQHttpRequestTool *httpTool = [JQHttpRequestTool shareHttpRequestTool];
    
    // get头热门和首页轮播器图片的数据
    [httpTool requestWithMethod:GET andUrlString:JQOrderSchoolFoodMinePageDataURL andParameters:nil andFinished:^(id response, NSError *error) {
        
        NSString *result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        JQLOG(@"%@", result);
        
        // 转成字典
        NSDictionary *dataDictionary = [result dictionaryWithJsonString:result];
        
        NSDictionary *pageDataDict = dataDictionary[@"pageData"];
        
        JQPageData *pageDataModel = [JQPageData mj_objectWithKeyValues:pageDataDict];
        block_self.pageData = pageDataModel;
        
        block_self.pageView.images = block_self.pageData.imgs;
        
    }];
    
//    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建headview
    [self buildHeadView];
    
    // 创建中间的view
    [self buildMainScrollView];
    
    // 创建底部轮播器
    [self buildFooterView];
    
//    // 加载数据
//    [self loadJSONData:^{
//       
////        JQLOG(@"%@", self.pageData.imgs);
//        self.pageView.images = self.pageData.imgs;
//    }];
}

#pragma mark - 创建headview
- (void)buildHeadView {
    
    JQMineHeadView *headView = [[JQMineHeadView alloc] init];
    headView.delegate = self;
    self.headView = headView;
    [self.view addSubview:headView];
    
    [headView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(200);
    }];
}

#pragma mark - 创建中间的view
- (void)buildMainScrollView {
    
    UIScrollView *mainScrollView = [[UIScrollView alloc] init];
    self.mainScrollView = mainScrollView;
    [self.view addSubview:mainScrollView];
    
    [mainScrollView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headView.bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-49);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    [mainScrollView addSubview:contentView];
    
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.mainScrollView);
        make.width.equalTo(self.mainScrollView);
    }];
    
    JQOrderFoodHeadView *orderFoodHeadView = [[JQOrderFoodHeadView alloc]init];
    self.orderFoodHeadView = orderFoodHeadView;
    [self.mainScrollView addSubview:orderFoodHeadView];
    
    [orderFoodHeadView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mainScrollView).offset(10);
        make.leading.trailing.equalTo(self.mainScrollView);
        make.height.equalTo(40);
    }];
    
    JQMenuView *orderMenuView = [JQMenuView menuViewWithMenus:self.orderMenus WithLine:NO];
    self.orderMenuView = orderMenuView;
    [contentView addSubview:orderMenuView];
    
    [orderMenuView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(orderFoodHeadView.bottom).offset(1);
        make.left.right.equalTo(contentView);
        make.height.equalTo(75);
    }];
    
    JQMenuView *mineMenuView = [JQMenuView menuViewWithMenus:self.mineMenus WithLine:YES];
    self.mineMenuView = mineMenuView;
    [contentView addSubview:mineMenuView];
    
    [mineMenuView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(orderMenuView.bottom).offset(15);
        make.left.right.equalTo(contentView);
        make.height.equalTo(150);
    }];
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor whiteColor];
    self.footerView = footerView;
    [contentView addSubview:footerView];
    
    [footerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mineMenuView.bottom).offset(20);
        make.left.right.equalTo(contentView);
        make.height.equalTo(150);
    }];
    
    // 根据footerview更新content的底部约束
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(footerView);
    }];
}

- (void)buildFooterView{
    
    NSArray *pageImgs = @[
                          @"",
                          @"",
                          @""
                          ];
    JQPageScrollView *pageView = [JQPageScrollView pageScroller:pageImgs placeHolderImage:[UIImage imageNamed:@"lunboqi"]];
    
    self.pageView = pageView;
    [self.footerView addSubview:pageView];
    
    [pageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.footerView).offset(6);
        make.left.equalTo(self.footerView).offset(10);
        make.right.equalTo(self.footerView).offset(-10);
        make.centerY.equalTo(self.footerView);
        make.height.equalTo(self.footerView.width).multipliedBy(0.37);
        
    }];
}

#pragma mark - 异步加载用户数据
- (void)loadHeadData:(void(^)()) then {
    
    IMP_BLOCK_SELF(JQMineViewController);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        JQUser *user = [JQUserTool getUserWithUnarchive];
        
        if (user != nil) {
            
            block_self.username = user.account;
        } else {
            
            block_self.username = @"未登录";
        }
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !then ? : then();
        });
    });
}

#pragma mark - 异步加载数据
- (void)loadJSONData:(void(^)()) then {
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
#warning 现在是模拟的json数据
        /********************************滚动条*****************************************/
        // 读取json数据
        NSString *pageDataFilePath =[[NSBundle mainBundle] pathForResource:@"MinePageData" ofType:@"json"];
        
        NSData *pageData = [NSData dataWithContentsOfFile:pageDataFilePath];
        
        NSDictionary *pageDataDictionary = [NSJSONSerialization JSONObjectWithData:pageData options: NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *pageDataDict = pageDataDictionary[@"pageData"];
        
        JQPageData *pageDataModel = [JQPageData mj_objectWithKeyValues:pageDataDict];
        weakSelf.pageData = pageDataModel;
        
        
        /****************************我的餐厅**********************************************/
        //        NSString *mineShopDataFilePath =[[NSBundle mainBundle] pathForResource:@"MineShopData" ofType:@"json"];
        //
        //        // 获取二进制数据
        //        NSData *mineShopData = [NSData dataWithContentsOfFile:mineShopDataFilePath];
        //
        //        // 转成字典
        //        NSDictionary *mineShopDataDictionary = [NSJSONSerialization JSONObjectWithData:mineShopData options: NSJSONReadingAllowFragments error:nil];
        //
        //        JQMineShopModel *msModel = [JQMineShopModel mj_objectWithKeyValues:mineShopDataDictionary];
        //
        //        weakSelf.mineShopModel = msModel;
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !then ? : then();
        });
    });
}

#pragma mark - JQMineHeadViewDelegate
- (void)mineHeadView:(JQMineHeadView *)mineHeadView clickWithTap:(UITapGestureRecognizer *)tap {
    
    if ([self.headView.username isEqualToString:@"未登录"]) {
        
        JQLoginRegisterViewController *loginVC = [[JQLoginRegisterViewController alloc] init];
        
        [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    }
    
    return;
    
}

- (void)mineHeadViewClickSetting:(JQMineHeadView *)mineHeadView {
    
    JQSettingTableViewController *settingTbVC = [[JQSettingTableViewController alloc] init];
    settingTbVC.title = @"设置";
    
    [self.navigationController pushViewController:settingTbVC animated:YES];
}

@end
