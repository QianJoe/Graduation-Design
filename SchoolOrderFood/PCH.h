//
//  PCH.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/21.
//  Copyright © 2016年 wlr. All rights reserved.
//

#ifndef PCH_h
#define PCH_h

#import "JQHttpRequestTool.h"

// 注册
#define JQOrderSchoolFoodRegisterURL @"http://60.205.182.229/schoolOrderFood/index.php/Index/doRegister"
// 登录
#define JQOrderSchoolFoodLoginURL @"http://60.205.182.229/schoolOrderFood/index.php/Index/doLogin"
// 首页头view的数据
#define JQOrderSchoolFoodHomeHeadAndPageDataURL @"http://60.205.182.229/schoolOrderFood/index.php/Home/getHomeHeadAndPageData"
// 首页推荐的数据
#define JQOrderSchoolFoodHomeRecommendDataURL @"http://60.205.182.229/schoolOrderFood/index.php/Home/getHomeRecommendData"
// 我的轮播器图片
#define JQOrderSchoolFoodMinePageDataURL @"http://60.205.182.229/schoolOrderFood/index.php/Home/getMinePageData"
// 我的订餐
#define JQGetMineBuyedFoodDataURL @"http://60.205.182.229/schoolOrderFood/index.php/User/getMineBuyedTakeFood"
// 代送列表
#define JQInsteadTakeFoodDataURL @"http://60.205.182.229/schoolOrderFood/index.php/User/getWaitForTakeFood"
// 申请代送
#define JQApplyInsteadTakeFoodURL @"http://60.205.182.229/schoolOrderFood/index.php/User/applyWaitForTakeFood"
// 我的代送
#define JQGetMineTakeFoodDataURL @"http://60.205.182.229/schoolOrderFood/index.php/User/getMineTakeFood"
#endif /* PCH_h */
