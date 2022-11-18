//
//  JQSettingTableViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/8.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQSettingTableViewController.h"
#import "JQSettingArrowItem.h"
#import "JQSettingSwitchItem.h"
#import "JQSettingGroup.h"
#import "JQFileTool.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JQPushSettingViewController.h"
#import "JQAboutViewController.h"

#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
@interface JQSettingTableViewController ()

/**缓存大小*/
@property (nonatomic, assign) NSInteger totalSize;
/**缓存title*/
@property (nonatomic, copy) NSString *totalSizeStr;

///**arrowItem*/
//@property (nonatomic, weak) JQSettingArrowItem *arrowItem;

@end

@implementation JQSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    // 获取文件夹尺寸
    // 文件夹非常小,如果我的文件非常大
    [JQFileTool getFileSize:CachePath completion:^(NSInteger totalSize) {
        
        _totalSize = totalSize;
        _totalSizeStr = [JQFileTool sizeStr:_totalSize];
        
//        JQLOG(@"_totalSizeStr:%@", _totalSizeStr);
//        self.arrowItem.title = _totalSizeStr;
        JQSettingGroup *group = [self.groups firstObject];
        JQSettingArrowItem *item = [group.items firstObject];
        item.title = _totalSizeStr;
        [self.tableView reloadData];
        
    }];
    
    [self setGroup0];
    
    [self setGroup1];
    
    [self setupGroup2];
    
    [self setupGroup3];
}

- (void)dealloc {
    
    NSLog(@"%s",__func__);
}

- (void)setGroup0 {
    
    // 第0组
    JQSettingArrowItem *item = [JQSettingArrowItem itemWithImage:[UIImage imageNamed:@"MoreAbout"] title:_totalSizeStr];
    
    item.operation = ^(NSIndexPath *indexPath) {
        
        [SVProgressHUD showWithStatus:@"正在清理缓存..."];
        
        [self removeFile:^{
           
            _totalSize = 0;
            _totalSizeStr = [JQFileTool sizeStr:_totalSize];
            JQSettingGroup *group = [self.groups firstObject];
            JQSettingArrowItem *item = [group.items firstObject];
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                // 改变标题
                item.title = _totalSizeStr;
                
                [self.tableView reloadData];
                
                [SVProgressHUD dismiss];
            });
        }];
        
    };
    
    // 创建组模型
    JQSettingGroup *group = [JQSettingGroup groupWithItems:@[item]];
//    self.arrowItem = item;
    // 添加到总数组中
    [self.groups addObject:group];
}

- (void)removeFile:(void(^)()) then {
    
//    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 清空缓存
        // 删除文件夹里面所有文件
        [JQFileTool removeDirectoryPath:CachePath];
        //        JQLOG(@"----%@", CachePath);
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !then ? : then();
        });
    });
}

- (void)setGroup1 {
    
    // 第1组
    JQSettingArrowItem *item1 = [JQSettingArrowItem itemWithImage:[UIImage imageNamed:@"MorePush"] title:@"推送和提醒"];
    item1.desVc = [JQPushSettingViewController class];
    
    JQSettingItem *item2 = [JQSettingSwitchItem itemWithImage:[UIImage imageNamed:@"sound_Effect"] title:@"声音效果"];
    
    // 创建组模型
    JQSettingGroup *group = [JQSettingGroup groupWithItems:@[item1, item2]];
    
    // 添加到总数组中
    [self.groups addObject:group];
}

- (void)setupGroup2{
    // 第2组
    JQSettingItem *item1 = [JQSettingArrowItem itemWithImage:[UIImage imageNamed:@"RedeemCode"] title:@"检查新版本"];
    item1.operation = ^(NSIndexPath *indexPath){
        
        [SVProgressHUD showWithStatus:@"正在检查..."];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [SVProgressHUD showSuccessWithStatus:@"已是最新版本"];
        });
        
    };
    
    JQSettingItem *item2 = [JQSettingArrowItem itemWithImage:[UIImage imageNamed:@"MoreShare"] title:@"分享"];
    
    JQSettingArrowItem *item3 = [JQSettingArrowItem itemWithImage:[UIImage imageNamed:@"MoreAbout"] title:@"关于"];
    item3.desVc =[JQAboutViewController class];
    
    // 创建组模型
    JQSettingGroup *group = [JQSettingGroup groupWithItems:@[item1, item2, item3]];
    
    // 添加到总数组中
    [self.groups addObject:group];
}

- (void)setupGroup3 {
    
    // 第3组
    JQSettingItem *item1 = [JQSettingArrowItem itemWithImage:nil title:@"退出登录"];
    
    IMP_BLOCK_SELF(JQSettingTableViewController);
    
    item1.operation = ^(NSIndexPath *indexPath){
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"是否退出登录?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            JQLOG(@"点击了取消");
        }];
        
        UIAlertAction *certainAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
#warning 退出登录
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
            NSString *filePath = [cachePath stringByAppendingPathComponent:@"user.plist"];
            
            if ([fileManager removeItemAtPath:filePath error:NULL]) {
                
                [SVProgressHUD showSuccessWithStatus:@"退出成功..."];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                    [block_self.navigationController popViewControllerAnimated:YES];
                });
            } else {
                
                [SVProgressHUD showErrorWithStatus:@"退出失败，未知错误"];
            }
            
            
        }];
        
        [ac addAction:cancelAction];
        [ac addAction:certainAction];
        
        // 显示出弹窗
        [self presentViewController:ac animated:YES completion:nil];

    };
    
    // 创建组模型
    JQSettingGroup *group = [JQSettingGroup groupWithItems:@[item1]];
    
    // 添加到总数组中
    [self.groups addObject:group];
}

@end
