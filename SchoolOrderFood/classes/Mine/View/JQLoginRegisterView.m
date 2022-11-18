//
//  JQLoginRegisterView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/6.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQLoginRegisterView.h"
#import "JQTextField.h"
#import "RadioButton.h"

@interface JQLoginRegisterView ()
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterBtn;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextF;
@property (weak, nonatomic) IBOutlet JQTextField *confirmPasswordTextF;

/**选择的类型tag*/
@property (nonatomic, assign) NSInteger selectedTag;
/**注册用的*/
/**用户名*/
//@property (nonatomic, copy) NSString *userNameRe;
///**密码*/
//@property (nonatomic, copy) NSString *passwordRe;

@end

@implementation JQLoginRegisterView

- (IBAction)loginAndRegisterClick:(UIButton *)button {

    if ([self.delegate respondsToSelector:@selector(loginRegisterView:clickLoginRegisterWithUserName:withPwd:withTag:)]) {
        
        JQLOG(@"UserName-----%@", self.userNameTextF.text);
        NSString *un = self.userNameTextF.tag == button.tag ? self.userNameTextF.text :nil;
        NSString *pwd = self.passwordTextF.tag == button.tag ? self.passwordTextF.text :nil;
        // tag 0 为登录 tag 1 为注册
        [self.delegate loginRegisterView:self clickLoginRegisterWithUserName:un withPwd:pwd withTag:button.tag];
    }
}
- (IBAction)checkUserOrShop:(RadioButton *)radioBtn {
    
    JQLOG(@"rb:%@,tag:%ld", radioBtn.titleLabel.text, radioBtn.tag);

    self.selectedTag = radioBtn.tag;
}

- (IBAction)finshRegisterClick:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(loginRegisterView:finshiRegisterWithConfirmPwd:withUserOrShopTag:)]) {
        
        JQLOG(@"self.confirmPasswordTextF.text:%@", self.passwordTextF.text);
        
        NSString *confPwd = self.passwordTextF.tag == button.tag ? self.passwordTextF.text :nil;
        
        [self.delegate loginRegisterView:self finshiRegisterWithConfirmPwd:confPwd withUserOrShopTag:self.selectedTag];
    }
}

- (void)awakeFromNib {
    
    // 按钮圆角
    self.loginRegisterBtn.layer.cornerRadius = 5;
    self.loginRegisterBtn.clipsToBounds = YES;
    
    // 添加监听，来判断是否禁止按钮
    [self.userNameTextF addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    
    [self.passwordTextF addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    
    [self textChanged];
    
}

- (void)textChanged {
    
    self.loginRegisterBtn.enabled = (self.userNameTextF.text.length && self.passwordTextF.text.length);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.userNameTextF.leftViewMode = UITextFieldViewModeAlways;
    self.userNameTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userNameTextF.borderStyle = UITextBorderStyleRoundedRect;
    
    self.passwordTextF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextF.borderStyle = UITextBorderStyleRoundedRect;
    
    self.confirmPasswordTextF.leftViewMode = UITextFieldViewModeAlways;
    self.confirmPasswordTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.confirmPasswordTextF.borderStyle = UITextBorderStyleRoundedRect;
}

#pragma mark - 加载登录注册view
+ (instancetype)loginView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype)registerView {
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][1];
}

+ (instancetype)finishView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
