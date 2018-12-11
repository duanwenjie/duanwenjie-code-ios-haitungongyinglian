//
//  HTBase_VC.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/12.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)


/**
 16进制创建颜色

 @param sHex 16进制颜色
 @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)sHex;



/**
 16进制创建颜色（有透明度）

 @param sHex 16进制颜色
 @param fAlpha 颜色透明度 1-0
 @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)sHex
                          Alpha:(CGFloat)fAlpha;


/**
 产生随机颜色

 @return 颜色
 */
+ (UIColor *)randomColor;











@end












