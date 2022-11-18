//
//  JQOrderTableFootView.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/25.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQOrderTableFootView;

@protocol JQOrderTableFootViewDelegate <NSObject>

@required
- (void)tableFootViewDidCommit:(JQOrderTableFootView *)orderTableFootView;

@end

@interface JQOrderTableFootView : UIView

/**totalprice*/
@property (nonatomic, assign) NSInteger totalPrice;

/**代理*/
@property (nonatomic, weak) id<JQOrderTableFootViewDelegate> delegate;

@end
