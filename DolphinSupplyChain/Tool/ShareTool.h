//
//  ShareTool.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/8.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UMSocialUIManager.h"


@interface ShareTool : NSObject


/**
 构造单例方法
 
 @return 实例对象
 */
+ (instancetype)shareInstance;



/**
 分享APP
 */
+ (void)shareHaiTunAPP;



/**
 分享商品

 @param sSKU 商品SKU
 @param sTitle 商品名称
 @param image 商品图片
 */
+ (void)shareHaiTunCommodity:(NSString *)sSKU
                       Title:(NSString *)sTitle
                       Image:(UIImage *)image;


@end
