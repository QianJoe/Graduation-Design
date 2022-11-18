//
//  JQMineShopFoodManagementViewController.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/6.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQMineBaseViewController.h"
@class JQFoodTotalModel;

@interface JQMineShopFoodManagementViewController : JQMineBaseViewController

/**持有一个foodTotalModel*/
@property (nonatomic, strong) JQFoodTotalModel *foodTotalModel;
@end
