//
//  JQCitiesGroup.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/9.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQCitiesGroup : NSObject

@property (nonatomic , strong) NSArray *cities;
@property (nonatomic , copy) NSString *state;

/**
 *  标识这组是否需要展开,  YES : 展开 ,  NO : 关闭
 */
@property (nonatomic, assign, getter = isOpened) BOOL opened;
@end
