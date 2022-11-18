//
//  JQHomeGoodsView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/1.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQHomeGoodsView.h"
#import "JQHomeCollectCell.h"
#import "JQCategoryGoods.h"

@interface JQHomeGoodsView ()

/**左边*/
@property (nonatomic, weak) JQHomeCollectCell *leftView;

/**中间*/
@property (nonatomic, weak) JQHomeCollectCell *midView;

/**右边*/
@property (nonatomic, weak) JQHomeCollectCell *rightView;

@end

@implementation JQHomeGoodsView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self setViewAutoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    JQHomeCollectCell *leftView = [[JQHomeCollectCell alloc] init];
    self.leftView = leftView;
    [self addSubview:leftView];
    
    JQHomeCollectCell *midView = [[JQHomeCollectCell alloc] init];
    self.midView = midView;
    [self addSubview:midView];
    
    JQHomeCollectCell *rightView = [[JQHomeCollectCell alloc] init];
    self.rightView = rightView;
    [self addSubview:rightView];

}

- (void)setViewAutoLayout {
    
    [self.leftView makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self);
        make.right.equalTo(self.midView.left);
        make.width.equalTo(self.width).multipliedBy(0.3333);
        make.top.bottom.equalTo(self);
    }];
    
    [self.midView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.leftView.right);
        make.width.equalTo(self.width).multipliedBy(0.3333);
        make.centerY.equalTo(self.leftView.centerY);
        make.top.bottom.equalTo(self.leftView);
    }];

    [self.rightView makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.right);
        make.width.equalTo(self.width).multipliedBy(0.3333);
        make.centerY.equalTo(self.leftView.centerY);
        make.top.bottom.equalTo(self.leftView);
    }];

}

- (void)setCategoryGoods:(JQCategoryGoods *)categoryGoods {
    
    _categoryGoods = categoryGoods;
    
    NSMutableArray<JQGoods *> *hotGoodsArrMTem = [NSMutableArray array];
    
    for (NSInteger i = 0; i < categoryGoods.goodsArr.count; i ++) {
        
        JQGoods *goods = categoryGoods.goodsArr[i];

        if ([goods.isHot integerValue]) {
            
            [hotGoodsArrMTem addObject:goods];
        }
    }
    
    if (hotGoodsArrMTem.count < 1 ) {
        
        JQGoods *goods1 = [[JQGoods alloc] init];
        goods1.goodsName = @"xxxxx";
        goods1.oldPrice = @"0.0";
        goods1.discountPrice = @"0.0";
        goods1.goodsImageURL = nil;
        
        JQGoods *goods2 = [[JQGoods alloc] init];
        goods2.goodsName = @"xxxxx";
        goods2.oldPrice = @"0.0";
        goods2.discountPrice = @"0.0";
        goods2.goodsImageURL = nil;
        
        JQGoods *goods3 = [[JQGoods alloc] init];
        goods3.goodsName = @"xxxxx";
        goods3.oldPrice = @"0.0";
        goods3.discountPrice = @"0.0";
        goods3.goodsImageURL = nil;
        
        self.leftView.goods = goods1;
        self.midView.goods = goods2;
        self.rightView.goods = goods3;
        
    } else if (hotGoodsArrMTem.count < 2) {
        
        self.leftView.goods = hotGoodsArrMTem[0];
        
        JQGoods *goods2 = [[JQGoods alloc] init];
        goods2.goodsName = @"xxxxx";
        goods2.oldPrice = @"0.0";
        goods2.discountPrice = @"0.0";
        goods2.goodsImageURL = nil;
        
        JQGoods *goods3 = [[JQGoods alloc] init];
        goods3.goodsName = @"xxxxx";
        goods3.oldPrice = @"0.0";
        goods3.discountPrice = @"0.0";
        goods3.goodsImageURL = nil;
        
        self.midView.goods = goods2;
        self.rightView.goods = goods3;
        
    } else if (hotGoodsArrMTem.count < 3) {
        
        self.leftView.goods = hotGoodsArrMTem[0];
        self.midView.goods = hotGoodsArrMTem[1];
        
        JQGoods *goods3 = [[JQGoods alloc] init];
        goods3.goodsName = @"xxxxx";
        goods3.oldPrice = @"0.0";
        goods3.discountPrice = @"0.0";
        goods3.goodsImageURL = nil;
        
        self.rightView.goods = goods3;
    } else {
        
        self.leftView.goods = hotGoodsArrMTem[0];
        self.midView.goods = hotGoodsArrMTem[1];
        self.rightView.goods = hotGoodsArrMTem[2];
    }

    
}

@end
