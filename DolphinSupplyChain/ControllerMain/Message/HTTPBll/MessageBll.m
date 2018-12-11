//
//  MessageBll.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/3.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "MessageBll.h"
#import "MessageModel.h"
#import "MessageFirstModel.h"
#import "MessageFourModel.h"

@implementation MessageBll

+ (NSMutableArray *)MessageJson:(id)json
{
    NSMutableArray *array = [NSMutableArray array];
    if (json == nil) {
        return array;
    }
    [json[@"list"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MessageModel *model = [[MessageModel alloc] init];
        [model setValuesForKeysWithDictionary:obj];
        
        [array addObject:model];
    }];
    return array;
}

+ (NSMutableArray *)MessageFourJson:(id)json
{
    NSMutableArray *array = [NSMutableArray array];
    if (json == nil) {
        return array;
    }
    [json[@"list"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MessageFourModel *model = [[MessageFourModel alloc] init];
        [model setValuesForKeysWithDictionary:obj];
        
        [array addObject:model];
    }];
    return array;
}


+ (NSMutableDictionary *)MessageFirstJson:(id)json
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (json == nil) {
        return dic;
    }

    [json enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj[@"type"] isEqualToString:@"1"]) {
            MessageFirstModel *model = [[MessageFirstModel alloc] init];
            [model setValuesForKeysWithDictionary:obj];
            [dic setValue:model forKey:@"One"];
        }
        
        if ([obj[@"type"] isEqualToString:@"2"]) {
            MessageFirstModel *model = [[MessageFirstModel alloc] init];
            [model setValuesForKeysWithDictionary:obj];
            [dic setValue:model forKey:@"Two"];
        }
        
        if ([obj[@"type"] isEqualToString:@"3"]) {
            MessageFirstModel *model = [[MessageFirstModel alloc] init];
            [model setValuesForKeysWithDictionary:obj];
            [dic setValue:model forKey:@"Three"];
        }
        
        if ([obj[@"type"] isEqualToString:@"4"]) {
            MessageFourModel *model = [[MessageFourModel alloc] init];
            [model setValuesForKeysWithDictionary:obj];
            [dic setValue:model forKey:@"Four"];
        }
    }];
    
    return dic;
}


@end
