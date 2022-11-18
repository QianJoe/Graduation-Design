//
//  JQWeatherHeaderView.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/9.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQWeatherData;

@interface JQWeatherHeaderView : UIView

@property (nonatomic , copy) void(^localBlock)();
@property (nonatomic , copy) void(^backBlock)();

- (void)setHeaderDataWithAry:(NSMutableArray *)weatherArray dt:(NSString *)dt weatherData:(JQWeatherData *)wd;

@end
