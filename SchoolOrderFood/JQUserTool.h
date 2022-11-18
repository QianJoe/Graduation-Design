//
//  JQUserTool.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/29.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JQUser;
@interface JQUserTool : NSObject

+ (void)saveUser:(NSDictionary *)userDict;
+ (id)getUserInfo:(NSString *)key;
- (void)deleteUserInfo:(NSString *)key;
- (void)modifyUserInfo:(NSDictionary *)dict;

+ (void)saveUserWithArchive:(JQUser *)user;
+ (id)getUserWithUnarchive;

@end
