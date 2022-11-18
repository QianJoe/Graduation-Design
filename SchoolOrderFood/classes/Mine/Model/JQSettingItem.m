//
//  JQSettingItem.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/8.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQSettingItem.h"

@implementation JQSettingItem

+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title {

    JQSettingItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title {
    
    return [self itemWithImage:nil title:title];
}

@end
