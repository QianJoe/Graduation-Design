//
//  JQHomeTableViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/27.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQHomeTableViewController.h"
#import <MJExtension/MJExtension.h>
#import "JQHomeCategoryCell.h"
#import "JQHomeCollectCell.h"
#import "JQCategoryGoods.h"
#import "JQHeadView.h"
#import <MJRefresh/MJRefresh.h>
#import "JQHead.h"
#import "JQHeadLine.h"
#import "JQHeadData.h"
#import "JQWeatherViewController.h"
#import "PCH.h"

@interface JQHomeTableViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

/**导航条中间搜索框*/
@property (nonatomic, weak) UISearchBar *searchBar;
/**导航条右边的按钮*/
@property (nonatomic, weak) UIButton *rightCategoryBtn;

@property (nonatomic, weak) UICollectionView *collectView;
/**每一组分类cell的分类商品数据模型的数组*/
@property (nonatomic, strong) NSMutableArray<JQCategoryGoods *> *categoryGoodsModelsFromJSON;

/**头view*/
@property (nonatomic, weak) JQHeadView *homeHeadView;
/**headLine数据模型*/
//@property (nonatomic, strong) JQHead *head;
//@property (nonatomic, strong) JQHeadLine *headLine;
@property (nonatomic, strong) JQHeadData *headData;

@end

@implementation JQHomeTableViewController

#pragma mark - 系统加载view
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 这个通知是为了随着滚动改变headview和collection的位置
    [self addNotification];
    
    // 改变navigationbar
    [self changeNavi];
    
    // 创建collectionview
    [self buildCollectionView];
    
    // 创建头view
    [self buildHomeHeadView];
    
    [self initRefresh];
    
    // 异步加载数据的block方法
//    [self loadCollectJSONData:^{
//        
////        self.homeHeadView.head = self.head;
////        self.homeHeadView.headLine = self.headLine;
//        
//        self.homeHeadView.headData = self.headData;
//        
//        [self.collectView registerClass:[JQHomeCategoryCell class] forCellWithReuseIdentifier:HOMECACELL];
//        [self.collectView reloadData];
//    }];
}

#pragma mark - 初始化下拉刷新
- (void)initRefresh {
    
    IMP_BLOCK_SELF(JQHomeTableViewController);
    self.collectView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        // 发送get请求
        JQHttpRequestTool *httpTool = [JQHttpRequestTool shareHttpRequestTool];
        
        // get头热门和首页轮播器图片的数据
        [httpTool requestWithMethod:GET andUrlString:JQOrderSchoolFoodHomeHeadAndPageDataURL andParameters:nil andFinished:^(id response, NSError *error) {
            
//            NSData *homeHeadData = [response dataUsingEncoding:NSUTF8StringEncoding];
            //            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:homeHeadData options: NSJSONReadingAllowFragments error:nil];
            NSString *result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
            JQLOG(@"%@", result);
            
            // 转成字典
            NSDictionary *dataDictionary = [result dictionaryWithJsonString:result];

            NSDictionary *headDataDict = dataDictionary[@"headData"];
            
//            JQLOG(@"dict:%@", headDataDict);
            JQHeadData *headDataModel = [JQHeadData mj_objectWithKeyValues:headDataDict];
            block_self.headData = headDataModel;
            
            block_self.homeHeadView.headData = block_self.headData;
            
        }];
        
        // get推荐食物数据
        [httpTool requestWithMethod:GET andUrlString:JQOrderSchoolFoodHomeRecommendDataURL andParameters:nil andFinished:^(id response, NSError *error) {
            
            NSString *result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
            JQLOG(@"111:%@", result);
            // 转成字典
            NSDictionary *dataDictionary = [result dictionaryWithJsonString:result];
            
            // 转成数组
            NSArray *categoryGoodsDataArr = dataDictionary[@"categoryGoods"];
            NSMutableArray *categoryDataArrM = @[].mutableCopy;
            
            categoryDataArrM = [JQCategoryGoods mj_objectArrayWithKeyValuesArray:categoryGoodsDataArr];
            block_self.categoryGoodsModelsFromJSON = categoryDataArrM;
            
            [block_self.collectView reloadData];
            [block_self.collectView.mj_header endRefreshing];
        }];
        
//        [block_self loadCollectJSONData:^{
//           
//            [block_self.collectView reloadData];
//            
//            block_self.homeHeadView.headData = block_self.headData;
//            
//            [block_self.collectView.mj_header endRefreshing];
//        }];
    }];
    
    [self.collectView.mj_header beginRefreshing];
}

#pragma mark - 设置导航条
- (void)changeNavi {
    
    /***************************导航条中间搜索框**************************************/
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.searchBar = searchBar;
    searchBar.delegate = self;
    searchBar.backgroundImage = [UIImage imageNamed:@"icon_homepage_search"];
    searchBar.placeholder = @"吊龙泉";
    self.navigationItem.titleView = searchBar;
    
    // 右边设置一个item（具体功能以后再想)
    // 不能使用默认的UIBarButtonItem，会变成系统默认颜色
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"category"] style:0 target:self action:@selector(rightClick)];
    
    
    
    /***************************导航条右边按钮****************************************/
    // 创建自定义item（用btn）
    UIButton *rightCategoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 强引用
    self.rightCategoryBtn = rightCategoryBtn;
    // 设置一下大小(这里就不必用自动布局了)
    rightCategoryBtn.frame = CGRectMake(0, 0, 40, 35);
    // 也不需要自适应
    //    [rightCategoryBtn sizeToFit];
    // 设置图片
    [rightCategoryBtn setImage:[UIImage imageNamed:@"category"] forState:UIControlStateNormal];
    // 设置点击事件
    [rightCategoryBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    // 设置为导航条右边的Item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightCategoryBtn];
    
}

#pragma mark - 导航条右边Item的点击事件
- (void)rightClick {
    
    JQLOGFUNC;
    
    JQWeatherViewController *vc = [[JQWeatherViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - searchBar的代理
// 开始编辑时调用
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    JQLOGFUNC;
    return YES;
}

#pragma mark - 创建UICollectView
- (void)buildCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 8;
    layout.minimumLineSpacing = 8;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectView = collectView;
    
    collectView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    [collectView registerClass:[JQHomeCategoryCell class] forCellWithReuseIdentifier:HOMECACELL];
    [collectView registerClass:[JQHomeCollectCell class] forCellWithReuseIdentifier:HOMECOLLECTCELL];
    collectView.delegate = self;
    collectView.dataSource = self;
    [self.view addSubview:collectView];
    [collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UICollectionView的代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //    JQLOG(@"%ld", [self.hotFoodModelsFromJSON count]);
    //    return [self.hotFoodModelsFromJSON count];
    return [self.categoryGoodsModelsFromJSON count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    JQHotFoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CETID forIndexPath:indexPath];
    //    cell.hotFoodModel = self.hotFoodModelsFromJSON[indexPath.row];
    
    JQHomeCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HOMECACELL forIndexPath:indexPath];
    cell.categoryGoods = self.categoryGoodsModelsFromJSON[indexPath.row];
    return cell;
}

// 每行cell的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize itemSize = CGSizeZero;
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    if (indexPath.section == 0) {
        itemSize = CGSizeMake(width, 310);
    }
    return itemSize;
}

// 选中哪一个view
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JQLOG(@"%ld", indexPath.row);
}

#pragma mark - 创建轮询器和头条
- (void)buildHomeHeadView{

    JQHeadView *homeHeadView = [[JQHeadView alloc] init];
    self.homeHeadView = homeHeadView;
    [self.collectView addSubview:self.homeHeadView];
    
}

#pragma mark - 监视头view高度的改变的一个通知
- (void)addNotification{
    
    [JQNotification addObserver:self selector:@selector(HomeHeadViewHeightDidChange:) name:@"HomeHeadViewHeightDidChange" object:nil];
}

#pragma mark - 头view改变后从头view最后一个子控件获取高度大小
- (void)HomeHeadViewHeightDidChange:(NSNotification *)notification{
    
    //    JQLOG(@"height = %lf",[notification.object floatValue]);
    CGFloat height = [notification.object floatValue];
    CGFloat room = 10;
    
    self.collectView.mj_header.ignoredScrollViewContentInsetTop = height + 10;
    self.homeHeadView.frame = CGRectMake(0, -height - room, SCREEN_WIDTH, height);
    self.collectView.contentInset = UIEdgeInsetsMake(height + room, 0, 50, 0);
    self.collectView.contentOffset = CGPointMake(0, -height - room);
}

#pragma mark - 异步加载数据
- (void)loadCollectJSONData:(void(^)()) then {
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
#warning 现在是模拟的json数据
        // 读取json数据
        // 获取json地址
        NSString *acFoodDataFilePath =[[NSBundle mainBundle] pathForResource:@"collectData" ofType:@"json"];
        
        // 获取二进制数据
        NSData *data = [NSData dataWithContentsOfFile:acFoodDataFilePath];
        
        // 转成字典
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
        
        // 转成数组
        NSArray *categoryGoodsDataArr = dataDictionary[@"categoryGoods"];
        NSMutableArray *categoryDataArrM = @[].mutableCopy;
        
        categoryDataArrM = [JQCategoryGoods mj_objectArrayWithKeyValuesArray:categoryGoodsDataArr];
        weakSelf.categoryGoodsModelsFromJSON = categoryDataArrM;
        
        //        NSString *headLineFilePath =[[NSBundle mainBundle] pathForResource:@"headLine" ofType:@"json"];
        
        // 获取二进制数据
        //        NSData *headLineData = [NSData dataWithContentsOfFile:headLineFilePath];
        
        // 转成字典
        //        NSDictionary *headLineDataDictionary = [NSJSONSerialization JSONObjectWithData:headLineData options: NSJSONReadingAllowFragments error:nil];
        //         JQHead *head = [JQHead mj_objectWithKeyValues:headLineDataDictionary];
        
        //        weakSelf.head = head;
        //        NSDictionary *headLineDict = headLineDataDictionary[@"headLine"];
        //        JQHeadLine *headLine = [JQHeadLine mj_objectWithKeyValues:headLineDict];
        //        weakSelf.headLine = headLine;
        
        NSString *headDataFilePath =[[NSBundle mainBundle] pathForResource:@"headData" ofType:@"json"];
        
        NSData *headData = [NSData dataWithContentsOfFile:headDataFilePath];
        
        NSDictionary *headDataDictionary = [NSJSONSerialization JSONObjectWithData:headData options: NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *headDataDict = headDataDictionary[@"headData"];
        //        JQLOG(@"dict:%@", headDataDict);
        JQHeadData *headDataModel = [JQHeadData mj_objectWithKeyValues:headDataDict];
        weakSelf.headData = headDataModel;
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !then ? : then();
        });
    });
}

@end
