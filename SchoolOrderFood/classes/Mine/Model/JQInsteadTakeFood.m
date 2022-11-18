//
//  JQInsteadTakeFood.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/31.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQInsteadTakeFood.h"
#import <MJExtension/MJExtension.h>

@implementation JQInsteadTakeFood
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"buyedfood_id" : @"id"
             };
}
@end
