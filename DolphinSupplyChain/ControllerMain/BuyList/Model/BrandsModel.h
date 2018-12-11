//
//  BrandsModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/1.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXNModel.h"

@interface BrandsModel : ZXNModel



/// 品牌id
@property (nonatomic, copy) NSString *brand_id;

/// 品牌名称
@property (nonatomic, copy) NSString *brand_name;

/// logo
@property (nonatomic, copy) NSString *logo;

/// 描述
@property (nonatomic, copy) NSString *sDescription;

/// 品牌链接
@property (nonatomic, copy) NSString *url;

/// 排序
@property (nonatomic, copy) NSString *ordering;

/// 是否可用
@property (nonatomic, copy) NSString *is_enable;

/// 是否删除
@property (nonatomic, copy) NSString *is_detele;

/// 是否选中了该品牌
@property (nonatomic, assign) BOOL bSelect;

@end
