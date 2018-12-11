//
//  OrderHandle_VC.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/5/16.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "HTBase_VC.h"

@interface OrderHandle_VC : HTBase_VC

/**
 指定初始化方法

 @param array 订单数组
 @param buyType 是C端购买还是 B端采购
 @param orderType 是境外商品订单 还是 国内商品订单
 @return 类本身
 */
- (instancetype)initWithArrayList:(NSMutableArray *)array
                          BuyType:(BuyType)buyType
                        OrderType:(OrderType)orderType;

@end
