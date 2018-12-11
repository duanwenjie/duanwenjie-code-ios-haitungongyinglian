//
//  NewHomeModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/26.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ZXNModel.h"

@interface NewHomeModel : ZXNModel

// 分类
@property (nonatomic, strong) NSMutableArray *arrTopLevelCategories;

// 轮播
@property (nonatomic, strong) NSArray *arrPictureAdLists;

// 促销 （固定两张）
@property (nonatomic, strong) NSArray *arrPromotion;

// 新品推荐 3个
@property (nonatomic, strong) NSArray *arrNewGoods;

// 特价
@property (nonatomic, strong) NSArray *arrDefective_list;

@property (nonatomic, copy) NSString *category_id;

// 品牌12个
@property (nonatomic, strong) NSArray *arrBrands;

// 热销产品
@property (nonatomic, strong) NSMutableArray *arrHotGoods;

// 二级分类
@property (nonatomic, strong) NSArray *arrCategory;


@end
