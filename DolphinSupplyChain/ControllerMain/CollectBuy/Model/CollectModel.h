//
//  CollectModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/3.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ZXNModel.h"

@interface CollectModel : ZXNModel

@property (nonatomic, copy) NSString *collect_goods_id;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *goods_id;

@property (nonatomic, copy) NSString *add_time;

@property (nonatomic, copy) NSString *sku;

@property (nonatomic, copy) NSString *brand_id;

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, copy) NSString *market_price;

@property (nonatomic, copy) NSString *pretax_price;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *img_original;

@end
