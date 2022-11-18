//
//  JQSettingTableViewCell.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/8.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQSettingTableViewCell.h"
#import "JQSettingArrowItem.h"
#import "JQSettingSwitchItem.h"

@implementation JQSettingTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"cell";
    
    JQSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if (!cell) {
        
        cell = [[JQSettingTableViewCell alloc] initWithStyle:style reuseIdentifier:ID];
    }
    
    return cell;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    return [self cellWithTableView:tableView style:UITableViewCellStyleValue1];
}

- (void)setItem:(JQSettingItem *)item {
    
    _item = item;
    self.imageView.image = item.image;
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subTitle;
    
    [self setupRightView];
}

/**设置右侧视图*/
- (void)setupRightView{
    
    if ([_item isKindOfClass:[JQSettingArrowItem class]]) { // 剪头
        
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
        
    } else if ([_item isKindOfClass:[JQSettingSwitchItem class]]){
        
        JQSettingSwitchItem *swItem = (JQSettingSwitchItem *)_item;
        
        UISwitch *sw = [[UISwitch alloc] init];
        
        sw.on = swItem.open;
        
        self.accessoryView = sw;
        
    } else {
        
        // 注意, 一定要清空
        self.accessoryView = nil;
    }
    
}

@end
