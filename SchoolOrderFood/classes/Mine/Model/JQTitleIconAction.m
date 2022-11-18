//
//  JQTitleIconAction.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/5.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQTitleIconAction.h"

@implementation JQTitleIconAction

+ (instancetype)titleIconWith:(NSString *)title icon:(UIImage *)image controller:(UIViewController *)controlller tag:(NSInteger )tag{
    
    JQTitleIconAction *titleIconAction = [[JQTitleIconAction alloc] init];
    
    titleIconAction.title = title;
    titleIconAction.icon = image;
    titleIconAction.controller = controlller;
    titleIconAction.tag = tag;
    
    return titleIconAction;
}

@end
