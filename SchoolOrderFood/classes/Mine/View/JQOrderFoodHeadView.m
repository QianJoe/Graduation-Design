//
//  JQOrderFoodHeadView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/5.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQOrderFoodHeadView.h"

@interface JQOrderFoodHeadView ()

@property (nonatomic, weak) UILabel *orderLabel;

@property (nonatomic, weak) UILabel *fullLabel;

@property (nonatomic, weak) UIImageView *arrowsImg;

@end

@implementation JQOrderFoodHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *orderLabel = [[UILabel alloc]init];
    orderLabel.text = @"我的订单";
    orderLabel.font = [UIFont systemFontOfSize:14];
    orderLabel.textColor = [UIColor blackColor];
    self.orderLabel = orderLabel;
    [self addSubview:orderLabel];
    
    UILabel *fullLabel = [[UILabel alloc]init];
    fullLabel.text = @"查看全部订单";
    fullLabel.font = [UIFont systemFontOfSize:14];
    fullLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    self.fullLabel = fullLabel;
    [self addSubview:fullLabel];
    
    UIImageView *arrowsImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_go"]];
    self.arrowsImg = arrowsImg;
    [self addSubview:arrowsImg];
    
}

- (void)setViewAutoLayout {
    
    [self.orderLabel makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(20);
        make.centerY.equalTo(self);
    }];
    
    [self.arrowsImg makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-5);
        make.centerY.equalTo(self);
    }];
    
    [self.fullLabel makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.arrowsImg).offset(-10);
        make.centerY.equalTo(self);
    }];

}

@end
