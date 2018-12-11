//
//  ProductExtentionModel.h
//  Distribution
//
//  Created by Steffen.D on 16/10/10.
//  Copyright © 2016年 ___YKSKJ.COM___. All rights reserved.
//
/**
 *  id = 1;
	attribute = 1件装:2件起购;
	goods_number = 10142483;
	goods_img = images/201512/goods_img/2_G_1450463656658.jpg;
	min_pur_num = 2;
	purchase_price = 130.00;
	original_sku = DEAP001;
	market_price = 180.00;
	is_modulo = 0;
	extension_sku = DEAP001;
	sort_order = a1;
	shop_price = 0.10;
 */

#import <Foundation/Foundation.h>

@interface ProductExtentionModel : NSObject
@property(nonatomic ,copy)NSString *id;
@property(nonatomic ,copy)NSString *attribute;
@property(nonatomic ,copy)NSString *stock;
@property(nonatomic ,copy)NSString *goods_img;
@property(nonatomic ,copy)NSString *min_purchase_quantity;
@property(nonatomic ,copy)NSString *purchase_price;
@property(nonatomic ,copy)NSString *original_sku;
@property(nonatomic ,copy)NSString *market_price;
@property(nonatomic ,copy)NSString *sku;
@property(nonatomic ,copy)NSString *sort_order;
@property(nonatomic ,copy)NSString *price;
@property(nonatomic ,copy)NSString *single_price;
@property(nonatomic ,copy)NSString *goods_name;
@property(nonatomic ,copy)NSString *img_thumb;
@property(nonatomic ,copy)NSString *goods_id;
@property(nonatomic ,copy)NSString *img_original;
@property(nonatomic ,assign)BOOL is_collect;



@end
