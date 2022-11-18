//
//  JQShopIntroViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/19.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQShopIntroViewController.h"
#import "JQShopIntroModel.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface JQShopIntroViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *reportLabel;

@end

@implementation JQShopIntroViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    IMP_BLOCK_SELF(JQShopIntroViewController);
    
    [SVProgressHUD showWithStatus:@"加载中"];
    
    // 异步加载出
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        block_self.phoneNumLabel.text = _shopIntroModel.phone;
        block_self.locationLabel.text = _shopIntroModel.location;
        block_self.categoryLabel.text = _shopIntroModel.category;
        block_self.timeLabel.text = _shopIntroModel.time;
        
        [SVProgressHUD dismiss];
    });
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.phoneNumLabel.text = _shopIntroModel.phone;
//    self.locationLabel.text = _shopIntroModel.location;
//    self.categoryLabel.text = _shopIntroModel.category;
//    self.timeLabel.text = _shopIntroModel.time;
    
    // 初始化一个手势
    UITapGestureRecognizer *reportSingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reportClick:)];
    // 为chooseImgView添加手势
    [self.reportLabel addGestureRecognizer:reportSingleTap];
    self.reportLabel.userInteractionEnabled = YES;
}

- (void)reportClick:(UITapGestureRecognizer *)tap {
    
    [SVProgressHUD showWithStatus:@"正在提交..."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
#warning 提交到服务器
        [SVProgressHUD showSuccessWithStatus:@"提交成功"];
        
    });
//    [SVProgressHUD dismiss];
}

@end
