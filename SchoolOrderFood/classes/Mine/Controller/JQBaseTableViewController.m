//
//  JQBaseTableViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/8.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQBaseTableViewController.h"
#import "JQSettingGroup.h"
#import "JQSettingTableViewCell.h"
#import "JQSettingArrowItem.h"

@interface JQBaseTableViewController ()

@end

@implementation JQBaseTableViewController

- (instancetype)init {
    
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)loadView {
    [super loadView];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (NSMutableArray *)groups{
    
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // 取出行组型数组
    JQSettingGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQSettingTableViewCell *cell = [JQSettingTableViewCell cellWithTableView:tableView];
    
    // 从总数组中取出组模型数组
    JQSettingGroup *group = self.groups[indexPath.section];
    
    // 从行模型数组中取出行模型
    JQSettingItem *item = group.items[indexPath.row];
    
    // 传递模型
    cell.item = item;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    JQLog(@"%@",indexPath);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    // 从总数组中取出组模型数组
    JQSettingGroup *group = self.groups[indexPath.section];
    
    // 从行模型数组中取出行模型
    JQSettingItem *item = group.items[indexPath.row];
    
    if (item.operation) {
        item.operation(indexPath);
        
    }else if ([item isKindOfClass:[JQSettingArrowItem class]]) {
        
        // 只有剪头模型才具备跳转功能
        JQSettingArrowItem *arrowItem = (JQSettingArrowItem *)item;
        
        if (arrowItem.desVc) { // 如果有目标控制器
            
            // 拿到目标控制器类名 创建目标控制器
            UIViewController *vc = [[arrowItem.desVc alloc] init];
            vc.title = arrowItem.title;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


@end
