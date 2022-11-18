//
//  AppConfig.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/9.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfig : NSObject

+ (instancetype)sharedInstance;

+ (void)saveProAndCityInfoWithPro:(NSString *)pro city:(NSString *)city;
+ (NSString *)getProInfo;
+ (NSString *)getCityInfo;

@end
