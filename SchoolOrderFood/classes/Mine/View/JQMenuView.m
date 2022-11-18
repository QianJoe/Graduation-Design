//
//  JQMenuView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/5.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQMenuView.h"
#import "JQTitleIconView.h"
#import "JQTitleIconAction.h"
#import "JQwaitForTakeFoodViewController.h"
#import "JQWaitCommentViewController.h"
#import "JQWeekListViewController.h"
#import "JQMineInsteadTakeViewController.h"
#import "JQInsteadTakeViewController.h"
#import "JQAdviseViewController.h"
#import "JQMyShopViewController.h"
#import "JQShareFriendsViewController.h"
#import "JQHelpViewController.h"
#import "JQMineViewController.h"

static const NSInteger DefaultRowNumbers = 3;

@interface JQMenuView ()

/**存放titleIconAction的数组*/
@property (nonatomic, strong) NSArray<JQTitleIconAction *> *menus;

@end

@implementation JQMenuView

- (instancetype)initWithMenus:(NSArray <JQTitleIconAction *>*)menus WithLine:(BOOL)line {
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.menus = menus;

        for (JQTitleIconAction *title in menus) {
            
            JQTitleIconView *titleIconView = [JQTitleIconView titleIconViewWithTitleLabel:title.title icon:title.icon isBorder:line];
            
            titleIconView.tag = title.tag;
            titleIconView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleIconViewClick:)];
            [titleIconView addGestureRecognizer:tap];
            [self addSubview:titleIconView];
        }
    }
    return self;
}

+ (instancetype)menuViewWithMenus:(NSArray<JQTitleIconAction *> *)menus WithLine:(BOOL)line {
    
    return [[self alloc] initWithMenus:menus WithLine:line];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width / DefaultRowNumbers;
    CGFloat height = self.bounds.size.height / (self.menus.count / DefaultRowNumbers);
    
    for (NSInteger i = 0; i < self.subviews.count; ++i) {
        
        JQTitleIconView *titleIconView = self.subviews[i];
        CGFloat viewX = (i % DefaultRowNumbers) * width;
        CGFloat viewY = (i / DefaultRowNumbers) * height;
        titleIconView.frame = CGRectMake(viewX, viewY, width, height);
    }
    
}

#pragma mark - 点击之后事件
- (void)titleIconViewClick:(UITapGestureRecognizer *)tap {

    JQLOG(@"titleIconViewClick:%ld",tap.view.tag);
    
    switch (tap.view.tag) {
        case 0:
            [self.menus[0].controller.navigationController pushViewController:[[JQwaitForTakeFoodViewController alloc] init] animated:YES];
            break;
            
        case 1:
            [self.menus[1].controller.navigationController pushViewController:[[JQWaitCommentViewController alloc] init] animated:YES];
            break;
            
        case 2:
            [self.menus[2].controller.navigationController pushViewController:[[JQWeekListViewController alloc] init] animated:YES];
            break;
            
        case 3:
            [self.menus[0].controller.navigationController pushViewController:[[JQMineInsteadTakeViewController alloc] init] animated:YES];
            break;
            
        case 4:
            [self.menus[1].controller.navigationController pushViewController:[[JQInsteadTakeViewController alloc] init] animated:YES];
            break;
            
        case 5:
            [self.menus[2].controller.navigationController pushViewController:[[JQAdviseViewController alloc] init] animated:YES];
            break;
            
        case 6:{
            JQMyShopViewController *myShopVC = [[JQMyShopViewController alloc] init];
//            myShopVC.mineShopModel = ((JQMineViewController *)self.menus[3].controller).mineShopModel;
            [self.menus[3].controller.navigationController pushViewController:myShopVC animated:YES];
                }
            break;
            
        case 7:
            [self.menus[4].controller.navigationController pushViewController:[[JQShareFriendsViewController alloc] init] animated:YES];
            break;
            
        case 8:
            [self.menus[5].controller.navigationController pushViewController:[[JQHelpViewController alloc] init] animated:YES];
            break;
    }
}

@end
