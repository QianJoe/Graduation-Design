//
//  JQHeadView.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/2.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class JQHead;
//@class JQHeadLine;
@class JQHeadData;

@interface JQHeadView : UIView

@property (nonatomic, assign) CGFloat height;
/**持有一个head*/
//@property (nonatomic, strong) JQHead *head;
//@property (nonatomic, strong) JQHeadLine *headLine;
@property (nonatomic, strong) JQHeadData *headData;

//- (instancetype)initWithHeadData:(JQHeadData *)headData;

@end
