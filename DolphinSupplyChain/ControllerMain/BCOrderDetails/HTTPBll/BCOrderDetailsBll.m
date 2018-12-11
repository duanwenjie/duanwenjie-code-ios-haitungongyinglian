//
//  BCOrderDetailsBll.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/15.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "BCOrderDetailsBll.h"
#import "BCOrderDetailsBuyModel.h"
#import "BCorderSellDetailBuyModel.h"
#import "LogisticsBuyModel.h"

@implementation BCOrderDetailsBll



+ (BCOrderDetailsModel *)gainOrderDetailList:(id)json
{
    if (json == nil) {
        return nil;
    }
    
    BCOrderDetailsModel *model = [[BCOrderDetailsModel alloc] init];
    [model setValuesForKeysWithDictionary:json];
    
    NSMutableArray *array = [NSMutableArray array];
    
    [json[@"goods"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BCOrderDetailsBuyModel *modelBuy = [[BCOrderDetailsBuyModel alloc] init];
        [modelBuy setValuesForKeysWithDictionary:obj];
        
        [array addObject:modelBuy];
    }];
    
    model.arrGoods = array;
    return model;
}


+ (BCOrderSellDetail *)gainOrderSellDetailList:(id)json
{
    if (json == nil) {
        return nil;
    }
    
    BCOrderSellDetail *model = [[BCOrderSellDetail alloc] init];
    [model setValuesForKeysWithDictionary:json];
    
    NSMutableArray *array = [NSMutableArray array];
    
    [json[@"goods"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BCorderSellDetailBuyModel *modelBuy = [[BCorderSellDetailBuyModel alloc] init];
        [modelBuy setValuesForKeysWithDictionary:obj];
        
        [array addObject:modelBuy];
    }];
    
    model.arrGoods = array;
    return model;
}


+ (NSMutableArray *)gainLogistics:(id)json
{
    if (json == nil) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [json enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableArray *arrErpBuy = [NSMutableArray array];
        [obj[@"erp_order_products"] enumerateObjectsUsingBlock:^(NSDictionary *objErp, NSUInteger idx, BOOL * _Nonnull stop) {
            LogisticsBuyModel *model = [[LogisticsBuyModel alloc] init];
            [model setValuesForKeysWithDictionary:objErp];
            [arrErpBuy addObject:model];
        }];
        
        NSDictionary *dicErp = [((NSArray *)obj[@"trans_events_array"][@"trans_events"]) lastObject];
        
        [dic setValue:dicErp forKey:@"HeadErp"];
        [dic setValue:arrErpBuy forKey:@"Goods"];
        
        [array addObject:dic];
    }];
    
    return array;
}

@end
