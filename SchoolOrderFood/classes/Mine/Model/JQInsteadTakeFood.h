//
//  JQInsteadTakeFood.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/31.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQInsteadTakeFood : NSObject

/**id*/
@property (nonatomic, assign) int buyedfood_id;
/**个人手机*/
@property (nonatomic, copy) NSString *personphone;

/**food*/
/**食物id*/
@property (nonatomic, assign) int food_id;

/**图片(url)*/
@property (nonatomic, copy) NSString *image;

/**名称*/
@property (nonatomic, copy) NSString *name;

/**单价*/
@property (nonatomic, copy) NSString *money;

/**购买的数量*/
@property (nonatomic, assign) NSInteger count;

/**总数量*/
@property (nonatomic, assign) NSInteger totalCount;

/**是否减少*/
@property (nonatomic, assign) NSInteger minus;

/**是否被选中*/
@property (nonatomic, assign, getter=isChecked) BOOL check;

/**商店电话*/
@property (nonatomic, assign) NSInteger phone;

/**分类*/
@property (nonatomic, copy) NSString *category;

/**所在地点*/
@property (nonatomic, copy) NSString *location;

/**取餐时间(unix时间戳)*/
@property (nonatomic, assign) NSInteger takeFoodTime;

/**下单时间*/
@property (nonatomic, assign) NSInteger orderFoodTime;

/**是否允许被帮带 1为允许带，0为不允许没有*/
@property (nonatomic, assign, getter=isAllowTaked) BOOL allowTake;

/**是否已经被帮带 1为帮带，0为没有*/
@property (nonatomic, assign, getter=isTaked) BOOL take;

/**被谁带了*/
@property (nonatomic, copy) NSString *takeName;

/**是否已经取餐 1为已经取餐，0为没有取餐*/
@property (nonatomic, assign, getter=isGetFood) BOOL getFood;

/**代拿的费用*/
@property (nonatomic, copy) NSString *takeMoney;

@end
