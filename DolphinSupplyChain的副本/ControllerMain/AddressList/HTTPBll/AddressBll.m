//
//  AddressBll.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/4.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "AddressBll.h"
#import "AddressListModel.h"
#import "DistrictModel.h"

@implementation AddressBll



+ (NSMutableArray *)gainAddressList:(id)json
{
    NSMutableArray *array = [NSMutableArray array];
    if (json == nil) {
        return array;
    }
    
    [json[@"list"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AddressListModel *model = [[AddressListModel alloc] init];
        [model setValuesForKeysWithDictionary:obj];
        
        [array addObject:model];
    }];
    return array;
}

+ (NSMutableArray *)gainDistrictList:(id)json
{
    NSMutableArray *array = [NSMutableArray array];
    if (json == nil) {
        return array;
    }
    
    [json enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DistrictModel *model = [[DistrictModel alloc] init];
        [model setValuesForKeysWithDictionary:obj];
        model.bSelect = NO;
        [array addObject:model];
    }];
    return array;
}



@end
