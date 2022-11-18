//
//  JQPushSettingViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/9.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQPushSettingViewController.h"
#import "JQSettingArrowItem.h"
#import "JQSettingGroup.h"
#import "JQSettingSwitchItem.h"

@interface JQPushSettingViewController ()

@end

@implementation JQPushSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupGroup0];

}

/**第0组*/
- (void)setupGroup0{
    
    // 第0组
    JQSettingArrowItem *item1 = [JQSettingArrowItem itemWithTitle:@"点餐提醒"];
    
    JQSettingArrowItem *item2 = [JQSettingArrowItem itemWithTitle:@"外卖提醒"];
    
    JQSettingSwitchItem *item3 = [JQSettingSwitchItem itemWithTitle:@"推送新版"];
    item3.open = YES;
    
    // 创建组模型
    JQSettingGroup *group = [JQSettingGroup groupWithItems:@[item1, item2, item3]];
    
    // 添加到总数组中
    [self.groups addObject:group];
}

@end
