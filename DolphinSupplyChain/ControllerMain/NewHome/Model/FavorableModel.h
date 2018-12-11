//
//  FavorableModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/27.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ZXNModel.h"

@interface FavorableModel : ZXNModel

@property (nonatomic, copy) NSString *KeyId;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *url_type;
@property (nonatomic, copy) NSString *beg_time;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, copy) NSString *sort_order;
@property (nonatomic, copy) NSString *is_valid;
@property (nonatomic, copy) NSString *web_real_url;
@property (nonatomic, copy) NSString *category_id_in;
@property (nonatomic, copy) NSString *brand_id_in;
@property (nonatomic, copy) NSString *goods_id_in;

@property (nonatomic, copy) NSString *sku;

@end
