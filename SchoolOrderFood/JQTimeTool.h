//
//  JQTimeTool.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/2.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQTimeTool : NSObject

+ (instancetype)timeTool;

+ (NSInteger)getCurrentTimeSp;
//+ (NSString *)getCurrentTimeStr;
- (NSString *)returnStrTime:(NSInteger)timeSp;
- (NSString *)returnStrHMTime:(NSInteger)timeSp;
@end
