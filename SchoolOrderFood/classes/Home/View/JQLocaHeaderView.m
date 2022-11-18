//
//  JQLocaHeaderView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/9.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQLocaHeaderView.h"
#import "JQCitiesGroup.h"

@interface JQLocaHeaderView ()

@property (nonatomic , weak) UIButton *namebtn;

@end

@implementation JQLocaHeaderView


+ (instancetype)headerWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"header";
    
    JQLocaHeaderView *header = [tableview dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[JQLocaHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        UIButton *namebtn = [[UIButton alloc]init];
        
        [namebtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        namebtn.titleLabel.font = [UIFont systemFontOfSize:15];
        // 设置按钮的内容左对齐
        namebtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        namebtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        
        [self.contentView addSubview:namebtn];
        self.namebtn = namebtn;
        
        
    }
    return self;
}



-(void)setGroups:(JQCitiesGroup *)groups
{
    _groups = groups;
    
    [self.namebtn setTitle:groups.state forState:UIControlStateNormal];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.namebtn.frame = self.bounds;
    
}

@end
