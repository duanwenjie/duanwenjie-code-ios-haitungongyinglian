//
//  OZGModel.m
//  OZGTrade
//
//  Created by farben on 15/9/1.
//  Copyright (c) 2015年 FarBen. All rights reserved.
//

#import "ZXNModel.h"

@implementation ZXNModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
#ifdef DEBUG
    NSLog(@"Model缺少字段 === %@",key);
#endif
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([value isKindOfClass:[NSNull class]]) {
        value = @"";
#ifdef DEBUG
         NSLog(@"Key>>>>%@ 所在 Value 为 Null",key);
#endif
    }
    
    if ([value isKindOfClass:[NSNumber class]]) {
        value = [value stringValue];
    }
    
    if ([key isEqualToString:@"id"]) {
        key = @"KeyId";
    }
    
    if ([key isEqualToString:@"description"]) {
        key = @"sDescription";
    }
    
    [super setValue:value forKey:key];
}

@end
