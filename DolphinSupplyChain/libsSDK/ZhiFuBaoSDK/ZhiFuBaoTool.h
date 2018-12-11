//
//  ZhiFuBaoTool.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/5.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>

@protocol ZhiFuBaoDelegate <NSObject>

- (void)ZhiFuBaoIsTrue:(BOOL)isTrue;

@end

@interface ZhiFuBaoTool : NSObject

/**
 构造单例方法
 
 @return 实例对象
 */
+ (instancetype)shareInstance;

- (BOOL)startZhiFuBaoPay:(NSString *)sInfo;

@property (nonatomic, weak) id<ZhiFuBaoDelegate> delegate;


@end
