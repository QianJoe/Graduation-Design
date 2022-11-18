//
//  JQMineBaseViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/4.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQMineBaseViewController.h"

@interface JQMineBaseViewController ()

@end

@implementation JQMineBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = BackgroundColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
