//
//  BCOrderSellDetail.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/15.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ZXNModel.h"

@interface BCOrderSellDetail : ZXNModel


@property (nonatomic, copy) NSString *sales_order_id;

@property (nonatomic, copy) NSString *sales_order_sn;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *from_api;

@property (nonatomic, copy) NSString *buyer_nick;

@property (nonatomic, copy) NSString *payment_flow_number;

@property (nonatomic, copy) NSString *consignee;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *district;

@property (nonatomic, copy) NSString *province_id;

@property (nonatomic, copy) NSString *city_id;

@property (nonatomic, copy) NSString *district_id;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *order_status;

@property (nonatomic, copy) NSString *order_status_message;

@property (nonatomic, copy) NSString *order_type;

@property (nonatomic, copy) NSString *goods_amount;

@property (nonatomic, copy) NSString *money_paid;

@property (nonatomic, copy) NSString *order_amount;

@property (nonatomic, copy) NSString *shop_amount;

@property (nonatomic, copy) NSString *id_card_number;

@property (nonatomic, copy) NSString *site_type;

@property (nonatomic, copy) NSString *site_name;

@property (nonatomic, copy) NSString *site_url;

@property (nonatomic, copy) NSString *consumer_note;

@property (nonatomic, copy) NSString *payment_info_method;

@property (nonatomic, copy) NSString *payment_info_number;

@property (nonatomic, copy) NSString *payment_order_sn;

@property (nonatomic, copy) NSString *payment_info_code;

@property (nonatomic, copy) NSString *payment_info_name;

@property (nonatomic, copy) NSString *payment_info_id_card_number;

@property (nonatomic, copy) NSString *add_time;

@property (nonatomic, copy) NSString *confirm_time;

@property (nonatomic, copy) NSString *send_time;

@property (nonatomic, copy) NSString *receipt_time;

@property (nonatomic, copy) NSString *pay_time;

@property (nonatomic, copy) NSString *check_time;

@property (nonatomic, copy) NSString *cancel_time;

@property (nonatomic, copy) NSString *create_from_platform;

@property (nonatomic, copy) NSString *cancel_able;

@property (nonatomic, copy) NSString *edit_able;

@property (nonatomic, copy) NSString *notify_able;

@property (nonatomic, strong) NSMutableArray *arrGoods;


@end
