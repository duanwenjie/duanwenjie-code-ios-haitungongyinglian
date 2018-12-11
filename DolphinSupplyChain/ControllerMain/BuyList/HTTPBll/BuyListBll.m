//
//  BuyListBll.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/1.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "BuyListBll.h"
#import "BuyListModel.h"
#import "BrandsModel.h"
#import "CategoriesModel.h"

@implementation BuyListBll

+ (NSMutableDictionary *)BuyListJson:(id)json
                             superId:(NSString *)sSuperId
                             isSuper:(BOOL)bSuper
                          loadBrands:(BOOL)bBrands
                      loadCategories:(BOOL)bCategories
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (json == nil) {
        return dic;
    }
    
    NSMutableArray *arrBrands = nil;
    
    if (bBrands) {
        arrBrands = [NSMutableArray array];
        
        for (NSDictionary *obj in json[@"brands"]) {
            BrandsModel *mdBrands = [[BrandsModel alloc] init];
            [mdBrands setValuesForKeysWithDictionary:obj];
            mdBrands.bSelect = NO;
            
            [arrBrands addObject:mdBrands];
        }
        
        [dic setObject:arrBrands forKey:@"brands"];
    }
    
    
    NSMutableArray *arrCategories = nil;
    
    if (bCategories) {
        arrCategories = [NSMutableArray array];
        
        CategoriesModel *mdCategories = [[CategoriesModel alloc] init];
        mdCategories.category_name = @"全部";
        mdCategories.category_id = sSuperId;
        
        if (bSuper) {
            mdCategories.bSelect = YES;
        }
        else
        {
            mdCategories.bSelect = NO;
        }
        
        [arrCategories addObject:mdCategories];
        
        for (NSDictionary *obj in json[@"categories"])
        {
            CategoriesModel *mdCategories = [[CategoriesModel alloc] init];
            [mdCategories setValuesForKeysWithDictionary:obj];
            
            if (!bSuper) {
                if ([mdCategories.category_id isEqualToString:sSuperId]) {
                    mdCategories.bSelect = YES;
                }
                else
                {
                    mdCategories.bSelect = NO;
                }
            }
            else
            {
                mdCategories.bSelect = NO;
            }
            
            [arrCategories addObject:mdCategories];
        }
        
        [dic setObject:arrCategories forKey:@"categories"];
    }
    
    
    NSMutableArray *arrBuyList = [NSMutableArray array];;
    
    [json[@"list"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BuyListModel *mdBuyList = [[BuyListModel alloc] init];
        [mdBuyList setValuesForKeysWithDictionary:obj];
        
        [arrBuyList addObject:mdBuyList];
    }];
    
    [dic setObject:arrBuyList forKey:@"list"];
    
    return dic;
}

@end
