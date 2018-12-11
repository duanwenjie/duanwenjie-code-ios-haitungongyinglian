//
//  OrderSearch_VC.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/23.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "HTBase_VC.h"

typedef void(^OrderSearchKeyWorldBlock)(NSString *sKeyWorld);

@interface OrderSearch_VC : HTBase_VC

- (instancetype)initWithBlock:(OrderSearchKeyWorldBlock)block;


@end
