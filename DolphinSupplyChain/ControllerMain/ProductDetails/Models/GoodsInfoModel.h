//
//  GoodsInfoModel.h
//  Distribution
//
//  Created by fei on 15/5/6.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsInfoModel : NSObject

@property (nonatomic ,copy)NSString *goods_id;
@property (nonatomic ,copy)NSString *goods_name;
@property (nonatomic ,copy)NSString *quantity;
@property (nonatomic ,copy)NSString *goods_number;
@property (nonatomic ,copy)NSString *goods_img;
@property (nonatomic ,copy)NSString *goods_thumb;
@property (nonatomic ,copy)NSString *img_original;
@property (nonatomic ,copy)NSString *price;
@property (nonatomic ,copy)NSString *shop_price;
@property (nonatomic ,copy)NSString *sku;
@property (nonatomic ,assign)NSString * has_stock;
@property (nonatomic ,copy)NSString *goods_sn;


@end
