//
//  JQTitleIconView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/5.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQTitleIconView.h"

@interface JQTitleIconView ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *icon;

@end

@implementation JQTitleIconView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {

    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];

    UIImageView *icon = [[UIImageView alloc]init];
    icon.contentMode = UIViewContentModeCenter;
    self.icon = icon;
    [self addSubview:icon];

}

- (void)setViewAutoLayout {
    
    [self.icon makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-10);;
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.icon.bottom).offset(3);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(15);
    }];
}

- (instancetype)initWithTitleLabel:(NSString *)titleLabel icon:(UIImage *)icon isBorder:(BOOL)isBorder{
    if (self = [super init]) {
        
        if (isBorder) {
            
            self.layer.borderColor = JQGrayColor.CGColor;
            self.layer.borderWidth = 0.5;
        }
        
        self.titleLabel.text = titleLabel;
        self.icon.image = icon;
        
    }
    
    return self;
}

+ (instancetype)titleIconViewWithTitleLabel:(NSString *)titleLabel icon:(UIImage *)icon isBorder:(BOOL)isBorder {
    return [[self alloc] initWithTitleLabel:titleLabel icon:icon isBorder:isBorder];
}

@end
