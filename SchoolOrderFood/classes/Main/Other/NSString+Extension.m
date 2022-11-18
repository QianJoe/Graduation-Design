//
//  NSString+Extension.m
//
//  Created by apple on 14-4-2.
//  Copyright (c) 2014年 gyh. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGRect)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
}

#pragma mark - NSString转JSON
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        
        JQLOG(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}
@end
