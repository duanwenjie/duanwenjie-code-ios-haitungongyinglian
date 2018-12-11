//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

/*
 {
 "goods_attr_id" = 313;
 "goods_id" = 37;
 "goods_image" = "images/201412/goods_img/37_G_1417493203067.jpg";
 "goods_name" = "\U5fb7\U56fd\U7231\U4ed6\U7f8ePre\U6bb50-6\U4e2a\U6708800g \U7f8e\U4e50\U5b9d\U5a74\U5e7c\U513f\U725b\U5976\U7c89\U76f4\U90ae:\U7ea2\U8272";
 "goods_price" = "219.00";
 "order_info" =             (
 );
 sku = "DEAP001-4";
 stocks = 1;
 }
 */
#import <Foundation/Foundation.h>

@interface StorageModel : NSObject

@property(nonatomic ,copy)NSString *goods_id;        //微仓商品id
@property(nonatomic ,copy)NSString *goods_image;
@property(nonatomic ,copy)NSString *img_url;//商品图片
@property(nonatomic ,copy)NSString *goods_name;      //商品名称
@property(nonatomic ,copy)NSString *price;           //商品价格
@property(nonatomic ,copy)NSString *sku;             //商品sku（确定商品的唯一标识）
@property(nonatomic ,copy)NSString *stock;          //商品库存
@property(nonatomic ,copy)NSString *available;      //商品可用库存
@property(nonatomic ,copy)NSArray  *order_info;      //商品采购信息
@property(nonatomic ,copy)NSString *min_pur_num;
@property(nonatomic ,copy)NSString *img_thumb;
@property(nonatomic ,copy)NSString *purchase_count;  //商品销量
@property(nonatomic ,copy)NSString *mw_available_stock;
@end
