//
//  JQWeekEveryDayModel.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/8.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JQFoodTotalModel;

@interface JQWeekEveryDayModel : NSObject
/**早餐*/
@property (nonatomic, strong) JQFoodTotalModel *breakfast;
/**午餐*/
@property (nonatomic, strong) JQFoodTotalModel *lunch;
/**晚餐*/
@property (nonatomic, strong) JQFoodTotalModel *dinner;
@end
