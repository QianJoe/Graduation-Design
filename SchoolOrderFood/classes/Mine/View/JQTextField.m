//
//  JQTextField.m
//  FoodFriends
//
//  Created by 乔谦 on 16/8/21.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQTextField.h"

@interface JQTextField ()

/**左边label*/
//@property (nonatomic, weak) UILabel *leftLabel;
/**左边图片*/
@property (nonatomic, weak) UIImageView *leftImgView;


@end

@implementation JQTextField

//- (void)setLeftLabelText:(NSString *)leftLabelText {
//    
//    _leftLabelText = leftLabelText;
//    
//    self.leftLabel.text = leftLabelText;
//}


- (void)awakeFromNib {
    
    self.leftViewMode = UITextFieldViewModeAlways;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.borderStyle = UITextBorderStyleRoundedRect;

//    UILabel *leftLabel = [[UILabel alloc] init];
//    leftLabel.text = @"蛤蛤";
//    self.leftLabel = leftLabel;
//    self.leftView = leftLabel;

    UIImageView *leftImgView = [[UIImageView alloc] init];
    
    leftImgView.image = [UIImage imageNamed:@"icon_confirm_pwd"];
    self.leftImgView = leftImgView;
    self.leftView = leftImgView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    [self.leftLabel makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(self.leftView);
//        make.bottom.equalTo(self.leftView);
//        make.left.equalTo(self.leftView);
//    }];
    
    [self.leftImgView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.leftView);
        make.bottom.equalTo(self.leftView);
        make.left.equalTo(self.leftView);
        make.width.equalTo(20);
    }];

}

//- (instancetype)initWithFrame:(CGRect)frame {
//    
//    if (self = [super initWithFrame:frame]) {
//        
//        self.leftViewMode = UITextFieldViewModeAlways;
//        self.clearButtonMode = UITextFieldViewModeWhileEditing;
//        self.borderStyle = UITextBorderStyleRoundedRect;
//        
//        UILabel *leftLabel = [[UILabel alloc]init];
//        self.leftLabel = leftLabel;
//        self.leftView = leftLabel;
//        
////        leftLabel.text = @"账  户";
//        
//        [leftLabel makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.equalTo(self.leftView);
//            make.bottom.equalTo(self.leftView);
//            make.left.equalTo(self.leftView);
//        }];
//    }
//    
//    return self;
//}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    
    CGRect rect = [super leftViewRectForBounds:bounds];
    rect.origin.x += 10;// 右偏10
    return rect;
}

@end
