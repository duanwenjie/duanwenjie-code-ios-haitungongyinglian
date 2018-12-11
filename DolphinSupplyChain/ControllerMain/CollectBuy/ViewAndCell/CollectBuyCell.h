//
//  CollectBuyCell.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/1.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectBuyCell : UITableViewCell


/**
 渲染数据

 @param sImageURL 图片URL
 @param sName 商品名称
 @param sMoneyOne 商品价格1
 @param sMoneyTwo 商品价格2
 @param bLoseEfficacy YES为失效 NO为正常
 */
- (void)loadView:(NSString *)sImageURL
         BuyName:(NSString *)sName
        MoneyOne:(NSString *)sMoneyOne
        MoneyTwo:(NSString *)sMoneyTwo
  isLoseEfficacy:(BOOL)bLoseEfficacy;


@end
