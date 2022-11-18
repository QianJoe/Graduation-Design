//
//  JQMineShopFoodTableViewCell.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/5.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQMineShopFoodTableViewCell.h"
#import "JQFoodTotalModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
NSString * const MINESHOPFOODTBVCELLID = @"MINESHOPFOODTBVCELLID";

@interface JQMineShopFoodTableViewCell ()

/**背景view*/
@property (nonatomic, weak) UIView *bgView;

/**食物图片*/
@property (nonatomic, weak) UIImageView *iconView;

/**食物名称Label*/
@property (nonatomic, weak) UILabel *nameLabel;

/**单价Label*/
@property (nonatomic, weak) UILabel *moneyLabel;

/**数量label*/
@property (nonatomic, weak) UILabel *totalCountLabel;

/**分类图钉*/
@property (nonatomic, weak) UIImageView *categoryImgView;

/**分类label*/
@property (nonatomic, weak) UILabel *categoryLabel;

@end

@implementation JQMineShopFoodTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    /**背景view*/
    UIView *bgView = [[UIView alloc] init];
    self.bgView = bgView;
    [self.contentView addSubview:bgView];
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.backgroundColor = [UIColor redColor];
    self.iconView = iconView;
    [self.bgView addSubview:iconView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
//    nameLabel.backgroundColor = [UIColor greenColor];
    self.nameLabel = nameLabel;
    [self.bgView addSubview:nameLabel];
    
    UILabel *moneyLabel = [[UILabel alloc] init];
//    moneyLabel.backgroundColor = [UIColor lightGrayColor];
    moneyLabel.textColor = [UIColor orangeColor];
    moneyLabel.font = [UIFont systemFontOfSize:12.0f];
    self.moneyLabel = moneyLabel;
    [self.bgView addSubview:moneyLabel];
    
    // 数量label
    UILabel *totalCountLabel = [[UILabel alloc] init];
    self.totalCountLabel = totalCountLabel;
    totalCountLabel.text = @"0";
    totalCountLabel.textAlignment = NSTextAlignmentCenter;
    totalCountLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.bgView addSubview:totalCountLabel];
    
    UIImageView *categoryImgView = [[UIImageView alloc] init];
    categoryImgView.image = [UIImage imageNamed:@"TD2"];
    [self.bgView addSubview:categoryImgView];
    self.categoryImgView = categoryImgView;
    
    UILabel *categoryLabel = [[UILabel alloc] init];
    categoryLabel.font = [UIFont systemFontOfSize:11.0f];
    self.categoryLabel = categoryLabel;
    [self.bgView addSubview:categoryLabel];
    
}

- (void)setViewAutoLayout {
    
    NSInteger margin = 5;
    NSInteger imgW = 105;
    NSInteger imgH = 80;
    NSInteger horMargin = 10;
    
    UIEdgeInsets padding = UIEdgeInsetsMake(margin, margin, margin, margin);
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.contentView).insets(padding);
    }];
    
    [self.iconView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bgView).offset(horMargin);
        make.top.equalTo(self.bgView).offset(horMargin);
        make.height.equalTo(imgH);
        make.width.equalTo(imgW);
    }];
    
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconView.right).offset(horMargin);
        make.right.equalTo(self.bgView.right).offset(-115);
        make.top.equalTo(self.iconView.top);
    }];
    
    [self.moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconView.right).offset(horMargin);
        make.centerY.equalTo(self.iconView.centerY);
    }];
    
    [self.categoryImgView makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.moneyLabel.left);
        make.bottom.equalTo(self.iconView.bottom);
        make.width.height.equalTo(12);
    }];
    
    
    [self.totalCountLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.bgView.right).offset(-5);
        make.centerY.equalTo(self.iconView.centerY);
    }];
    
    [self.categoryLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.categoryImgView.right).offset(3);
        make.centerY.equalTo(self.categoryImgView.centerY);
    }];
    
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.iconView.bottom).offset(horMargin);
    }];
}

- (void)setFoodTotalModel:(JQFoodTotalModel *)foodTotalModel {
    
    _foodTotalModel = foodTotalModel;
    
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:foodTotalModel.image] placeholderImage:[UIImage imageNamed:@"hot_food01"]];
    self.iconView.image = [UIImage imageNamed:foodTotalModel.image];
    self.nameLabel.text = foodTotalModel.name;
    self.moneyLabel.text = [NSString stringWithFormat:@"单价:￥%@", foodTotalModel.money];
    self.totalCountLabel.text = [NSString stringWithFormat:@"剩余:%ld", foodTotalModel.totalCount];
    self.categoryLabel.text = foodTotalModel.category;
}

@end
