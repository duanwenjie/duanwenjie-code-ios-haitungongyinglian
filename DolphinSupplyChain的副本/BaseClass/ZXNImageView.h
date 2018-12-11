//
//  ZXNImageView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/30.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

// 背景图片类型
typedef NS_ENUM(NSInteger, ZXNBackgroundImage) {
    ZXNImageDefaul      = 0,     // 默认背景图片
    ZXNImageClassify    = 1      // 分类背景图片
};

@interface ZXNImageView : UIImageView


/// 下载图片（不设置背景图）
- (void)downloadImageAndNoBackImage:(NSString *)sUrl;


/**
 *  下载图片（有背景图）
 *
 *  @param sUrl  图片URL
 *  @param iType 背景图片类型
 */
- (void)downloadImage:(NSString *)sUrl backgroundImage:(ZXNBackgroundImage)iType;


@end
