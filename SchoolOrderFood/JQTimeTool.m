//
//  JQTimeTool.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/2.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQTimeTool.h"

@implementation JQTimeTool

+ (instancetype)timeTool {
    
    return [[self alloc] init];
}

+ (NSInteger)getCurrentTimeSp {
    
    return (NSInteger)([[NSDate date] timeIntervalSince1970] * 1000);

}

- (NSString *)returnStrTime:(NSInteger)timeSp {
    
//    JQLOG(@"timeSpxxxx:%ld", timeSp);
    NSTimeInterval time = (double)(timeSp / 1000);
    
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    
    return currentDateStr;
}


- (NSString *)returnStrHMTime:(NSInteger)timeSp {
    
    //    JQLOG(@"timeSpxxxx:%ld", timeSp);
    NSTimeInterval time = (double)(timeSp / 1000);
    
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    
    return currentDateStr;
}


@end
