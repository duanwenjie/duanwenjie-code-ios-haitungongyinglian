//
//  DefaultAddressFootView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Go_B_Pay,
    Go_C_Pay,
} PayType;

typedef void(^OrderRiskTipsBlock)();

@interface DefaultAddressFootView : UIView

@property (nonatomic, strong) UIButton *btnCheck;

@property (nonatomic, strong) OrderRiskTipsBlock TipsBlock;

typedef void (^DefaultAddressFootBlock)(PayType type);

- (instancetype)initWithBuyTpye:(BuyType)buyType
                      OrderType:(OrderType)orderType
                goUserOrDealers:(DefaultAddressFootBlock)block;

- (void)loadViewAllMoney:(NSString *)sAllMoney;



@end
