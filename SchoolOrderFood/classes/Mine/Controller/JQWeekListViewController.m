//
//  JQWeekListViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/4.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQWeekListViewController.h"
#import "JQNavTabBar.h"
#import "JQWeekDetailViewController.h"

@interface JQWeekListViewController () <UIScrollViewDelegate, JQNavTabBarDelegate>

/**当前角标*/
@property (nonatomic, assign) NSInteger currentIndex;
/**标题数组*/
@property (nonatomic, strong) NSMutableArray *titles;
/**顶部*/
@property (nonatomic, strong) JQNavTabBar *navTabBar;
/**UIScrollView*/
@property (nonatomic, strong) UIScrollView *mainView;

@end

@implementation JQWeekListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self initControl];
    [self initConfig];
    [self viewConfig];
}

- (void)initControl {
    
    NSArray *namearray = [NSArray array];
    namearray = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSArray *contentarray = [NSArray array];
    contentarray = @[@"mon",@"tues",@"wed",@"thur",@"fri",@"sat"];
    
    NSMutableArray *viewArray = [NSMutableArray array];
    
    JQWeekDetailViewController *oneViewController = [[JQWeekDetailViewController alloc] init];
    oneViewController.title = @"星期日";
    oneViewController.dataContent = @"sun";
    
    [viewArray addObject:oneViewController];
    
    for(int i = 0; i < namearray.count; i++){
        JQWeekDetailViewController *otherViewController = [[JQWeekDetailViewController alloc] init];
        otherViewController.title = namearray[i];
        otherViewController.dataContent = contentarray[i];
        [viewArray addObject:otherViewController];
    }
    
    _subViewControllers = [NSArray array];
    _subViewControllers = viewArray;
}

- (void)initConfig {
    
    _currentIndex = 1;
    
    _titles = [[NSMutableArray alloc] initWithCapacity:_subViewControllers.count];
    
    for (UIViewController *viewController in _subViewControllers) {
        [_titles addObject:viewController.title];
    }
}

- (void)viewConfig {
    [self viewInit];
    
    //首先加载第一个视图
    //    UIViewController *viewController = (UIViewController *)_subViewControllers[0];
    //    viewController.view.frame = CGRectMake(0 , 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    //    [_mainView addSubview:viewController.view];
    //    [self addChildViewController:viewController];
}

#pragma mark - 初始化view
- (void)viewInit {
    
    // 顶部自定义滚动tabbar
    _navTabBar = [[JQNavTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 64)];
    _navTabBar.backgroundColor = [UIColor whiteColor];
    _navTabBar.delegate = self;
    _navTabBar.lineColor = _navTabBarLineColor;
    _navTabBar.itemTitles = _titles;
    [_navTabBar updateData];
    [self.view addSubview:_navTabBar];
    
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _mainView.delegate = self;
    _mainView.pagingEnabled = YES;
    _mainView.bounces = _mainViewBounces;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.showsVerticalScrollIndicator = NO;
    _mainView.contentSize = CGSizeMake(SCREEN_WIDTH * _subViewControllers.count, 0);
    [self.view addSubview:_mainView];
    
    UIView *linev = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    linev.backgroundColor = [UIColor colorWithRed:216/255.0f green:216/255.0f blue:216/255.0f alpha:1];
    [self.view addSubview:linev];
}

//-(void)weatherClick
//{
//    WeatherViewController *vc = [[WeatherViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//}


#pragma mark - Scroll View Delegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    _navTabBar.currentItemIndex = _currentIndex;
    
    /** 当scrollview滚动的时候加载当前视图 */
    UIViewController *viewController = (UIViewController *)_subViewControllers[_currentIndex];
    viewController.view.frame = CGRectMake(_currentIndex * SCREEN_WIDTH, 0, SCREEN_WIDTH, _mainView.frame.size.height);
    [_mainView addSubview:viewController.view];
    [self addChildViewController:viewController];
}


- (void)itemDidSelectedWithIndex:(NSInteger)index withCurrentIndex:(NSInteger)currentIndex {
    
    if (currentIndex-index>=2 || currentIndex-index<=-2) {
        
        [_mainView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:NO];
        
    } else {
        
        [_mainView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
    }
}

@end
