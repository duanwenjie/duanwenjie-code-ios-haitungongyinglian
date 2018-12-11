//
//  CollectBll.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/3.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectModel.h"

@interface CollectBll : NSObject

+ (NSMutableArray *)gainCollectList:(id)json;

@end
