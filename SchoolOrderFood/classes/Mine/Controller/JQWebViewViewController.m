//
//  JQWebViewViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/9.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQWebViewViewController.h"

@interface JQWebViewViewController () <UIWebViewDelegate>

/**用于显示html*/
@property (nonatomic,weak) UIWebView *webView;

@end

@implementation JQWebViewViewController

#pragma mark - 当控制器不是从xib，storyboard创建的，就会通过loadView创建一个空白的View
- (void)loadView{
    
    UIWebView *webView = [[UIWebView alloc] init];
    
    self.view = webView;
    
    self.webView = webView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置UIWebView的代理
    self.webView.delegate = self;
}


@end
