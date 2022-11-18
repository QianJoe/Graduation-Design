//
//  JQWeatherViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/9.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQWeatherViewController.h"
#import "JQWeatherHeaderView.h"
#import "JQWeatherBottomView.h"
#import "JQWeatherData.h"
#import "AppConfig.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JQLocaViewController.h"
#import "JQHttpRequestTool.h"
#import <MJExtension/MJExtension.h>

#define IMP_BLOCK_SELF(type) __weak type *block_self=self;

@interface JQWeatherViewController ()

@property (nonatomic , strong) NSMutableArray *weatherArray;

@property (nonatomic , strong) JQWeatherHeaderView *headerView;
///底部未来三天view
@property (nonatomic , strong) JQWeatherBottomView *bottomView;

@end

@implementation JQWeatherViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    
    NSString *pro = [AppConfig getProInfo];
    NSString *city = [AppConfig getCityInfo];
    
    if (pro && city) {
        [self requestNet:pro city:city];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.tabBarController.tabBar.hidden = YES;

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma mark - network
- (void)requestNet:(NSString *)pro city:(NSString *)city
{
    IMP_BLOCK_SELF(JQWeatherViewController);
    
    NSString *urlstr = [NSString stringWithFormat:@"http://c.3g.163.com/nc/weather/%@|%@.html",pro,city];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[JQHttpRequestTool shareHttpRequestTool] runRequestWithPara:nil path:urlstr success:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSString *str = [NSString stringWithFormat:@"%@|%@",pro,city];
        NSArray *dataArray = [JQWeatherData mj_objectArrayWithKeyValuesArray:responseObject[str]];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (JQWeatherData *weather in dataArray) {
            
            [tempArray addObject:weather];
        }
        block_self.weatherArray = tempArray;
        
        //pm2d5
        JQWeatherData *wd = [JQWeatherData mj_objectWithKeyValues:responseObject[@"pm2d5"]];
        
        [block_self.headerView setHeaderDataWithAry:block_self.weatherArray dt:responseObject[@"dt"] weatherData:wd];
        
        //底部未来三天数据
        [block_self.bottomView setDataWithAry:block_self.weatherArray];
        
    } failure:^(id error) {
        
    }];
}

#pragma mark - lazy
- (NSMutableArray *)weatherArray
{
    if(!_weatherArray){
        _weatherArray = [NSMutableArray array];
    }
    return _weatherArray;
}

- (JQWeatherBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[JQWeatherBottomView alloc] init];
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

- (JQWeatherHeaderView *)headerView
{
    if (!_headerView) {
        
        _headerView = [[JQWeatherHeaderView alloc] init];
        [self.view addSubview:_headerView];
    }
    
    IMP_BLOCK_SELF(JQWeatherViewController);
    
    _headerView.localBlock = ^{
        
        NSString *city = [AppConfig getCityInfo];
        JQLocaViewController *locaV = [[JQLocaViewController alloc] init];
        locaV.currentTitle = city;
        locaV.view.backgroundColor = [UIColor whiteColor];
        
        locaV.CityBlock = ^(NSString *provice, NSString *city){
            
            block_self.weatherArray = nil;
            [SVProgressHUD showWithStatus:@"正在加载..."];
            [block_self requestNet:provice city:city];
            [AppConfig saveProAndCityInfoWithPro:provice city:city];
        };
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:locaV];
        [block_self.navigationController presentViewController:nav animated:YES completion:nil];
    };
    
    _headerView.backBlock = ^{

        [block_self.navigationController popViewControllerAnimated:YES];

    };
    return _headerView;
}

@end
