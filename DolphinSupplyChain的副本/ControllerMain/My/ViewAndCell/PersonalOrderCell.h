//
//  PersonalOrderCell.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/29.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    AllOrder = 0,  // 全部订单
    Payment,       // 待付款
    Shipments,     // 待发货
    GatherGoods,   // 待收货
} PersonalOrderType;


@interface PersonalOrderCell : UITableViewCell

typedef void (^PersonalOrderBlock)(PersonalOrderType type);

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier tapSomeButton:(PersonalOrderBlock)block;

- (void)loadView:(NSString *)sPaymentNumber
        Shipment:(NSString *)sShipmentNumber
     GatherGoods:(NSString *)sGatherGoodsNumber;

@end
