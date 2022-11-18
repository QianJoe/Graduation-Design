//
//  JQMineShopFoodView.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/7.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQMineShopFoodView, JQFoodTotalModel;

@protocol JQMineShopFoodViewDelegate <NSObject>

@required
- (void)mineShopFoodViewEdit:(JQMineShopFoodView *)mineShopFoodView foodTotalModel:(JQFoodTotalModel *)foodTotalModel andArray:(NSMutableArray *)foodTotalModelArrayM;

- (void)mineShopFoodViewAdd:(JQMineShopFoodView *)mineShopFoodView;

@end

@interface JQMineShopFoodView : UIView

/**持有一个数据模型数组*/
@property (nonatomic, strong) NSMutableArray *foodTotalModelArrayM;

/**代理*/
@property (nonatomic, weak) id<JQMineShopFoodViewDelegate> delegate;

@end
