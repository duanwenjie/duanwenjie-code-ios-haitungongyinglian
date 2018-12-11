//
//  RecommendModel.h
//  Distribution
//
//  Created by Steffen.D on 16/11/10.
//  Copyright © 2016年 ___YKSKJ.COM___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendModel : NSObject
@property(nonatomic ,copy)NSString *goods_sn;
@property(nonatomic ,copy)NSString *shop_price;
@property(nonatomic ,assign)BOOL has_stock;
@property(nonatomic ,copy)NSString *goods_name;
@property(nonatomic ,copy)NSString *goods_img;

@end
