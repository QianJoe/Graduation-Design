//
//  JQBuyView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/21.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQBuyView.h"

@interface JQBuyView ()

/**增加*/
@property (nonatomic, weak) UIButton *addBtn;
/**减少*/
@property (nonatomic, weak) UIButton *reduceBtn;
/**数量*/
@property (nonatomic, weak) UILabel *countLabel;


@end

@implementation JQBuyView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    UIButton *addBtn = [[UIButton alloc] init];
    self.addBtn = addBtn;
}

- (void)setViewAutoLayout {
    
    
}

@end
