//
//  BCOrderDetails_VC.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/15.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "HTBase_VC.h"

@interface BCOrderDetails_VC : HTBase_VC

/// 是否有修改选项
@property (nonatomic, assign) BOOL bNoRevise;

/**
 初始化构造器

 @param sOrderID 传入OrderID
 @param bB_COrder 如果是C模式订单传入YES 如果是B模式订单传入NO
 @param bNOPay 如果是未支付进入传入YES  如果是支付后进入传入NO
 @return 返回本身
 */
- (instancetype)initWithOrderID:(NSString *)sOrderID B_COrder:(BOOL)bB_COrder isNoPay:(BOOL)bNOPay;

@end
