//
//  ShopingCart_VC.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/8.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "HTBase_VC.h"

typedef enum : NSUInteger {
    Cart_Add,
    Cart_Sub,
    Cart_Set,
    Cart_Del,
} CartSettingType;


@interface ShopingCart_VC : HTBase_VC

@property (nonatomic, assign) BOOL bBottom;



@end
