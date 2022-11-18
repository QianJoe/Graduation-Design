//
//  UIColor+JQHexColorToARGB.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/2.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "UIColor+JQHexColorToARGB.h"

@implementation UIColor (JQHexColorToARGB)


+ (UIColor *)getColor:(NSString *)hexColor{
    
    unsigned int red, green, blue;
    NSRange range;
    range.length =2;
    
    range.location =0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location =2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location =4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:1.0f];
}

@end
