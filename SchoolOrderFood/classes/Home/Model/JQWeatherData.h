//
//  JQWeatherData.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/9.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQWeatherData : NSObject

/*
 
 "wind": "微风",
 "nongli": "农历九月初一日",
 "date": "13日",
 "climate": "晴",
 "temperature": "26°C/11°C",
 "week": "星期二"
 
 "dt": "2015-10-13",
 "rt_temperature": 22,
 "pm2d5": {
 "nbg1": "http://img1.cache.netease.com/m/newsapp/weather/TianQi370/QingTian.jpg",
 "nbg2": "http://img1.cache.netease.com/m/newsapp/weather/TianQi1008/QingTian.jpg",
 "aqi": "53",
 "pm2_5": "22"
 }
 
 */

@property (nonatomic , copy) NSString * wind;         //风
@property (nonatomic , copy) NSString * date;         //日期
@property (nonatomic , copy) NSString * climate;      //天气
@property (nonatomic , copy) NSString * temperature;  //温度
@property (nonatomic , copy) NSString * week;         //星期几

@property (nonatomic , copy) NSString * nbg2;         //背景图
@property (nonatomic , copy) NSString * aqi;          //空气质量
@property (nonatomic , copy) NSString * pm2_5;

@end
