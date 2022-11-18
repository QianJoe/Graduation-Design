//
//  JQUserInfo.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/30.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQUserInfo : NSObject

/**id*/
@property (nonatomic, assign) NSInteger userInfo_id;
/**username*/
@property (nonatomic, copy) NSString *username;
/**sex*/
@property (nonatomic, copy) NSString *sex;
/**phone*/
@property (nonatomic, copy) NSString *phone;
/**location*/
@property (nonatomic, copy) NSString *location;
/**uid*/
@property (nonatomic, assign) NSInteger uid;

@end
