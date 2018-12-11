//
//  PayModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/6.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ZXNModel.h"

@interface PayModel : ZXNModel

@property (nonatomic, copy) NSString *c_order_id;

@property (nonatomic, copy) NSString *c_order_sn;

@property (nonatomic, copy) NSString *order_amount;

@end
