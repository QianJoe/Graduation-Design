//
//  JQDateTextField.m
//  15拦截用户输入(UITextField)
//
//  Created by 乔谦 on 16/8/10.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQDateTextField.h"

@interface JQDateTextField ()

/**unix时间戳*/
@property (nonatomic, assign) NSInteger unixTimeSp;

@end

@implementation JQDateTextField

- (void)awakeFromNib {
    
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // 设置inputView
        [self setUp];
    }
    
    return self;
}

- (void)setUp {
    
    UIDatePicker *dp = [[UIDatePicker alloc] init];
//    dp.datePickerMode = UIDatePickerModeDate;
    dp.datePickerMode = UIDatePickerModeTime;
    dp.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    [dp addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    self.inputView = dp;
}

- (void)dateChanged:(UIDatePicker *)dp {
    
    // 先将date转为时间戳
    NSInteger timeSp = (NSInteger)[dp.date timeIntervalSince1970] * 1000;
//    JQLOG(@"timeSp：%ld", timeSp);
    self.unixTimeSp = timeSp;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
//    df.dateFormat = @"yyyy-MM-dd";
    df.dateFormat = @"HH点mm分";
    self.text = [df stringFromDate:dp.date];
}

- (NSInteger)getUnixTime {
    
    return _unixTimeSp;
}

@end
