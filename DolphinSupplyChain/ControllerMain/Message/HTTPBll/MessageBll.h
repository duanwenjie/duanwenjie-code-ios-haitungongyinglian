//
//  MessageBll.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/3.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageBll : NSObject

+ (NSMutableArray *)MessageJson:(id)json;

+ (NSMutableArray *)MessageFourJson:(id)json;

+ (NSMutableDictionary *)MessageFirstJson:(id)json;

@end
