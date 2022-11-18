//
//  JQBasicTabBarController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/27.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQBasicTabBarController.h"
#import "JQBasicNaviController.h"
#import "JQHomeTableViewController.h"
#import "JQMineViewController.h"
#import "JQSelectFoodViewController.h"
#import "JQOrderViewController.h"
#import "JQShopCarTool.h"

@interface JQBasicTabBarController ()

@end

@implementation JQBasicTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景颜色
    self.view.backgroundColor = BackgroundColor;
    
    [self initChildVC];
    [self addNotification];
}

- (void)initChildVC {
    
    // 首页
    JQHomeTableViewController *homeVC = [[JQHomeTableViewController alloc] init];
    [self createChildVCWithVC:homeVC Title:@"首页" Image:@"home_normal" SelectedImage:@"home_pressed"];
    
    // 挑食（按分类选择）
    JQSelectFoodViewController *foodVC = [[JQSelectFoodViewController alloc] init];
    [self createChildVCWithVC:foodVC Title:@"挑食" Image:@"food_normal" SelectedImage:@"food_pressed"];
    
    // 订单
    JQOrderViewController *orderVC = [[JQOrderViewController alloc] init];
    [self createChildVCWithVC:orderVC Title:@"订单" Image:@"order_normal" SelectedImage:@"order_pressed"];
    
    // 个人信息
    JQMineViewController *mineVC = [[JQMineViewController alloc] init];
    [self createChildVCWithVC:mineVC Title:@"我的" Image:@"mine_normal" SelectedImage:@"mine_pressed"];
}

#pragma mark - 创建tabBar对应的VC
- (void)createChildVCWithVC:(UIViewController *)childVC Title:(NSString *)title Image:(NSString *)image SelectedImage:(NSString *)selectedimage {
    
    //设置子控制器的文字
    // childVC.tabBarItem.title =title;
    // childVC.navigationItem.title =title;
    //等价于
    childVC.title = title;//同时设置tabbar和navigation的标题
    
    //设置文字的样式
    NSMutableDictionary *textAttrs = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *selectedtextAttrs = [[NSMutableDictionary alloc]init];
    
    textAttrs[NSForegroundColorAttributeName] = tabbarTitleColor;
    selectedtextAttrs[NSForegroundColorAttributeName] = tabbarTitleSelectedColor;
    
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:selectedtextAttrs forState:UIControlStateSelected];
    
    //设置子控制器的图片
    childVC.tabBarItem.image =[UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedimage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //这句话的意思是声明这张图片按照原始的样子显示出来，不要自动渲染成其他颜色
    // childVC.view.backgroundColor = RandomColor;
    
    //给子控制器包装导航控制器
    JQBasicNaviController *nav = [[JQBasicNaviController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

#pragma mark - 重写view大小
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUInteger count = self.tabBar.subviews.count;
    for (int i = 0; i<count; i++) {
        UIView *child = self.tabBar.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            CGRect frameT = self.tabBar.frame;
            
            CGRect frame = child.frame;
            frame.size.width = frameT.size.width / count;
            child.frame = frame;
        }
    }
}

#pragma mark - 添加通知

- (void)addNotification{
    
    [JQNotification addObserver:self selector:@selector(increaseShoppingCar) name:JQFoodChangedNotification object:nil];
}

#pragma mark - badge红点提示
- (void)increaseShoppingCar {
    
    UIViewController *orderVC = self.childViewControllers[2];
    
    NSInteger foodNumber = [[JQShopCarTool sharedInstance] getShopCarFoodNumber];
    
    if (foodNumber == 0) {
        
        orderVC.tabBarItem.badgeValue = nil;
        return;
    }
    
    orderVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd", foodNumber];
}

#pragma mark - 程序结束，移除通知
- (void)dealloc {
    [JQNotification removeObserver:self];
}

@end
