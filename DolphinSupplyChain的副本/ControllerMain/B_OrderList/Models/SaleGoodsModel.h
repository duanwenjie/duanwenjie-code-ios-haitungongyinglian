//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//
/*
 "all_stock" = 1035;
 "fx_order_id" = 96;
 "goods_id" = 4;
 "goods_name" = "\U5fb7\U56fd\U7231\U4ed6\U7f8eAptamil\U5976\U7c892";
 "goods_price" = "0.00";
 "goods_sn" = DEAP003;
 "goods_str" = "";
 "goods_thumb" = "images/201412/thumb_img/4_thumb_G_1418493531340.jpg";
 id = 109;
 "market_price" = "0.00";
 quantity = 5;
 "sku_name" = "";
 "user_stock" = 0;
 */

#import <Foundation/Foundation.h>

@interface SaleGoodsModel : NSObject

@property (nonatomic ,strong)NSNumber *id;
@property (nonatomic ,strong)NSNumber *fx_order_id;
@property (nonatomic ,strong)NSNumber *goods_id;
@property (nonatomic , copy )NSString *goods_str;
@property (nonatomic , copy )NSString *goods_name;
@property (nonatomic , copy )NSString *goods_price;
@property (nonatomic , copy )NSString *goods_thumb;
//@property (nonatomic , copy )NSString *goods_sn;
@property (nonatomic , copy )NSString *sku;
@property (nonatomic ,copy)NSString *quantity;
@property (nonatomic ,strong)NSNumber *mw_stock;
@property (nonatomic ,strong)NSNumber *yks_stock;
@property (nonatomic , copy )NSString *purchase_count;
@property (nonatomic , copy )NSString *img_thumb;


@end
