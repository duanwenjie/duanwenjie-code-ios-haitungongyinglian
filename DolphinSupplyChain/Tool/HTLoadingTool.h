//
//  HTLoadingTool.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/15.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTLoadingTool : NSObject

/**
 构造单例对象
 
 @return 返回本身
 */
+ (instancetype)shareInstance;

#pragma mark - 相对于View层
/**
 View层 显示(透明 可操作)等待
 
 @param view View层视图
 */
+ (void)showLoadingForView:(UIView *)view;


/**
 View层 显示(透明 可操作)等待
 
 @param view View层视图
 @param sHint 自定义等待语
 */
+ (void)showLoadingForView:(UIView *)view Hint:(NSString *)sHint;


/**
 View层 显示(透明 不可操作)等待
 
 @param view View层视图
 */
+ (void)showLoadingDontOperationForView:(UIView *)view;


/**
 View层 显示(透明 不可操作)等待
 
 @param view View层视图
 @param sHint 自定义等待语
 */
+ (void)showLoadingDontOperationForView:(UIView *)view Hint:(NSString *)sHint;


#pragma mark - 相对于Windows层
/**
 Windows层 显示(透明 可操作)等待
 */
+ (void)showLoading;


/**
 Windows层 显示(透明 可操作)等待

 @param sHint 自定义等待文字
 */
+ (void)showLoadingString:(NSString *)sHint;


/**
 Windows层 显示(透明 不可操作)等待
 */
+ (void)showLoadingDontOperation;


/**
 Windows层 显示(透明 不可操作)等待

 @param sHint 自定义等待文字
 */
+ (void)showLoadingStringDontOperation:(NSString *)sHint;



#pragma mark - 消除等待视图
/**
 消除Windows层等待视图
 */
+ (void)disMissForWindow;


/**
 消除View层等待视图
 */
+ (void)disMissForView;




@end
