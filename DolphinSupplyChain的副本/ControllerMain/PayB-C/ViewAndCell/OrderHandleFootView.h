//
//  OrderHandleFootView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/5/16.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderHandleFootDelegate <NSObject>

- (void)tapGoOrderList;

- (void)tapGoShopingCart;

@end

@interface OrderHandleFootView : UIView

@property (nonatomic, weak) id<OrderHandleFootDelegate> delegate;

@end
