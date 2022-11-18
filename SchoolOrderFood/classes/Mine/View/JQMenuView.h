//
//  JQMenuView.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/5.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQTitleIconAction;

@interface JQMenuView : UIView

- (instancetype)initWithMenus:(NSArray <JQTitleIconAction *> *)menus WithLine:(BOOL)line;

+ (instancetype)menuViewWithMenus:(NSArray <JQTitleIconAction *> *)menus WithLine:(BOOL)line;

@end
