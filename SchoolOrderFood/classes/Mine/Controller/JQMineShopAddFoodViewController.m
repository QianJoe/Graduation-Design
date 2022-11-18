//
//  JQMineShopAddFoodViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/8.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQMineShopAddFoodViewController.h"
#import "JQFoodTotalModel.h"
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+Image.h"
#import "UIColor+JQHexColorToARGB.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface JQMineShopAddFoodViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/**头图片*/
@property (nonatomic, weak) UIImageView *headImgView;
/**中间的内容view*/
@property (nonatomic, weak) UIView *midContentView;
/**食物名字*/
@property (nonatomic, weak) UITextField *nameTF;
/**共多少份*/
@property (nonatomic, weak) UITextField *totalCountTF;
/**单价*/
@property (nonatomic, weak) UITextField *priceTF;
/**分类*/
@property (nonatomic, weak) UITextField *categoryTF;
/**线*/
@property (nonatomic, weak) UIView *lineView;
/**底部view*/
@property (nonatomic, weak) UIView *bottomView;

/**添加按钮*/
@property (nonatomic, weak) UIButton *addBtn;

/**是否允许编辑*/
@property (nonatomic, assign) BOOL editEnable;

/**选择的图片，如果不为空，就上传*/
@property (nonatomic, weak) UIImage *selectdImage;

@end

@implementation JQMineShopAddFoodViewController

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNoti];
    [self initHeadImgView];
    [self initBottomView];
    [self initMidContentView];
    [self changeNav];
    
    // 先调用一次textChanged
    [self textChanged];
}


#pragma mark - 监听键盘弹出
- (void)initNoti {
    
    [JQNotification addObserver:self selector:@selector(didClickKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    
    [JQNotification addObserver:self selector:@selector(didKboardDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)dealloc {
    
    [JQNotification removeObserver:self];
}

#pragma mark - 键盘即将跳出
-(void)didClickKeyboard:(NSNotification *)sender{
    
    CGFloat durition = [sender.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    CGRect keyboardRect = [sender.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    CGFloat keyboardHeight = keyboardRect.size.height;
    
    [UIView animateWithDuration:durition animations:^{
        
        self.view.transform = CGAffineTransformMakeTranslation(0, -keyboardHeight);
        
    }];
}

#pragma mark - 当键盘即将消失

-(void)didKboardDisappear:(NSNotification *)sender{
    
    CGFloat duration = [sender.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.view.transform = CGAffineTransformIdentity;
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.nameTF resignFirstResponder];
    [self.totalCountTF resignFirstResponder];
    [self.priceTF resignFirstResponder];
}

#pragma mark - 设置导航条
- (void)changeNav {
    
    UIButton *btn = [[UIButton alloc] init];
    [self.view addSubview:btn];
    [btn sizeToFit];
    [btn setBackgroundImage:[UIImage imageNamed:@"close_icon"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"close_icon_highlighted"] forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [btn makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.top).offset(24);
        make.left.equalTo(self.view.left).offset(10);
        make.width.height.equalTo(35);
    }];
}

- (void)back {
    
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initHeadImgView {
    
    UIImageView *headImgView = [[UIImageView alloc] init];
    headImgView.userInteractionEnabled = YES;
    // 初始化一个手势
    UITapGestureRecognizer *headImgViewSingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeHeadImgViewClick:)];
    // 为chooseImgView添加手势
    [headImgView addGestureRecognizer:headImgViewSingleTap];
    
    [headImgView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"hot_food06"]];
    self.headImgView = headImgView;
    [self.view addSubview:headImgView];
    
    [headImgView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(250);
    }];
}

#pragma mark - 手势点击
- (void)changeHeadImgViewClick:(UITapGestureRecognizer *)tap {
    
    JQLOGFUNC;
    [self selectImage];
}
#pragma mark - 选择照片
- (void)selectImage {
    
    // 弹出 alertView 来让用户选择
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"打开照相机" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"从手机相册中获取" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self openAlbum];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

/**
 * 通过照相机获取一张图片
 */
- (void)openCamera {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    /**
     *  UIImagePickerControllerSourceType
     *
     *  SourceType pickerController 的类型
     *  UIImagePickerControllerSourceTypePhotoLibrary,     从 所有 相册中选择
     *  UIImagePickerControllerSourceTypeCamera,           弹出照相机
     *  UIImagePickerControllerSourceTypeSavedPhotosAlbum  从 moment 相册中选择
     */
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

/**
 * 打开用户相册 获取一张图片
 */
- (void)openAlbum {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    /**
     *  UIImagePickerControllerSourceType
     *
     *  SourceType pickerController 的类型
     *  UIImagePickerControllerSourceTypePhotoLibrary,     从 所有 相册中选择
     *  UIImagePickerControllerSourceTypeCamera,           弹出照相机
     *  UIImagePickerControllerSourceTypeSavedPhotosAlbum  从 moment 相册中选择
     */
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 选择照片代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // 获取选择的照片
    UIImage *selectdImage = info[UIImagePickerControllerOriginalImage];
    self.selectdImage = selectdImage;
    
    NSData *data = UIImagePNGRepresentation(selectdImage);
    UIImage *pngImg = [UIImage imageWithData:data];
    self.headImgView.image = pngImg;
    // 跳转
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 初始化中间的view
- (void)initMidContentView {
    
    NSInteger mar = 30;
    
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
    nameLabel.text = @"食物名称:";
    [self.midContentView addSubview:nameLabel];
    
    [nameLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.midContentView.top).offset(mar);
        make.left.equalTo(self.midContentView.left).offset(20);
    }];
    
    UITextField *nameTF = [[UITextField alloc] init];
    [nameTF addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    nameTF.borderStyle = UITextBorderStyleRoundedRect;
    nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameTF = nameTF;
    [self.midContentView addSubview:nameTF];
    
    [nameTF makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(nameLabel.centerY);
        make.left.equalTo(nameLabel.right).offset(2);
        make.width.equalTo(175);
    }];
    
    UILabel *totalCountLabel = [[UILabel alloc] init];
    //    totalCountLabel.textColor = [UIColor lightGrayColor];
    //    totalCountLabel.font = [UIFont systemFontOfSize:11.0f];
    totalCountLabel.text = @"剩余数量:";
    [self.midContentView addSubview:totalCountLabel];
    
    [totalCountLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(nameLabel.bottom).offset(mar);
        make.left.equalTo(nameLabel.left);
    }];
    
    UITextField *totalCountTF = [[UITextField alloc] init];
    [totalCountTF addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    totalCountTF.keyboardType = UIKeyboardTypeNumberPad;
    totalCountTF.borderStyle = UITextBorderStyleRoundedRect;
    totalCountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.totalCountTF = totalCountTF;
    [self.midContentView addSubview:totalCountTF];
    
    [totalCountTF makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(totalCountLabel.centerY);
        make.left.equalTo(totalCountLabel.right).offset(2);
        make.width.equalTo(175);
    }];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    //    priceLabel.textColor = [UIColor redColor];
    //    priceLabel.font = [UIFont systemFontOfSize:16.0f];
    priceLabel.text = @"单价(￥):";
    [self.midContentView addSubview:priceLabel];
    
    [priceLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(totalCountLabel.bottom).offset(mar);
        make.left.equalTo(totalCountLabel.left);
    }];
    
    UITextField *priceTF = [[UITextField alloc] init];
    [priceTF addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    priceTF.keyboardType = UIKeyboardTypeDecimalPad;
    priceTF.borderStyle = UITextBorderStyleRoundedRect;
    priceTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.priceTF = priceTF;
    [self.midContentView addSubview:priceTF];
    
    [priceTF makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(priceLabel.centerY);
        make.left.equalTo(totalCountTF.left);
        make.width.equalTo(175);
    }];
    
    UILabel *category1Label = [[UILabel alloc] init];
    category1Label.text = @"分";
    [self.midContentView addSubview:category1Label];
    
    [category1Label makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(priceLabel.bottom).offset(mar);
        make.left.equalTo(priceLabel.left);
    }];
    
    UILabel *category2Label = [[UILabel alloc] init];
    category2Label.text = @"类:";
    [self.midContentView addSubview:category2Label];
    
    [category2Label makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(category1Label.centerY);
        make.right.equalTo(priceLabel.right);
    }];
    
    UITextField *categoryTF = [[UITextField alloc] init];
    [categoryTF addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    categoryTF.borderStyle = UITextBorderStyleRoundedRect;
    categoryTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.categoryTF = categoryTF;
    [self.midContentView addSubview:categoryTF];
    
    [categoryTF makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(category2Label.centerY);
        make.left.equalTo(totalCountTF.left).offset(2);
        make.width.equalTo(175);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = BackgroundColor;
    self.lineView = lineView;
    [self.midContentView addSubview:lineView];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.midContentView.bottom);
        make.left.equalTo(self.midContentView.left).offset(5);
        make.right.equalTo(self.midContentView.right).offset(-5);
        make.height.equalTo(1);
    }];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.textColor = JQFontColor;
    tipLabel.text = @"Tips:";
    [self.midContentView addSubview:tipLabel];
    
    [tipLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(priceLabel.left);
        make.bottom.equalTo(self.midContentView.bottom).offset(-60);
    }];
    
    UILabel *tipContentLabel = [[UILabel alloc] init];
    tipContentLabel.font = [UIFont systemFontOfSize:13.0f];
    tipContentLabel.textColor = JQFontColor;
    tipContentLabel.text = @"需要换食物图片时，直接点击图片就可以换了。";
    [self.midContentView addSubview:tipContentLabel];
    
    [tipContentLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(tipLabel.right).offset(3);
        make.centerY.equalTo(tipLabel);
    }];
}

- (void)initBottomView {
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    self.bottomView = bottomView;
    [self.view addSubview:bottomView];
    
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(100);
    }];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.clipsToBounds = YES;
    addBtn.layer.cornerRadius = 3;
    [addBtn setBackgroundImage:[UIImage imageWithColor:[UIColor getColor:@"20B1FA"]] forState:UIControlStateNormal];
    [addBtn setTitle:@"保存信息" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.addBtn = addBtn;
    [self.bottomView addSubview:addBtn];
    
    [addBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.bottomView.centerY);
        make.height.equalTo(44);
        make.left.equalTo(self.bottomView.left).offset(3);
        make.right.equalTo(self.bottomView.right).offset(-3);
    }];
}

#pragma mark - 判断按钮能否点击
- (void)textChanged {
    
    self.addBtn.enabled = (self.nameTF.text.length && self.totalCountTF.text.length && self.priceTF.text.length && self.categoryTF.text.length);
}

#pragma mark - 添加按钮点击事件
- (void)addBtnClick:(UIButton *)btn {
    
    [SVProgressHUD showWithStatus:@"正在添加..."];
#warning 向服务器提交
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    });
    
}

@end
