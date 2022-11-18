//
//  JQHttpRequestTool.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/21.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQHttpRequestTool : NSObject

typedef NS_ENUM(NSInteger, RequestMethod)
{
    POST,
    GET
};

+ (instancetype)shareHttpRequestTool;

- (void)runRequestWithPara:(NSMutableDictionary *)para
                      path:(NSString *)path
                   success:(void(^)(id responseObject))success
                   failure:(void(^)(id error))failure;


/**
 * requestMethod:请求方式
 * urlString:请求地址
 * parameters:请求参数
 * responseBlock:请求成功或失败的回调
 */
- (void)requestWithMethod:(RequestMethod)requestMethod andUrlString:(NSString *)urlString andParameters:(id) parameters andFinished:(void(^)(id response, NSError *error))responseBlock;

/**
 * data:上传资料
 * name:上传到服务器的保存的key
 * fileName:图片的名字，要有后缀.jpg
 * urlString:请求地址
 * parameters:请求参数
 * responseBlock:请求成功或失败的回调
 */
- (void)requestWithData:(NSData *)data andName:(NSString *)name andFileName:(NSString *)fileName andUrlString:(NSString *)urlString andParameters:(id) parameters andFinished:(void(^)(id response, NSError *error))responseBlock;

@end
