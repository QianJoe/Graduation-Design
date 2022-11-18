//
//  JQHeadLineContentView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/3.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQHeadLineContentView.h"
#import "JQHead.h"

@interface JQHeadLineContentView ()

@property (nonatomic, weak) UILabel *titLabel;
@property (nonatomic, weak) UILabel *contentLabel;

@end

@implementation JQHeadLineContentView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    UILabel *titLabel = [[UILabel alloc]init];
    titLabel.textColor = [UIColor redColor];
    titLabel.font = [UIFont systemFontOfSize:12];
    titLabel.layer.borderColor = [UIColor redColor].CGColor;
    titLabel.layer.borderWidth = 1;
    titLabel.layer.cornerRadius = 3;
    titLabel.textAlignment = NSTextAlignmentCenter;
    titLabel.text = @"促销";
    self.titLabel = titLabel;
    [self addSubview:_titLabel];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    [contentLabel sizeToFit];
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1];
    contentLabel.text = @"3M防霾口罩 19.9元/3只";
    self.contentLabel = contentLabel;
    [self addSubview:contentLabel];
    
}

- (void)setViewAutoLayout {
    
    [self.titLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(18);
    }];
    
//    [self.contentLabel sizeToFit];
    [self.contentLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titLabel.right).offset(10);
        make.centerY.equalTo(self);
    }];
    
}

- (void)setHead:(JQHead *)head {
    
    _head = head;
    
    self.titLabel.text = head.titleName;
    self.contentLabel.text = head.content;
    
}


@end
