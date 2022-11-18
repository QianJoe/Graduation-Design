//
//  JQOrderDefaultView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/25.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQOrderDefaultView.h"

@interface JQOrderDefaultView ()

/**显示空购物车的图片*/
@property (nonatomic, weak) UIImageView *emptyShopImgView;

/**titleLabel*/
@property (nonatomic, weak) UILabel *titleLabel;

/**逛逛的btn*/
@property (nonatomic, weak) UIButton *buyButton;

@end

@implementation JQOrderDefaultView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    UIImageView *emptyShopImgView = [[UIImageView alloc] init];
    emptyShopImgView.image = [UIImage imageNamed:@"icon_no_food"];
    self.emptyShopImgView = emptyShopImgView;
    [self addSubview:emptyShopImgView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.text = @"亲,购物车空空的耶~赶紧挑好吃的吧";
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    [self addSubview:titleLabel];
    
    UIButton *buyButton = [[UIButton alloc] init];
    [buyButton setBackgroundImage:[UIImage imageNamed:@"btn_full"] forState:UIControlStateNormal];
    [buyButton setTitle:@"去逛逛" forState:UIControlStateNormal];
    [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyButton addTarget:self action:@selector(buyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.buyButton = buyButton;
    [self addSubview:buyButton];

}

- (void)setViewAutoLayout {
    
    [self.emptyShopImgView makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self);
        make.centerX.equalTo(self);
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.top.equalTo(self.emptyShopImgView.bottom);
        make.height.equalTo(50);
    }];
    
    [self.buyButton makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.titleLabel.bottom);
        make.centerX.equalTo(self);
        make.height.equalTo(30);
        make.width.equalTo(150);
    }];
}

#pragma -mark 逛一逛的点击事件
- (void)buyBtnClick:(UIButton *)buyBtn {
    
    JQLOGFUNC;
}

@end
