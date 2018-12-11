//
//  AppDelegate.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/28.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


/**
 切换TabBar
 
 @param bRootC 传入YES则切换到个人TabBar NO为切换为经销商
 */
- (void)changeRootView:(BOOL)bRootC;

/**
 切换TabBar 并跳转到指定的根控制器
 
 @param bRootC 入YES则切换到个人TabBar NO为切换为经销商
 @param iNumber 指定根控制器的下标
 */
- (void)changeRootView:(BOOL)bRootC cutSomeController:(NSInteger)iNumber;

- (void)cutSomeController:(NSInteger)iNumber;

@end

