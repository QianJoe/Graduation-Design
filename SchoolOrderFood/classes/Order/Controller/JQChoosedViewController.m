//
//  JQChoosedViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/1.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQChoosedViewController.h"
#import "JQDateTextField.h"
#import "JQShopCarTool.h"
#import "JQFoodTotalModel.h"
#import "JQTimeTool.h"

@interface JQChoosedViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *takeFoodLabel;
@property (weak, nonatomic) IBOutlet UISwitch *insteadTakeSwitch;
@property (weak, nonatomic) IBOutlet JQDateTextField *takeFoodTimeLabel;

/**取餐时间戳*/
@property (nonatomic, assign) NSInteger takeFoodTimeSp;

@end

@implementation JQChoosedViewController

- (IBAction)finshBtnClick:(UIButton *)sender {
    
    // 获取选择的时间
    self.takeFoodTimeSp = [self.takeFoodTimeLabel getUnixTime];
//    JQLOG(@"takeFoodTimeSp:%ld", self.takeFoodTimeSp);
    
    
    // 获取当前unix时间戳
    NSInteger currentTimeSp = [JQTimeTool getCurrentTimeSp];
    for (JQFoodTotalModel *model in self.buyFoodDataList) {
        
        model.orderFoodTime = currentTimeSp;
        model.takeFoodTime = self.takeFoodTimeSp;
        
        if (self.insteadTakeSwitch.isOn) { // 是否允许帮带
            
            model.allowTake = YES;
        } else {
            
            model.allowTake = NO;
        }
    }
#warning 向服务器异步提交
    
    // 先将购物车里面的数据添加到已经购买的数组中
    [[JQShopCarTool sharedInstance] addShopCarAllFoodToBuyedArray];
    
    // 去除订餐里面的food
    [self.buyFoodDataList removeAllObjects];
    
    // 去除tabbaritem的bd值
    [JQNotification postNotificationName:JQFoodChangedNotification object:nil];
    
    // 退出当前vc
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置label的代理
    self.takeFoodTimeLabel.delegate = self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 取消编辑
    [self.takeFoodTimeLabel endEditing:YES];
}

#pragma mark - UITextFieldDelegate
//是否允许改变文本框内容(拦截用户输入)
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return NO;
}

@end
