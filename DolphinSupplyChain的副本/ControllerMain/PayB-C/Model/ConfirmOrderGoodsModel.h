//
//  ConfirmOrderGoodsModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/6.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ZXNModel.h"

@interface ConfirmOrderGoodsModel : ZXNModel

@property (nonatomic, copy) NSString *goods_id;

@property (nonatomic, copy) NSString *goods_sn;

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *market_price;

@property (nonatomic, copy) NSString *img_original;

@property (nonatomic, copy) NSString *has_stock;

@property (nonatomic, copy) NSString *sQuantity;

@property (nonatomic, copy) NSString *security_stock;

@property (nonatomic, copy) NSString *stock;

@property (nonatomic, assign) BOOL bWarning;



@end
