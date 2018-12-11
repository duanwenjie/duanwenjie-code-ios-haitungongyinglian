//
//  OrderListBll.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/5.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "OrderListBll.h"
#import "OrderListModel.h"
#import "OrderListGoodsModel.h"

@implementation OrderListBll

+ (NSMutableArray *)gainOrderList:(id)json
{
    NSMutableArray *array = [NSMutableArray array];
    if (json == nil) {
        return array;
    }
    
    [json[@"list"] enumerateObjectsUsingBlock:^(NSDictionary *obj1, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSMutableArray *arr = [NSMutableArray array];
        
        OrderListModel *model = [[OrderListModel alloc] init];
        [model setValuesForKeysWithDictionary:obj1];
        [dic setValue:model forKey:@"OrderListModel"];
        
        [obj1[@"goods"] enumerateObjectsUsingBlock:^(NSDictionary *obj2, NSUInteger idx, BOOL * _Nonnull stop) {
            
            OrderListGoodsModel *model = [[OrderListGoodsModel alloc] init];
            [model setValuesForKeysWithDictionary:obj2];
            [arr addObject:model];
        }];
        
        [dic setValue:arr forKey:@"OrderListGoodsModel"];
        
        [array addObject:dic];
    }];
    return array;
    
}

@end
