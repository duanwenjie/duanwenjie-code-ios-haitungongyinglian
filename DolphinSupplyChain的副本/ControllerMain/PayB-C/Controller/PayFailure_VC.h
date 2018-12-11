//
//  PayFailure_VC.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "HTBase_VC.h"

typedef void (^FailureBlock)(BOOL isZhiFuBao);

@interface PayFailure_VC : HTBase_VC

// bHaiWaiOrGuoNei 境外商品订单  国内商品订单
- (instancetype)initWithIsZhiFiBaoOrWeiXin:(NSString *)sZhifuboaOrWeixin
                                 OrderType:(OrderType)orderType;

@property (nonatomic, strong) FailureBlock block;

@property (nonatomic, copy) NSString *sOrderNumber;

@property (nonatomic, copy) NSString *sOrderMoney;


@end
