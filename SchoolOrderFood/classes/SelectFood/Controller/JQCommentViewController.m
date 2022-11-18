//
//  JQCommentViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/15.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQCommentViewController.h"
#import "JQCommentModel.h"
#import "JQCommentTableViewCell.h"
#import <MJExtension/MJExtension.h>
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

@interface JQCommentViewController () <UITableViewDataSource, UITableViewDelegate>

/**头view，用于总评分*/
@property (nonatomic, weak) UIView *headView;
/**总平均评分*/
@property (nonatomic, weak) UILabel *avgPointLabel;

/**评论的tableview*/
@property (nonatomic, weak) UITableView *commentTableView;

/**存放commentModel的数组*/
@property (nonatomic, strong) NSMutableArray *commentModelArrMFromJSON;

@end

@implementation JQCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initHeadView];
    
    [self initTableView];
    
    [self initRefresh];
}

#pragma mark - 初始化上拉刷新
- (void)initRefresh {
    
    IMP_BLOCK_SELF(JQCommentViewController);
    self.commentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [block_self loadJSONData:^{
            
            [block_self.commentTableView reloadData];
            
            block_self.avgPointLabel.text = @"4.7";
            
            [block_self.commentTableView.mj_footer endRefreshing];
        }];
    }];
    
    [self.commentTableView.mj_footer beginRefreshing];
}

#pragma mark - 异步加载数据
- (void)loadJSONData:(void(^)()) then {
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
#warning 现在是模拟的json数据
        // 读取json数据
        // 获取json地址
        NSString *commentDataFilePath =[[NSBundle mainBundle] pathForResource:@"commentData" ofType:@"json"];
        
        // 获取二进制数据
        NSData *data = [NSData dataWithContentsOfFile:commentDataFilePath];
        
        // 转成字典
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
        
        // 转成数组
        NSArray *commentDataArr = dataDictionary[@"commentData"];
        NSMutableArray *commentDataArrM = @[].mutableCopy;
        
        commentDataArrM = [JQCommentModel mj_objectArrayWithKeyValuesArray:commentDataArr];
        weakSelf.commentModelArrMFromJSON = commentDataArrM;
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !then ? : then();
        });
    });
}

#pragma mark - 初始化头view
- (void)initHeadView {
    
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor whiteColor];
    self.headView = headView;
    [self.view addSubview:headView];
    
    [headView makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(10);
        make.height.equalTo(70);
    }];
    
    UILabel *comLabel = [[UILabel alloc] init];
    comLabel.font = [UIFont boldSystemFontOfSize:19.0f];
    comLabel.text = @"综合评分";
    [headView addSubview:comLabel];
    
    [comLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(headView).offset(50);
        make.top.equalTo(headView).offset(8);
        make.bottom.equalTo(headView.bottom).offset(-8);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = BackgroundColor;
    [headView addSubview:line];
    
    [line makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.centerX.equalTo(headView);
        make.top.equalTo(headView).offset(8);
        make.bottom.equalTo(headView.bottom).offset(-8);
        make.width.equalTo(2);
    }];
    
    UILabel *avgPointLabel = [[UILabel alloc] init];
    self.avgPointLabel = avgPointLabel;
    avgPointLabel.textColor = naviColor;
    avgPointLabel.font = [UIFont boldSystemFontOfSize:19.0f];
    avgPointLabel.text = @"4.9";
    [headView addSubview:avgPointLabel];
    
    [avgPointLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(line.right).offset(50);
        make.top.equalTo(headView).offset(8);
        make.bottom.equalTo(headView.bottom).offset(-8);
    }];
    
}

- (void)initTableView {
    
    UITableView *commentTableView = [[UITableView alloc] init];
    
//    commentTableView.rowHeight = 80;
    // 去掉尾部多余的
    commentTableView.tableFooterView = [[UIView alloc] init];
    
    commentTableView.delegate = self;
    commentTableView.dataSource = self;
    [commentTableView registerClass:[JQCommentTableViewCell class] forCellReuseIdentifier:COMMENTTBCELL];
    self.commentTableView = commentTableView;
    [self.view addSubview:commentTableView];
    
    [commentTableView makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.headView.bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.bottom);
    }];
    
}

#pragma mark - tableview的数据源和代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.commentModelArrMFromJSON.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:COMMENTTBCELL];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self setupModelOfCell:cell atIndexPath:indexPath];
    
//    cell.commentModel = self.commentModelArrMFromJSON[indexPath.row];
    return cell;
}

#pragma mark - 设置cell的数据
- (void)setupModelOfCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    // 采用计算frame模式还是自动布局模式，默认为NO，自动布局模式
    //    cell.fd_enforceFrameLayout = NO;
    JQCommentTableViewCell *ctvCell = (JQCommentTableViewCell *)cell;
    ctvCell.commentModel = self.commentModelArrMFromJSON[indexPath.row];
    
}

#pragma mark - 改变cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.commentTableView fd_heightForCellWithIdentifier:COMMENTTBCELL cacheByIndexPath:indexPath configuration:^(id cell) {
        
        [self setupModelOfCell:cell atIndexPath:indexPath];
    }];
}

@end

