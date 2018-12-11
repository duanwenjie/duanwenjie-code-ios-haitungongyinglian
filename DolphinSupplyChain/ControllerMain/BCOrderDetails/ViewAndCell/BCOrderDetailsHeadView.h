//
//  BCOrderDetailsHeadView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/15.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCOrderDetailsHeadView : UIView


/**
 初始化构造器

 @param bB_COrder 如果是查看C模式订单传入YES 如果查看B模式订单传入NO
 @return 返回本身
 */
- (instancetype)initWithBOrderOrCOrder:(BOOL)bB_COrder;


- (void)loadViewStateTitle:(NSString *)sState
                      Name:(NSString *)sName
                  identity:(NSString *)sIdentity
                   address:(NSString *)sAddress;

@end
