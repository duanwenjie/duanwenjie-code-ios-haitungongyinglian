//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//
/*
 {
     "add_time" = "2014-12-18 17:58:34";
     address = "\U4ed6\U611f\U5230\U5c34\U5c2c";
     "can_cancel" = 0;
     city = "\U91cd\U5e86\U5e02";
     consignee = "\U4f60";
     district = "\U4e07\U5dde\U533a";
     id = 73;
     "id_card_back" = "";
     "id_card_font" = "";
     "id_card_number" = "";
     mobile = 13723887053;
     notice = 0;
     "order_goods" =             (
         {
         "all_stock" = 0;
         "fx_order_id" = 73;
         "goods_id" = 274;
         "goods_name" = "\U8377\U5170\U672c\U571fKabrita\U4f73\U8d1d\U827e\U7279\U5a74\U5e7c\U513f\U7f8a\U5976\U7c893\U6bb5(1\U5c81 )";
         "goods_price" = "0.00";
         "goods_sn" = HEKA003;
         "goods_str" = "";
         "goods_thumb" = "images/201412/thumb_img/274_thumb_G_1418684529016.jpg";
         id = 82;
         "market_price" = "0.00";
         quantity = 1;
         "sku_name" = "";
         "user_stock" = 0;
         }
      );
     "order_goods_count" = 1;
     "order_sn" = 357466333;
     "pay_time" = "2014-12-18 17:58:00";
     province = "\U91cd\U5e86";
     "shipping_status" = 0;
     state = "\U5f85\U901a\U77e5\U53d1\U8d27";
     stock = 0;
     "user_id" = 142;
 },
 
 */

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic ,copy)NSString *sales_order_id;
@property (nonatomic , copy )NSString *sales_order_sn;
@property (nonatomic , copy )NSString *add_time;
@property (nonatomic , copy )NSString *pay_time;
@property (nonatomic , copy )NSString *order_status;
@property (nonatomic , copy )NSString *order_status_str;
@property (nonatomic , copy )NSString *mobile;
@property (nonatomic , copy )NSString *consignee;
@property (nonatomic , copy )NSString *province;
@property (nonatomic , copy )NSString *city;
@property (nonatomic , copy )NSString *district;
@property (nonatomic , copy )NSString *address;
@property (nonatomic ,strong)NSNumber *shipping_status;
@property (nonatomic , copy )NSString *id_card_number;
@property (nonatomic,  copy )NSString *id_card_back;
@property (nonatomic,  copy )NSString *id_card_font;
@property (nonatomic ,strong)NSNumber *can_cancel;
@property (nonatomic ,strong)NSNumber *notice;
@property (nonatomic, copy)NSString *payment_info_id_card_number;
@property (nonatomic, copy)NSString *payment_info_method;
@property (nonatomic, copy)NSString *payment_info_name;
@property (nonatomic, copy)NSString *payment_info_number;
@property (nonatomic, copy)NSString *site_type;
@property (nonatomic, copy)NSString *site_name;
@property (nonatomic , strong )NSMutableArray *logistics;
@property (nonatomic , strong )NSArray *goods;
@end
