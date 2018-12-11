//
//  OrderPayModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/3.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "ZXNModel.h"

@interface OrderPayModel : ZXNModel

@property (nonatomic, assign) BOOL flag;

@property (nonatomic, assign) BOOL hasSoon;

@property (nonatomic, copy) NSString *order_amount;

@property (nonatomic, copy) NSString *order_sn;

@property (nonatomic, copy) NSMutableArray *arrList;

@end
