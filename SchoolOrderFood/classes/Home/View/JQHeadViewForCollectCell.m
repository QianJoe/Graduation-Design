//
//  JQHeadViewForCollectCell.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/1.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQHeadViewForCollectCell.h"
#import "JQCategoryGoods.h"
#import "UIColor+JQHexColorToARGB.h"

@interface JQHeadViewForCollectCell ()

/**最右边的线view*/
@property (nonatomic, weak) UIView *lineView;
/**标题Label*/
@property (nonatomic, weak) UILabel *titleLabel;
/**最右边的箭头img*/
@property (nonatomic, weak) UIImageView *arrowImgView;

@end

@implementation JQHeadViewForCollectCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor redColor];
    self.lineView = lineView;
    [self addSubview:lineView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"快餐速食";
    titleLabel.textColor = [UIColor redColor];
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    UIImageView *arrowImgView = [[UIImageView alloc] init];
    arrowImgView.image = [UIImage imageNamed:@"main_arrow"];
    self.arrowImgView = arrowImgView;
    [self addSubview:arrowImgView];
    
}

- (void)setViewAutoLayout {
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(3);
        make.height.mas_equalTo(15);
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lineView);
        make.left.equalTo(self.lineView).offset(10);
        make.height.mas_equalTo(15);
    }];
    
    [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self.lineView);
        make.width.height.mas_equalTo(15);
    }];
}

- (void)setCategoryGoods:(JQCategoryGoods *)categoryGoods {
    
    _categoryGoods = categoryGoods;
    
    UIColor *headBackGroundColor = [UIColor getColor:categoryGoods.categoryHeadBackGroundColor];
    self.lineView.backgroundColor = headBackGroundColor;
    
    self.titleLabel.textColor = headBackGroundColor;
    self.titleLabel.text = categoryGoods.categoryGoodsName;
}

@end
