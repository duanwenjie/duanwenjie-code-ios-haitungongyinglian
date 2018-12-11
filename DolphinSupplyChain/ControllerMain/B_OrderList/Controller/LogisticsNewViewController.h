//
//  LogisticsNewViewController.h
//  DolphinSupplyChain
//
//  Created by Steffen.D on 16/12/8.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTBase_VC.h"
@interface LogisticsNewViewController : HTBase_VC
@property (nonatomic ,copy)NSString *orderID;
@property (nonatomic ,strong)NSMutableArray * arrList;//物流信息
@property (nonatomic ,copy)NSString * type;
@end
