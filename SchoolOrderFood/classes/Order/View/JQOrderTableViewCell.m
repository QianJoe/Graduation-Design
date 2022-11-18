//
//  JQOrderTableViewCell.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/26.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQOrderTableViewCell.h"
#import "JQFoodTotalModel.h"
#import "JQShopCarTool.h"
#import <SDWebImage/UIImageView+WebCache.h>

NSString * const ORDERTABLEVIEWCELLID = @"ORDERTABLEVIEWCELLID";
@interface JQOrderTableViewCell ()

/**背景view*/
@property (nonatomic, weak) UIView *bgView;

/**最前面选中的按钮*/
@property (nonatomic, weak) UIButton *selectedBtn;

/**icon*/
@property (nonatomic, weak) UIImageView *iconView;

/**nameLabel*/
@property (nonatomic, weak) UILabel *nameLabel;

/**moneyLabel*/
@property (nonatomic, weak) UILabel *moneyLabel;

/**圆形加号按钮*/
@property (nonatomic, weak) UIButton *plusBtn;

/**圆形减号按钮*/
@property (nonatomic, weak) UIButton *minusBtn;

/**数量label*/
@property (nonatomic, weak) UILabel *countLabel;


@end

@implementation JQOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    // 选中之后没有颜色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /**背景view*/
    UIView *bgView = [[UIView alloc] init];
    self.bgView = bgView;
    [self.contentView addSubview:bgView];

    /**最前面选中的按钮*/
    UIButton *selectedBtn = [[UIButton alloc] init];
    // 默认为选中
    selectedBtn.selected = YES;
    [selectedBtn setImage:[UIImage imageNamed:@"v2_noselected"] forState:UIControlStateNormal];
    [selectedBtn setImage:[UIImage imageNamed:@"v2_selected"] forState:UIControlStateSelected];
    [selectedBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.selectedBtn = selectedBtn;
    [self.bgView addSubview:selectedBtn];

    /**icon*/
    UIImageView *iconView = [[UIImageView alloc] init];
//    iconView.backgroundColor = [UIColor redColor];
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

    /**圆形加号按钮*/
    UIButton *plusBtn = [[UIButton alloc]init];
    self.plusBtn = plusBtn;
    [plusBtn setImage:[UIImage imageNamed:@"v2_increase"] forState:UIControlStateNormal];
    [plusBtn addTarget:self action:@selector(plusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:plusBtn];
    
    /**数量label*/
    UILabel *countLabel = [[UILabel alloc] init];
    self.countLabel = countLabel;
    countLabel.text = @"0";
    countLabel.textAlignment = NSTextAlignmentCenter;
    countLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.bgView addSubview:countLabel];

    /**圆形减号按钮*/
    UIButton *minusBtn = [[UIButton alloc]init];
    self.minusBtn = minusBtn;
    [minusBtn setImage:[UIImage imageNamed:@"v2_reduce"] forState:UIControlStateNormal];
    [minusBtn addTarget:self action:@selector(minusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:minusBtn];
}

- (void)setViewAutoLayout {
    
    NSInteger margin = 5;
    NSInteger imgW = 90;
    NSInteger imgH = 90;
    NSInteger horMargin = 10;
    
    UIEdgeInsets padding = UIEdgeInsetsMake(margin, margin, margin, margin);
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.contentView).insets(padding);
    }];
    
    [self.selectedBtn makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.width.equalTo(15);
        make.left.equalTo(self.bgView).offset(10);
        make.centerY.equalTo(self.bgView);
    }];
    
    [self.iconView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.selectedBtn.right).offset(horMargin);
        make.top.equalTo(self.bgView).offset(horMargin);
        make.height.equalTo(imgH);
        make.width.equalTo(imgW);
    }];
    
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconView.right).offset(horMargin);
        make.right.equalTo(self.contentView.right).offset(-115);
        make.top.equalTo(self.iconView.top);
    }];
    
    [self.moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconView.right).offset(horMargin);
        make.bottom.equalTo(self.iconView.bottom);
    }];
    
    [self.plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.right).offset(-5);
        make.centerY.equalTo(self.contentView.centerY);
        make.width.equalTo(40);
        make.height.equalTo(40);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.plusBtn.left).offset(-5);
        make.width.equalTo(20);
        make.centerY.equalTo(self.plusBtn.centerY);
    }];
    
    [self.minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.countLabel.left).offset(-5);
        make.centerY.equalTo(self.plusBtn.centerY);
        make.width.equalTo(40);
        make.height.equalTo(40);
    }];
    
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.iconView.bottom).offset(horMargin);
    }];
}

- (void)selectedBtnClick:(UIButton *)selectedBtn {
    
    if (selectedBtn.selected) {
        
        selectedBtn.selected = NO;

        if ([self.delegate respondsToSelector:@selector(orderCellNoSelectedBtnClick:)]) {
            
            [self.delegate orderCellNoSelectedBtnClick:self];
        }
        
    } else {
      
        selectedBtn.selected = YES;
        
        if ([self.delegate respondsToSelector:@selector(orderCellSelectedBtnClick:)]) {
            
            [self.delegate orderCellSelectedBtnClick:self];
        }
    }
    
    // 发送一个通知
    [JQNotification postNotificationName:JQFoodChangedNotification object:nil];

}

- (void)plusButtonClick:(UIButton *)btn {
    
    // 将此model添加到购物车中
    [[JQShopCarTool sharedInstance] addFoodToShopCar:self.foodTotalModel];
    
    // 发送购物车的数量改变的通知
    [JQNotification postNotificationName:JQFoodChangedNotification object:nil];
    
    // 先让减号变为可视
    if (self.minusBtn.hidden) {
        
        self.foodTotalModel.minus = 1;
        self.minusBtn.hidden = !self.foodTotalModel.minus;
    }
    
//    self.foodTotalModel.count ++;
    self.countLabel.text = [NSString stringWithFormat:@"%zd", self.foodTotalModel.count];
    
    // 判断有没有实现代理方法
    if ([self.delegate respondsToSelector:@selector(orderCellPlusBtnClick:)]) {
        
        [self.delegate orderCellPlusBtnClick:self];
    }
}

- (void)minusButtonClick:(UIButton *)btn {
    
    // 将此model添加到购物车中
    [[JQShopCarTool sharedInstance] removeFromFoodShopCar:self.foodTotalModel];
    
    // 发送购物车的数量改变的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:JQFoodChangedNotification object:nil];
    
//    self.foodTotalModel.count --;
    self.foodTotalModel.minus = (self.foodTotalModel.count > 0);
    self.minusBtn.hidden = !self.foodTotalModel.minus;
    
    
    self.countLabel.text = [NSString stringWithFormat:@"%zd", self.foodTotalModel.count];
    
    // 判断有没有实现代理方法
    if ([self.delegate respondsToSelector:@selector(orderCellMinusBtnClick:)]) {
        
        [self.delegate orderCellMinusBtnClick:self];
    }
}

- (void)setFoodTotalModel:(JQFoodTotalModel *)foodTotalModel {
    
    _foodTotalModel = foodTotalModel;
    
    self.iconView.image = [UIImage imageNamed:foodTotalModel.image];
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:foodTotalModel.image]placeholderImage:[UIImage imageNamed:@"hot_food05"]];
    self.nameLabel.text = foodTotalModel.name;
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@", foodTotalModel.money];
    
    self.countLabel.text = [NSString stringWithFormat:@"%zd", foodTotalModel.count];
    self.minusBtn.hidden = !foodTotalModel.minus;
    
    if (foodTotalModel.isChecked) { // 如果被选中
        
        self.selectedBtn.selected = YES;
    } else {
        
        self.selectedBtn.selected = NO;
    }
}

@end
