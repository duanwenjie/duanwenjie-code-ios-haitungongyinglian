//
//  ShoppingCartCell.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/8.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartZXNModel.h"

@protocol ShoppingCartDelegate <NSObject>


/**
 勾选商品回调

 @param bSeletc YES表示勾选了商品 NO反之
 @param index 对应的Cell坐标
 */
- (void)seletcCommodity:(BOOL)bSeletc Index:(NSIndexPath *)index;


/**
 减少了商品购买数量

 @param index 对应的Cell坐标
 */
- (void)subCommodityNumberIndex:(NSIndexPath *)index;


/**
 增加了商品购买数量

 @param index 对应的Cell坐标
 */
- (void)addCommodityNumberIndex:(NSIndexPath *)index;


/**
 点击了TextField回调

 @param index 对应的Cell坐标
 */
- (void)BeginEditingKeyBoardIndex:(NSIndexPath *)index;


/**
 点击了键盘的完成按钮

 @param index 对应的Cell坐标
 @param sMessage 提示语
 @param bCanEidt 是否能对数量进行编辑 返回YES则是可以 NO反之
 */
- (void)tapKeyBoardAccomplish:(NSIndexPath *)index Number:(NSString *)sNumber Message:(NSString *)sMessage isCanEidt:(BOOL)bCanEidt;


@end

@interface ShoppingCartCell : UITableViewCell

@property (nonatomic, weak) id<ShoppingCartDelegate> delegate;

- (void)loadViewModel:(CartZXNModel *)model Index:(NSIndexPath *)index isEdit:(BOOL)bEdit;


@end
