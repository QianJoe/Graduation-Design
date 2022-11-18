//
//  JQMineShopModel.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/5.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQMineShopModel.h"
#import <MJExtension/MJExtension.h>

@implementation JQMineShopModel
+ (NSDictionary *)mj_objectClassInArray {
    
    return @{
             @"foodTotalModelArray" : @"JQFoodTotalModel",
             };
}
@end
