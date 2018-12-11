//
//  PayBC_VC.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/1.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "HTBase_VC.h"
#import "AddressListModel.h"

@interface PayBC_VC : HTBase_VC

@property (nonatomic, copy) NSString *sOrderId;

@property (nonatomic, copy) NSString *sOrderNumber;

@property (nonatomic, copy) NSString *sOrderMoney;

@property (nonatomic, assign) BOOL bNeedPay;

@property (nonatomic, strong) AddressListModel *model;


/**
 初始化方法

 @param buyType C端订单 B端订单
 @param orderType 国内商品订单类型  境外购订单类型
 @return 返回类本身
 */
- (instancetype)initWithIsBuyType:(BuyType)buyType
                            Order:(OrderType)orderType;


@end
