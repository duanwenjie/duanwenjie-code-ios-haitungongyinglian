//
//  CommodityRecommendModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/8.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "ZXNModel.h"

@interface CommodityRecommendModel : ZXNModel

@property (nonatomic, copy) NSString *goods_id;

@property (nonatomic, copy) NSString *goods_sn;

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *market_price;

@property (nonatomic, copy) NSString *img_original;

@property (nonatomic, copy) NSString *has_stock;

@end
