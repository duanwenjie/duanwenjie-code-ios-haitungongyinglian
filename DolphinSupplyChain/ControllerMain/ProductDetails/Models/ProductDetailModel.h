//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface ProductDetailModel : NSObject
@property(nonatomic ,copy)NSString *mv_stock;
@property(nonatomic ,copy)NSString *stock;
@property(nonatomic ,assign)BOOL is_modulo;
@property(nonatomic ,assign)BOOL is_best;
@property(nonatomic ,assign)BOOL is_hot;
@property (nonatomic ,copy)NSString *min_purchase_quantity;
@property(nonatomic ,copy)NSString *attribute;
@property (nonatomic ,strong)NSMutableArray *extension;
@property (nonatomic ,strong)NSMutableArray *standard;
@property (nonatomic ,strong)NSArray *goods_desc;
@property(nonatomic ,assign)BOOL is_collect;
@property(nonatomic ,copy)NSString *sku;
@property(nonatomic ,copy)NSString *goods_id;
@property(nonatomic ,copy)NSString *goods_name;
@property(nonatomic ,copy)NSString *market_price;
@property(nonatomic ,copy)NSString *price;
@property(nonatomic ,copy)NSString *item_price;
@property(nonatomic ,copy)NSString *img_thumb;
@property(nonatomic ,copy)NSString *img_original;
@property(nonatomic ,copy)NSString *img_url;
@property(nonatomic ,copy)NSString *purchase_price;
@property (nonatomic ,strong)NSArray *gallery;
@property (nonatomic ,strong)NSMutableArray *pro;
@property (nonatomic ,strong)NSMutableArray *description_arr;
@property (nonatomic ,copy)NSString *description_html;
@property(nonatomic ,copy)NSString *single_price;
@property (nonatomic ,strong)NSMutableArray *brand_sku;
@end
