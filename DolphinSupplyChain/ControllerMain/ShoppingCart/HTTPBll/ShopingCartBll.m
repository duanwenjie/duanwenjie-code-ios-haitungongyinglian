//
//  ShopingCartBll.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/9.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ShopingCartBll.h"
#import "CartZXNModel.h"

@implementation ShopingCartBll

+ (NSMutableDictionary *)gainShoppingCartList:(id)json
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (json == nil) {
        return dic;
    }
    
    NSMutableArray *arrHaiWai = [NSMutableArray array];
    NSMutableArray *arrGuoNei = [NSMutableArray array];
    
    [json[@"list"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CartZXNModel *model = [[CartZXNModel alloc] init];
        [model setValuesForKeysWithDictionary:obj];
        
        model.isSelectBuy = YES;
        model.isSelectEdit = NO;
        model.goods_number_edit = obj[@"goods_number"];
        
        if ([model.is_trade_sku isEqualToString:@"1"]) // 一般贸易商品
        {
            [arrGuoNei addObject:model];
        }
        else
        {
            [arrHaiWai addObject:model];
        }
        
//        [array addObject:model];
    }];
    
    if (arrHaiWai.count != 0) {
        [dic setValue:arrHaiWai forKey:@"HaiWai"];
    }
    if (arrGuoNei.count != 0) {
        [dic setValue:arrGuoNei forKey:@"GuoNei"];
    }
    
    return dic;
}

@end
