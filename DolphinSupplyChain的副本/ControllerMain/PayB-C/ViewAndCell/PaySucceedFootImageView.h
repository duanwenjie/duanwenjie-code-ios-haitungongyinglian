//
//  PaySucceedFootImageView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/3.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaySucceedFootImageView : UIView


/**
 支付成功回调

 @param sType "Go_Order" 表示回到销售订单  "Go_Home" 表示回到首页
 */
typedef void (^PaySucceedGoBlock)(NSString *sType);

- (instancetype)initWithShipmentsOrHomeNameBlock:(PaySucceedGoBlock)block;


@end
