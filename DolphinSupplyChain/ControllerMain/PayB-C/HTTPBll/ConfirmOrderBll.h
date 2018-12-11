//
//  ConfirmOrderBll.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/6.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayModel.h"
#import "PurchaseModel.h"
#import "OrderPayModel.h"

@interface ConfirmOrderBll : NSObject

+ (NSMutableDictionary *)gainConfirmOrder:(id)json arrIDOrQuantity:(NSArray *)arrInfo;

+ (NSMutableArray *)gainInventorySeparation:(id)json;

+ (NSMutableArray *)gainOrderHandle:(id)json;

+ (PayModel *)gainConfirmOrder:(id)json;

+ (PurchaseModel *)gainPurchaseOrder:(id)json;

+ (OrderPayModel *)gainOrderPay:(id)json;

@end
