//
//  UIView+frame.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/14.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)


- (void)setJq_height:(CGFloat)jq_height {
    
    CGRect rect = self.frame;
    rect.size.height = jq_height;
    self.frame = rect;
}

- (CGFloat)jq_height {
    
    return self.frame.size.height;
}

- (CGFloat)jq_width {
    
    return self.frame.size.width;
}

- (void)setJq_width:(CGFloat)jq_width {
    
    CGRect rect = self.frame;
    rect.size.width = jq_width;
    self.frame = rect;
}

- (CGFloat)jq_x {
    
    return self.frame.origin.x;
}

- (void)setJq_x:(CGFloat)jq_x {
    
    CGRect rect = self.frame;
    rect.origin.x = jq_x;
    self.frame = rect;
}

- (void)setJq_y:(CGFloat)jq_y {
    
    CGRect rect = self.frame;
    rect.origin.y = jq_y;
    self.frame = rect;
}

- (CGFloat)jq_y {
    
    return self.frame.origin.y;
}

- (void)setJq_centerX:(CGFloat)jq_centerX {
    CGPoint center = self.center;
    center.x = jq_centerX;
    self.center = center;
}

- (CGFloat)jq_centerX {
    return self.center.x;
}

- (void)setJq_centerY:(CGFloat)jq_centerY {
    CGPoint center = self.center;
    center.y = jq_centerY;
    self.center = center;
}

- (CGFloat)jq_centerY {
    return self.center.y;
}

@end
