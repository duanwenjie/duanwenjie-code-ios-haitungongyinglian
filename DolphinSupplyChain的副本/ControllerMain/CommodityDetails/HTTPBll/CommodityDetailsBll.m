//
//  CommodityDetailsBll.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/8.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "CommodityDetailsBll.h"
#import "CommodityDetailsModel.h"
#import "CommodityImageModel.h"
#import "CommodityRecommendModel.h"

@implementation CommodityDetailsBll

+ (NSMutableDictionary *)gainCommodityDetails:(id)json
{
    if (json == nil) {
        return nil;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    //******** 解析默认商品详情 ********//
    CommodityDetailsModel *dflDetailsModel = [[CommodityDetailsModel alloc] init];
    [dflDetailsModel setValuesForKeysWithDictionary:json];
    
    // 解析图片数组
    NSMutableArray *arrDFLImage = [NSMutableArray array];
    [json[@"gallery"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CommodityImageModel *mImage = [[CommodityImageModel alloc] init];
        mImage.sImageBig = obj[@"img_original"];
        mImage.sImageSmall = obj[@"thumb_url"];
        [arrDFLImage addObject:mImage];
    }];
    
    dflDetailsModel.arrImage = arrDFLImage;
    
    // 解析商品属性
    dflDetailsModel.arrAttribute = json[@"standard"];
    
    //******** 解析推荐商品 ********//
    NSMutableArray *arrCommodityRecommend = [NSMutableArray array];
    [json[@"brand_sku"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CommodityRecommendModel *mCommodityRecommend = [[CommodityRecommendModel alloc] init];
        [mCommodityRecommend setValuesForKeysWithDictionary:obj];
        [arrCommodityRecommend addObject:mCommodityRecommend];
    }];
    
    //******** 解析商品图文Web Html ********//
    NSString *sHtml = json[@"description_html"];
    
    
    //******** 解析商品详情数组 ********//
    NSMutableArray *arrExtension = [NSMutableArray array];
    
    for (NSDictionary *obj in json[@"extension"]) {
        
        if ([obj isKindOfClass:[NSArray class]]) {
            break;
        }
        CommodityDetailsModel *DetailsModel = [[CommodityDetailsModel alloc] init];
        [DetailsModel setValuesForKeysWithDictionary:obj];
        
        // 解析图片数组
        NSMutableArray *arrImage = [NSMutableArray array];
        [obj[@"gallery"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CommodityImageModel *mArrayImage = [[CommodityImageModel alloc] init];
            mArrayImage.sImageBig = obj[@"img_original"];
            mArrayImage.sImageSmall = obj[@"thumb_url"];
            [arrImage addObject:mArrayImage];
        }];
        
        DetailsModel.arrImage = arrImage;
        
        // 解析商品属性
        DetailsModel.arrAttribute = obj[@"standard"];
        
        [arrExtension addObject:DetailsModel];
        
    }
    
    
    //******** 添加数据 ********//
    [dic setValue:dflDetailsModel forKey:@"DFLModel"];
    [dic setValue:arrCommodityRecommend forKey:@"Recommend"];
    [dic setValue:arrExtension forKey:@"Extension"];
    [dic setValue:sHtml forKey:@"HTML"];
    
    return dic;
}

@end
