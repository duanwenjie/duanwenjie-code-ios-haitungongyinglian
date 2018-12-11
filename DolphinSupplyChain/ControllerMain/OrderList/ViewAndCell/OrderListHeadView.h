//
//  OrderListHeadView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/5.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol OrderListHeadDelegate <NSObject>

- (void)ComeInOederInfoVC:(NSInteger)iIndex;

@end


@interface OrderListHeadView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<OrderListHeadDelegate> delegate;

- (void)loadViewOrderNumber:(NSString *)sOrderNumber
                       Time:(NSString *)sTime
                      Order:(NSString *)sOrder
                      Index:(NSInteger )iIndex;


@end
