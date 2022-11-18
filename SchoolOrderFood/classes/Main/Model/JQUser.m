//
//  JQUser.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/30.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQUser.h"
#import <MJExtension/MJExtension.h>
#import "JQUserInfo.h"

@implementation JQUser

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"user_id" : @"id"
             };
}
MJCodingImplementation
///**
// *  在它归档时调用这个方法
// *  哪些属性需要归档
// *  这些属性怎么归档
// *  @param aCoder
// */
//- (void)encodeWithCoder:(NSCoder *)aCoder{
//    
//    [aCoder encodeInteger:self.user_id forKey:@"user_id"];
//    [aCoder encodeObject:self.account forKey:@"account"];
//    [aCoder encodeObject:self.pwd forKey:@"pwd"];
//    [aCoder encodeObject:self.isSeller forKey:@"isSeller"];
//    [aCoder encodeObject:self.userinfo forKey:@"userinfo"];
//    
//}
//
///**
// *  在它解档的时候调用这个方法
// *  哪些属性需要解档
// *  这些属性怎么解档
// *  @param aDecoder
// *
// *  @return 对象
// */
//- (id)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super init]) {//在加载xib时也会调用这个方法，因为xib也是文件，也需要解档
//        
//        _user_id = [aDecoder decodeIntForKey:@"user_id"];
//        _account = [aDecoder decodeObjectForKey:@"account"];
//        _pwd = [aDecoder decodeObjectForKey:@"sex"];
//        _isSeller = [aDecoder decodeObjectForKey:@"isSeller"];
//        _userinfo = [aDecoder decodeObjectForKey:@"userinfo"];
//    }
//    return self;
//}

@end
