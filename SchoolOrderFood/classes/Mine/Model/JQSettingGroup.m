//
//  JQSettingGroup.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/8.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQSettingGroup.h"

@implementation JQSettingGroup

+ (instancetype)groupWithItems:(NSArray *)items{
    
    JQSettingGroup *group = [[JQSettingGroup alloc] init];
    group.items = items;
    return group;
}

@end
