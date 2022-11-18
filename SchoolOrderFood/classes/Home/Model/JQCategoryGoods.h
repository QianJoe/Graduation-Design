//
//  JQCategoryGoods.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/1.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JQGoods.h"

@interface JQCategoryGoods : NSObject

/**有一个存放相同类型的goods数组*/
@property (nonatomic, strong) NSArray<JQGoods *> *goodsArr;

/**分类名，用于每个分类cell的headview中的标题titleLabel*/
@property (nonatomic, copy) NSString *categoryGoodsName;

/**分类名和线的颜色*/
@property (nonatomic, copy) NSString *categoryHeadBackGroundColor;

/**分类图片的URL,用于每个分类cell的中的titleImgView*/
@property (nonatomic, copy) NSString *titleImgURL;

@end
