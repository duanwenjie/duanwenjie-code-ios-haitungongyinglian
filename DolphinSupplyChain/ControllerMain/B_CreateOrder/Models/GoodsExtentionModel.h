//
//  GoodsExtentionModel.h
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/2/22.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsExtentionModel : NSObject
@property (nonatomic ,copy )NSString *goods_name;
@property (nonatomic ,copy)NSString * sku;
@property (nonatomic ,copy)NSString * img_thumb;
@property (nonatomic ,copy)NSString * min_sale_quantity;
@property (nonatomic ,copy)NSString * max_sale_quantity;
@property (nonatomic ,assign)BOOL  is_modulo;
@property (nonatomic ,copy)NSString * img_original;
@end
