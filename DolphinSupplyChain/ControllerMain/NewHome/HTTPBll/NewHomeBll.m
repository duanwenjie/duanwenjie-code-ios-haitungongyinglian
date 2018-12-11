//
//  NewHomeBll.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/26.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "NewHomeBll.h"
#import "CarouselModel.h"
#import "FavorableModel.h"
#import "NewProductRecommendModel.h"
#import "BargainPriceModel.h"
#import "HotBrandModel.h"
#import "HotCommodityModel.h"
#import "HomeClassifyModel.h"

@implementation NewHomeBll

+ (NewHomeModel *)NewHomeJson:(id)json
{
    if (json == nil) {
        return nil;
    }
    
    NewHomeModel *model = [[NewHomeModel alloc] init];
        
    // 解析轮播图
    NSMutableArray *arrCarouse = [NSMutableArray array];
    [json[@"pictureAdLists"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CarouselModel *carouselM = [[CarouselModel alloc] init];
        [carouselM setValuesForKeysWithDictionary:obj];
        
        [arrCarouse addObject:carouselM];
    }];
    model.arrPictureAdLists = arrCarouse;
    
    
    // 解析促销
    NSMutableArray *arrFavorable = [NSMutableArray array];
    [json[@"promotion"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FavorableModel *favorableM = [[FavorableModel alloc] init];
        [favorableM setValuesForKeysWithDictionary:obj];
        
        [arrFavorable addObject:favorableM];
    }];
    model.arrPromotion = arrFavorable;
    
    // 解析新品推荐
    NSMutableArray *arrNewGoods = [NSMutableArray array];
    [json[@"new_goods"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NewProductRecommendModel *newProductM = [[NewProductRecommendModel alloc] init];
        [newProductM setValuesForKeysWithDictionary:obj];
        
        [arrNewGoods addObject:newProductM];
    }];
    model.arrNewGoods = arrNewGoods;
    
    // 解析特价
    NSMutableArray *arrBargainPrice = [NSMutableArray array];
    [json[@"defective_goods"][@"defective_list"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BargainPriceModel *bargainPriceM = [[BargainPriceModel alloc] init];
        [bargainPriceM setValuesForKeysWithDictionary:obj];
        [arrBargainPrice addObject:bargainPriceM];
    }];
    
    // 添加特价分类ID
    BargainPriceModel *bargainPriceModel = [[BargainPriceModel alloc] init];
    bargainPriceModel.category_id = json[@"defective_goods"][@"category_id"];
    [arrBargainPrice addObject:bargainPriceModel];
    model.arrDefective_list = arrBargainPrice;
    
    
    
    // 解析品牌
    NSMutableArray *arrBrands = [NSMutableArray array];
    [json[@"brands"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HotBrandModel *hotBrandM = [[HotBrandModel alloc] init];
        [hotBrandM setValuesForKeysWithDictionary:obj];
        
        [arrBrands addObject:hotBrandM];
    }];
    model.arrBrands = arrBrands;
    
    // 解析热销产品
    NSMutableArray *arrHotGoods = [NSMutableArray array];
    [json[@"hot_goods"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HotCommodityModel *commodityM = [[HotCommodityModel alloc] init];
        [commodityM setValuesForKeysWithDictionary:obj];
        
        [arrHotGoods addObject:commodityM];
    }];
    model.arrHotGoods = arrHotGoods;
    
    // 解析分类
    NSMutableArray *array = [NSMutableArray arrayWithArray:json[@"topLevelCategories"]];
    [array insertObject:@{@"category_id":@"0", @"category_name":@"推荐"} atIndex:0];
    model.arrTopLevelCategories = array;
    
    return model;
}


+ (NSMutableArray *)NewHomeHotGoodsJson:(id)json
{
    if (json == nil) {
        return nil;
    }
    
    // 解析热销产品
    NSMutableArray *arrHotGoods = [NSMutableArray array];
    [json[@"hot_goods"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HotCommodityModel *commodityM = [[HotCommodityModel alloc] init];
        [commodityM setValuesForKeysWithDictionary:obj];
        
        [arrHotGoods addObject:commodityM];
    }];

    return arrHotGoods;
}


+ (NewHomeModel *)NewHomeCategory:(id)json
{
    if (json == nil) {
        return nil;
    }
    
    NewHomeModel *model = [[NewHomeModel alloc] init];
    
    // 解析轮播图
    NSMutableArray *arrCarouse = [NSMutableArray array];
    [json[@"pictureAdLists"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CarouselModel *carouselM = [[CarouselModel alloc] init];
        [carouselM setValuesForKeysWithDictionary:obj];
        
        [arrCarouse addObject:carouselM];
    }];
    model.arrPictureAdLists = arrCarouse;
    
    if (json[@"subCategories"] == nil || ((NSArray *)json[@"subCategories"]).count == 0) {
        model.arrCategory = nil;
    }
    else
    {
        NSMutableArray *arrCategories = [NSMutableArray array];
        [json[@"subCategories"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HomeClassifyModel *hotBrandM = [[HomeClassifyModel alloc] init];
            [hotBrandM setValuesForKeysWithDictionary:obj];
            [arrCategories addObject:hotBrandM];
        }];
        model.arrCategory = arrCategories;
    }
    
    // 解析品牌
    NSMutableArray *arrBrands = [NSMutableArray array];
    [json[@"brands"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HotBrandModel *hotBrandM = [[HotBrandModel alloc] init];
        [hotBrandM setValuesForKeysWithDictionary:obj];
        
        [arrBrands addObject:hotBrandM];
    }];
    model.arrBrands = arrBrands;
    
    
    // 解析热销产品
    NSMutableArray *arrHotGoods = [NSMutableArray array];
    [json[@"hot_goods"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HotCommodityModel *commodityM = [[HotCommodityModel alloc] init];
        [commodityM setValuesForKeysWithDictionary:obj];
        
        [arrHotGoods addObject:commodityM];
    }];
    model.arrHotGoods = arrHotGoods;
    
    return model;
}

@end
