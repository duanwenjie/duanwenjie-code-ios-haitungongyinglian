//
//  HotBrandModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/27.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ZXNModel.h"

@interface HotBrandModel : ZXNModel


@property (nonatomic, copy) NSString *brand_id;

@property (nonatomic, copy) NSString *brand_name;

@property (nonatomic, copy) NSString *logo;

@property (nonatomic, copy) NSString *sDescription;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *ordering;

@property (nonatomic, copy) NSString *is_enable;

@property (nonatomic, copy) NSString *is_delete;

@end
