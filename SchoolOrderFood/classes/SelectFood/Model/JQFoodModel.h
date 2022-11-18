//
//  JQFoodModel.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/10.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQFoodModel : NSObject

/**食物名字*/
@property (nonatomic, copy) NSString *name;
/**食物所属分类*/
@property (nonatomic, copy) NSString *category;
/**食物成分*/
@property (nonatomic, copy) NSString *content;
/**食物所在商店*/
@property (nonatomic, copy) NSString *location;
/**商店联系方式*/
@property (nonatomic, copy) NSString *contact;
/**食物图片*/
@property (nonatomic, copy) NSString *foodImgName;
/**食物价格*/
@property (nonatomic, copy) NSString *price;
/**受欢迎的星星*/
@property (nonatomic, assign) NSInteger favCount;

@end
