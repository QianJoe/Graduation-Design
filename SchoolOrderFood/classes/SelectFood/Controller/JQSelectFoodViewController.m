//
//  JQSelectFoodViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/9.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQSelectFoodViewController.h"
#import "JQMultipleButtonView.h"
#import "JSDropDownMenu.h"
#import <MJExtension/MJExtension.h>
#import "JQFoodTableViewCell.h"
#import "JQFoodModel.h"
#import "JQShopDetailViewController.h"
#import "UIImage+Image.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import "JQCategory.h"

#define menuIndicatorColor [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0]
#define menuSeparatorColor [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0]
#define menuTextColor [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f]

//#define FIRSTMENUDATAS @[@{@"炸的" : @[@"炸土豆", @"炸年糕", @"炸鱿鱼", @"炸玉米"]}, @{@"煮的" : @[@"煮饭", @"煮粥", @"煮玉米"]}, @{@"煎的" : @[@"煎蛋", @"煎饼"]}, @{@"蒸的" : @[@"蒸馒头", @"蒸包子", @"蒸西瓜"]}]
//#define data1 @[@"炸土豆", @"炸年糕", @"炸鱿鱼", @"炸玉米"]
//#define data2 @[@"煮饭", @"煮粥", @"煮玉米"]
//#define data3 @[@"煎蛋", @"煎饼"]
//#define data4 @[@"蒸馒头", @"蒸包子", @"蒸西瓜"]
//
//#define FIRSTMENUDATAS @[@{@"title":@"炸的", @"data":data1}, @{@"title":@"煮的", @"data":data2}, @{@"title":@"煎的", @"data":data3}]

#define SECONDMENUDATAS @[@"智能排序", @"评价最高", @"最新发布", @"人气最高", @"价格最低", @"价格最高"]
#define THRIDMENUDATAS @[@"早餐", @"午餐", @"晚餐", @"夜宵"]

@interface JQSelectFoodViewController () <JQMultipleButtonViewDelegate, JSDropDownMenuDataSource, JSDropDownMenuDelegate, UITableViewDataSource, UITableViewDelegate>

/**顶部下拉筛选菜单*/
@property (nonatomic, strong) JSDropDownMenu *menu;

/**记录第一列数据当前的角标索引*/
@property (nonatomic, assign) NSInteger currentFirstDataIndex;
/**记录第一列数据右边被选中的角标*/
@property (nonatomic, assign) NSInteger currentFirstDataSelectedIndex;

/**记录第二列数据当前的角标索引*/
@property (nonatomic, assign) NSInteger currentSecondDataIndex;

/**记录第三列数据当前的角标索引*/
@property (nonatomic, assign) NSInteger currentThridDataIndex;

/**存储分类的数组*/
@property (nonatomic, strong) NSArray<JQCategory *> *categorys;

/**tableview*/
@property (nonatomic, weak) UITableView *tableView;

/**foodModel的数组*/
@property (nonatomic, strong) NSMutableArray<JQFoodModel *> *foodModels;

@end

@implementation JQSelectFoodViewController

#pragma mark - 懒加载
- (NSArray<JQCategory *> *)categorys{
    
    if (!_categorys) {
        _categorys = [JQCategory mj_objectArrayWithFilename:@"foodCategory.plist"];;
    }
    return _categorys;
}

#pragma mark - 加载view
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    UIColor *color = JQColor(255, 214, 0, 1.0);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeNav];
    
    [self setDropMenu];
    
    [self setTable];
    
    [self initRefresh];
}

#pragma mark - 初始化下拉刷新
- (void)initRefresh {
    
    IMP_BLOCK_SELF(JQSelectFoodViewController);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [block_self loadJSONData:^{
            
            [block_self.tableView reloadData];
            
            [block_self.tableView.mj_header endRefreshing];
        }];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 初始化导航栏
- (void)changeNav {
    
    NSArray  *array = @[@"全部商家",@"优惠商家"];
    
    //这个地方用UIView来接收也不会报错的，因为JFMultipleButtonView继承于UIView但是没有代理方法
    JQMultipleButtonView *buttonView = [[JQMultipleButtonView alloc] initWithFrame:CGRectMake(0, 0, 160, 40) titleArray:array];
    
    buttonView.delegate = self;
    
    self.navigationItem.titleView = buttonView;
    
}

#pragma mark - 导航条中间的JQMultipleButtonViewDelegate
- (void)multipleButtonView:(JQMultipleButtonView *)multipleBtn clickAtIndex:(NSInteger)index {
    
    JQLOG(@"multipleBtn:%ld", index);
}

#pragma mark - 设置tableview
- (void)setTable {
    
    UITableView *tableView = [[UITableView alloc] init];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [tableView registerClass:[JQFoodTableViewCell class] forCellReuseIdentifier:FOODTBCELL];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.menu.bottom);
        make.leading.equalTo(self.view.leading);
        make.trailing.equalTo(self.view.trailing);
        make.bottom.equalTo(self.view.bottom).offset(-45);
    }];
}

#pragma mark - tableview的数据源和代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.foodModels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    JQFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FOODTBCELL];
    
//    cell.foodModel = self.foodModels[indexPath.row];
    [self setupModelOfCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JQLOG(@"didSelectRowAtIndexPath:%ld", indexPath.row);
    
    JQShopDetailViewController *shopDetailVC = [[JQShopDetailViewController alloc] init];
    
    [self.navigationController pushViewController:shopDetailVC animated:YES];
}


#pragma mark - 设置cell的数据
- (void)setupModelOfCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    // 采用计算frame模式还是自动布局模式，默认为NO，自动布局模式
    //    cell.fd_enforceFrameLayout = NO;
    JQFoodTableViewCell *stCell = (JQFoodTableViewCell *)cell;
    stCell.foodModel = self.foodModels[indexPath.row];
    
}

#pragma mark - 改变cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.tableView fd_heightForCellWithIdentifier:FOODTBCELL cacheByIndexPath:indexPath configuration:^(id cell) {
        
        [self setupModelOfCell:cell atIndexPath:indexPath];
    }];
}

#pragma mark - 下拉菜单
- (void)setDropMenu {
    
    // 指定第一列默认选中
    self.currentFirstDataIndex = 0;
    self.currentFirstDataSelectedIndex = 0;
    
    JSDropDownMenu *menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:40];
    menu.indicatorColor = menuIndicatorColor;
    menu.separatorColor = menuSeparatorColor;
    menu.textColor = menuTextColor;
    menu.dataSource = self;
    menu.delegate = self;
    
    self.menu = menu;
    [self.view addSubview:menu];
}

#pragma mark - 下拉菜单的数据源方法JSDropDownMenuDataSource
/**菜单有几列*/
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    /* 为3列：
     第0列：里面有两列（为按口味，炸的，煎的，煮的，蒸的...）
     第1列：一列（按人气，评价，智能排序）
     第2列：一列（早，中，晚，夜）
     */
    return 3;
}

/**是否需要显示为UICollectionView 默认为否*/
- (BOOL)displayByCollectionViewInColumn:(NSInteger)column {
    
    if (column == 2) { // 第2列为collection
        
        return YES;
    }
    
    return NO;
}

/**表视图显示时，是否需要两个表显示*/
- (BOOL)haveRightTableViewInColumn:(NSInteger)column {
    
    if (column == 0) { // 第0列中有左右两个table
        
        return YES;
    }
    
    return NO;
}


/**表视图显示时，左边表显示比例*/
- (CGFloat)widthRatioOfLeftColumn:(NSInteger)column {
    
    if (column == 0) { // 第0列中左边的table宽度占0.3
        
        return 0.3;
    }
    
    return 1;
}

/**返回当前菜单左边表选中行*/
- (NSInteger)currentLeftSelectedRow:(NSInteger)column {
    
    if (column == 0) { // 第0列返回（为按口味，炸的，煎的，煮的，蒸的...）的数据
        
        return self.currentFirstDataIndex;
    }
    
    if (column == 1) { // 第1列返回（按人气，评价，智能排序））的数据
        
        return self.currentSecondDataIndex;
    }
    
    return 0;
}

/**返回每一列有多少行数据*/
- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow {
    
    if (column == 0) { // 第0列时，返回左右table数据不同的数量来确定行数
        
        if (leftOrRight == 0) { // 为左时,返回大分类的数量 （0为左）
            
            return self.categorys.count;
        
        } else { // 为右时,返回大分类中的小分类的数量
            
            JQCategory *p = self.categorys[leftRow];
            return p.category.count;
        }
        
    } else if (column == 1){ // 返回第1列的数据的数量
        
        return SECONDMENUDATAS.count;
        
    } else if (column == 2){ // 返回第2列中的数据数量
        
        return THRIDMENUDATAS.count;
    }
    
    return 0;
    
}

/**显示每一列的标题*/
- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column {
    
    switch (column) {
            
        case 0:return [[self.categorys[self.currentFirstDataIndex] category] objectAtIndex:self.currentFirstDataSelectedIndex];
            
            break;
            
        case 1: return SECONDMENUDATAS[self.currentSecondDataIndex];
            
            break;
            
        case 2: return THRIDMENUDATAS[self.currentThridDataIndex];
            
            break;
            
        default:
            return nil;
            break;
    }
}

/**显示点击下拉菜单之后，左边的小菜单*/
- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        
        if (indexPath.leftOrRight == 0) { // 第0列的左右table的数据
            
            JQCategory *p = self.categorys[indexPath.row];
            NSString *proName = p.name;
            return proName;
            
        } else {
            
            NSInteger leftRow = indexPath.leftRow;
            JQCategory *p = self.categorys[leftRow];
            return p.category[indexPath.row];
        }
        
    } else if (indexPath.column == 1) {
        
        return SECONDMENUDATAS[indexPath.row];
        
    } else {
        
        return THRIDMENUDATAS[indexPath.row];
    }
}

#pragma mark - JSDropDownMenuDelegate
/**
 * 选择哪一行，会设置为当前行，然后设置为该列的标题
 * 选择的是哪行
 * 第一列是返回左边小菜单
 */
- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        
        if(indexPath.leftOrRight == 0){
            
            self.currentFirstDataIndex = indexPath.row;
            
            return;
        }
        
        JQLOG(@"第1列左边：%ld:%@---%ld----第1列右边：%ld:%@", indexPath.leftOrRight, self.categorys[indexPath.leftRow].name , indexPath.row, indexPath.leftRow, self.categorys[indexPath.leftRow].category[indexPath.row]);
        
    } else if(indexPath.column == 1){
        
        self.currentSecondDataIndex = indexPath.row;
        JQLOG(@"第2列：%ld:%@", indexPath.leftRow, SECONDMENUDATAS[indexPath.leftRow]);
        
    } else {
        
        self.currentThridDataIndex = indexPath.row;JQLOG(@"第3列：%ld:%@", indexPath.row, THRIDMENUDATAS[indexPath.row]);
    }
}

#pragma mark - 加载json数据
- (void) loadJSONData:(void(^)()) then {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
#warning 现在是模拟的json数据
        // 读取json数据
        // 获取json地址
        NSString *foodDataFilePath =[[NSBundle mainBundle] pathForResource:@"foodData" ofType:@"json"];
        
        // 获取二进制数据
        NSData *data = [NSData dataWithContentsOfFile:foodDataFilePath];
        
        // 转成字典
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
        
        // 转成数组
        NSArray *foodModelArr = dataDictionary[@"foodData"];
        NSMutableArray *foodModelArrM = @[].mutableCopy;
        
        foodModelArrM = [JQFoodModel mj_objectArrayWithKeyValuesArray:foodModelArr];
        self.foodModels = foodModelArrM;
        JQLOG(@"foodModels:%@", self.foodModels);
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !then ? : then();
        });
    });
}

@end
