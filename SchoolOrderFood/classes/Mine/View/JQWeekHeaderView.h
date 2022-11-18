//
//  JQWeekHeaderView.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/8.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString * const HEADVWEEKID;

@interface JQWeekHeaderView : UITableViewHeaderFooterView

/**name*/
@property (nonatomic, copy) NSString *name;
/**颜色*/
@property (nonatomic, copy) NSString *colorHex;

@end
