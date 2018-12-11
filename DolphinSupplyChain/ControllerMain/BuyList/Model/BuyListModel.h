//
//  BuyListModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/1.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXNModel.h"

@interface BuyListModel : ZXNModel

/// 产品ID
@property (nonatomic, copy) NSString *goods_id;

/// 产品SKU
@property (nonatomic, copy) NSString *goods_sn;

/// 产品名称
@property (nonatomic, copy) NSString *goods_name;

/// 包邮单价
@property (nonatomic, copy) NSString *price;

/// 市场价
@property (nonatomic, copy) NSString *market_price;

/// 中图
@property (nonatomic, copy) NSString *img_original;

/// 是否有库存 1表示有  0表示无
@property (nonatomic, copy) NSString *has_stock;

@end
