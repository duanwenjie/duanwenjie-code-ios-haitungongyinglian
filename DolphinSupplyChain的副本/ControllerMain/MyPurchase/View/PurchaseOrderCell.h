//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseOrderModel.h"
#import "PurchaseGoodsView.h"

@interface PurchaseOrderCell : UITableViewCell

@property (nonatomic ,strong)UILabel *num_lab;
@property (nonatomic ,strong)UILabel *time_lab;
@property (nonatomic ,strong)UIButton *cancelBtn;
@property (nonatomic ,strong)UIButton *purchaseBtn;
@property (nonatomic ,strong)UIButton *rePurchaseBtn;

@property (nonatomic ,strong)PurchaseGoodsView *purchaseGoodsView;

-(void)cellDisplayWithModel:(PurchaseOrderModel *)model;

@end
