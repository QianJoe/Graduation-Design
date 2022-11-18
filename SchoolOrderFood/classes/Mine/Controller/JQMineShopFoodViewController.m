//
//  JQMineShopFoodViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/5.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQMineShopFoodViewController.h"
#import <MJExtension/MJExtension.h>
#import "JQFoodTotalModel.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import "JQMineShopFoodTableViewCell.h"
#import "JQMineShopFoodManagementViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface JQMineShopFoodViewController () <UITableViewDataSource, UITableViewDelegate>

/**tableview*/
@property (nonatomic, weak) UITableView *tableView;

/**总的数据*/
@property (nonatomic, strong) NSMutableArray *dataListM;

@end

@implementation JQMineShopFoodViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    __weak typeof (self) weakSelf = self;
    
    [SVProgressHUD showWithStatus:@"加载中"];
    
    // 异步加载出
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [weakSelf loadJSONData:^{
            
            [weakSelf.tableView reloadData];
            
        }];
        
        [SVProgressHUD dismiss];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    
    
}

#pragma mark - 初始化tableview
- (void)initTableView {
    
    UITableView *tableView = [[UITableView alloc] init];
    [tableView registerClass:[JQMineShopFoodTableViewCell class] forCellReuseIdentifier:MINESHOPFOODTBVCELLID];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    //    tableView.rowHeight = 80;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(10);
        make.left.right.bottom.equalTo(self.view);
    }];
}


#pragma mark - uitableview的数据源和代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataListM.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQMineShopFoodManagementViewController *msfmVC = [[JQMineShopFoodManagementViewController alloc] init];
    msfmVC.foodTotalModel = self.dataListM[indexPath.row];
    
    [self presentViewController:msfmVC animated:YES completion:nil];
//    UINavigationController *na = [[UINavigationController alloc] init];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQMineShopFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MINESHOPFOODTBVCELLID];
    
    // 设置数据模型
    [self setupModelOfCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - 设置cell的数据
- (void)setupModelOfCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    // 采用计算frame模式还是自动布局模式，默认为NO，自动布局模式
    //    cell.fd_enforceFrameLayout = NO;
    JQMineShopFoodTableViewCell *mineShopFoodCell = (JQMineShopFoodTableViewCell *)cell;
    mineShopFoodCell.foodTotalModel = self.dataListM[indexPath.row];
    
}

#pragma mark - 改变cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.tableView fd_heightForCellWithIdentifier:MINESHOPFOODTBVCELLID cacheByIndexPath:indexPath configuration:^(id cell) {
        
        [self setupModelOfCell:cell atIndexPath:indexPath];
    }];
}

#pragma mark - 异步加载数据
- (void)loadJSONData:(void(^)()) then {
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
#warning 现在是模拟的json数据
        // 读取json数据
        // 获取json地址
        NSString *foodAlreadyBuyFoodFilePath =[[NSBundle mainBundle] pathForResource:@"foodAlreadyBuyData" ofType:@"json"];
        
        // 获取二进制数据
        NSData *data = [NSData dataWithContentsOfFile:foodAlreadyBuyFoodFilePath];
        
        // 转成字典
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
        
        // 转成数组
        NSArray *foodAlreadyBuyArrayM = dataDictionary[@"foodAlreadyBuyData"];
        NSMutableArray *foodTotalDataArrM = @[].mutableCopy;
        
        foodTotalDataArrM = [JQFoodTotalModel mj_objectArrayWithKeyValuesArray:foodAlreadyBuyArrayM];
        weakSelf.dataListM = foodTotalDataArrM;
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !then ? : then();
        });
    });
}

- (NSMutableArray *)dataListM{
    
    if (!_dataListM) {
        _dataListM = [NSMutableArray array];
    }
    return _dataListM;
}


@end
