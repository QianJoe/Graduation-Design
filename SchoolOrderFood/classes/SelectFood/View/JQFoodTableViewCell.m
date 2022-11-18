//
//  JQFoodTableViewCell.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/10.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQFoodTableViewCell.h"
#import "JQFoodModel.h"
#import "JQStarView.h"

NSString * const FOODTBCELL = @"FOODTBCELL";
#define categoryFoods @[@"炖的", @"煮的", @"蒸的", @"炸的"]

@interface JQFoodTableViewCell ()

/**backView*/
@property (nonatomic, weak) UIView *bgView;
/**食物名字*/
@property (nonatomic, weak) UILabel *foodTitleLabel;
/**食物所属分类*/
@property (nonatomic, weak) UILabel *categoryFoodLabel;
/**食物成分*/
@property (nonatomic, weak) UILabel *foodContentLabel;
/**食物所在商店*/
@property (nonatomic, weak) UILabel *locationLabel;
/**商店联系方式*/
@property (nonatomic, weak) UILabel *contactLabel;
/**食物图片*/
@property (nonatomic, weak) UIImageView *foodImg;
/**食物价格*/
@property (nonatomic, weak) UILabel *priceLabel;

/**受欢迎星星*/
@property (nonatomic, weak) JQStarView *startView;

/**商店所在地左边的图片*/
@property (nonatomic, weak) UIImageView *locaImg;

/**分类图钉*/
@property (nonatomic, weak) UIImageView *categoryImgView;

@end

@implementation JQFoodTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    UIView *bgView = [[UIView alloc] init];
    self.bgView = bgView;
    [self.contentView addSubview:bgView];
    
    /**食物图片*/
    UIImageView *foodImg = [[UIImageView alloc] init];
    foodImg.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:foodImg];
    self.foodImg = foodImg;
    
    /**食物名字*/
    UILabel *foodTitleLabel = [[UILabel alloc] init];
    foodTitleLabel.font = titleBoldFont;
    [bgView addSubview:foodTitleLabel];
    self.foodTitleLabel = foodTitleLabel;
    
    /**食物所在商店*/
    UIImageView *locaImg = [[UIImageView alloc] init];
    locaImg.image = [UIImage imageNamed:@"mycity_normal"];
    [bgView addSubview:locaImg];
    self.locaImg = locaImg;
    
    UILabel *locationLabel = [[UILabel alloc] init];
    locationLabel.font = oldPriceFont;
    [bgView addSubview:locationLabel];
    self.locationLabel = locationLabel;
    
    /**受欢迎星星*/
    JQStarView *startView = [JQStarView startView];
    self.startView = startView;
    [bgView addSubview:startView];
    
    /**食物价格*/
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.font = oldPriceFont;
    priceLabel.textColor = [UIColor redColor];
    self.priceLabel = priceLabel;
    [bgView addSubview:priceLabel];
    
    /**商店联系方式*/
    UILabel *contactLabel = [[UILabel alloc] init];
//    contactLabel.textColor = [UIColor lightGrayColor];
    contactLabel.font = [UIFont systemFontOfSize:11.0];
    contactLabel.text = @"外卖电话:";
    self.contactLabel = contactLabel;
    [bgView addSubview:contactLabel];
    
    /**食物所属分类*/
    UIImageView *categoryImgView = [[UIImageView alloc] init];
    categoryImgView.image = [UIImage imageNamed:@"TD2"];
    [bgView addSubview:categoryImgView];
    self.categoryImgView = categoryImgView;
    
    UILabel *categoryFoodLabel = [[UILabel alloc] init];
    categoryFoodLabel.font = [UIFont systemFontOfSize:10.0];
    [bgView addSubview:categoryFoodLabel];
    self.categoryFoodLabel = categoryFoodLabel;
    
    /**食物成分*/
    //    UILabel *foodContentLabel = [[UILabel alloc] init];
    ////    foodContentLabel.textColor = [UIColor lightGrayColor];
    //    foodContentLabel.font = [UIFont systemFontOfSize:13.0];
    //    [backGroundView addSubview:foodContentLabel];
    //    self.foodContentLabel = foodContentLabel;
    
}

- (void)setViewAutoLayout {
    
    NSInteger horMargin = 10;

    UIEdgeInsets padding = UIEdgeInsetsMake(8, 0, 5, 0);
    self.contentView.backgroundColor = JQGrayColor;
    self.bgView.backgroundColor = [UIColor whiteColor];
    
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.contentView).insets(padding);
    }];
    
    [self.foodImg makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bgView).offset(horMargin);
        make.top.equalTo(self.bgView).offset(horMargin);
        make.width.height.equalTo(108);
    }];
    
    [self.foodTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.foodImg.right).offset(8);
        make.top.equalTo(self.foodImg.top).offset(3);
        make.right.equalTo(self.bgView.right).offset(-115);
    }];
    
    [self.locationLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.bgView.right).offset(-8);
        make.centerY.equalTo(self.foodTitleLabel);
    }];
    
    [self.locaImg makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.locationLabel.left);
        make.centerY.equalTo(self.foodTitleLabel.centerY);
        make.width.height.equalTo(12);
    }];
    
    [self.startView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.foodTitleLabel.left);
        make.top.equalTo(self.foodTitleLabel.bottom).offset(10);
        make.width.equalTo(65);
        make.height.equalTo(13);
    }];
    
    [self.priceLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.foodTitleLabel.left);
        make.top.equalTo(self.startView.bottom).offset(10);
    }];
    
    [self.contactLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.priceLabel.bottom);
        make.right.equalTo(self.bgView.right).offset(-5);
    }];
    
    [self.categoryImgView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.foodTitleLabel.left);
        make.bottom.equalTo(self.bgView.bottom).offset(-10);
        make.width.height.equalTo(12);
    }];
    
    [self.categoryFoodLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.categoryImgView.right).offset(3);
        make.centerY.equalTo(self.categoryImgView.centerY);
    }];
    
//    [self.foodContentLabel makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.left.equalTo(self.foodTitleLabel.left);
//        make.top.equalTo(self.categoryFoodLabel.bottom).offset(3);
//    }];
    
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.foodImg.bottom).offset(10);
    }];
}

- (void)setFoodModel:(JQFoodModel *)foodModel {
    
    _foodModel = foodModel;
    
    self.foodTitleLabel.text = foodModel.name;
    
    if ([foodModel.category isEqualToString:@"0"]) {
        
        self.categoryFoodLabel.text = [NSString stringWithFormat:@"%@", categoryFoods[0]];
        
    } else if ([foodModel.category isEqualToString:@"1"]) {
        
        self.categoryFoodLabel.text = [NSString stringWithFormat:@"%@", categoryFoods[1]];
        
    } else if ([foodModel.category isEqualToString:@"2"]) {
        
        self.categoryFoodLabel.text = [NSString stringWithFormat:@"%@", categoryFoods[2]];
        
    } else if ([foodModel.category isEqualToString:@"3"]) {
        
        self.categoryFoodLabel.text = [NSString stringWithFormat:@"%@", categoryFoods[3]];
    }
    
    self.foodImg.image = [UIImage imageNamed:foodModel.foodImgName];
    self.locationLabel.text = foodModel.location;
    self.contactLabel.text = [NSString stringWithFormat:@"外卖号码:%@", foodModel.contact];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", foodModel.price];
    self.startView.favCount = foodModel.favCount;
    //    self.foodContentLabel.text = [NSString stringWithFormat:@"成分:%@", foodModel.content];
}

@end
