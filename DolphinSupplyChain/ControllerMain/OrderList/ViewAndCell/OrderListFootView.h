//
//  OrderListFootView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/5.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderListFootDelegate <NSObject>


/**
 删除订单

 @param index 对应的下标
 */
- (void)DeleteOrder:(NSInteger)index;


/**
 进行付款

 @param index 对应的下标
 */
- (void)PayOrder:(NSInteger)index;


/**
 确认收货

 @param index 对应的下标
 */
- (void)ReceiptOrder:(NSInteger)index;


/**
 取消订单

 @param index 对应的下标
 */
- (void)CancelOrder:(NSInteger)index;


/**
 查看物流

 @param index 对应的下标
 */
- (void)CheckLogisticsOrder:(NSInteger)index;

@end


@interface OrderListFootView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<OrderListFootDelegate> delegate;


- (void)loadViewAddress:(NSString *)sAddress
                 Status:(NSString *)sStatus
                  Money:(NSString *)sMoney
                   Type:(NSString *)sType
                  Index:(NSInteger )index;

@end
