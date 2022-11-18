//
//  JQBasicNaviController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/27.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQBasicNaviController.h"
#import "UIImage+Image.h"

@interface JQBasicNaviController ()

@end

@implementation JQBasicNaviController


+ (void)initialize{
    
    if (self == [JQBasicNaviController class]) {
        
        UIImage *navBackImg = [UIImage imageWithColor:naviColor];
        // appearanceWhenContainedIn获取当前类的标志
        UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
        [bar setBackgroundImage:navBackImg forBarMetrics:UIBarMetricsDefault];
        
        [bar setTintColor:[UIColor whiteColor]];
        // 设置导航条标题的字体和颜色
        NSDictionary *titleAttr = @{
                                    NSForegroundColorAttributeName:[UIColor whiteColor],
                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:22]
                                    };
        [bar setTitleTextAttributes:titleAttr];
        
//        // 把返回按钮的文字移除
//        UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[self]];
//        // Position 位置
//        [item setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -64) forBarMetrics:UIBarMetricsDefault];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 状态栏改成亮白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

@end
