//
//  JQHttpRequestTool.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/21.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQHttpRequestTool.h"
#import "AFNetworking.h"

@implementation JQHttpRequestTool

static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)shareHttpRequestTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

- (void)runRequestWithPara:(NSMutableDictionary *)para
                      path:(NSString *)path
                   success:(void(^)(id responseObject))success
                   failure:(void(^)(id error))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:path parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        JQLOG(@" --%@ %@",path,responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        JQLOG(@" --%@ %@",path,error);
        failure(error);
    }];
}

- (void)requestWithMethod:(RequestMethod)requestMethod andUrlString:(NSString *)urlString andParameters:(id) parameters andFinished:(void(^)(id response, NSError *error))responseBlock
{
    // 定义成功的block
    void (^success)(NSURLSessionDataTask *dataTask, id responseObject) = ^(NSURLSessionDataTask *dataTask,id responseObject)
    {
        responseBlock(responseObject, nil);
    };
    // 定义失败的block
    void (^failure)(NSURLSessionDataTask *dataTask,NSError *error) = ^(NSURLSessionDataTask *dataTask,NSError *error)
    {
        responseBlock(nil, error);
    };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];//响应
    if (requestMethod == GET) {
        
        [manager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:success failure:failure];
        
//        [[AFHTTPSessionManager manager] GET:urlString parameters:parameters success:success failure:failure];
    } else {
        [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:success failure:failure];
//        [[AFHTTPSessionManager manager] POST:urlString parameters:parameters success:success failure:failure];
    }
}

- (void)requestWithData:(NSData *)data andName:(NSString *)name andFileName:(NSString *)fileName andUrlString:(NSString *)urlString andParameters:(id) parameters andFinished:(void(^)(id response, NSError *error))responseBlock
{
    void (^success)(NSURLSessionDataTask *dataTask, id responseObject) = ^(NSURLSessionDataTask *dataTask,id responseObject)
    {
        responseBlock(responseObject, nil);
    };
    void (^failure)(NSURLSessionDataTask *dataTask,NSError *error) = ^(NSURLSessionDataTask *dataTask,NSError *error)
    {
        responseBlock(nil, error);
    };
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:name fileName:[NSString stringWithFormat:@"%@.jpg",fileName] mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:success failure:failure];
//    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:data name:name fileName:@"aa" mimeType:@"application/octet-stream"];
//    } success:success failure:failure];
}

@end
