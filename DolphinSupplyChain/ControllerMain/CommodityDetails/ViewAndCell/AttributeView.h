//
//  AttributeView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/7.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AttributeDelegate <NSObject>

- (void)selectClose:(NSInteger)iIndex number:(NSInteger)iNumber;

- (void)selectAddCart:(NSInteger)iIndex number:(NSInteger)iNumber;

- (void)selectAttribute:(NSInteger)iIndex number:(NSInteger)iNumber;

- (void)selectPresentStockRegistration;

@end

@interface AttributeView : UIView

@property (nonatomic, weak) id<AttributeDelegate> delegate;

- (void)loadData:(NSMutableArray *)arrData index:(NSInteger)iIndex;

/**
 单独改变加入购物车文字
 
 @param bHave YES为加入购物车文字 NO为缺货登记文字
 */
- (void)changeAddShoppingCart:(BOOL)bHave;

@end
