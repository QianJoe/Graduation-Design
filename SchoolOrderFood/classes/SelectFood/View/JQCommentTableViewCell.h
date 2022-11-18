//
//  JQCommentTableViewCell.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/22.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQCommentModel;

UIKIT_EXTERN NSString * const COMMENTTBCELL;

@interface JQCommentTableViewCell : UITableViewCell

/**持有一个commentModel*/
@property (nonatomic, strong) JQCommentModel *commentModel;

@end
