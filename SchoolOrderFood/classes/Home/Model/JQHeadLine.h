//
//  JQHeadLine.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/3.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JQHead;
@interface JQHeadLine : NSObject

/**持有一个存有jqhead的数据*/
@property (nonatomic, strong) NSArray<JQHead *> *headArr;

@end
