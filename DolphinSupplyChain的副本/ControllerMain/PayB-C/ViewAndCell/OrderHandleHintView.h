//
//  OrderHandleHintView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/5/17.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HT_WeiXin,    // 微信支付
    HT_ZhiFuBao,  // 支付宝支付
} OrderHandleHintENUM;

@protocol OrderHandleHintViewDelegate <NSObject>

/**
 点击了取消
 */
- (void)cancel;


/**
 点击了去支付
 
 @param type 选择的支付方式
 */
- (void)selectorGoPay:(OrderHandleHintENUM)type;

@end

@interface OrderHandleHintView : UIView

@property (nonatomic, weak) id<OrderHandleHintViewDelegate> delegate;


@end
