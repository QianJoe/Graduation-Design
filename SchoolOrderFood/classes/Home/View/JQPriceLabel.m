//
//  JQPriceLabel.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/1.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQPriceLabel.h"
#import "JQGoods.h"

@interface JQPriceLabel ()

@property (nonatomic, strong) UILabel *oldPriceLabel;
@property (nonatomic, strong) UILabel *discountPriceLabel;
@property (nonatomic, strong) UIView *lines;

@end

@implementation JQPriceLabel


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    UILabel *oldPriceLabel = [[UILabel alloc]init];
    oldPriceLabel.text = @"￥50.0";
    oldPriceLabel.font = [UIFont systemFontOfSize:13];
    oldPriceLabel.textColor = [UIColor redColor];
    self.oldPriceLabel = oldPriceLabel;
    [self addSubview:oldPriceLabel];
    
    UILabel *discountPriceLabel = [[UILabel alloc]init];
    discountPriceLabel.font = [UIFont systemFontOfSize:12];
    discountPriceLabel.textColor = [UIColor grayColor];
    discountPriceLabel.text = @"￥49.0";
    self.discountPriceLabel = discountPriceLabel;
    [self addSubview:discountPriceLabel];
    
    UIView *lines = [[UIView alloc]init];
    lines.backgroundColor = [UIColor grayColor];
    self.lines = lines;
    [self addSubview:lines];
    
}

- (void)setViewAutoLayout {
    
    [self.oldPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
    }];
    
    [self.discountPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.oldPriceLabel.trailing).offset(1);
        make.centerY.equalTo(self);
    }];
    
    [self.lines makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.discountPriceLabel);
        make.height.equalTo(1);
        make.leading.equalTo(self.discountPriceLabel);
        make.centerY.equalTo(self);
    }];
    
}

- (void)setGoods:(JQGoods *)goods {
    
    _goods = goods;
    
    self.oldPriceLabel.text = [NSString stringWithFormat:@"￥%@", goods.oldPrice];
    self.discountPriceLabel.text = [NSString stringWithFormat:@"￥%@",goods.discountPrice];
//    [self.oldPriceLabel sizeToFit];
//    [self.discountPriceLabel sizeToFit];
    
    if ([goods.oldPrice isEqualToString:goods.discountPrice]) {
        self.discountPriceLabel.hidden = YES;
        self.lines.hidden = YES;
    }else{
        self.discountPriceLabel.hidden = NO;
        self.lines.hidden = NO;
    }
}

@end
