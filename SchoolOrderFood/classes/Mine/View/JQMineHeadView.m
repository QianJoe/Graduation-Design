//
//  JQMineHeadView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/5.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQMineHeadView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface JQMineHeadView ()

/**背景图片*/
@property (nonatomic, weak) UIImageView *backImgView;

/**头像按钮*/
@property (nonatomic, weak) UIImageView *headImgView;

/**设置按钮*/
@property (nonatomic, weak) UIButton *settingBtn;

/**用户名label*/
@property (nonatomic, weak) UILabel *userNameLabel;


@end

@implementation JQMineHeadView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    UIImageView *backImgView = [[UIImageView alloc] init];
    backImgView.image = [UIImage imageNamed:@"v2_my_avatar_bg"];
    self.backImgView = backImgView;
    [self addSubview:backImgView];
    
    UIButton *settingBtn = [[UIButton alloc] init];
    [settingBtn setImage:[UIImage imageNamed:@"v2_my_settings_icon"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.settingBtn = settingBtn;
    [self addSubview:settingBtn];
    
    UIImageView *headImgView = [[UIImageView alloc] init];
    headImgView.image = [UIImage imageNamed:@"v2_my_avatar"];
    
    // 添加点击手势
    /*
     当未登录时，跳到登录界面
     当已登录，跳到设置界面
     */
    headImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headImgViewClick:)];
    [headImgView addGestureRecognizer:tap];
    
    self.headImgView = headImgView;
    [self addSubview:headImgView];
    
    UILabel *userNameLabel = [[UILabel alloc] init];
    userNameLabel.text = @"未登录";
    userNameLabel.font = [UIFont systemFontOfSize:19.0];
    userNameLabel.textColor = [UIColor whiteColor];
    userNameLabel.textAlignment = NSTextAlignmentCenter;
    self.userNameLabel = userNameLabel;
    [self addSubview:userNameLabel];
}

- (void)setViewAutoLayout {
    
    [self.backImgView makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.bottom.right.equalTo(self);
    }];
    
    [self.settingBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self).offset(5);
        make.width.height.equalTo(50);
    }];
    
    [self.headImgView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(-10);
//        make.left.equalTo(10);
        make.centerX.equalTo(self);
    }];
    
    [self.userNameLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.headImgView.bottom).offset(8);
//        make.left.equalTo(self.headImgView.right).offset(5);
        make.centerX.equalTo(self.headImgView);
        make.height.equalTo(30);
    }];
    
}

#pragma mark - 当未登录时，跳到登录界面,当已登录，跳到设置界面
- (void)headImgViewClick:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(mineHeadView:clickWithTap:)]) {
        
        [self.delegate mineHeadView:self clickWithTap:tap];
    }

    
//    JQLoginViewController *loginVC = [[JQLoginViewController alloc] init];
//    JQNaviViewController *naviVc = [[JQNaviViewController alloc] initWithRootViewController:loginVC];
    
//    [self.navigationController presentViewController:naviVc animated:YES completion:nil];
    
}

#pragma mark - 设置的点击事件
- (void)settingBtnClick {
    
    if ([self.delegate respondsToSelector:@selector(mineHeadViewClickSetting:)]) {
        
        [self.delegate mineHeadViewClickSetting:self];
    }
}

- (void)setUsername:(NSString *)username {
    
    _username = username;
    
    self.userNameLabel.text = username;
}

- (void)setHeadImgUrl:(NSString *)headImgUrl {
    
    _headImgUrl = headImgUrl;
    
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:headImgUrl] placeholderImage:[UIImage imageNamed:@"v2_my_avatar"]];
}

@end
