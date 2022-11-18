//
//  JQHomeCategoryCell.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/1.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQHomeCategoryCell.h"
#import "JQHeadViewForCollectCell.h"
#import "JQHomeGoodsView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "JQCategoryGoods.h"

NSString * const HOMECACELL = @"HOMECACELL";

@interface JQHomeCategoryCell ()

/**每一组section的组头view*/
@property (nonatomic, weak) JQHeadViewForCollectCell *titleView;
/**头图片*/
@property (nonatomic, weak) UIImageView *titleImgView;
/**食物view*/
@property (nonatomic, weak) JQHomeGoodsView *homeGoodsView;

@end

@implementation JQHomeCategoryCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    JQHeadViewForCollectCell *titleView = [[JQHeadViewForCollectCell alloc] init];
    self.titleView = titleView;
    [self addSubview:titleView];
    
    UIImageView *titleImgView = [[UIImageView alloc] init];
    [titleImgView sd_setImageWithURL:[NSURL URLWithString:@"http://img01.bqstatic.com//upload/activity/2016031610050631.jpg@90Q.jpg"] placeholderImage:[UIImage imageNamed:@"hot_shop02"]];
    self.titleImgView = titleImgView;
    [self addSubview:titleImgView];
    
    JQHomeGoodsView *homeGoodsView = [[JQHomeGoodsView alloc] init];
    self.homeGoodsView = homeGoodsView;
    [self addSubview:homeGoodsView];
}

- (void)setViewAutoLayout {
    
    [self.titleView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_offset(30);
    }];
    
    [self.titleImgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.bottom);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(100);
    }];
    
    [self.homeGoodsView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImgView.bottom);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
}

- (void)setCategoryGoods:(JQCategoryGoods *)categoryGoods {
    
    _categoryGoods = categoryGoods;
    
    self.titleView.categoryGoods = categoryGoods;
    
    [self.titleImgView sd_setImageWithURL:[NSURL URLWithString:categoryGoods.titleImgURL] placeholderImage:[UIImage imageNamed:@"hot_shop02"]];
    
    self.homeGoodsView.categoryGoods = categoryGoods;
}

@end
