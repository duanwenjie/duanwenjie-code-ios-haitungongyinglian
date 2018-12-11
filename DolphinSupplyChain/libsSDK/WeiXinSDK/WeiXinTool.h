//
//  WeiXinTool.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/4.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@protocol WeiXinZhiFuDelegate <NSObject>


/**
 判断微信是否支付成功

 @param bType 成功返回YES 失败返回NO
 */
- (void)isZhiFuTureOrFalse:(BOOL)bType;

@end

@interface WeiXinTool : NSObject <WXApiDelegate>

@property (nonatomic, weak) id<WeiXinZhiFuDelegate> delegate;

/**
 构造单例方法
 
 @return 实例对象
 */
+ (instancetype)shareInstance;

/**
 调用微信支付
 
 @param dicPay 传入数据
 */
- (void)startWeiXinPay:(NSDictionary *)dicPay;


/**
 判断手机用户是否安装了WXAPP
 
 @return YES则是安装了 反正NO就是没安装
 */
- (BOOL)isWXAppMake;


@end
