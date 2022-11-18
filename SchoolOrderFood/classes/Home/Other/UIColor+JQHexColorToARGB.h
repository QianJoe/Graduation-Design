//
//  UIColor+JQHexColorToARGB.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/2.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JQHexColorToARGB)

/**接受一个二进制颜色
 * 如：F38631，20B1FA，7B4D03，E80013，FF3319，1EB2A3，E80013，E80013
 */
+ (UIColor *)getColor:(NSString *)hexColor;

@end
