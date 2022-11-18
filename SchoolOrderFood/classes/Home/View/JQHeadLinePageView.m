//
//  JQHeadLinePageView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/3.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQHeadLinePageView.h"
#import "JQHeadLineContentView.h"
#import "JQHeadLine.h"
#import "JQHead.h"

@interface JQHeadLinePageView () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *headlineScrollView;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation JQHeadLinePageView

/**最大重用view的个数*/
static const CGFloat MaxContentViewCount = 3;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIScrollView *headlineScrollView = [[UIScrollView alloc]init];
        headlineScrollView.pagingEnabled = YES;
        headlineScrollView.bounces = NO;
        headlineScrollView.delegate = self;
        headlineScrollView.showsVerticalScrollIndicator = NO;
        headlineScrollView.showsHorizontalScrollIndicator = NO;
        self.headlineScrollView = headlineScrollView;
        [self addSubview:headlineScrollView];
        
        for (int i = 0; i < MaxContentViewCount; ++i) {
            
            JQHeadLineContentView *contentView = [[JQHeadLineContentView alloc]init];
            
            // 打开交互接口
            contentView.userInteractionEnabled = YES;

            // 添加手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contentViewClicked:)];
            [contentView addGestureRecognizer:tap];
            
            [self.headlineScrollView addSubview:contentView];
        }
    }
    
    return self;
}

#pragma mark - 用frame的要在这个方法里布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.headlineScrollView.frame = self.bounds;
    CGFloat scrollViewW = self.headlineScrollView.frame.size.width;
    CGFloat scrollViewH = self.headlineScrollView.frame.size.height;
    
    self.headlineScrollView.contentSize = CGSizeMake(scrollViewW, scrollViewH * MaxContentViewCount);
    
    for (NSInteger i = 0; i < MaxContentViewCount; i++) {
        
        JQHeadLineContentView *contentView = self.headlineScrollView.subviews[i];
        
        contentView.frame = CGRectMake(0, i * scrollViewH, scrollViewW, scrollViewH);
    }
}

- (void)updateHeadlinePageView{
    
    CGFloat scrollViewH = self.headlineScrollView.frame.size.height;
    
    for (int i = 0; i < MaxContentViewCount; ++i) {
        
        NSInteger index = self.currentPage;
        JQHeadLineContentView *contentView = self.headlineScrollView.subviews[i];
        
        if (i==0) {
            
            index--;
            
        } else if(i == 2){
            
            index++;
        }
        
        if (index < 0) { // 先暂定有3个数据
            
            index = self.headLine.headArr.count - 1;
            
        } else if (index > self.headLine.headArr.count - 1) {
            
            index = 0;
        }
        
        contentView.tag = index;
        // 给内容控件赋值
        contentView.head = self.headLine.headArr[index];
    }
    self.headlineScrollView.contentOffset = CGPointMake(0, scrollViewH);
}

#pragma mark - ---| UIScrollViewDelegate |---

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat minDistance = MAXFLOAT;
    for (int i = 0; i < MaxContentViewCount; ++i) {
        
        JQHeadLineContentView *contentView = self.headlineScrollView.subviews[i];
//        JQLOG(@"self.headlineScrollView.subviews[i]:%ld", [self.headlineScrollView.subviews count]);
        
        CGFloat distance = fabs(contentView.frame.origin.y - self.headlineScrollView.contentOffset.y);
        
        if (distance < minDistance) {
            
            minDistance = distance;
            self.currentPage = contentView.tag;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self updateHeadlinePageView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self updateHeadlinePageView];
}

- (void)strarTimer{
    self.timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)stopTimer{
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)next{
    CGFloat scrollViewH = self.headlineScrollView.frame.size.height;
    
    [self.headlineScrollView setContentOffset:CGPointMake(0, 2 * scrollViewH) animated:YES];
}

- (void)setHeadLine:(JQHeadLine *)headLine {
    [self layoutIfNeeded];
    _headLine = headLine;
    
    self.currentPage = 0;
    
    [self stopTimer];
    [self strarTimer];
    
    [self updateHeadlinePageView];
}

#pragma mark - 点击其中一个调用
- (void)contentViewClicked:(UITapGestureRecognizer *)tap {
    
    NSString *headURL = self.headLine.headArr[tap.view.tag].content;
    JQLOG(@"头条被点击:%ld----%@", tap.view.tag, headURL);
}


@end
