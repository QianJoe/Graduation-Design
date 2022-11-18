//
//  NSString+Extension.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/14.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)
/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGRect)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**qingning*/
- (NSString *)cleanDecimalPointZear;

@end