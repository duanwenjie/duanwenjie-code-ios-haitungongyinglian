//
//  ConfirmOrderBll.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/6.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ConfirmOrderBll.h"
#import "ConfirmOrderGoodsModel.h"
#import "AddressListModel.h"
#import "OrderHandleModel.h"

@implementation ConfirmOrderBll

+ (NSMutableDictionary *)gainConfirmOrder:(id)json arrIDOrQuantity:(NSArray *)arrInfo
{
    if (json == nil) {
        return nil;
    }
    
    NSMutableDictionary *dicData = [NSMutableDictionary dictionary];
    NSMutableArray *arrData = [NSMutableArray array];
    [json[@"list"] enumerateObjectsUsingBlock:^(NSDictionary *obj1, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ConfirmOrderGoodsModel *model = [[ConfirmOrderGoodsModel alloc] init];
        [model setValuesForKeysWithDictionary:obj1];
        
        [arrInfo enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([model.goods_id isEqualToString:obj[@"goods_id"]]) {
                model.sQuantity = obj[@"quantity"];
                
                
                NSInteger a = [obj1[@"stock"] integerValue];
                NSInteger b = [obj[@"quantity"] integerValue];
                NSInteger c = [obj1[@"security_stock"] integerValue];
                if ((a - b) >= c) {
                    model.bWarning = NO;
                }
                else
                {
                    model.bWarning = YES;
                }
                [arrData addObject:model];
                *stop = YES;
            }

        }];        
    }];
    
    [dicData setValue:arrData forKey:@"List"];
    
    if ([json[@"default_addr"] isKindOfClass:[NSArray class]]) {
        return dicData;
    }
    else
    {
        AddressListModel *model = [[AddressListModel alloc] init];
        [model setValuesForKeysWithDictionary:json[@"default_addr"]];
        
        [dicData setValue:model forKey:@"Address"];
        return dicData;
    }
    
}

+ (NSMutableArray *)gainInventorySeparation:(id)json
{
    if (json == nil) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    [json enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        NSMutableArray *array1 = [NSMutableArray array];
        [dic1 setValue:obj[@"warehouse_id"] forKey:@"warehouse_id"];
        [dic1 setValue:obj[@"warehouse_name"] forKey:@"warehouse_name"];
        
        [obj[@"goods_list"] enumerateObjectsUsingBlock:^(NSDictionary *obj1, NSUInteger idx, BOOL * _Nonnull stop) {
            
            ConfirmOrderGoodsModel *model = [[ConfirmOrderGoodsModel alloc] init];
            [model setValuesForKeysWithDictionary:obj1];
            model.sQuantity = obj1[@"goods_number"];
            [array1 addObject:model];
        }];
        
        [dic1 setValue:array1 forKey:@"List"];
        [array addObject:dic1];
    }];
    return array;
}


+ (NSMutableArray *)gainOrderHandle:(id)json
{
    if (json == nil) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    [json enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        OrderHandleModel *model = [[OrderHandleModel alloc] init];
        model.c_order_id = obj[@"c_order_id"];
        model.c_order_sn = obj[@"c_order_sn"];
        model.order_amount = obj[@"order_amount"];
        model.warehouse_id = obj[@"warehouse_id"];
        model.warehouse_name = obj[@"warehouse_name"];
        model.bIsPay = NO;
        
        NSMutableArray *arrayData = [NSMutableArray array];
        [obj[@"goods_list"] enumerateObjectsUsingBlock:^(NSDictionary *obj1, NSUInteger idx, BOOL * _Nonnull stop) {
            ConfirmOrderGoodsModel *model1 = [[ConfirmOrderGoodsModel alloc] init];
            [model1 setValuesForKeysWithDictionary:obj1];
            [arrayData addObject:model1];
        }];
        
        model.arrList = arrayData;
        
        [array addObject:model];
    }];
    
    return array;
}


+ (PayModel *)gainConfirmOrder:(id)json
{
    if (json == nil) {
        return nil;
    }
    
    PayModel *model = [[PayModel alloc] init];
    [model setValuesForKeysWithDictionary:json];
    
    return model;
}


+ (PurchaseModel *)gainPurchaseOrder:(id)json
{
    if (json == nil) {
        return nil;
    }
    
    PurchaseModel *model = [[PurchaseModel alloc] init];
    [model setValuesForKeysWithDictionary:json];
    
    return model;
}


+ (OrderPayModel *)gainOrderPay:(id)json
{
    if (json == nil) {
        return nil;
    }
    
    OrderPayModel *model = [[OrderPayModel alloc] init];
    [model setValuesForKeysWithDictionary:json];
    
    NSMutableArray *arr = [NSMutableArray array];
    if (model.hasSoon) {
        [json[@"list"] enumerateObjectsUsingBlock:^(NSDictionary *obj1, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [arr addObject:obj1[@"order_sn"]];
        }];
        [arr addObject:@"回首页"];
    }
    model.arrList = arr;
    
    return model;
}

@end
