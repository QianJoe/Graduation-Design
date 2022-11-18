//
//  JQWeekListViewController.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/4.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JQMineBaseViewController.h"
@class JQNavTabBar;

@interface JQWeekListViewController : JQMineBaseViewController
@property (nonatomic, assign)   BOOL        scrollAnimation;            // Default value: NO
@property (nonatomic, assign)   BOOL        mainViewBounces;            // Default value: NO

@property (nonatomic, strong)NSArray *subViewControllers;

@property (nonatomic, strong)UIColor  *navTabBarColor;
@property (nonatomic, strong)UIColor  *navTabBarLineColor;

@end
