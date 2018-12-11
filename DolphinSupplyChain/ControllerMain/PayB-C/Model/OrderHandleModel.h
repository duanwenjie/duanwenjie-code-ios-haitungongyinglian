//
//  OrderHandleModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/5/16.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "ZXNModel.h"
@interface OrderHandleModel : ZXNModel

@property (nonatomic, copy) NSString *c_order_id;

@property (nonatomic, copy) NSString *c_order_sn;

@property (nonatomic, copy) NSString *order_amount;

@property (nonatomic, copy) NSString *warehouse_id;

@property (nonatomic, copy) NSString *warehouse_name;

@property (nonatomic, assign) BOOL bIsPay;

@property (nonatomic, copy) NSMutableArray *arrList;

@end
