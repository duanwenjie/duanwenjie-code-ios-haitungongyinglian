//
//  WeiXinTool.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/4.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "WeiXinTool.h"

@implementation WeiXinTool

/**
 构造单例方法
 
 @return 实例对象
 */
+ (instancetype)shareInstance
{
    static WeiXinTool *WeiXin;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        WeiXin = [[WeiXinTool alloc] init];
    });
    return WeiXin;
}


/**
 调用微信支付

 @param dicPay 传入数据
 */
- (void)startWeiXinPay:(NSDictionary *)dicPay
{
    PayReq *payReq = [[PayReq alloc] init];
    payReq.partnerId  = dicPay[@"partnerid"]; //
    payReq.prepayId   = dicPay[@"prepayid"]; //
    payReq.nonceStr   = dicPay[@"noncestr"]; //
    payReq.timeStamp  = (UInt32)[dicPay[@"timestamp"] integerValue]; //
    payReq.package    = dicPay[@"package"];  //
    payReq.sign       = dicPay[@"sign"];  //
    ZXNLog(@"%@",payReq.nonceStr);
    [WXApi sendReq:payReq];
}


- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]]) {
        switch (resp.errCode) {
            case 0:
            {
                // 支付成功
                if (self.delegate && [self.delegate respondsToSelector:@selector(isZhiFuTureOrFalse:)]) {
                    [self.delegate isZhiFuTureOrFalse:YES];
                }
            }
                break;
            default:
                
                // 支付成功
                if (self.delegate && [self.delegate respondsToSelector:@selector(isZhiFuTureOrFalse:)]) {
                    [self.delegate isZhiFuTureOrFalse:NO];
                }
                break;
        }
    }
    
    // 判断是否是媒体消息
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        return;
    }
    
    // 判断是否是微信登录
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        return;
    }
}


/**
 判断手机用户是否安装了WXAPP

 @return YES则是安装了 反正NO就是没安装
 */
- (BOOL)isWXAppMake
{
    if ([WXApi isWXAppInstalled]) {
        return YES;
    }
    return NO;
}



@end
