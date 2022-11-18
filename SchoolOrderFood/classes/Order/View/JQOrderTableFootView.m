//
//  JQOrderTableFootView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/25.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQOrderTableFootView.h"
#import "UIImage+Image.h"

@interface JQOrderTableFootView ()

/**显示总价的label*/
@property (nonatomic, weak) UILabel *totalPriceLabel;

/**提交按钮*/
@property (nonatomic, weak) UIButton *commitBtn;

@end

@implementation JQOrderTableFootView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    self.layer.borderWidth = 0.4;
    self.layer.borderColor = BackgroundColor.CGColor;
    self.backgroundColor = BackgroundColor;
    
    UILabel *totalPriceLabel = [[UILabel alloc] init];
    totalPriceLabel.font = [UIFont systemFontOfSize:15.0f];
    totalPriceLabel.textColor = [UIColor redColor];
    totalPriceLabel.text = @"￥0.00";
    self.totalPriceLabel = totalPriceLabel;
    [self addSubview:totalPriceLabel];
    
    UIButton *commitBtn = [[UIButton alloc] init];
    [commitBtn setTitle:@"选好了" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [commitBtn setBackgroundImage:[UIImage imageWithColor:CommitColor] forState:UIControlStateNormal];
    [commitBtn setBackgroundImage:[UIImage imageWithColor:BackgroundColor] forState:UIControlStateHighlighted];
    [commitBtn addTarget:self action:@selector(commitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    commitBtn.backgroundColor = CommitColor;
    self.commitBtn = commitBtn;
    [self addSubview:commitBtn];
}

- (void)setViewAutoLayout {
    
    [self.totalPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.width.equalTo(100);
        make.leading.equalTo(self).offset(15);
        make.height.equalTo(100);
    }];
    
    [self.commitBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.trailing.equalTo(self).offset(-5);
        make.height.equalTo(self).offset(-10);
        make.width.equalTo(100);
    }];
}

- (void)setTotalPrice:(NSInteger)totalPrice {
    
    _totalPrice = totalPrice;
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%ld", totalPrice];
}

- (void)commitBtnClick:(UIButton *)commitBtn {
    
    JQLOGFUNC;
    
    if ([self.delegate respondsToSelector:@selector(tableFootViewDidCommit:)]) {
        
        [self.delegate tableFootViewDidCommit:self];
    }
}

@end
