//
//  SearchScreenHeadView.h
//  DolphinSupplyChain
//
//  Created by zhengxuening on 2017/2/13.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchScreenHeadDelegate <NSObject>


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
- (void)tapScreen:(BOOL)bHaveOnlyGoods;

@end


@interface SearchScreenHeadView : UIView

@property (nonatomic, weak) id<SearchScreenHeadDelegate> delegate;


@end
