//
//  OrderListModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/5.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ZXNModel.h"

@interface OrderListModel : ZXNModel

@property (nonatomic, copy) NSString *c_order_id;

@property (nonatomic, copy) NSString *c_order_sn;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *consignee;

@property (nonatomic, copy) NSString *country_id;

@property (nonatomic, copy) NSString *country;

@property (nonatomic, copy) NSString *province_id;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *city_id;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *district_id;

@property (nonatomic, copy) NSString *district;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *zipcode;

@property (nonatomic, copy) NSString *tel;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *order_status;

@property (nonatomic, copy) NSString *order_status_message;

@property (nonatomic, copy) NSString *order_amount;

@property (nonatomic, copy) NSString *id_card_number;

@property (nonatomic, copy) NSString *consumer_note;

@property (nonatomic, copy) NSString *payment_status;

@property (nonatomic, assign) NSInteger payment_amount;

@property (nonatomic, assign) NSInteger pullout_amount;

@property (nonatomic, copy) NSString *add_time;

@property (nonatomic, copy) NSString *send_time;

@property (nonatomic, copy) NSString *receipt_time;

@property (nonatomic, copy) NSString *cancel_time;

@property (nonatomic, copy) NSString *create_from_platform;

@property (nonatomic, copy) NSString *order_status_working;

@property (nonatomic, copy) NSString *pay_code;

@property (nonatomic, copy) NSString *update_time;

@property (nonatomic, copy) NSString *order_status_info;

@property (nonatomic, copy) NSString *order_status_type;

@property (nonatomic, copy) NSString *business_type;

@end
