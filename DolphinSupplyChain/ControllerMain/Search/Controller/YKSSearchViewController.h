//
//  HTSearchViewController.h
//  Distribution
//
//  Created by 汪超 on 16/1/4.
//  Copyright © 2016年 ___YKSKJ.COM___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKSSearchViewController : UIViewController


typedef void (^YKSSearchBlock)(NSString *sKeyWord, NSString *sType, NSString *sSKU);

/**
 初始化构造器

 @param bHome 是否是首页进入的搜索-YES 不是首页进入为-NO
 @param block Block 回调
 @return 本身
 */
- (instancetype)initWithIsHome:(BOOL)bHome Block:(YKSSearchBlock)block;

@end
