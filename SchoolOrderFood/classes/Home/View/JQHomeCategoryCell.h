//
//  JQHomeCategoryCell.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/1.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQCategoryGoods;

UIKIT_EXTERN NSString * const HOMECACELL;

@interface JQHomeCategoryCell : UICollectionViewCell

/**持有一个分类商品的数据模型*/
@property (nonatomic, strong) JQCategoryGoods *categoryGoods;

@end
