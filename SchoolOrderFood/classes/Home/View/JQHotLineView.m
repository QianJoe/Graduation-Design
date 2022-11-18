//
//  JQHotLineView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/3.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQHotLineView.h"
#import "JQHeadLineContentView.h"
#import "JQHeadLinePageView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "JQHead.h"

@interface JQHotLineView ()

@property (nonatomic, weak) UIImageView *headlineImageView;
@property (nonatomic, weak) UIView *line;
//@property (nonatomic, weak) JQHeadLineContentView *headLinecontentView;
@property (nonatomic, weak) JQHeadLinePageView *headLinePageView;

@end
@implementation JQHotLineView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0].CGColor;
    self.layer.borderWidth = 1;

    UIImageView *headlineImageView = [[UIImageView alloc] init];
    headlineImageView.image = [UIImage imageNamed:@"hotheadtitle"];
//    [headlineImageView sd_setImageWithURL:[NSURL URLWithString:] placeholderImage:[UIImage imageNamed:]];
    headlineImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.headlineImageView = headlineImageView;
    [self addSubview:headlineImageView];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = BackgroundColor;
    self.line = line;
    [self addSubview:line];
    
//    JQHeadLineContentView *headLinecontentView = [[JQHeadLineContentView alloc] init];
//    self.headLinecontentView = headLinecontentView;
    JQHeadLinePageView *headLinePageView = [[JQHeadLinePageView alloc] init];
    self.headLinePageView = headLinePageView;
    [self addSubview:headLinePageView];
    
}

- (void)setViewAutoLayout {
    
    [self.headlineImageView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(80);
        make.bottom.equalTo(self).offset(-3);
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(3);
    }];
    
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self.headlineImageView.right).offset(5);
        make.bottom.equalTo(self).offset(-5);
        make.width.equalTo(1);
    }];
    
    [self.headLinePageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.right);
        make.top.equalTo(self);
        make.bottom.equalTo(self.bottom);
        make.right.equalTo(self);
    }];
}

//- (void)setHead:(JQHead *)head {
//    
//    _head = head;
//    
//    self.headLinecontentView.head = head;
//}

- (void)setHeadLine:(JQHeadLine *)headLine {
    
    _headLine = headLine;
    
    self.headLinePageView.headLine = headLine;
}

@end
