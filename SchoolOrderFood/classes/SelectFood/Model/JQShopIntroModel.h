//
//  JQShopIntroModel.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/22.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQShopIntroModel : NSObject

/**地址*/
@property (nonatomic, copy) NSString *location;

/**电话*/
@property (nonatomic, copy) NSString *phone;

/**分类*/
@property (nonatomic, copy) NSString *category;

/**运营时间*/
@property (nonatomic, copy) NSString *time;

@end
