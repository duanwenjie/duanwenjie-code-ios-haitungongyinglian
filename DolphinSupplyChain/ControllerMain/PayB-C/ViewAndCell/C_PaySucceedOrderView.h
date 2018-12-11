//
//  C_PaySucceedOrderView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/2.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol C_PaySucceedDelegate <NSObject>

- (void)C_PayGoHome;

- (void)C_PayGoToOrderInfo:(NSString *)sOrderNumber;

@end


@interface C_PaySucceedOrderView : UIView

@property (nonatomic, weak) id<C_PaySucceedDelegate> delegate;

/**
 初始化

 @param bDisperseOrder YES为不拆单  NO为拆单
 @param arrOrderNumber 拆单后的子订单数组
 @return 类本身
 */
- (instancetype)initWithNODisperseOrder:(BOOL)bDisperseOrder OrderNumberList:(NSMutableArray *)arrOrderNumber;


/**
 初始化--单查询服务器支付失败的情况调用

 @return 类本身
 */
- (instancetype)initWithServePayQueryFails;

@end
