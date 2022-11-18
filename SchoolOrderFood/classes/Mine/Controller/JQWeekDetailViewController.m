//
//  JQWeekDetailViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/8.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQWeekDetailViewController.h"
#import <MJExtension/MJExtension.h>
#import "JQWeekEveryDayModel.h"
#import "JQWeekEveryDataTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import "JQWeekHeaderView.h"
#import "JQSelectFoodViewController.h"

@interface JQWeekDetailViewController () <UITableViewDataSource, UITableViewDelegate>
/**待取餐的tableview*/
@property (nonatomic, weak) UITableView *tableView;

/**星期单数据模型*/
@property (nonatomic, strong) JQWeekEveryDayModel *weekEveryDayModel;
/**数组*/
@property (nonatomic, strong) NSMutableArray *dataListM;
@end

@implementation JQWeekDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self refreshSet];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initTableView];
    [JQNotification addObserver:self selector:@selector(mynotification) name:@"星期日" object:nil];
}


#pragma mark - 刷新数据
- (void)refreshSet {
    
    // 防止循环引用
    IMP_BLOCK_SELF(JQWeekDetailViewController);
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [block_self loadJSONData:^{
            
            [block_self.tableView reloadData];
            
            [block_self.tableView.mj_header endRefreshing];
        }];
    }];
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)mynotification {
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)dealloc {
    
    [JQNotification removeObserver:self name:@"星期日" object:nil];
}

#pragma mark - 初始化tableview
- (void)initTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.rowHeight = 120;
    // cell
    [tableView registerClass:[JQWeekEveryDataTableViewCell class] forCellReuseIdentifier:WEEKTABLEVIEWCELLID];
    // head
    [tableView registerClass:[JQWeekHeaderView class] forHeaderFooterViewReuseIdentifier:HEADVWEEKID];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(5);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - uitableview的数据源和代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataListM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataListM[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    JQWeekEveryDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WEEKTABLEVIEWCELLID];

    // 设置数据模型
    cell.foodTotalModel = self.dataListM[indexPath.section][indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    itdVC.foodTotalModel = self.dataListM[indexPath.row];
    JQSelectFoodViewController *sfVC = [[JQSelectFoodViewController alloc] init];
    
    [self.navigationController pushViewController:sfVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    JQLOG(@"section:%ld", section);
    
    JQWeekHeaderView *headViewWeekView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HEADVWEEKID];
    
    headViewWeekView.colorHex = weekHeadColorArray[section];
    headViewWeekView.name = weekHeadTitleArray[section];
    
    return headViewWeekView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

#pragma mark - 异步加载数据
- (void)loadJSONData:(void(^)()) then {
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [weakSelf.dataListM removeAllObjects];
#warning 现在是模拟的json数据
        // 读取json数据
        // 获取json地址
        NSString *weekListDataFilePath =[[NSBundle mainBundle] pathForResource:@"weekListData" ofType:@"json"];
        
        // 获取二进制数据
        NSData *data = [NSData dataWithContentsOfFile:weekListDataFilePath];
        
        // 转成字典
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
        
        // 转成数组
        
        weakSelf.weekEveryDayModel = [JQWeekEveryDayModel mj_objectWithKeyValues:dataDictionary[self.dataContent]];
        
        [weakSelf.dataListM addObject:@[weakSelf.weekEveryDayModel.breakfast]];
        [weakSelf.dataListM addObject:@[weakSelf.weekEveryDayModel.lunch]];
        [weakSelf.dataListM addObject:@[weakSelf.weekEveryDayModel.dinner]];
        
        [self.tableView.mj_header endRefreshing];
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
