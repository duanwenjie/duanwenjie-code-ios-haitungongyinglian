//
//  HTTabbleView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/1/13.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HeaderBlock)();

typedef void(^FooterBlock)();

@interface HTTabbleView : UITableView


/**
 添加下拉刷新

 @param block 触发回调方法
 */
- (void)addHeaderRefresh:(HeaderBlock)block;


/**
 添加上拉加载更多

 @param block 触发回调方法
 */
- (void)addFooterRefresh:(FooterBlock)block;



/**
 开始刷新
 */
- (void)beginRefreshing;


/**
 结束刷新
 */
- (void)endHeaderRefreshing;



/**
 结束加载更多
 */
- (void)endFooterRefreshing;



/**
 加载更多显示没有更多数据-默认是“别拉了，到底了~”
 */
- (void)showNoMoreData;


/**
 加载更多显示没有更多数据

 @param sTitle 自定义结尾文字
 */
- (void)showNoMoreData:(NSString *)sTitle;



@end
