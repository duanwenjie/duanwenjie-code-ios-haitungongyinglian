//
//  ShoppingCartFoot.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/8.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShoppingCartFootDelegate <NSObject>


/**
 是否选择了全选

 @param bSelectAll YES是选择了全选 NO反之
 */
- (void)tapSelectAll:(BOOL)bSelectAll;


/**
 点击了立即购买
 */
- (void)tapCartSettle;


/**
 点击了立即采购
 */
- (void)tapCartPurchase;


/**
 点击了删除
 */
- (void)tapCartDelete;

@end


@interface ShoppingCartFoot : UIView


@property (nonatomic, weak) id<ShoppingCartFootDelegate> delegate;

/**
 是否选择了全部

 @param bSelectAll YES则是选择了全部 NO反之
 */
- (void)isSelectAll:(BOOL)bSelectAll;


/**
 更新总计金额

 @param sMoney 金额
 */
- (void)updateAllMoney:(NSString *)sMoney;


/**
 是否进入了编辑状态

 @param bDelete YES表示进入了编辑状态 NO反之
 */
- (void)isComeDeletePattern:(BOOL)bDelete;

@end
