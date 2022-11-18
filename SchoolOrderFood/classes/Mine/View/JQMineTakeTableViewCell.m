//
//  JQMineTakeTableViewCell.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/5.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQMineTakeTableViewCell.h"
#import "JQInsteadTakeFood.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "JQTimeTool.h"

NSString * const MINETAKETABLEVIEWCELLID = @"MINETAKETABLEVIEWCELLID";
@interface JQMineTakeTableViewCell ()

/**背景view*/
@property (nonatomic, weak) UIView *bgView;

/**icon*/
@property (nonatomic, weak) UIImageView *iconView;

/**nameLabel*/
@property (nonatomic, weak) UILabel *nameLabel;

/**数量label*/
@property (nonatomic, weak) UILabel *countLabel;

/**单价moneyLabel*/
@property (nonatomic, weak) UILabel *moneyLabel;

/**地点图片*/
@property (nonatomic, weak) UIImageView *locaImg;

/**地点*/
@property (nonatomic, weak) UILabel *locationLabel;

/**联系方式*/
@property (nonatomic, weak) UILabel *contactLabel;

/**取餐时间*/
@property (nonatomic, weak) UILabel *timeLabel;

@end

@implementation JQMineTakeTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}


- (void)createUI {
    
    // 选中之后没有颜色
    //    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /**背景view*/
    UIView *bgView = [[UIView alloc] init];
    self.bgView = bgView;
    [self.contentView addSubview:bgView];
    
    /**icon*/
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.backgroundColor = [UIColor redColor];
    self.iconView = iconView;
    [self.bgView addSubview:iconView];
    
    /**食品名称*/
    UILabel *nameLabel = [[UILabel alloc] init];
    //    nameLabel.backgroundColor = [UIColor greenColor];
    self.nameLabel = nameLabel;
    [self.bgView addSubview:nameLabel];
    
    /**数量*/
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.font = [UIFont systemFontOfSize:12.0f];
    //    countLabel.backgroundColor = [UIColor greenColor];
    self.countLabel = countLabel;
    [self.bgView addSubview:countLabel];
    
    /**单价价格*/
    UILabel *moneyLabel = [[UILabel alloc] init];
    //    moneyLabel.backgroundColor = [UIColor lightGrayColor];
    moneyLabel.textColor = [UIColor orangeColor];
    moneyLabel.font = [UIFont systemFontOfSize:12.0f];
    self.moneyLabel = moneyLabel;
    [self.bgView addSubview:moneyLabel];
    
    /**地点*/
    UIImageView *locaImg = [[UIImageView alloc] init];
    locaImg.image = [UIImage imageNamed:@"mycity_normal"];
    [self.bgView addSubview:locaImg];
    self.locaImg = locaImg;
    
    UILabel *locationLabel = [[UILabel alloc] init];
    locationLabel.font = [UIFont systemFontOfSize:11.0f];
    self.locationLabel = locationLabel;
    [self.bgView addSubview:locationLabel];
    
    /**商店联系方式*/
    UILabel *contactLabel = [[UILabel alloc] init];
    contactLabel.textColor = [UIColor lightGrayColor];
    contactLabel.font = [UIFont systemFontOfSize:11.0f];
    contactLabel.text = @"外卖电话:";
    [self.bgView addSubview:contactLabel];
    self.contactLabel = contactLabel;
    
    /**取餐时间*/
    UILabel *timeLabel = [[UILabel alloc] init];
    //    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.font = [UIFont systemFontOfSize:11.0f];
    self.timeLabel = timeLabel;
    [self.bgView addSubview:timeLabel];
    
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
        
        make.left.equalTo(self.bgView.left).offset(horMargin);
        make.top.equalTo(self.bgView).offset(horMargin);
        make.height.equalTo(imgH);
        make.width.equalTo(imgW);
    }];
    
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconView.right).offset(horMargin);
        make.right.equalTo(self.contentView.right).offset(-115);
        make.top.equalTo(self.iconView.top);
    }];
    
    [self.locationLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.bgView.right).offset(-5);
        make.centerY.equalTo(self.nameLabel);
    }];
    
    [self.locaImg makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.locationLabel.left);
        make.centerY.equalTo(self.nameLabel.centerY);
        make.width.height.equalTo(12);
    }];
    
    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.nameLabel.left);
        make.centerY.equalTo(self.iconView.centerY);
    }];
    
    [self.countLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.iconView.centerY);
        make.right.equalTo(self.bgView.right).offset(-5);
    }];
    
    [self.moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconView.right).offset(horMargin);
        make.bottom.equalTo(self.iconView.bottom);
    }];
    
    [self.contactLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.bgView.right).offset(-5);
        make.bottom.equalTo(self.moneyLabel.bottom);
    }];
    
    
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.contactLabel.bottom).offset(margin);
    }];
    
}

- (void)setFoodTotalModel:(JQInsteadTakeFood *)foodTotalModel {
    
    _foodTotalModel = foodTotalModel;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:foodTotalModel.image]placeholderImage:[UIImage imageNamed:@"hot_food04"]];
    self.nameLabel.text = foodTotalModel.name;
    self.countLabel.text = [NSString stringWithFormat:@"共 %zd 份", foodTotalModel.count];
    self.moneyLabel.text = [NSString stringWithFormat:@"单价:￥%@", foodTotalModel.money];
    self.contactLabel.text = [NSString stringWithFormat:@"联系方式:%zd", foodTotalModel.phone];
    self.locationLabel.text = [NSString stringWithFormat:@"%@", foodTotalModel.location];
    
    // 转一下时间戳
    JQTimeTool *timeTool = [JQTimeTool timeTool];
    self.timeLabel.text = [NSString stringWithFormat:@"取餐时间:%@", [timeTool returnStrTime: foodTotalModel.takeFoodTime]];
    JQLOG(@"foodTotalModel.takeFoodTime:%ld", foodTotalModel.takeFoodTime);
    
}


@end
