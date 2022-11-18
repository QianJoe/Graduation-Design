//
//  JQShopTotalViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/19.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQShopTotalViewController.h"
#import "JQShopTotalTableViewCell.h"
#import <MJExtension/MJExtension.h>
#import "JQFoodTotalModel.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

@interface JQShopTotalViewController () <UITableViewDataSource, UITableViewDelegate, JQShopTotalTableViewCellDeleagte>

/**tableview*/
@property (nonatomic, weak) UITableView *tableView;

/**接受数据的数据*/
@property (nonatomic, strong) NSMutableArray *foodTotalDataArrMFromJSON;

/**存放购买的食物*/
@property (nonatomic, strong) NSMutableArray<JQFoodTotalModel *> *buyFoodTotalArrayM;
;

/**总价*/
@property (nonatomic, assign) NSInteger totalPrice;
@end

@implementation JQShopTotalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    
    [self initRefresh];
}

#pragma mark - 初始化上拉刷新
- (void)initRefresh {
    
    IMP_BLOCK_SELF(JQShopTotalViewController);
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [block_self loadJSONData:^{
            
            [block_self.tableView reloadData];
            
            [block_self.tableView.mj_footer endRefreshing];
        }];
    }];
    
    [self.tableView.mj_footer beginRefreshing];
}

#pragma mark - 初始化tableview
- (void)initTableView {
    
    UITableView *tableView = [[UITableView alloc] init];
    [tableView registerClass:[JQShopTotalTableViewCell class] forCellReuseIdentifier:SHOPTOTALTABLEVIEWCELLID];
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


#pragma mark - 异步加载数据
- (void)loadJSONData:(void(^)()) then {
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
#warning 现在是模拟的json数据
        // 读取json数据
        // 获取json地址
        NSString *foodTotalDataFilePath =[[NSBundle mainBundle] pathForResource:@"foodHaodadaData" ofType:@"json"];
        
        // 获取二进制数据
        NSData *data = [NSData dataWithContentsOfFile:foodTotalDataFilePath];
        
        // 转成字典
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
        
        // 转成数组
        NSArray *foodTotalDataArr = dataDictionary[@"foodHaodadaData"];
        NSMutableArray *foodTotalDataArrM = @[].mutableCopy;
        
        foodTotalDataArrM = [JQFoodTotalModel mj_objectArrayWithKeyValuesArray:foodTotalDataArr];
        weakSelf.foodTotalDataArrMFromJSON = foodTotalDataArrM;
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !then ? : then();
        });
    });
}

#pragma mark - JQShopTotalTableViewCellDeleagte
- (void)shopTotalCellPlusBtnClick:(JQShopTotalTableViewCell *)cell {

    if (![self.buyFoodTotalArrayM containsObject:cell.foodTotalModel]) {
        
        [self.buyFoodTotalArrayM addObject:cell.foodTotalModel];
    }
    
    NSInteger money = [cell.foodTotalModel.money integerValue];
    self.totalPrice += money;
    JQLOG(@"增加.....总结:%ld", self.totalPrice);
}

- (void)shopTotalCellMinusBtnClick:(JQShopTotalTableViewCell *)cell {

    // 当count为0 删除购物车中的模型
    if (!cell.foodTotalModel.count) {
        JQLOG(@"-----------:%ld", cell.foodTotalModel.count);
        [self.buyFoodTotalArrayM removeObject:cell.foodTotalModel];
    }
    
    NSInteger money = [cell.foodTotalModel.money integerValue];
    self.totalPrice -= money;
    JQLOG(@"减少.....总结:%ld", self.totalPrice);
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.foodTotalDataArrMFromJSON.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQShopTotalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SHOPTOTALTABLEVIEWCELLID];
    
    // 设置代理
    cell.delegate = self;
    
    // 选中之后没有颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    // 设置数据模型
//    cell.foodTotalModel = self.foodTotalDataArrMFromJSON[indexPath.row];
    
    [self setupModelOfCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - 设置cell的数据
- (void)setupModelOfCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    // 采用计算frame模式还是自动布局模式，默认为NO，自动布局模式
    //    cell.fd_enforceFrameLayout = NO;
    JQShopTotalTableViewCell *stCell = (JQShopTotalTableViewCell *)cell;
    stCell.foodTotalModel = self.foodTotalDataArrMFromJSON[indexPath.row];
    
}

#pragma mark - 改变cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.tableView fd_heightForCellWithIdentifier:SHOPTOTALTABLEVIEWCELLID cacheByIndexPath:indexPath configuration:^(id cell) {
        
        [self setupModelOfCell:cell atIndexPath:indexPath];
    }];
}

#pragma mark - 懒加载
- (NSMutableArray<JQFoodTotalModel *> *)buyFoodTotalArrayM {
    
    if (!_buyFoodTotalArrayM) {
        _buyFoodTotalArrayM = [NSMutableArray array];
    }
    return _buyFoodTotalArrayM;
}

@end
