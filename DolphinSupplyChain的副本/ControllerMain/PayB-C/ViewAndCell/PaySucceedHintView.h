//
//  PaySucceedHintView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/3.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaySucceedHintView : UIView

- (void)loadViewOrderNumber:(NSString *)sOrderNumber
                    PayType:(NSString *)sPayType
                MoneyNumber:(NSString *)sMoneyNumber
                  PayNumber:(NSString *)sPayNumber;

@end
