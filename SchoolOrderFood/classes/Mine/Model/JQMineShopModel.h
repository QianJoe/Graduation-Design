//
//  JQMineShopModel.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/5.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JQFoodTotalModel;

@interface JQMineShopModel : NSObject

/**id*/
@property (nonatomic, assign) int shop_id;
/**店名*/
@property (nonatomic, copy) NSString *shopName;

/**商店图片*/
@property (nonatomic, copy) NSString *shopImgName;

/**地址*/
@property (nonatomic, copy) NSString *location;

/**电话*/
@property (nonatomic, assign) NSInteger phone;

/**分类*/
@property (nonatomic, copy) NSString *category;

/**运营开始时间(unix时间戳)*/
@property (nonatomic, copy) NSString *startTime;

/**运营结束时间*/
@property (nonatomic, copy) NSString *endTime;

/**食物数组*/
@property (nonatomic, strong) NSMutableArray<JQFoodTotalModel *> *foodTotalModelArray;

@end
