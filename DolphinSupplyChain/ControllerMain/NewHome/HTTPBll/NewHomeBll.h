//
//  NewHomeBll.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/26.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewHomeModel.h"

@interface NewHomeBll : NSObject

+ (NewHomeModel *)NewHomeJson:(id)json;


+ (NSMutableArray *)NewHomeHotGoodsJson:(id)json;

+ (NewHomeModel *)NewHomeCategory:(id)json;

@end
