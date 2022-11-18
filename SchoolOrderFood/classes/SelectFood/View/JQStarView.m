//
//  JQStarView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/12.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQStarView.h"

@interface JQStarView ()


@end

@implementation JQStarView


- (void)setFavCount:(NSInteger)favCount {
    
    _favCount = favCount;
    
    for (NSInteger i = 0; i < favCount; i ++) {
        
        UIImageView *starImgView = self.subviews[i];
        starImgView.highlighted = YES;
    }
}

+ (instancetype)startView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
