//
//  JQShopDetailViewController.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/13.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQFoodModel;

@interface JQShopDetailViewController : UIViewController

/**持有一个foodModel*/
@property (nonatomic, strong) JQFoodModel *foodModel;

@end
