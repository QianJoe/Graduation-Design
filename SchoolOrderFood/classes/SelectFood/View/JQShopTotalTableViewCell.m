//
//  JQShopTotalTableViewCell.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/21.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQShopTotalTableViewCell.h"
#import "JQFoodTotalModel.h"
#import "JQShopCarTool.h"

NSString * const SHOPTOTALTABLEVIEWCELLID = @"SHOPTOTALTABLEVIEWCELLID";

@interface JQShopTotalTableViewCell ()

/**背景view*/
@property (nonatomic, weak) UIView *bgView;

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

/**数量*/
@property (nonatomic, assign) NSInteger tempCount;

@end

@implementation JQShopTotalTableViewCell

- (void)setFoodTotalModel:(JQFoodTotalModel *)foodTotalModel {
    
    _foodTotalModel = foodTotalModel;
    
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:foodTotalModel.image] placeholderImage:[UIImage imageNamed:@"hot_food02"]];
    self.iconView.image = [UIImage imageNamed:foodTotalModel.image];
    self.nameLabel.text = foodTotalModel.name;
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@", foodTotalModel.money];
    
    self.countLabel.text = [NSString stringWithFormat:@"%zd", foodTotalModel.count];
    self.minusBtn.hidden = !foodTotalModel.minus;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /**背景view*/
    UIView *bgView = [[UIView alloc] init];
    self.bgView = bgView;
    [self.contentView addSubview:bgView];
    
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
    
    UIButton *plusBtn = [[UIButton alloc]init];
    self.plusBtn = plusBtn;
    [plusBtn setImage:[UIImage imageNamed:@"v2_increase"] forState:UIControlStateNormal];
    [plusBtn addTarget:self action:@selector(plusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:plusBtn];
    
    // 数量label
    UILabel *countLabel = [[UILabel alloc] init];
    self.countLabel = countLabel;
    countLabel.text = @"0";
    countLabel.textAlignment = NSTextAlignmentCenter;
    countLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.bgView addSubview:countLabel];
    
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
    
    [self.iconView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(horMargin);
        make.top.equalTo(self.contentView).offset(horMargin);
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
    
    [self.plusBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.right).offset(-5);
        make.centerY.equalTo(self.contentView.centerY);
        make.width.equalTo(40);
        make.height.equalTo(40);
    }];
    
    [self.countLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.plusBtn.left).offset(-5);
        make.width.equalTo(20);
        make.centerY.equalTo(self.plusBtn.centerY);
    }];
    
    [self.minusBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.countLabel.left).offset(-5);
        make.centerY.equalTo(self.plusBtn.centerY);
        make.width.equalTo(40);
        make.height.equalTo(40);
    }];
    
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.iconView.bottom).offset(horMargin);
    }];
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
    self.tempCount ++;
    self.countLabel.text = [NSString stringWithFormat:@"%zd", self.tempCount];
    
    
    // 判断有没有实现代理方法
    if ([self.delegate respondsToSelector:@selector(shopTotalCellPlusBtnClick:)]) {
        
        [self.delegate shopTotalCellPlusBtnClick:self];
    }
}

- (void)minusButtonClick:(UIButton *)btn {
    
    // 将此model添加到购物车中
    [[JQShopCarTool sharedInstance] removeFromFoodShopCar:self.foodTotalModel];
    
    // 发送购物车的数量改变的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:JQFoodChangedNotification object:nil];
    
    self.tempCount --;

    self.countLabel.text = [NSString stringWithFormat:@"%zd", self.tempCount];
    JQLOG(@"self.foodTotalModel.count:%ld", self.foodTotalModel.count);
//    self.foodTotalModel.minus = (self.foodTotalModel.count > 0);
    self.foodTotalModel.minus = (self.tempCount > 0); // 用临时的就减不到最后
    // 判断减号是否显示
    self.minusBtn.hidden = !self.foodTotalModel.minus;
    
    // 判断有没有实现代理方法
    if ([self.delegate respondsToSelector:@selector(shopTotalCellMinusBtnClick:)]) {
        
        [self.delegate shopTotalCellMinusBtnClick:self];
    }
}


@end
