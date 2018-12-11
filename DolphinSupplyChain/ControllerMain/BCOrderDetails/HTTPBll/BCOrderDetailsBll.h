//
//  BCOrderDetailsBll.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/15.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BCOrderDetailsModel.h"
#import "BCOrderSellDetail.h"

@interface BCOrderDetailsBll : NSObject

+ (BCOrderDetailsModel *)gainOrderDetailList:(id)json;

+ (BCOrderSellDetail *)gainOrderSellDetailList:(id)json;

+ (NSMutableArray *)gainLogistics:(id)json;

@end
