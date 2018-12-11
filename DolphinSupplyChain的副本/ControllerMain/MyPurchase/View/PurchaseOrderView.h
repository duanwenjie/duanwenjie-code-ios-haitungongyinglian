//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseOrderModel.h"
#import "HTTabbleView.h"
@protocol PurchaseOrderViewDelegate <NSObject>

-(void)payActionWithOrder:(PurchaseOrderModel *)order;
- (void)rePayActionWithOrder:(PurchaseOrderModel *)order;
-(void)cancelActionWithOrder:(PurchaseOrderModel *)order;

@end


@interface PurchaseOrderView : HTTabbleView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,assign)id<PurchaseOrderViewDelegate>purDelegate;

@property (nonatomic ,strong)NSMutableArray *purchaseOrderList;

@end
