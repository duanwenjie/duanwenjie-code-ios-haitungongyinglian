//
//  C_TabBarController.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/1.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface C_TabBarController : UITabBarController

/**
 *  (主动)界面转化
 */
@property (nonatomic, assign) NSInteger         iPage;

- (instancetype)initWithLogin:(BOOL)isLogin;

/**
 *  添加Item红点
 *
 *  @param iControllerType 对应的 ViewController 下标
 *  @param iNumber         想要显示的数字
 */
- (void)addRedDot:(NSInteger)iControllerType dotNumber:(NSInteger)iNumber;

/**
 *  删除对应Item的红点
 *
 *  @param iControllerType 对应的 ViewController 下标
 */
- (void)removeRedDot:(NSInteger)iControllerType;

/**
 *  删除所有的Item红点
 */
- (void)removeAllRedDot;

@end
