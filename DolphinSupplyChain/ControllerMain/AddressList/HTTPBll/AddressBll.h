//
//  AddressBll.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/4.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBll : NSObject

+ (NSMutableArray *)gainAddressList:(id)json;

+ (NSMutableArray *)gainDistrictList:(id)json;

@end
