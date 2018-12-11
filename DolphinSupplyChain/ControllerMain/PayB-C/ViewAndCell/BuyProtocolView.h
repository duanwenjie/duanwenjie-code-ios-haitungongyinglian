//
//  BuyProtocolView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/29.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BuyProtocolDelegate <NSObject>


/**
 购买协议按钮回调

 @param bSelect YES表示同意购买协议  NO表示不同意
 */
- (void)buyProtocolIsSelect:(BOOL)bSelect;

@end

@interface BuyProtocolView : UIView

@property (nonatomic, weak) id<BuyProtocolDelegate> delegate;

@end
