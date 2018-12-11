//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//
/*
 "goods_name" = "";
 "goods_price" = 0;
 "goods_sn" = 7465464;
 quantity = 0;
 "sku_name" = KD876;
 */


#import <Foundation/Foundation.h>

@interface OrderGoodsModel : NSObject

@property (nonatomic ,copy )NSString  *goods_name;
@property (nonatomic ,strong)NSNumber *goods_price;
@property (nonatomic ,copy )NSString  *goods_sn;
@property (nonatomic ,strong)NSString *quantity;
@property (nonatomic ,copy )NSString  *sku_name;
@property (nonatomic ,copy)NSString *id;

@end
