//
//  BCorderSellDetailBuyModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/15.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ZXNModel.h"

@interface BCorderSellDetailBuyModel : ZXNModel

@property (nonatomic, copy) NSString *sales_order_id;

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, copy) NSString *sku;

@property (nonatomic, copy) NSString *cancel_number;

@property (nonatomic, copy) NSString *quantity;

@property (nonatomic, copy) NSString *market_price;

@property (nonatomic, copy) NSString *pretax_price;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *purchase_price;

@property (nonatomic, copy) NSString *sales_price;

@property (nonatomic, copy) NSString *goods_id;

@property (nonatomic, copy) NSString *sDescription;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *keywords;

@property (nonatomic, copy) NSString *brand_id;

@property (nonatomic, copy) NSString *img_thumb;

@property (nonatomic, copy) NSString *img_large;

@property (nonatomic, copy) NSString *img_original;

@property (nonatomic, copy) NSString *purchase_count;

@property (nonatomic, copy) NSString *click_count;

@property (nonatomic, copy) NSString *is_group_sku;

@property (nonatomic, copy) NSString *is_trade_sku;

@property (nonatomic, copy) NSString *is_defective_sku;

@property (nonatomic, copy) NSString *min_purchase_quantity;

@property (nonatomic, copy) NSString *min_sale_quantity;

@property (nonatomic, copy) NSString *max_sale_quantity;

@property (nonatomic, copy) NSString *is_best;

@property (nonatomic, copy) NSString *is_new;

@property (nonatomic, copy) NSString *is_hot;

@property (nonatomic, copy) NSString *is_on_sale;

@property (nonatomic, copy) NSString *is_deleted;

@property (nonatomic, copy) NSString *is_modulo;

@property (nonatomic, copy) NSString *ordering;

@property (nonatomic, copy) NSString *last_update_time;

@end
