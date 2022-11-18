//
//  JQSettingTableViewCell.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/8.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JQSettingItem.h"

@interface JQSettingTableViewCell : UITableViewCell

/**行模型*/
@property (nonatomic, strong) JQSettingItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;

@end
