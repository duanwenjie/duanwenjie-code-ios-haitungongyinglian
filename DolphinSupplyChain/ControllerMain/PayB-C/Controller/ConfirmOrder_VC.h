//
//  ConfirmOrder_VC.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "HTBase_VC.h"

@interface ConfirmOrder_VC : HTBase_VC


/**
 默认初始化构造器

 @param array 购物车选中的商品数组的ID集合 必须有GoodID 跟 GoodQuantity
              比如下面的例子：数组里面是字典，字典包含上面两个Key 一个商品ID 一个商品数量
 
                 @[@{@"goods_id":@"1", @"quantity":@"2"},
                   @{@"goods_id":@"2", @"quantity":@"3"}]
 
 @param arrayTwo 购物车选中的商品数组的ID集合 必须有GoodSKU 跟 GoodQuantity
            比如下面的例子：数组里面是字典，字典包含上面两个Key 一个商品sku 一个商品数量
 
                @[@{@"sku":@"DEAP001", @"quantity":@"2"},
                  @{@"sku":@"DEAP001", @"quantity":@"3"}]
 
 @param buyType 是C端购买 还是 B端采购
 
 @param orderType 是境外商品 还是 国内商品
 
 @return 本身
 */
- (instancetype)initWithCartData:(NSArray *)array
                     twoCartData:(NSArray *)arrayTwo
                         BuyType:(BuyType)buyType
                       OrderType:(OrderType)orderType;

@end
