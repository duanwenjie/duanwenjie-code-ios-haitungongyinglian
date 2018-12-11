//
//  ImageAndTextView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/4.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageAndTextDelegate <NSObject>

/**
 改变ImageAndTextScrollView的X坐标

 @param bImage YES调整到图文详情 NO调整到产品属性
 */
- (void)changeImageAndTextScrollView:(BOOL)bImage;

@end

@interface ImageAndTextView : UIView

@property (nonatomic, weak) id<ImageAndTextDelegate> delegate;

/**
 决定高亮图文详情 或 产品属性

 @param bImage YES高亮图文详情 NO高亮产品属性
 */
- (void)changeImageAndTextShow:(BOOL)bImage;

@end
