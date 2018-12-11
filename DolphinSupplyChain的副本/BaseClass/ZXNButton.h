//
//  ZXNButton.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/1/13.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXNButton : UIButton



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
