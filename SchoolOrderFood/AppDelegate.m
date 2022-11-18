//
//  AppDelegate.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/27.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "AppDelegate.h"
#import "JQBasicTabBarController.h"
#import "JQStartManager.h"
#import "AppConfig.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - 入口方法
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 设置根控制器
    [self setRootVC];
    
    // 初始化配置
    [self initConfig];
    
    return YES;
}

#pragma mark - 设置根控制器
- (void)setRootVC {
    
    // 注意这里initWithFrame在9.0之后就不需要了，直接用init
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 强引用
    self.window = window;
    
    // 创建根控制器，因为使用的是底部菜单，所以使用tabBarVC，当然是自定义的23333
    JQBasicTabBarController *tbVc = [[JQBasicTabBarController alloc] init];
    // 将创建好的根控制器，让窗口强引用
    window.rootViewController = tbVc;
    
    // 将窗口显示出来
    [self.window makeKeyAndVisible];
}

- (void)initConfig {
    
    [JQStartManager sharedInstance];
    [AppConfig sharedInstance];
}

# pragma mark - 主代理方法的其他一些方法
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
