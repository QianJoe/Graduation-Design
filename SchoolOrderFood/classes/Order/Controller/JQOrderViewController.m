//
//  JQOrderViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/25.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQOrderViewController.h"
#import "JQOrderDefaultView.h"
#import "JQOrderTableFootView.h"
#import "JQOrderTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import <MJExtension/MJExtension.h>
#import "JQFoodTotalModel.h"
#import "JQShopCarTool.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JQChoosedViewController.h"

@interface JQOrderViewController () <UITableViewDataSource, UITableViewDelegate, JQOrderTableViewCellDeleagte, JQOrderTableFootViewDelegate>

/**没有订餐，显示的界面*/
@property (nonatomic, weak) JQOrderDefaultView *defaultView;

/**已经订的tableview*/
@property (nonatomic, weak) UITableView *orderTableView;

/**footview*/
@property (nonatomic, weak) JQOrderTableFootView *footView;

/**接受数据的数据*/
@property (nonatomic, strong) NSMutableArray *foodTotalDataArrMFromJSON;

/**存放购买的食物*/
@property (nonatomic, strong) NSMutableArray<JQFoodTotalModel *> *buyFoodTotalArrayM;
;

/**总价*/
@property (nonatomic, assign) NSInteger totalPrice;

/**食物的数组*/
@property (nonatomic, strong) NSMutableArray *dataList;

/**存放购买的临时食物*/
@property (nonatomic, strong) NSMutableArray<JQFoodTotalModel *> *buyFoodTotalTempArray;
;

@end

@implementation JQOrderViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;

    if ([[JQShopCarTool sharedInstance] isEmpty]) {
        
        self.defaultView.hidden = NO;
        self.orderTableView.hidden = YES;
        
    } else {
        
        self.defaultView.hidden = YES;
        self.orderTableView.hidden = NO;
        
        __weak typeof (self) weakSelf = self;
        
        [SVProgressHUD showWithStatus:@"加载中"];
        
        // 异步加载出
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            weakSelf.dataList = [JQShopCarTool sharedInstance].shopCar;
            weakSelf.buyFoodTotalTempArray = weakSelf.dataList.mutableCopy;
            
            // 显示到脚view上
            weakSelf.footView.totalPrice = [[JQShopCarTool sharedInstance] getShopCarTotalPrice];
            
            weakSelf.totalPrice = [[JQShopCarTool sharedInstance] getShopCarTotalPrice];
            
            [weakSelf.orderTableView reloadData];
            
            [SVProgressHUD dismiss];
        });
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单";
    self.view.backgroundColor = BackgroundColor;
    
    [self initTableView];
    [self initDefaultView];
    [self initTableFootView];
    
}

#pragma mark - 添加通知
- (void)addNotification {
    
    [JQNotification addObserver:self selector:@selector(increaseShoppingCar) name:JQFoodChangedNotification object:nil];
    [JQNotification addObserver:self selector:@selector(removeFoodFromShopCar) name:JQShopCarFoodRemoveNotification object:nil];
}

- (void)increaseShoppingCar {
    
    self.footView.totalPrice = [[JQShopCarTool sharedInstance] getShopCarTotalPrice];
}
- (void)removeFoodFromShopCar {
    
    self.footView.totalPrice = [[JQShopCarTool sharedInstance] getShopCarTotalPrice];
}

- (void)dealloc {
    [JQNotification removeObserver:self];
}

#pragma mark - 初始化tableview
- (void)initTableView {
    
    UITableView *orderTableView = [[UITableView alloc] init];
    [orderTableView registerClass:[JQOrderTableViewCell class] forCellReuseIdentifier:ORDERTABLEVIEWCELLID];
    orderTableView.showsVerticalScrollIndicator = NO;
    orderTableView.dataSource = self;
    orderTableView.delegate = self;
    
    self.orderTableView = orderTableView;
    [self.view addSubview:orderTableView];
    
    [orderTableView makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view).offset(10);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - 初始化脚view
- (void)initTableFootView {
    
    // 脚view
    JQOrderTableFootView *footView = [[JQOrderTableFootView alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, 50)];
    footView.delegate = self;
//    JQOrderTableFootView *footView = [[JQOrderTableFootView alloc] init];
    self.footView = footView;
    self.orderTableView.tableFooterView = footView;
//    [self.view addSubview:footView];
    
//    [footView makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.left.right.equalTo(self.view);
//        make.bottom.equalTo(self.view);
//        make.height.equalTo(50);
//    }];
    
}

#pragma mark - 默认view
- (void)initDefaultView {
    
    JQOrderDefaultView *defaultView = [[JQOrderDefaultView alloc] init];
    // 默认隐藏，无订餐时，为NO
//    defaultView.hidden = YES;
    self.defaultView = defaultView;
    [self.view addSubview:defaultView];
    
    [self.defaultView makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(170);
    }];
}

#pragma mark - tableview数据源和代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    return self.foodTotalDataArrMFromJSON.count;
    return self.dataList.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ORDERTABLEVIEWCELLID];
    
    // 设置代理
    cell.delegate = self;
    
    // 设置数据模型
    //    cell.foodTotalModel = self.foodTotalDataArrMFromJSON[indexPath.row];
    
    [self setupModelOfCell:cell atIndexPath:indexPath];
    
    return cell;
}


#pragma mark - 设置cell的数据
- (void)setupModelOfCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    // 采用计算frame模式还是自动布局模式，默认为NO，自动布局模式
    //    cell.fd_enforceFrameLayout = NO;
    JQOrderTableViewCell *orderCell = (JQOrderTableViewCell *)cell;
//    orderCell.foodTotalModel = self.foodTotalDataArrMFromJSON[indexPath.row];
    orderCell.foodTotalModel = self.dataList[indexPath.row];

}

#pragma mark - 改变cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.orderTableView fd_heightForCellWithIdentifier:ORDERTABLEVIEWCELLID cacheByIndexPath:indexPath configuration:^(id cell) {
        
        [self setupModelOfCell:cell atIndexPath:indexPath];
    }];
}

#pragma mark - JQOrderTableViewCellDeleagte
- (void)orderCellPlusBtnClick:(JQOrderTableViewCell *)cell {
    
//    if (![self.buyFoodTotalArrayM containsObject:cell.foodTotalModel]) {
//        
//        [self.buyFoodTotalArrayM addObject:cell.foodTotalModel];
//    }
    
    if (![self.buyFoodTotalTempArray containsObject:cell.foodTotalModel]) {
        
        [self.buyFoodTotalTempArray addObject:cell.foodTotalModel];
    }
    
    NSInteger money = [cell.foodTotalModel.money integerValue];
    
    self.totalPrice += money;
    
    // 显示在footview上
    self.footView.totalPrice = self.totalPrice;
    JQLOG(@"增加.....总结:%ld,%@", self.totalPrice, self.dataList);
}

- (void)orderCellMinusBtnClick:(JQOrderTableViewCell *)cell {
    
    // 当count为0 删除购物车中的模型
//    if (!cell.foodTotalModel.count) {
//        [self.buyFoodTotalArrayM removeObject:cell.foodTotalModel];
//    }
    if (!cell.foodTotalModel.count) {
        [self.buyFoodTotalTempArray removeObject:cell.foodTotalModel];
    }
    
    NSInteger money = [cell.foodTotalModel.money integerValue];
    self.totalPrice -= money;
    // 显示在footview上
    self.footView.totalPrice = self.totalPrice;
    JQLOG(@"减少.....总结:%ld, %@", self.totalPrice, self.dataList);
}

- (void)orderCellSelectedBtnClick:(JQOrderTableViewCell *)cell {
    
    // 先将数据模型中的被选中设置YES，下一次循环引用时，就为选中
    cell.foodTotalModel.check = YES;
    
    // 添加进去
//    [self.buyFoodTotalArrayM addObject:cell.foodTotalModel];
//    [self.buyFoodTotalTempArray addObject:cell.foodTotalModel];
    
    [self.dataList addObject:cell.foodTotalModel];
    
    NSInteger money = [cell.foodTotalModel.money integerValue];
    money = money * cell.foodTotalModel.count;
    self.totalPrice += money;
    // 显示在footview上
    self.footView.totalPrice = self.totalPrice;
    
    JQLOG(@"选中.....总结:%ld, %@", self.totalPrice, self.dataList);

}

- (void)orderCellNoSelectedBtnClick:(JQOrderTableViewCell *)cell {
    
    // 先将数据模型中的被选中设置NO，下一次循环引用时，就为未选中
    cell.foodTotalModel.check = NO;
    
    // 直接将它移除
//    [self.buyFoodTotalArrayM removeObject:cell.foodTotalModel];
//    [self.buyFoodTotalTempArray removeObject:cell.foodTotalModel];
    [self.dataList removeObject:cell.foodTotalModel];

    NSInteger money = [cell.foodTotalModel.money integerValue];
    money = money * cell.foodTotalModel.count;
    self.totalPrice -= money;
    // 显示在footview上
    self.footView.totalPrice = self.totalPrice;
    JQLOG(@"未选中.....总结:%ld, %@", self.totalPrice, self.dataList);

}

#pragma mark - JQOrderTableFootViewDelegate
- (void)tableFootViewDidCommit:(JQOrderTableFootView *)orderTableFootView {
    
//    for (JQFoodTotalModel *foodModel in self.buyFoodTotalArrayM) {
//        
//        JQLOG(@"买了%@:共%ld个", foodModel.name, foodModel.count);
//    }
    
    JQChoosedViewController *choosedVC = [[JQChoosedViewController alloc] init];
    choosedVC.buyFoodDataList = self.dataList;
    [self.navigationController pushViewController:choosedVC animated:YES];
}

#pragma mark - 懒加载
- (NSMutableArray<JQFoodTotalModel *> *)buyFoodTotalArrayM {
    
    if (!_buyFoodTotalArrayM) {
        _buyFoodTotalArrayM = [NSMutableArray array];
    }
    return _buyFoodTotalArrayM;
}

- (NSMutableArray<JQFoodTotalModel *> *)buyFoodTotalTempArray{
    
    if (!_buyFoodTotalTempArray) {
        _buyFoodTotalTempArray = [NSMutableArray array];
    }
    return _buyFoodTotalTempArray;
}

@end
