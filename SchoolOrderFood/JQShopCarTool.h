//
//  JQShopCarTool.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/27.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JQFoodTotalModel;

@interface JQShopCarTool : NSObject

/**存放foodtotalmodel的可变数组*/
@property (nonatomic, strong) NSMutableArray<JQFoodTotalModel *> *shopCar;

/**已经购买的*/
@property (nonatomic, strong) NSMutableArray<JQFoodTotalModel *> *buyFoodArrayM;

/**单例*/
+ (instancetype)sharedInstance;

/**添加食物到购物车*/
- (void)addFoodToShopCar:(JQFoodTotalModel *)foodTotalModel;

/**从购物车删除食物*/
- (void)removeFromFoodShopCar:(JQFoodTotalModel *)foodTotalModel;

/**获取总价格*/
- (CGFloat)getShopCarTotalPrice;

/**获取购物车食物数量*/
- (NSInteger)getShopCarFoodNumber;

/**购物车是否为空*/
- (BOOL)isEmpty;

/**将购物车里的食物添加到已经购买的*/
- (void)addShopCarAllFoodToBuyedArray;

@end
