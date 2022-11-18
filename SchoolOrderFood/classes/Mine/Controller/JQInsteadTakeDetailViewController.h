//
//  JQInsteadTakeDetailViewController.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/4.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JQMineBaseViewController.h"
@class JQInsteadTakeFood;

@interface JQInsteadTakeDetailViewController : JQMineBaseViewController

/**持有一个JQInsteadTakeFood*/
@property (nonatomic, strong) JQInsteadTakeFood *foodTotalModel;

@end
