//
//  TransEventArrayModel.h
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/3/2.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransEventArrayModel : NSObject

@property (nonatomic ,copy)NSString * erp_orders_sn;

@property (nonatomic ,copy)NSString * transportion_sn;

@property (nonatomic ,copy)NSString * express;

@property (nonatomic ,strong)NSArray * trans_events;

@end
