//
//  PurchaseModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/6.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ZXNModel.h"

@interface PurchaseModel : ZXNModel

@property (nonatomic, copy) NSString *purchase_order_id;

@property (nonatomic, copy) NSString *purchase_order_sn;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *order_status;

@property (nonatomic, copy) NSString *payment_code;

@property (nonatomic, copy) NSString *order_amount;

@property (nonatomic, copy) NSString *add_time;

@property (nonatomic, copy) NSString *pay_time;

@property (nonatomic, copy) NSString *create_from_platform;

@end
