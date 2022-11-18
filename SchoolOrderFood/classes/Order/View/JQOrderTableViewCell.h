//
//  JQOrderTableViewCell.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/26.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQFoodTotalModel, JQOrderTableViewCell;

UIKIT_EXTERN NSString * const ORDERTABLEVIEWCELLID;

@protocol JQOrderTableViewCellDeleagte <NSObject>

@required
- (void)orderCellPlusBtnClick:(JQOrderTableViewCell *)cell;
- (void)orderCellMinusBtnClick:(JQOrderTableViewCell *)cell;

- (void)orderCellSelectedBtnClick:(JQOrderTableViewCell *)cell;
- (void)orderCellNoSelectedBtnClick:(JQOrderTableViewCell *)cell;

@end

@interface JQOrderTableViewCell : UITableViewCell

/**持有一个food模型*/
@property (nonatomic, strong) JQFoodTotalModel *foodTotalModel;
/**代理*/
@property (nonatomic, weak) id<JQOrderTableViewCellDeleagte> delegate;

@end
