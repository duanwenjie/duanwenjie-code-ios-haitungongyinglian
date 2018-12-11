//
//  ZhiFuBaoTool.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/5.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ZhiFuBaoTool.h"


@implementation ZhiFuBaoTool

/**
 构造单例方法
 
 @return 实例对象
 */
+ (instancetype)shareInstance
{
    static ZhiFuBaoTool *ZhiFuBao;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ZhiFuBao = [[ZhiFuBaoTool alloc] init];
    });
    return ZhiFuBao;
}


/**
 调用支付宝支付
 
 @param sInfo 传入数据
 */
- (BOOL)startZhiFuBaoPay:(NSString *)sInfo
{
    if (sInfo.length == 0 || sInfo == nil) {
        return NO;
    }
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"DolphinSupplyChain";
    
    [[AlipaySDK defaultService] payOrder:sInfo fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
        // 支付后回调函数
        ZXNLog(@"reslut = %@",resultDic);
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(ZhiFuBaoIsTrue:)]) {
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                [self.delegate ZhiFuBaoIsTrue:YES];
            }
            else
            {
                [self.delegate ZhiFuBaoIsTrue:NO];
            }
        }
    }];
     
    return YES;
}


@end
