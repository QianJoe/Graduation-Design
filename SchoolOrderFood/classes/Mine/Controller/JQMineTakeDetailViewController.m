//
//  JQMineTakeDetailViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/5.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQMineTakeDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "JQInsteadTakeFood.h"
#import "JQTimeTool.h"
#import "UIImage+Image.h"

@interface JQMineTakeDetailViewController ()

/**头图片*/
@property (nonatomic, weak) UIImageView *headImgView;
/**中间的内容view*/
@property (nonatomic, weak) UIView *midContentView;
/**名字label*/
@property (nonatomic, weak) UILabel *nameLabel;
/**买多少份的label*/
@property (nonatomic, weak) UILabel *countLabel;
/**单价*/
@property (nonatomic, weak) UILabel *priceLabel;
/**代拿所支持的钱的label*/
@property (nonatomic, weak) UILabel *takeMoneyLabel;
/**线*/
@property (nonatomic, weak) UIView *lineView;
/**商店名称*/
@property (nonatomic, weak) UILabel *shopNameLabel;
/**取餐时间*/
@property (nonatomic, weak) UILabel *takeFoodTimeLabel;
/**商家电话*/
@property (nonatomic, weak) UILabel *shopPhoneLabel;
/**需要人电话*/
@property (nonatomic, weak) UILabel *personPhoneLabel;

/**底部view*/
@property (nonatomic, weak) UIView *bottomView;

/**接受label*/
@property (nonatomic, weak) UILabel *acceptLabel;

@end

@implementation JQMineTakeDetailViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 设置透明
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initHeadImgView];
    [self initBottomView];
    [self initMidContentView];
}


- (void)initHeadImgView {
    
    UIImageView *headImgView = [[UIImageView alloc] init];
    [headImgView sd_setImageWithURL:[NSURL URLWithString:self.foodTotalModel.image] placeholderImage:[UIImage imageNamed:@"hot_food06"]];
    self.headImgView = headImgView;
    [self.view addSubview:headImgView];
    
    [headImgView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(250);
    }];
}

- (void)initMidContentView {
    
    UIView *midContentView = [[UIView alloc] init];
    midContentView.backgroundColor = [UIColor whiteColor];
    self.midContentView = midContentView;
    [self.view addSubview:midContentView];
    
    [midContentView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headImgView.bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.top);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = self.foodTotalModel.name;
    self.nameLabel = nameLabel;
    [self.midContentView addSubview:nameLabel];
    
    [nameLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.midContentView.top).offset(8);
        make.left.equalTo(self.midContentView.left).offset(10);
    }];
    
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.textColor = [UIColor lightGrayColor];
    countLabel.font = [UIFont systemFontOfSize:11.0f];
    countLabel.text = [NSString stringWithFormat:@"共需带%ld份", self.foodTotalModel.count];
    self.countLabel = countLabel;
    [self.midContentView addSubview:countLabel];
    
    [countLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(nameLabel.bottom).offset(5);
        make.left.equalTo(nameLabel.left);
    }];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.font = [UIFont systemFontOfSize:16.0f];
    priceLabel.text = [NSString stringWithFormat:@"￥%@", self.foodTotalModel.money];
    self.priceLabel = priceLabel;
    [self.midContentView addSubview:priceLabel];
    
    [priceLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.countLabel.bottom).offset(15);
        make.left.equalTo(self.countLabel.left);
    }];
    
    UILabel *takeMoneyLabel = [[UILabel alloc] init];
    takeMoneyLabel.textColor = JQFontColor;
    takeMoneyLabel.font = [UIFont systemFontOfSize:15.0f];
    takeMoneyLabel.text = [NSString stringWithFormat:@"代送费用:￥%@", self.foodTotalModel.takeMoney];
    self.takeMoneyLabel = takeMoneyLabel;
    [self.midContentView addSubview:takeMoneyLabel];
    
    [takeMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.midContentView.right).offset(-10);
        make.top.equalTo(self.priceLabel.top);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = BackgroundColor;
    self.lineView = lineView;
    [self.midContentView addSubview:lineView];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.takeMoneyLabel.bottom).offset(8);
        make.left.equalTo(self.midContentView.left).offset(5);
        make.right.equalTo(self.midContentView.right).offset(-5);
        make.height.equalTo(1);
    }];
    
    UILabel *shopNameLabel = [[UILabel alloc] init];
    shopNameLabel.font = [UIFont systemFontOfSize:12.5f];
    shopNameLabel.textColor = [UIColor lightGrayColor];
    shopNameLabel.text = self.foodTotalModel.location;
    self.shopNameLabel = shopNameLabel;
    [self.view addSubview:shopNameLabel];
    
    [shopNameLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.lineView.bottom).offset(10);
        make.left.equalTo(self.priceLabel.left);
    }];
    
    UILabel *takeTimeStaticLabel = [[UILabel alloc] init];
    takeTimeStaticLabel.font = [UIFont systemFontOfSize:11.5f];
    takeTimeStaticLabel.textColor = JQFontColor;
    takeTimeStaticLabel.text = @"取餐时间:";
    [self.midContentView addSubview:takeTimeStaticLabel];
    
    [takeTimeStaticLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.shopNameLabel.bottom).offset(10);
        make.left.equalTo(self.shopNameLabel.left);
    }];
    
    UILabel *takeFoodTimeLabel = [[UILabel alloc] init];
    takeFoodTimeLabel.font = [UIFont systemFontOfSize:13.0f];
    JQTimeTool *timeTool = [JQTimeTool timeTool];
    takeFoodTimeLabel.text = [NSString stringWithFormat:@"%@", [timeTool returnStrTime:self.foodTotalModel.orderFoodTime]];
    self.takeFoodTimeLabel = takeFoodTimeLabel;
    [self.midContentView addSubview:takeFoodTimeLabel];
    
    [takeFoodTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(takeTimeStaticLabel.centerY);
        make.left.equalTo(takeTimeStaticLabel.right).offset(5);
    }];
    
    UILabel *shopPhoneStaticLabel = [[UILabel alloc] init];
    shopPhoneStaticLabel.font = [UIFont systemFontOfSize:11.5f];
    shopPhoneStaticLabel.textColor = JQFontColor;
    shopPhoneStaticLabel.text = @"商家电话:";
    [self.midContentView addSubview:shopPhoneStaticLabel];
    
    [shopPhoneStaticLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(takeTimeStaticLabel.bottom).offset(10);
        make.left.equalTo(takeTimeStaticLabel.left);
    }];
    
    UILabel *shopPhoneLabel = [[UILabel alloc] init];
    shopPhoneLabel.font = [UIFont systemFontOfSize:13.0f];
    JQLOG(@"self.foodTotalModel.phone:%ld", self.foodTotalModel.phone);
    shopPhoneLabel.text = [NSString stringWithFormat:@"%ld", self.foodTotalModel.phone];
    self.shopPhoneLabel = shopPhoneLabel;
    [self.midContentView addSubview:shopPhoneLabel];
    
    [shopPhoneLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(shopPhoneStaticLabel.centerY);
        make.left.equalTo(shopPhoneStaticLabel.right).offset(5);
        
    }];
    
    UILabel *personPhoneStaticLabel = [[UILabel alloc] init];
    personPhoneStaticLabel.font = [UIFont systemFontOfSize:11.5f];
    personPhoneStaticLabel.textColor = JQFontColor;
    personPhoneStaticLabel.text = @"需求人电话:";
    [self.midContentView addSubview:personPhoneStaticLabel];
    
    [personPhoneStaticLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(shopPhoneStaticLabel.bottom).offset(50);
        make.left.equalTo(shopPhoneStaticLabel.left);
    }];
    
    UILabel *personPhoneLabel = [[UILabel alloc] init];
    personPhoneLabel.font = [UIFont systemFontOfSize:13.0f];
    personPhoneLabel.text = self.foodTotalModel.personphone;
    self.personPhoneLabel = personPhoneLabel;
    [self.midContentView addSubview:personPhoneLabel];
    
    [personPhoneLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(personPhoneStaticLabel.centerY);
        make.left.equalTo(personPhoneStaticLabel.right).offset(5);
    }];
}

- (void)initBottomView {
    
    UIView *bottomView = [[UIView alloc] init];
    self.bottomView = bottomView;
    [self.view addSubview:bottomView];
    
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(44);
    }];
    
    UILabel *acceptLabel = [[UILabel alloc] init];
    acceptLabel.textAlignment = NSTextAlignmentCenter;
    acceptLabel.textColor = [UIColor grayColor];
    acceptLabel.text = @"您已接受";
    acceptLabel.backgroundColor = naviColor;
    self.acceptLabel = acceptLabel;
    [self.bottomView addSubview:acceptLabel];
    
    [acceptLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.bottomView.top).offset(3);
        make.bottom.equalTo(self.bottomView.bottom).offset(-3);
        make.left.equalTo(self.bottomView.left).offset(3);
        make.right.equalTo(self.bottomView.right).offset(-3);
    }];
}

@end
