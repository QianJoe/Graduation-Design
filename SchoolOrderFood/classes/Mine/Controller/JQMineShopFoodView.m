//
//  JQMineShopFoodView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/7.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQMineShopFoodView.h"
#import "JQMineShopFoodTableViewCell.h"
#import "JQFoodTotalModel.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import <MJExtension/MJExtension.h>
#import "UIImage+Image.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface JQMineShopFoodView () <UITableViewDataSource, UITableViewDelegate>
/**tableview*/
@property (nonatomic, weak) UITableView *tableView;

/**总的数据*/
@property (nonatomic, strong) NSMutableArray *dataListM;

/**添加的按钮*/
@property (nonatomic, weak) UIButton *addFoodBtn;

/**底部*/
@property (nonatomic, weak) UIView *bottomView;

@end

@implementation JQMineShopFoodView

#pragma mark - 移除通知
- (void)dealloc {
    
    // 移除通知
    [JQNotification removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self setViewAutoLayout];
        
        [JQNotification addObserver:self selector:@selector(foodTotalModelDidRemoveTableViewReload:) name:JQTableViewRemoveModelNotification object:nil];
        
        
    }
    
    return self;
}

- (void)createUI {
    
    UITableView *tableView = [[UITableView alloc] init];
    [tableView registerClass:[JQMineShopFoodTableViewCell class] forCellReuseIdentifier:MINESHOPFOODTBVCELLID];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    //    tableView.rowHeight = 80;
    tableView.tableFooterView = [[UIView alloc] init];
    self.tableView = tableView;
    [self addSubview:tableView];
    
    // 底部按钮
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0, 5, SCREEN_WIDTH, 44);
    tableView.tableFooterView = bottomView;
    
    UIButton *addFoodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addFoodBtn addTarget:self action:@selector(addFood:) forControlEvents:UIControlEventTouchUpInside];
    [addFoodBtn setTitle:@"添加食物" forState:UIControlStateNormal];
    [addFoodBtn setBackgroundImage:[UIImage imageWithColor:naviColor] forState:UIControlStateNormal];
    [addFoodBtn setBackgroundImage:[UIImage imageWithColor:naviColorAlp] forState:UIControlStateHighlighted];
    addFoodBtn.frame = CGRectMake(5, 5, SCREEN_WIDTH - 10, 40);
    self.addFoodBtn = addFoodBtn;
    [bottomView addSubview:addFoodBtn];
    
}

- (void)setViewAutoLayout {
    
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(5);
        make.left.right.bottom.equalTo(self);
    }];
}

- (void)addFood:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(mineShopFoodViewAdd:)]) {
        
        [self.delegate mineShopFoodViewAdd:self];
    }
}

#pragma mark - 通知刷新数据
- (void)foodTotalModelDidRemoveTableViewReload:(NSNotification *)noti {
    
    NSDictionary *foodDic = noti.userInfo;
    JQFoodTotalModel *ftm = foodDic[@"rmovedFood"];
    if ([self.dataListM containsObject:ftm]) {
        
        [self.dataListM removeObject:ftm];
        
        // 刷新数据
        [self.tableView reloadData];
    }
}

#pragma mark - uitableview的数据源和代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataListM.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(mineShopFoodViewEdit:foodTotalModel:andArray:)]) {
        
        [self.delegate mineShopFoodViewEdit:self foodTotalModel:self.dataListM[indexPath.row]andArray:self.dataListM];
    }
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
//        // 读取json数据
//        // 获取json地址
//        NSString *foodAlreadyBuyFoodFilePath =[[NSBundle mainBundle] pathForResource:@"foodAlreadyBuyData" ofType:@"json"];
//        
//        // 获取二进制数据
//        NSData *data = [NSData dataWithContentsOfFile:foodAlreadyBuyFoodFilePath];
//        
//        // 转成字典
//        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
//        
//        // 转成数组
//        NSArray *foodAlreadyBuyArrayM = dataDictionary[@"foodAlreadyBuyData"];
//        NSMutableArray *foodTotalDataArrM = @[].mutableCopy;
//        
//        foodTotalDataArrM = [JQFoodTotalModel mj_objectArrayWithKeyValuesArray:foodAlreadyBuyArrayM];
        weakSelf.dataListM = weakSelf.foodTotalModelArrayM;
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !then ? : then();
        });
    });
}

- (void)setFoodTotalModelArrayM:(NSMutableArray *)foodTotalModelArrayM {
    
    _foodTotalModelArrayM = foodTotalModelArrayM;
    [self loadJSONData:^{
        
        [self.tableView reloadData];
    }];
}

@end
