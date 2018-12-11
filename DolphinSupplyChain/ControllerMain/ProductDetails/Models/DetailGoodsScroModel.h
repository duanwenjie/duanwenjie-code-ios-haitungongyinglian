//
//  DetailGoodsScroModel.h
//  DolphinSupplyChain
//
//  Created by Steffen.D on 16/12/4.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailGoodsScroModel : NSObject
@property (nonatomic, copy)NSString *price;
@property (nonatomic, copy)NSString *market_price;
@property(nonatomic,copy)NSString *goods_sn;
@property(nonatomic,copy)NSString *img_original;
@property (nonatomic , assign)BOOL has_stock;
@property (nonatomic, copy)NSString *goods_name;
@property (nonatomic, copy)NSString *goods_id;
@end
