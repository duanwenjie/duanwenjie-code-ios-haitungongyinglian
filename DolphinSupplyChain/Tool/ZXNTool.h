//
//  ZXNTool.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/30.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXNTool : NSObject

/**
 添加¥符号 并修改¥的字体大小

 @param sMoney 金额数量
 @param fFont ¥字体大小
 @return 可变的字符串
 */
+ (NSMutableAttributedString *)addMoneySignal:(NSString *)sMoney font:(CGFloat)fFont;



/**
 获取文字的Size（长度宽度）

 @param textFont 文字的Font
 @param sText 该文字
 @return Size
 */
+ (CGSize)gainTextSize:(UIFont *)textFont text:(NSString *)sText;



/**
 获取文字的Size（长度宽度）--指定宽度下获取高度及宽度

 @param textFont 文字的Font
 @param sText 该文字
 @param fWidth 文字的宽度
 @return Size
 */
+ (CGSize)gainTextSize:(UIFont *)textFont text:(NSString *)sText Width:(CGFloat)fWidth;


/**
 实例化一个有颜色的UIImage

 @param color 该UIImage的颜色
 @param size 该UIImage的大小
 @return UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


/**
 *  压缩图片
 *
 *  @param image       需要压缩的图片
 *  @param fImageBytes 希望压缩后的大小(以KB为单位)
 *
 *  @return 压缩后的图片
 */
+ (UIImage *)compressedImageFiles:(UIImage *)image
                       imageBytes:(CGFloat)fImageBytes;



/**
 将对象转换为JSON字符串

 @param Value 字典、数组等对象
 @return JSON字符串
 */
+ (NSString *)getJSONString:(id)Value;

@end
