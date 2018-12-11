//
//  GoodsAddModel.h
//  Distribution
//
//  Created by fei on 14-12-18.
//  Copyright (c) 2014年 ___YKSKJ.COM___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsAddModel : NSObject

@property (nonatomic ,copy )NSString *goods_index;
@property (nonatomic ,copy )NSString *goods_sn;
@property (nonatomic ,copy )NSString *goods_amount;
@property (nonatomic ,copy )NSString *goods_price;
@property (nonatomic ,copy )NSString * goods_imgthumb;

@property (nonatomic ,copy )NSString *goods_name;
//@property (nonatomic ,copy)NSString * sku;
//@property (nonatomic ,copy)NSString * img_thumb;
@property (nonatomic ,copy)NSString * min_sale_quantity;
@property (nonatomic ,copy)NSString * max_sale_quantity;
@property (nonatomic ,copy)NSString * img_original;
@property (nonatomic ,assign)BOOL  is_modulo;

@end
