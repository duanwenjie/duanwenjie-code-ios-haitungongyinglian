//
//  PayFailureHintView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayFailureHintView : UIView

- (void)loadViewOrderNumber:(NSString *)sOrderNumber
                MoneyNumber:(NSString *)sMoneyNumber;

@end
