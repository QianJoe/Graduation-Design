//
//  JQLoginRegisterView.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/6.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQLoginRegisterView;
@protocol JQLoginRegisterViewDelegate <NSObject>

@required
- (void)loginRegisterView:(JQLoginRegisterView *)loginRegisterView clickLoginRegisterWithUserName:(NSString *)username withPwd:(NSString *)pwd withTag:(NSInteger)tag;

@optional
- (void)loginRegisterView:(JQLoginRegisterView *)loginRegisterView finshiRegisterWithConfirmPwd:(NSString *)confirmPwd withUserOrShopTag:(NSInteger)selectedTag;

@end

@interface JQLoginRegisterView : UIView

+ (instancetype)loginView;
+ (instancetype)registerView;
+ (instancetype)finishView;

/**代理*/
@property (nonatomic, weak) id<JQLoginRegisterViewDelegate> delegate;

@end
