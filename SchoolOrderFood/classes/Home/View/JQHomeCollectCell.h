//
//  JQhomeCollectCell.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/1.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQGoods;
UIKIT_EXTERN NSString * const HOMECOLLECTCELL;

@interface JQHomeCollectCell : UICollectionViewCell

/**持有一个商品数据模型*/
@property (nonatomic, strong) JQGoods *goods;
@end
