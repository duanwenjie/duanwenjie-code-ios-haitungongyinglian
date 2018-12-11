//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

/*
 "extension_code" = "";
 "goods_attr" = "";
 "goods_attr_id" = 0;
 "goods_id" = 30;
 "goods_img" = "images/200905/goods_img/30_G_1241973114234.jpg";
 "goods_name" = "\U79fb\U52a820\U5143\U5145\U503c\U5361";
 "goods_number" = 1;
 "goods_price" = "18.00";
 "goods_sn" = ECS000030;
 "is_gift" = 0;
 "is_real" = 0;
 "market_price" = "21.00";
 "order_id" = 62;
 "parent_id" = 0;
 "product_id" = 0;
 "product_sn" = "";
 "rec_id" = 49;
 "send_number" = 0;
 
 */

#import <Foundation/Foundation.h>

@interface PurchaseGoodsModel : NSObject

@property (nonatomic ,strong)NSNumber *goods_attr_id;
@property (nonatomic ,strong)NSString *goods_attr;
@property (nonatomic ,strong)NSNumber *goods_id;
//@property (nonatomic , copy )NSString *goods_img;
@property (nonatomic , copy )NSString *img_thumb;

@property (nonatomic , copy )NSString *goods_name;
//@property (nonatomic ,strong)NSNumber *goods_number;
//@property (nonatomic ,strong)NSNumber *goods_price;
@property (nonatomic ,strong)NSNumber *price;
//@property (nonatomic ,strong)NSNumber *goods_amount;
@property (nonatomic ,strong)NSNumber *quantity;
//@property (nonatomic , copy )NSString *goods_sn;
@property (nonatomic , copy )NSString *sku;

@property (nonatomic ,strong)NSNumber *merket_price;
@property (nonatomic ,strong)NSNumber *order_id;
@property (nonatomic ,strong)NSNumber *product_id;
@property (nonatomic ,strong)NSNumber *rec_id;



@end
