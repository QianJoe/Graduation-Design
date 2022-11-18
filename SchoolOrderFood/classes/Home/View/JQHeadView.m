//
//  JQHeadView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/2.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQHeadView.h"
#import "JQPageScrollView.h"
#import "JQHotLineView.h"
#import "JQHeadData.h"

@interface JQHeadView ()

/**轮播器*/
@property (nonatomic, weak) JQPageScrollView *pageView;
/**头条view*/
@property (nonatomic, weak) JQHotLineView *hotLineView;

@end

@implementation JQHeadView

//- (instancetype)initWithHeadData:(JQHeadData *)headData {
//    
//    if (self = [super init]) {
//        
//        self.headData = headData;
//    }
//    
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    NSArray *pageImgs = @[
                          @"",
                          @"",
                          @""
                          ];
    
    JQPageScrollView *pageView = [JQPageScrollView pageScroller:pageImgs placeHolderImage:[UIImage imageNamed:@"01"]];
    
    self.pageView = pageView;
    [self addSubview:pageView];

    
    JQHotLineView *hotLineView = [[JQHotLineView alloc] init];
    self.hotLineView = hotLineView;
    [self addSubview:hotLineView];
    
}

- (void)setViewAutoLayout {
    
    [self.pageView layoutIfNeeded];
    
    [self.pageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(self.width).multipliedBy(0.37);
    }];
    
    [self.hotLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pageView.bottom).offset(5);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(35);
    }];
    
}

- (void)setHeight:(CGFloat)height{
    _height = height;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeHeadViewHeightDidChange" object:[NSNumber numberWithFloat:height]];
}

//- (void)setHead:(JQHead *)head {
//    
//    _head = head;
//    
//    self.hotLineView.head = head;
//}

//- (void)setHeadLine:(JQHeadLine *)headLine {
//    
//    _headLine = headLine;
//    
//    self.hotLineView.headLine = headLine;
//}

- (void)setHeadData:(JQHeadData *)headData {
    
    _headData = headData;
    
    self.pageView.images = headData.pageViewImgArr;
    
    self.hotLineView.headLine = headData.headLine;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.height = CGRectGetMaxY(self.hotLineView.frame);
}


@end
