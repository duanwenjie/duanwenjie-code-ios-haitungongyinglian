//
//  ShowCommodityQuality_VC.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/5.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "HTBase_VC.h"
#import "CommodityDetailsModel.h"

typedef void (^SeleteQualityBlock)(CommodityDetailsModel *model, NSInteger number, BOOL isAddCart);

@interface ShowCommodityQuality_VC : HTBase_VC

- (instancetype)initWithData:(NSMutableArray *)arrData TrueQuality:(NSString *)sSKU block:(SeleteQualityBlock)block;

@end
