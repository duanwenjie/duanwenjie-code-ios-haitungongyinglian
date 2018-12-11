//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "HTTabbleView.h"
@protocol OrderTableViewDelegate <NSObject>

-(void)orderListPayActionWithModel:(OrderModel *)order; //去采购

-(void)orderListDeliverActionWithModel:(OrderModel *)order; //通知发货

-(void)orderlistLogisticActionWithModel:(OrderModel *)order; //查看物流

-(void)orderlistSureActionWithModel:(OrderModel *)order; //确认收货

-(void)orderListCancelActionWithModel:(OrderModel *)order; //取消订单



@end

@interface OrderTableView : HTTabbleView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign)id<OrderTableViewDelegate>orderDelegate;

@property (nonatomic ,strong)NSArray *orderList;
@property (nonatomic ,strong)NSNumber *status;

@end
