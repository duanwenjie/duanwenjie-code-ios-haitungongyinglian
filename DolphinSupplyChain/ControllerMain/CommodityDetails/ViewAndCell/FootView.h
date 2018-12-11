//
//  FootView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/4.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommodityFootDelegate <NSObject>


/**
 点击了客服
 */
- (void)touchService;


/**
 点击了收藏

 @param isCollect YES收藏 NO为不收藏
 */
- (void)touchCollect:(BOOL)isCollect;


/**
 点击了购物车
 */
- (void)touchShoppingCart;


/**
 点击了加入购物车

 @param isAddCart YES为加入购物车  NO为缺货登记
 */
- (void)touchAddShoppingCart:(BOOL)isAddCart;

@end

@interface FootView : UIView

@property (nonatomic, weak) id<CommodityFootDelegate> delegate;

- (instancetype)initWithFootView;


/**
 单独改变购物车数量数字

 @param sNumber 数量
 */
- (void)changeShoppingCartNumber:(NSString *)sNumber;



/**
 单独改变收藏图片

 @param isCollect YES表示已收藏 NO表示未收藏
 */
- (void)changeCollect:(BOOL)isCollect;



/**
 单独改变加入购物车文字

 @param bHave YES为加入购物车文字 NO为缺货登记文字
 */
- (void)changeAddShoppingCart:(BOOL)bHave;

@end
