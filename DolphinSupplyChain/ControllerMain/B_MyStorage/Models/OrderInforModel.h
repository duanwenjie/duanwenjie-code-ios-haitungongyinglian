//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderInforModel : NSObject

@property(nonatomic ,copy)NSString *order_id;      //微仓采购订单id
@property(nonatomic ,copy)NSString *order_sn;      //采购订单sn
//@property(nonatomic ,copy)NSString *goods_price;  //采购价格
@property(nonatomic ,copy)NSString *pay_time;     //支付时间
@property(nonatomic ,strong)NSArray *goods;  //采购数量

@end
