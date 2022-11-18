//
//  JQSettingItem.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/8.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQSettingItem : NSObject

/**图标*/
@property (nonatomic, strong) UIImage *image;
/**标题*/
@property (nonatomic, copy) NSString *title;
/**子标题*/
@property (nonatomic, copy) NSString *subTitle;
/**点击这行cell要做的事情*/
@property (nonatomic, strong) void(^operation)(NSIndexPath *indexPath);

+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title;

+ (instancetype)itemWithTitle:(NSString *)title;

@end
