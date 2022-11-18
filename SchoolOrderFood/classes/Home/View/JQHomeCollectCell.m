//
//  JQhomeCollectCell.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/1.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQhomeCollectCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "JQPriceLabel.h"
#import "JQGoods.h"

#define GrayColor [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1]
NSString * const HOMECOLLECTCELL = @"HOMECOLLECTCELL";

@interface JQHomeCollectCell ()

/**商品图片*/
@property (nonatomic,weak) UIImageView *goodsImageView;
/**商品名字图片*/
@property (nonatomic,weak) UILabel *nameLabel;
/**精选的图片*/
@property (nonatomic,weak) UIImageView *fineImageView;
/**商品单位的图片*/
@property (nonatomic,weak) JQPriceLabel *priceLabel;

@end

@implementation JQHomeCollectCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    self.userInteractionEnabled = YES;
    
    self.layer.borderWidth = 0.3;
    self.layer.borderColor = GrayColor.CGColor;
    
    UIImageView *goodsImageView = [[UIImageView alloc] init];
    [goodsImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img01.bqstatic.com/upload/goods/201/603/1609/20160316094120_299780.jpg@200w_200h_90Q.jpg"] placeholderImage:[UIImage imageNamed:@"03"]];
    goodsImageView.userInteractionEnabled = YES;
    self.goodsImageView = goodsImageView;
    [self addSubview:goodsImageView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"红烧牛肉面";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];

    UIImageView *fineImageView = [[UIImageView alloc] init];
    fineImageView.userInteractionEnabled = YES;
    fineImageView.image = [UIImage imageNamed:@"jingxuan.png"];
    self.fineImageView = fineImageView;
    [self addSubview:fineImageView];
    
    JQPriceLabel *priceLabel = [[JQPriceLabel alloc] init];
//    priceLabel.text = @"￥50";
    self.priceLabel = priceLabel;
    [self addSubview:priceLabel];
}

- (void)setViewAutoLayout {
    
    [self.goodsImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.width.equalTo(self.width);
    }];
    
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsImageView.bottom).offset(3);
        make.centerX.equalTo(self.centerX);
        make.width.equalTo(self.width).offset(-2);
//        make.height.equalTo(12);
    }];
    
    [self.fineImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.bottom).offset(2);
        make.left.equalTo(self.left).offset(4);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(13);
    }];
    
    [self.priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(-10);
        make.left.equalTo(self);
    }];
}

- (void)setGoods:(JQGoods *)goods {
    
    _goods = goods;
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goods.goodsImageURL] placeholderImage:[UIImage imageNamed:@"03"]];
    self.nameLabel.text = goods.goodsName;
    self.priceLabel.goods = goods;
}

@end
