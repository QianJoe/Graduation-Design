//
//  JQPageScrollView.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/2.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JQPageScrollView : UIView

+ (instancetype)pageScroller:(NSArray <NSString *>*)images placeHolderImage:(UIImage *)placeHolderImage;

/**存放播放图片名称的数组*/
@property (nonatomic, strong) NSArray *images;


@end
