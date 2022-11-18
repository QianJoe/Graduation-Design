//
//  JQShopIntroView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/20.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQShopIntroView.h"

@interface JQShopIntroView ()

@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *reportLabel;

@end

@implementation JQShopIntroView

+ (instancetype)shopIntroView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}



@end
