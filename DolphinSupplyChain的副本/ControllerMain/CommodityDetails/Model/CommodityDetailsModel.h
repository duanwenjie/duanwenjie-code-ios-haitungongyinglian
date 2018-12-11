//
//  CommodityDetailsModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/8.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "ZXNModel.h"
#import "CommodityImageModel.h"

@interface CommodityDetailsModel : ZXNModel

@property (nonatomic, copy) NSString *goods_id;

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, copy) NSString *sku;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *keywords;

@property (nonatomic, copy) NSString *brand_id;

@property (nonatomic, copy) NSString *attribute_cat_id;

@property (nonatomic, copy) NSString *img_thumb;

@property (nonatomic, copy) NSString *img_large;

@property (nonatomic, copy) NSString *img_original;

@property (nonatomic, copy) NSString *market_price;

@property (nonatomic, copy) NSString *pretax_price;

@property (nonatomic, copy) NSString *price;

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

@property (nonatomic, copy) NSString *stock;

@property (nonatomic, copy) NSString *ordering;

@property (nonatomic, copy) NSString *last_update_time;

@property (nonatomic, copy) NSString *category_manager_id;

@property (nonatomic, copy) NSString *upc;

@property (nonatomic, copy) NSString *single_price;

@property (nonatomic, copy) NSString *mv_stock;

@property (nonatomic, copy) NSString *is_collect;

@property (nonatomic, copy) NSString *security_stock;

@property (nonatomic, copy) NSString *attribute;

//******新增加的库存显示字段*******//

//库存描述
@property (nonatomic ,copy)NSString * stock_description;

//允许的最大购买量
@property (nonatomic ,copy)NSString * purchase_max_quantity;

//允许最大的购买金额
@property (nonatomic ,copy)NSString * purchase_max_amount;

/// 图片数组
@property (nonatomic, copy) NSMutableArray *arrImage;

/// 商品属性
@property (nonatomic, copy) NSMutableArray *arrAttribute;

/// 商品保质期
@property (nonatomic, copy) NSDictionary *expiration_date;
@end
