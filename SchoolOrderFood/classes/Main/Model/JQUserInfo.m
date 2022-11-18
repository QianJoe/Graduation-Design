//
//  JQUserInfo.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/30.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQUserInfo.h"
#import <MJExtension/MJExtension.h>

@implementation JQUserInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"userInfo_id" : @"id"
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
//    [aCoder encodeInteger:self.userInfo_id forKey:@"userInfo_id"];
//    [aCoder encodeObject:self.username forKey:@"username"];
//    [aCoder encodeObject:self.sex forKey:@"sex"];
//    [aCoder encodeObject:self.phone forKey:@"phone"];
//    [aCoder encodeObject:self.location forKey:@"location"];
//    [aCoder encodeInteger:self.uid forKey:@"uid"];
//
//}
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
//        _userInfo_id = [aDecoder decodeIntForKey:@"userInfo_id"];
//        _username = [aDecoder decodeObjectForKey:@"username"];
//        _sex = [aDecoder decodeObjectForKey:@"sex"];
//        _phone = [aDecoder decodeObjectForKey:@"phone"];
//        _location = [aDecoder decodeObjectForKey:@"location"];
//        _uid = [aDecoder decodeIntForKey:@"uid"];
//    }
//    return self;
//}
@end
