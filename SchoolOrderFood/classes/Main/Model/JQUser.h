//
//  JQUser.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/30.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JQUserInfo;

@interface JQUser : NSObject

/**id*/
@property (nonatomic, assign) int user_id;
/**账号*/
@property (nonatomic, copy) NSString *account;
/**密码*/
@property (nonatomic, copy) NSString *pwd;
/**isSeller*/
@property (nonatomic, copy) NSString *isSeller;
/**信息*/
@property (nonatomic, strong) JQUserInfo *userinfo;

@end
