//
//  JQLocaViewController.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/9.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JQLocaViewController : UIViewController
@property (nonatomic , copy) void(^CityBlock)(NSString *provice , NSString *city);
@property (nonatomic , copy) NSString *currentTitle;
@end
