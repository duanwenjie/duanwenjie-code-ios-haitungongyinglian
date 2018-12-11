//
//  DistrictModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/4.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ZXNModel.h"

@interface DistrictModel : ZXNModel

@property (nonatomic, copy) NSString *region_id;

@property (nonatomic, copy) NSString *parent_id;

@property (nonatomic, copy) NSString *region_name;

@property (nonatomic, copy) NSString *region_type;

@property (nonatomic, assign) BOOL bSelect;

@end
