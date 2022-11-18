//
//  JQCommentHeadTableView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/20.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQCommentHeadTableView.h"

@interface JQCommentHeadTableView () <UITableViewDelegate, UITableViewDataSource>

/**头view，用于总评分*/
@property (nonatomic, weak) UIView *headView;

/**静态label*/
@property (nonatomic, weak) UILabel *comLabel;

/**总平均评分*/
@property (nonatomic, weak) UILabel *avgPointLabel;

/**中间的线*/
@property (nonatomic, weak) UIView *line;

/**评论的tableview*/
@property (nonatomic, weak) UITableView *commentTableView;

@end

@implementation JQCommentHeadTableView

NSString *JQCommentHeadTableViewCELL = @"JQCommentHeadTableViewCELL";


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self setViewAutoLayout];
        
    }
    
    return self;
}

- (void)setViewAutoLayout {
    
    [self.headView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(10);
        make.height.equalTo(70);
    }];
    
    [self.comLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.headView).offset(50);
        make.top.equalTo(self.headView).offset(8);
        make.bottom.equalTo(self.headView.bottom).offset(-8);
    }];
    
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.centerX.equalTo(self.headView);
        make.top.equalTo(self.headView).offset(8);
        make.bottom.equalTo(self.headView.bottom).offset(-8);
        make.width.equalTo(2);
    }];
    
    [self.avgPointLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.line.right).offset(50);
        make.top.equalTo(self.headView).offset(8);
        make.bottom.equalTo(self.headView.bottom).offset(-8);
    }];
    
    [self.commentTableView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headView.bottom).offset(10);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.bottom);
    }];
}


- (void)createUI {
    
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor whiteColor];
    self.headView = headView;
    [self addSubview:headView];
    
    UILabel *comLabel = [[UILabel alloc] init];
    self.comLabel = comLabel;
    comLabel.font = [UIFont boldSystemFontOfSize:19.0f];
    comLabel.text = @"综合评分";
    [headView addSubview:comLabel];
    
    UIView *line = [[UIView alloc] init];
    self.line = line;
    line.backgroundColor = BackgroundColor;
    [headView addSubview:line];
    
    UILabel *avgPointLabel = [[UILabel alloc] init];
    self.avgPointLabel = avgPointLabel;
    avgPointLabel.textColor = naviColor;
    avgPointLabel.font = [UIFont boldSystemFontOfSize:19.0f];
    avgPointLabel.text = @"4.9";
    [headView addSubview:avgPointLabel];
    
    UITableView *commentTableView = [[UITableView alloc] init];
    [commentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:JQCommentHeadTableViewCELL];
    commentTableView.delegate = self;
    commentTableView.dataSource = self;
    self.commentTableView = commentTableView;
    [self addSubview:commentTableView];
}

#pragma mark - tableview的数据源和代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

//NSString *TESTID = @"TESTID";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JQCommentHeadTableViewCELL];
    
    cell.textLabel.text = @"xxxx";
    return cell;
}

@end
