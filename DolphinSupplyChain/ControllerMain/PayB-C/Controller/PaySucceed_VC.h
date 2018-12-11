//
//  PaySucceed_VC.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 学宁. All rights reserved.
//
#import "HTBase_VC.h"

@interface PaySucceed_VC : HTBase_VC


- (instancetype)initWithBuyType:(BuyType)buyType
                        PayType:(NSString *)sPayType
                      PayNumber:(NSString *)sPayNumber;


@property (nonatomic, copy) NSString *sOrderNumber;

@property (nonatomic, copy) NSString *sOrderMoney;

@end
