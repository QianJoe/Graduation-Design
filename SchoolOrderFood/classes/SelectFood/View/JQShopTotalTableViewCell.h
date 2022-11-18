//
//  JQShopTotalTableViewCell.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/21.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQFoodTotalModel, JQShopTotalTableViewCell;

UIKIT_EXTERN NSString * const SHOPTOTALTABLEVIEWCELLID;

@protocol JQShopTotalTableViewCellDeleagte <NSObject>

@required
- (void)shopTotalCellPlusBtnClick:(JQShopTotalTableViewCell *)cell;
- (void)shopTotalCellMinusBtnClick:(JQShopTotalTableViewCell *)cell;

@end

@interface JQShopTotalTableViewCell : UITableViewCell

/**持有一个foodtotalmodel*/
@property (nonatomic, strong) JQFoodTotalModel *foodTotalModel;

/**代理*/
@property (nonatomic, weak) id<JQShopTotalTableViewCellDeleagte> delegate;

@end
