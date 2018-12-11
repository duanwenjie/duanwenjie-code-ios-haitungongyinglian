//
//  XNGuideView.h
//
//  Created by LuohanCC on 15/11/30.
//  Copyright © 2015年 罗函. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XNGuideView : UIView

/**
 显示引导页

 @param imageArray 引导页图片
 @param fTop 距离顶部距离
 */
+ (void)showGudieView:(NSArray *)imageArray top:(CGFloat)fTop;

@end
