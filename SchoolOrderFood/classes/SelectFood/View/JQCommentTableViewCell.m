//
//  JQCommentTableViewCell.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/22.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQCommentTableViewCell.h"
#import "JQCommentModel.h"
#import "JQStarView.h"
#import <UIImageView+WebCache.h>

NSString * const COMMENTTBCELL = @"COMMENTTBCELL";

@interface JQCommentTableViewCell ()

/**背景view*/
@property (nonatomic, weak) UIView *bgView;

/**头像*/
@property (nonatomic, weak) UIImageView *headImgView;

/**昵称label*/
@property (nonatomic, weak) UILabel *nameLabel;

/**评论时间*/
@property (nonatomic, weak) UILabel *timeLabel;

/**点评的星星*/
@property (nonatomic, weak) JQStarView *starView;

/**评论label*/
@property (nonatomic, weak) UILabel *commentLabel;

@end

@implementation JQCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    /**背景view*/
    UIView *bgView = [[UIView alloc] init];
    self.bgView = bgView;
    [self.contentView addSubview:bgView];
    
    /**头像*/
    UIImageView *headImgView = [[UIImageView alloc] init];
    headImgView.backgroundColor = [UIColor grayColor];
    self.headImgView = headImgView;
    [self.bgView addSubview:headImgView];
    
    /**昵称*/
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:13.0f];
    self.nameLabel = nameLabel;
    [self.bgView addSubview:nameLabel];
    
    /**评论时间*/
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = [UIFont systemFontOfSize:11.0f];
    timeLabel.textColor = [UIColor lightGrayColor];
    self.timeLabel = timeLabel;
    [self.bgView addSubview:timeLabel];
    
    /**点评的星星*/
    JQStarView *starView = [JQStarView startView];
    self.starView = starView;
    [self.bgView addSubview:starView];
    
    /**评论内容*/
    UILabel *commentLabel = [[UILabel alloc] init];
    // 自动换行
    commentLabel.numberOfLines = 0;
    commentLabel.font = [UIFont systemFontOfSize:12.0f];
    self.commentLabel = commentLabel;
    [self.bgView addSubview:commentLabel];
    
}

- (void)setViewAutoLayout {
    
    NSInteger margin = 3;

    UIEdgeInsets padding = UIEdgeInsetsMake(margin, margin, margin, margin);
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.contentView).insets(padding);
    }];
    
    [self.headImgView makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.bgView.left).offset(5);
        make.top.equalTo(self.bgView.top).offset(5);
        make.width.height.equalTo(35);
    }];
    
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.headImgView.top).offset(3);
        make.left.equalTo(self.headImgView.right).offset(5);
    }];
    
    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.bgView.right).offset(-5);
        make.centerY.equalTo(self.nameLabel.centerY);
    }];
    
    [self.starView makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.nameLabel.left);
        make.top.equalTo(self.nameLabel.bottom).offset(5);
        make.width.equalTo(65);
        make.height.equalTo(11);
    }];
    
    [self.commentLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.starView.left);
        make.top.equalTo(self.starView.bottom).offset(10);
        make.right.equalTo(self.timeLabel.left);
    }];
    
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.commentLabel.bottom).offset(8);
    }];
}

- (void)setCommentModel:(JQCommentModel *)commentModel {
    
    _commentModel = commentModel;
    
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:commentModel.headImgUrl] placeholderImage:[UIImage imageNamed:@"v2_my_avatar"]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@", commentModel.name];
    self.timeLabel.text = commentModel.time;
    self.starView.favCount = commentModel.favCount;
    self.commentLabel.text = commentModel.comment;
}

@end
