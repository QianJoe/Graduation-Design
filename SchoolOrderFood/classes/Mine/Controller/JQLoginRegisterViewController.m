//
//  JQLoginRegisterViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/6.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQLoginRegisterViewController.h"
#import "JQLoginRegisterView.h"
#import <SVProgressHUD/SVProgressHUD.h>
//#import "JQPasswordConfirmViewController.h"
//#import "JQBasicNaviController.h"
#import "PCH.h"
#import "JQUserTool.h"
#import "JQUser.h"
#import <MJExtension/MJExtension.h>

@interface JQLoginRegisterViewController () <JQLoginRegisterViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleLeadingCons;

/**账号*/
@property (nonatomic, copy) NSString *username;
/**密码*/
@property (nonatomic, copy) NSString *password;

@end

@implementation JQLoginRegisterViewController


- (IBAction)close:(id)sender {
    
    // dismiss掉sp
    [SVProgressHUD dismiss];
    
    // 退出
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 点击注册
- (IBAction)clickRegister:(UIButton *)button {
    
    button.selected = !button.selected;

    // 平移中间view，改变左边的约束
    _middleLeadingCons.constant = _middleLeadingCons.constant == 0? - self.middleView.frame.size.width * 0.3333 : 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        // 重新布局
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - 状态栏改成亮白色
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    
//    return UIStatusBarStyleLightContent;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建登录view
    JQLoginRegisterView *loginView = [JQLoginRegisterView loginView];
    
    // 添加注册界面
    JQLoginRegisterView *registerView = [JQLoginRegisterView registerView];
    
    // 添加下一步view
    JQLoginRegisterView *finishView = [JQLoginRegisterView finishView];
    
    // 添加到中间的view
    [self.middleView addSubview:loginView];
    [self.middleView addSubview:registerView];
    [self.middleView addSubview:finishView];
    
    loginView.delegate = self;
    registerView.delegate = self;
    finishView.delegate = self;
}

#pragma mark - viewDidLayoutSubviews:才会根据布局调整控件的尺寸
- (void)viewDidLayoutSubviews {
    // 一定要调用super
    [super viewDidLayoutSubviews];
    
    // 设置登录view
    JQLoginRegisterView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.frame.size.width * 0.3333, self.middleView.frame.size.height);
    
    // 设置注册view
    JQLoginRegisterView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake(self.middleView.frame.size.width * 0.3333, 0,self.middleView.frame.size.width * 0.3333, self.middleView.frame.size.height);

    JQLoginRegisterView *finishView = self.middleView.subviews[2];
    finishView.frame = CGRectMake(self.middleView.frame.size.width * 0.6666, 0,self.middleView.frame.size.width * 0.3333, self.middleView.frame.size.height);

}

#pragma mark - 登录界面的代码
// 用于登录和检测注册是否合法
- (void)loginRegisterView:(JQLoginRegisterView *)loginRegisterView clickLoginRegisterWithUserName:(NSString *)username withPwd:(NSString *)pwd withTag:(NSInteger)tag {
    // 提交登录
    JQLOG(@"%@----%@----%ld", username, pwd, tag);
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:BackgroundColor];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    
    if (tag) { // 1为注册
        
        if (![self isValidateUserName:username]) { // 账号是否符合规则
            
            [SVProgressHUD showErrorWithStatus:@"用户名格式错误，请好好检查用户名格式"];
            
            return;
        }
        
        if (![self checkPassWord:pwd]) {
            
            [SVProgressHUD showErrorWithStatus:@"请输入6-9位非纯数字密码"];
            
            return;
        }
        
        self.username = username;
        self.password = pwd;
        
        // 平移到完成界面
        self.middleLeadingCons.constant = - self.middleView.frame.size.width * 0.6666;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.view layoutIfNeeded];
        }];

        // 平移到完成界面
        
    } else { // 0为登录
        
        // 提交登录
//        JQLOG(@"%@----%@----%ld", username, pwd, tag);
        
        [SVProgressHUD showWithStatus:@"正在登录..."];

#warning 向服务器提交登录
        NSMutableDictionary *loginDict = [NSMutableDictionary dictionary];
        [loginDict setValue:username forKey:@"account"];
        [loginDict setValue:pwd forKey:@"pwd"];
        
        JQHttpRequestTool *tool = [JQHttpRequestTool shareHttpRequestTool];

        [tool requestWithMethod:POST andUrlString:JQOrderSchoolFoodLoginURL andParameters:loginDict andFinished:^(id response, NSError *error) {
            
            NSString *result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
            JQLOG(@"result:%@", result);
            
            // string转为json
            NSMutableDictionary *resultDict = [result dictionaryWithJsonString:result].mutableCopy;
            
            if (resultDict[@"success"]) { // 如果返回值为1，就是登录成功
                
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                
                // 返回信息转成数据模型
                resultDict[@"account"] = username;
                resultDict[@"pwd"] = pwd;
                JQUser *user = [JQUser mj_objectWithKeyValues:resultDict];
                
                // 归档保存信息
                [JQUserTool saveUserWithArchive:user];
                
                // 1s后消失
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
                
            } else if (resultDict[@"success"] == 0) {
                
                [SVProgressHUD showErrorWithStatus:@"登录失败，账号或者密码错误，请重新输入账号密码..."];
                // 1s之后，结束提示
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                    
                });
                
            } else {
                
                [SVProgressHUD showErrorWithStatus:@"发生神秘的未知错误，请稍后重试..."];
                // 1s之后，结束提示
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                    
                });
            }
        }];
    }
}

// 提交注册
- (void)loginRegisterView:(JQLoginRegisterView *)loginRegisterView finshiRegisterWithConfirmPwd:(NSString *)confirmPwd withUserOrShopTag:(NSInteger)selectedTag {
    
//    JQLOG(@"------%ld", selectedTag);
    
    if (![confirmPwd isEqualToString:self.password]) { // 如果两次密码不一致
        
        [SVProgressHUD showErrorWithStatus:@"两次密码不一致，请重新输如!"];
        
        return;
    }
    
#warning 提交注册
    NSDictionary *registerDict = [NSMutableDictionary dictionary];
    [registerDict setValue:self.username forKey:@"account"];
    [registerDict setValue:self.password forKey:@"pwd"];
    [registerDict setValue:confirmPwd forKey:@"pwded"];
    [registerDict setValue:[NSString stringWithFormat:@"%ld", selectedTag] forKey:@"isSeller"];
    
    // 向服务器提交
    JQHttpRequestTool *httpTool = [JQHttpRequestTool shareHttpRequestTool];
    [httpTool requestWithMethod:POST andUrlString:JQOrderSchoolFoodRegisterURL andParameters:registerDict andFinished:^(id response, NSError *error) {
        
        NSString *result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
//        JQLOG(@"result:%@", result);

        // string转为json
        NSDictionary *resultDict = [result dictionaryWithJsonString:result];
        
//        JQLOG(@"success:%@", resultDict[@"success"]);
        
        if (resultDict[@"success"]) { // 如果返回值为1，就是注册成功
            
            [SVProgressHUD showSuccessWithStatus:@"注册成功，请去登录"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
                
                [self dismissViewControllerAnimated:YES completion:nil];
            });
            
        } else if (resultDict[@"success"] == 0) {
            
            [SVProgressHUD showErrorWithStatus:@"注册失败，请更换新的账号密码..."];
            // 1s之后，结束提示
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
                
            });
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:@"发生神秘的未知错误，请稍后重试..."];
            // 1s之后，结束提示
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
                
            });
        }
        
        [SVProgressHUD showSuccessWithStatus:@"注册成功，请去登录..."];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

// 判断 用户名 是否合理
- (BOOL)isValidateUserName:(NSString *)userName {
    
    NSString *unRegex = @"^(?![0-9]+$)[0-9A-Za-z]{6,12}$";
    NSPredicate *unTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", unRegex];
    return [unTest evaluateWithObject:userName];
}

// 判断密码是否合理
- (BOOL)checkPassWord:(NSString *)pwd {
    
    //6-15位非纯数字组成
    NSString *regex = @"^(?![0-9]+$)[0-9A-Za-z]{6,15}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:pwd];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [SVProgressHUD dismiss];
//}

@end
