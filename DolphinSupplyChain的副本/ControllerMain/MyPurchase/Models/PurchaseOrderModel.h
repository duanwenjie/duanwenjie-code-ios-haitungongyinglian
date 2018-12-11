//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//
/*
 {
 "add_time" = 1416993490;
 "goods_amount" = "0.00";
 "order_amount" = "13999.00";
 "order_goods" =                 (
 );
 "order_id" = 20;
 "order_sn" = 2014112610086;
 "order_status" = 0;
 "pay_status" = 0;
 "shipping_fee" = "0.00";
 "shipping_status" = 0;
 "user_id" = 15;
 }
 */

#import <Foundation/Foundation.h>

@interface PurchaseOrderModel : NSObject

@property (nonatomic , copy )NSString *purchase_order_id;
@property (nonatomic , copy )NSString *order_amount;
@property (nonatomic , copy )NSString *balance;
@property (nonatomic , copy )NSString *purchase_order_sn;

@property (nonatomic , copy )NSString *add_time;
@property (nonatomic , copy )NSString *goods_amount;
@property (nonatomic , copy)NSString *order_status;
@property (nonatomic , strong)NSString *money_paid;
@property (nonatomic , strong)NSNumber *pay_status;
@property (nonatomic , strong)NSNumber *shipping_fee;
@property (nonatomic , strong)NSNumber *shipping_status;
@property (nonatomic , strong)NSArray *goods;
@property (nonatomic , strong)NSMutableDictionary *payment_info;


@property (nonatomic , copy) NSString *is_normal_trade;

@end
