//
//  JQDateTextField.h
//  15拦截用户输入(UITextField)
//
//  Created by 乔谦 on 16/8/10.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JQDateTextField : UITextField

/**获取unix时间戳*/
- (NSInteger)getUnixTime;

@end
