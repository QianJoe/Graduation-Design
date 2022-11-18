//
//  JQTiltleButton.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/14.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQTiltleButton.h"

@implementation JQTiltleButton


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{ // 只要重写了这个方法，按钮就无法进入highlighted状态
    
}

@end
