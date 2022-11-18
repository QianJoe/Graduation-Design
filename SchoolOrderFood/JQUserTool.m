//
//  JQUserTool.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/29.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQUserTool.h"
#import "JQUser.h"

@implementation JQUserTool

+ (void)saveUser:(NSDictionary *)userDict {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 取出所有的key
    NSArray * allkeys = [userDict allKeys];
    for (int i = 0; i < allkeys.count; i ++) {
        
        NSString * key = [allkeys objectAtIndex:i];
        
        // 如果你的字典中存储的多种不同的类型,那么最好用id类型去接受它
        id obj  = [userDict objectForKey:key];
        // 自动生成一个plist文件存放在偏好设置的文件夹
        [defaults setObject:obj forKey:key];
    }
    // 同步：把内存中的数据和沙盒同步
    [defaults synchronize];
}

+ (id)getUserInfo:(NSString *)key {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults objectForKey:key];
}

//删除数据
- (void)deleteUserInfo:(NSString *)key {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

//修改数据
- (void)modifyUserInfo:(NSDictionary *)dict {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 取出所有的key
    NSArray * allkeys = [dict allKeys];
    for (int i = 0; i < allkeys.count; i ++) {
        
        NSString * key = [allkeys objectAtIndex:i];
        
        // 如果你的字典中存储的多种不同的类型,那么最好用id类型去接受它
        id obj  = [dict objectForKey:key];
        // 自动生成一个plist文件存放在偏好设置的文件夹
        [defaults setObject:obj forKey:key];
    }
    
    [defaults synchronize];
}

+ (void)saveUserWithArchive:(JQUser *)user {
    
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"user.plist"];
    [NSKeyedArchiver archiveRootObject:user toFile:filePath];
}

+ (id)getUserWithUnarchive {
    
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"user.plist"];
    
    JQUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    return user;
}

@end
