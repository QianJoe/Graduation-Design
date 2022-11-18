//
//  JQAboutViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/9.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQAboutViewController.h"
#import "JQSettingArrowItem.h"
#import "JQSettingGroup.h"
@interface JQAboutViewController ()

@end

@implementation JQAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JQSettingArrowItem *item1 = [JQSettingArrowItem itemWithTitle:@"应用评分"];
    
    item1.operation = ^(NSIndexPath *indexPath){
        /*1.评分
         》使用UIApplication打开URL 如 "itms-apps://itunes.apple.com/cn/app/id%@?mt=8"
         》注意把id替换成appid //eg.725296055
         》什么是appID,每个应用上架后就有个application ID*/
        NSString *url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/%@?mt=8", @"123123123"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        
    };
    
    JQSettingArrowItem *item2 = [JQSettingArrowItem itemWithTitle:@"客服电话"];
    
    item2.subTitle = @"10086";
    item2.operation = ^(NSIndexPath *indexPath){
        
        NSURL *url = [NSURL URLWithString:@"tel://10010"];
        [[UIApplication sharedApplication] openURL:url];
    };
    //解决引用

    // 创建组模型
    JQSettingGroup *group = [JQSettingGroup groupWithItems:@[item1, item2]];
    
    // 添加到总数组中
    [self.groups addObject:group];


}

@end
