//
//  JQPageScrollView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/2.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQPageScrollView.h"
#import <SDWebImage/UIImageView+WebCache.h>
/** 循环利用的imageview的个数  */
static const NSInteger MaxImageViewCount = 3;

@interface JQPageScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIImage *placeImage;

@end

@implementation JQPageScrollView


+ (instancetype)pageScroller:(NSArray <NSString *>*)images placeHolderImage:(UIImage *)placeHolderImage{
    JQPageScrollView *pageView = [[self alloc]init];
    pageView.images = images;
    pageView.placeImage = placeHolderImage;
    
    return pageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.scrollView = ({
            UIScrollView *scroll = [[UIScrollView alloc]init];
            scroll.showsHorizontalScrollIndicator = NO;
            scroll.showsVerticalScrollIndicator = NO;
            scroll.pagingEnabled = YES;
            scroll.bounces = NO;
            scroll.delegate = self;
            scroll;
        });
        [self addSubview:self.scrollView];
        
//        JQLOG(@"self.images.count  - %zd",self.images.count);
        
        for (int i = 0; i <  MaxImageViewCount; ++i) {
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.userInteractionEnabled = YES;
            
            // 添加一个点击手势
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)];
            [imageView addGestureRecognizer:tapGes];
            [self.scrollView addSubview:imageView];
        }
//        JQLOG(@"self.subvies = %@",self.scrollView.subviews);
        
        self.pageControl = [[UIPageControl alloc]init];
        self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"v2_home_cycle_dot_selected"]];
        self.pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"v2_home_cycle_dot_normal"]];
        [self addSubview:self.pageControl];
        
    }
    return self;
}

- (void)setImages:(NSArray *)images {
    
    _images = images;
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = images.count;
    
    [self stopTimer];
    [self starTimer];
    [self updatePageScrollerView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    CGFloat scrollViewW = self.scrollView.frame.size.width;
    CGFloat scrollViewH = self.scrollView.frame.size.height;
    
    self.scrollView.contentSize = CGSizeMake(scrollViewW * MaxImageViewCount, 0);
    
    for (int i = 0; i < self.scrollView.subviews.count; ++i) {
        
        UIImageView *images = self.scrollView.subviews[i];
        images.frame = CGRectMake(scrollViewW * i, 0, scrollViewW, scrollViewH);
    }
    
    self.pageControl.frame = CGRectMake(scrollViewW - 80, scrollViewH - 20, 80, 20);
    
    [self updatePageScrollerView];
}

- (void)updatePageScrollerView {
    
    // 然后创建
    for (int i = 0; i < self.scrollView.subviews.count; ++i) {
        
        UIImageView *imageView = self.scrollView.subviews[i];
        NSInteger index = self.pageControl.currentPage;
        if (i==0) {
            index --;
        } else if(i == 2) {
            index ++;
        }
        
        if (index < 0) {
            
            index = self.pageControl.numberOfPages-1;
        } else if (index > self.pageControl.numberOfPages - 1) {
        
            index = 0;
        }
        
        imageView.tag = index;
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.images[index]] placeholderImage:self.placeImage];
        
    }
    
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat minDistance = MAXFLOAT;
    NSInteger page = 0;
    
    for (NSInteger i = 0; i<self.scrollView.subviews.count; i++) {
        
        UIImageView *imageView = self.scrollView.subviews[i];
        CGFloat distance = fabs(self.scrollView.contentOffset.x - imageView.frame.origin.x);
        
        if (distance < minDistance) {
            
            minDistance = distance;
            page = imageView.tag;
        }
    }
    
    self.pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updatePageScrollerView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self updatePageScrollerView];
}

- (void)stopTimer {
    if (self.timer != nil) {
        [self.timer  invalidate];
        self.timer = nil;
    }
}

- (void)starTimer {
    
    self.timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
}

- (void)next {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * 2, 0) animated:YES];
}

#pragma mark - 点击轮播器中图片的手势事件
- (void)imageViewClick:(UITapGestureRecognizer *)tapGes {
    
    NSString *imgURL = self.images[tapGes.view.tag];
    JQLOG(@"轮询器被点击:%ld----%@", tapGes.view.tag, imgURL);
}


@end
