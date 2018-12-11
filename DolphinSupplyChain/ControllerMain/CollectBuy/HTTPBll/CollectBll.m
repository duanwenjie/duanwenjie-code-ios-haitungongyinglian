//
//  CollectBll.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/3.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "CollectBll.h"

@implementation CollectBll

+ (NSMutableArray *)gainCollectList:(id)json
{
    NSMutableArray *array = [NSMutableArray array];
    if (json == nil) {
        return array;
    }
    [json[@"list"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CollectModel *model = [[CollectModel alloc] init];
        [model setValuesForKeysWithDictionary:obj];
        
        [array addObject:model];
    }];
    return array;
}

@end
