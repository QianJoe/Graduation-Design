//
//  JQCommentModel.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/22.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQCommentModel : NSObject

/**头像*/
@property (nonatomic, copy) NSString *headImgUrl;
/**昵称*/
@property (nonatomic, copy) NSString *name;
/**评论的时间*/
@property (nonatomic, copy) NSString *time;
/**点评的星星*/
@property (nonatomic, assign) NSInteger favCount;
/**评论*/
@property (nonatomic, copy) NSString *comment;

@end
