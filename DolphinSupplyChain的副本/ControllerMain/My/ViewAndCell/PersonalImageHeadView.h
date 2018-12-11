//
//  PersonalImageHeadView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/29.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalImageHeadView : UIView

typedef void (^PersonalImageBlock)();

/**
 该类初始化方法

 @param bLogin 是否已经登录
 @param block Block回调
 @return 返回本身
 */
- (id)initWithTapSelfViewIsLogin:(BOOL)bLogin TapBlock:(PersonalImageBlock)block;



/**
 实时控制是否显示登录按钮

 @param bShow 是否登录
 */
- (void)isShowLogin:(BOOL)bShow;

@end
