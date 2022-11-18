//
//  JQMineShopIntroViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/5.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQMineShopIntroViewController.h"
#import "JQMineShopModel.h"
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface JQMineShopIntroViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *shopPhoneTF;
@property (weak, nonatomic) IBOutlet UITextField *locationTF;
@property (weak, nonatomic) IBOutlet UITextField *shopNameTF;
@property (weak, nonatomic) IBOutlet UITextField *categoryTF;
@property (weak, nonatomic) IBOutlet UITextField *runStartTimeTF;
@property (weak, nonatomic) IBOutlet UITextField *runEndTimeTF;

/**mineShopModel*/
@property (nonatomic, strong) JQMineShopModel *mineShopModel;
/**编辑标记*/
@property (nonatomic, assign, getter=isEdited) BOOL editEnable;
@end

@implementation JQMineShopIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shopPhoneTF.enabled = NO;
    self.locationTF.enabled = NO;
    self.shopNameTF.enabled = NO;
    self.categoryTF.enabled = NO;
    self.runStartTimeTF.enabled = NO;
    self.runEndTimeTF.enabled = NO;

    [self loadJSONData:^{
        
        self.shopPhoneTF.text = [NSString stringWithFormat:@"%ld", self.mineShopModel.phone];
        self.locationTF.text = self.mineShopModel.location;
        self.shopNameTF.text = self.mineShopModel.shopName;
        self.categoryTF.text = self.mineShopModel.category;
        self.runStartTimeTF.text = self.mineShopModel.startTime;
        self.runEndTimeTF.text = self.mineShopModel.endTime;
    }];
    
}

#pragma mark - 编辑信息
- (IBAction)editInfoBtnClick:(UIButton *)editBtn {
    
    if (!_editEnable) {
        
        [editBtn setTitle:@"保存" forState:UIControlStateNormal];
        
        [SVProgressHUD showWithStatus:@"现在可以编辑了"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
        });
        
        self.shopPhoneTF.enabled = YES;
        self.locationTF.enabled = YES;
        self.shopNameTF.enabled = YES;
        self.categoryTF.enabled = YES;
        self.runStartTimeTF.enabled = YES;
        self.runEndTimeTF.enabled = YES;
    } else {
        
        [editBtn setTitle:@"编辑信息" forState:UIControlStateNormal];
        
#warning 向服务器提交数据
        [SVProgressHUD showSuccessWithStatus:@"信息更新成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
        });
        
        self.shopPhoneTF.enabled = NO;
        self.locationTF.enabled = NO;
        self.shopNameTF.enabled = NO;
        self.categoryTF.enabled = NO;
        self.runStartTimeTF.enabled = NO;
        self.runEndTimeTF.enabled = NO;
    }
    
    _editEnable = !_editEnable;
    
    
}


#pragma mark - 异步加载数据
- (void)loadJSONData:(void(^)()) then {
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
#warning 现在是模拟的json数据
        // 读取json数据
        // 获取json地址
        /****************************我的餐厅**********************************************/
        NSString *mineShopDataFilePath =[[NSBundle mainBundle] pathForResource:@"MineShopData" ofType:@"json"];
        
        // 获取二进制数据
        NSData *mineShopData = [NSData dataWithContentsOfFile:mineShopDataFilePath];
        
        // 转成字典
        NSDictionary *mineShopDataDictionary = [NSJSONSerialization JSONObjectWithData:mineShopData options: NSJSONReadingAllowFragments error:nil];
        
        JQMineShopModel *msModel = [JQMineShopModel mj_objectWithKeyValues:mineShopDataDictionary];
        
        weakSelf.mineShopModel = msModel;
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !then ? : then();
        });
    });
}

@end
