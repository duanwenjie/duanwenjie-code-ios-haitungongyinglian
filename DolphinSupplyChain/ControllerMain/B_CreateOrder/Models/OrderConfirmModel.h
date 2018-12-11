//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

/*
 {
 address = "\U5e73\U6e56\U4e00\U53f7\U4ea4\U6613\U5e7f\U573a6\U697cA\U533a";
 city = "\U6df1\U5733";
 consignee = "\U8d39\U8fdb";
 country = "\U4e2d\U56fd";
 district = "\U9f99\U5c97\U533a";
 mobile = 18717114977;
 "money_paid" = 11;
 "order_amount" = 11;
 "order_goods" =         (
 {
 "goods_name" = "";
 "goods_price" = 0;
 "goods_sn" = 7465464;
 quantity = 0;
 "sku_name" = KD876;
 },
 {
 "goods_name" = cs;
 "goods_price" = 1;
 "goods_sn" = "\U6ca1\U6709\U5339\U914d\U5230sku";
 quantity = 1;
 }
 );
 "order_sn" = 16970034;
 "pay_time" = "2014-11-05 09:28:18";
 province = "\U5e7f\U4e1c";
 "shipping_fee" = 0;
 };
 
 */

#import <Foundation/Foundation.h>

@interface OrderConfirmModel : NSObject

@property (nonatomic ,copy )NSString *order_sn;
@property (nonatomic ,copy )NSString  *pay_time;
@property (nonatomic ,copy )NSString  *consignee;
@property (nonatomic ,copy )NSString  *mobile;
@property (nonatomic ,copy )NSString  *country;
@property (nonatomic ,copy )NSString  *province;
@property (nonatomic ,copy )NSString  *city;
@property (nonatomic ,copy )NSString  *district;
@property (nonatomic ,copy )NSString  *address;
@property (nonatomic ,strong)NSNumber *money_paid;
@property (nonatomic ,strong)NSNumber *order_amount;
@property (nonatomic ,strong)NSNumber *shipping_fee;
@property (nonatomic ,strong)NSArray  *order_goods;



@end
