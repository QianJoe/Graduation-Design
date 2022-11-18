//
//  JQMultipleButtonView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/9.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQMultipleButtonView.h"

@interface JQMultipleButtonView ()

/**按钮*/
@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation JQMultipleButtonView


- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray{
    
    if (self = [super initWithFrame:frame]) {
        
        NSInteger  buttonCount = titleArray.count;
        
        for (NSInteger i = 0; i < titleArray.count ; i ++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

            // 设置tag
            button.tag = i + 10;
            // 设置frame
            button.frame = CGRectMake(i * VIEWWIDTH / buttonCount + 0.5, 5, VIEWWIDTH / buttonCount, 30);
            // 设置图层圆角
            button.layer.borderColor= [UIColor whiteColor].CGColor;
            button.layer.cornerRadius = 2.0;
            button.layer.borderWidth = 1.5;
            button.clipsToBounds = YES;
            
            // 设置属性
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            button.titleLabel.font = [UIFont systemFontOfSize:14.0];
            
            if (i == 0) {
                
                button.selected = YES;
//                _btnType = button;
                self.selectedBtn = button;
            }
            
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    
    return self;
}

#pragma mark - button-Action这个地方引入一个butotn类型册参数 用来接收(三段式)
- (void)buttonClick:(UIButton *)button {

//    if (!_btnType) {
//        
//        _btnType = button;
//        _btnType.selected = !_btnType.selected;
//        
//    } else {
//        
//        _btnType.selected = NO;
//        _btnType = button;
//        _btnType.selected = YES;
//    }
    
    if (!self.selectedBtn) {
        
        self.selectedBtn = button;
        self.selectedBtn.selected = self.selectedBtn.selected;
        
    } else {
        
        self.selectedBtn.selected = NO;
        self.selectedBtn = button;
        self.selectedBtn.selected = YES;
    }
    
    if ( [self.delegate respondsToSelector:@selector(multipleButtonView:clickAtIndex:)]) {
        
        [self.delegate multipleButtonView:self clickAtIndex:(button.tag - 10)];
    }
    
}

@end
