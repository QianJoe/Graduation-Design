//
//  JQHeadViewWaitFoodView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/3.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQHeadViewWaitFoodView.h"
#import "UIColor+JQHexColorToARGB.h"

NSString * const HEADVWAITID = @"HEADVWAITID";

@interface JQHeadViewWaitFoodView ()

/**背景view*/
@property (nonatomic, weak) UIView *bgView;

/**最右边的线view*/
@property (nonatomic, weak) UIView *lineView;
/**标题Label*/
@property (nonatomic, weak) UILabel *titleLabel;
/**最右边的箭头img*/
@property (nonatomic, weak) UIImageView *arrowImgView;

@end

@implementation JQHeadViewWaitFoodView


//- (instancetype)initWithFrame:(CGRect)frame {
//    
//    if (self = [super initWithFrame:frame]) {
//        
//        [self createUI];
//        [self setViewAutoLayout];
//    }
//    
//    return self;
//}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    /**背景view*/
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    self.bgView = bgView;
    [self.contentView addSubview:bgView];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor redColor];
    self.lineView = lineView;
    [self.bgView addSubview:lineView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"已经取到的订餐";
    titleLabel.textColor = [UIColor redColor];
    self.titleLabel = titleLabel;
    [self.bgView addSubview:titleLabel];
    
    UIImageView *arrowImgView = [[UIImageView alloc] init];
    arrowImgView.image = [UIImage imageNamed:@"main_arrow"];
    self.arrowImgView = arrowImgView;
    [self.bgView addSubview:arrowImgView];
}

- (void)setViewAutoLayout {
    
    UIEdgeInsets padding = UIEdgeInsetsMake(1, 1, 1, 1);
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.contentView).insets(padding);
    }];
    
    [self.lineView makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(3);
        make.height.equalTo(15);
        make.left.equalTo(self.bgView).offset(10);
        make.centerY.equalTo(self.bgView);
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.lineView);
        make.left.equalTo(self.lineView).offset(10);
        make.height.mas_equalTo(15);
    }];
    
    [self.arrowImgView makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.bgView).offset(-10);
        make.centerY.equalTo(self.lineView);
        make.width.height.equalTo(15);
    }];
}

- (void)setColorHex:(NSString *)colorHex {
    
    _colorHex = colorHex;
    
    UIColor *headBackGroundColor = [UIColor getColor:colorHex];
    self.lineView.backgroundColor = headBackGroundColor;
    
    self.titleLabel.textColor = headBackGroundColor;
}

- (void)setName:(NSString *)name {
    
    _name = name;
    
    self.titleLabel.text = name;
}

@end
