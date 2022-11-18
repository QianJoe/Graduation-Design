//
//  JQFoodTableViewCell.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/10.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const FOODTBCELL;
@class JQFoodModel;

@interface JQFoodTableViewCell : UITableViewCell

/**食物模型*/
@property (nonatomic, strong) JQFoodModel *foodModel;

@end
