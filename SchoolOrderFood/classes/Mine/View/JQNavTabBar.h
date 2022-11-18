//
//  JQNavTabBar.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/7.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JQNavTabBarDelegate <NSObject>

@optional
- (void)itemDidSelectedWithIndex:(NSInteger)index;
- (void)itemDidSelectedWithIndex:(NSInteger)index withCurrentIndex:(NSInteger)currentIndex;

@end

@interface JQNavTabBar : UIView

@property (nonatomic, assign) NSInteger currentItemIndex;
@property (nonatomic, strong) NSArray *itemTitles;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic , strong) NSMutableArray  *items;

@property (nonatomic, weak) id<JQNavTabBarDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;

- (void)updateData;

@end
