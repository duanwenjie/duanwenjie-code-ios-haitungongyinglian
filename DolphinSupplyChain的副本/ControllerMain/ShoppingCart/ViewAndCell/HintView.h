//
//  HintView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/27.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HT_HaiWai,  // 海外贸易
    HT_GuoNie,  // 国内贸易
} CartHintENUM;

@protocol HintViewDelegate <NSObject>



/**
 点击了返回购物车
 */
- (void)TapGoShopping;


/**
 点击了结算按钮

 @param type 选择的贸易模式
 */
- (void)TapGoAccount:(CartHintENUM)type;

@end


@interface HintView : UIView

@property (nonatomic, weak) id<HintViewDelegate> delegate;


/**
 改变提示海外 及 国内 数字

 @param iHaiWaiNumber 海外数字
 @param iGuoNieNumber 国内数字
 */
- (void)changeHaiWaiAndGuoNie:(NSInteger)iHaiWaiNumber :(NSInteger)iGuoNieNumber;

@end
