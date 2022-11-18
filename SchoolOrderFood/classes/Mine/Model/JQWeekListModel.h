//
//  JQWeekListModel.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/8.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JQWeekEveryDayModel;

@interface JQWeekListModel : NSObject

/**sun*/
@property (nonatomic, strong) JQWeekEveryDayModel *sun;
/**mon*/
@property (nonatomic, strong) JQWeekEveryDayModel *mon;
/**tues*/
@property (nonatomic, strong) JQWeekEveryDayModel *tues;
/**wed*/
@property (nonatomic, strong) JQWeekEveryDayModel *wed;
/**thur*/
@property (nonatomic, strong) JQWeekEveryDayModel *thur;
/**fri*/
@property (nonatomic, strong) JQWeekEveryDayModel *fri;
/**sat*/
@property (nonatomic, strong) JQWeekEveryDayModel *sat;
@end
