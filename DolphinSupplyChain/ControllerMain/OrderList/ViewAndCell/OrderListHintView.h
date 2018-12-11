//
//  PersonalHintView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/5/18.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HT_Pass,       // 验证通过
    HT_Name_NO,    // 姓名不符
    HT_Number_NO,  // 身份证不符
    HT_Report_NO   // 没有勾选申报委托
} OrderListHintENUM;


@protocol OrderListHintDelegate <NSObject>

/**
 点击了取消
 */
- (void)cancel;


/**
 点击了去支付
 */
- (void)selectorGoPay;


/**
 点击了申报委托
 */
- (void)selectorReportDelegate;


@end


@interface OrderListHintView : UIView

@property (nonatomic, weak) id<OrderListHintDelegate> delegate;

- (OrderListHintENUM)isPayerVerificationPassed;

@end
