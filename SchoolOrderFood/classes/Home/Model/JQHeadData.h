//
//  JQHeadData.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/4.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JQHeadLine;

@interface JQHeadData : NSObject

/**轮播器的图片*/
@property (nonatomic, strong) NSArray<NSString *> *pageViewImgArr;
/**headline*/
@property (nonatomic, strong) JQHeadLine *headLine;

@end
