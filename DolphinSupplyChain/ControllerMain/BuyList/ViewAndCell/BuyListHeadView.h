//
//  BuyListHeadView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/30.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BuyListHeadDelegate <NSObject>


/**
 点击了子分类
 */
- (void)tapClassify;

/**
 点击了人气
 */
- (void)tapPopularity;

/**
 点击了销量
 */
- (void)tapSales;

/**
 点击了价格

 @param sHighOrLow 价格高低（默认第一次点击是低）
 */
- (void)tapPriceHightOrLow:(NSString *)sHighOrLow;

/**
 点击了筛选
 */
- (void)tapScreen;


/**
 点击了删除查看有货
 */
- (void)tapDeleteOnlyGoods;


/**
 点击了删除品牌
 */
- (void)tapDeleteBrand;


/**
 点击了清空
 */
- (void)tapDeleteAll;

@end

@interface BuyListHeadView : UIView

@property (nonatomic, weak) id<BuyListHeadDelegate> delegate;

- (void)loadView:(NSString *)sLblClassifyName;

- (void)addOnlyGoods;

- (void)addBrand:(NSString *)sText;

- (BOOL)deleteOnlyHaveGoods;

- (BOOL)deleteBrandButton;

@end
