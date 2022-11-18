//
//  JQTitleIconView.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/5.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JQTitleIconView : UIView

- (instancetype)initWithTitleLabel:(NSString *)titleLabel icon:(UIImage *)icon isBorder:(BOOL)isBorder;

+ (instancetype)titleIconViewWithTitleLabel:(NSString *)titleLabel icon:(UIImage *)icon isBorder:(BOOL)isBorder;

@end
