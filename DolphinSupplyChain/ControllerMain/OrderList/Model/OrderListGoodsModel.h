//
//  OrderListGoodsModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/5.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ZXNModel.h"

@interface OrderListGoodsModel : ZXNModel

@property (nonatomic, copy) NSString *c_order_goods_id;

@property (nonatomic, copy) NSString *c_order_id;

@property (nonatomic, copy) NSString *goods_id;

@property (nonatomic, copy) NSString *sku;

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *quantity;

@property (nonatomic, copy) NSString *pullout_number_bad;

@property (nonatomic, copy) NSString *pullout_number_ok;

@property (nonatomic, copy) NSString *pretax_price;

@property (nonatomic, copy) NSString *market_price;

@property (nonatomic, copy) NSString *img_thumb;

@property (nonatomic, copy) NSString *img_original;

@end
