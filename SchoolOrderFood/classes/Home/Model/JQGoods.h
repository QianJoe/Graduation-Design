//
//  JQGood.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/1.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQGoods : NSObject

/**原价*/
@property (nonatomic, copy) NSString *oldPrice;
/**折扣之后价格*/
@property (nonatomic, copy) NSString *discountPrice;
/**商品的图片的URL*/
@property (nonatomic, copy) NSString *goodsImageURL;
/**商品名*/
@property (nonatomic, copy) NSString *goodsName;
/**是否是热门："hot"为热门，其他为不是*/
@property (nonatomic, copy) NSString *isHot;


@end
