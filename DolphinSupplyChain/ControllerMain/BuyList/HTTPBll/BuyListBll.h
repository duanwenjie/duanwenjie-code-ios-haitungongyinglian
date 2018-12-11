//
//  BuyListBll.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/1.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BuyListModel.h"
#import "BrandsModel.h"
#import "CategoriesModel.h"


@interface BuyListBll : NSObject

+ (NSMutableDictionary *)BuyListJson:(id)json
                             superId:(NSString *)sSuperId
                             isSuper:(BOOL)bSuper
                          loadBrands:(BOOL)bBrands
                      loadCategories:(BOOL)bCategories;

@end
