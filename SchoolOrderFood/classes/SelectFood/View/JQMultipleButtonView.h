//
//  JQMultipleButtonView.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/9.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQMultipleButtonView;

@protocol JQMultipleButtonViewDelegate <NSObject>

@optional
-(void)multipleButtonView:(JQMultipleButtonView *)multipleBtn clickAtIndex:(NSInteger)index;

@end

@interface JQMultipleButtonView : UIView

/**按钮*/
//@property (nonatomic, strong) UIButton *btnType;

@property(nonatomic, weak)id <JQMultipleButtonViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

@end
