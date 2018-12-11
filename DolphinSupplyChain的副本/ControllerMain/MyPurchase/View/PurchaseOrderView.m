//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "PurchaseOrderView.h"
#import "PurchaseOrderCell.h"


@implementation PurchaseOrderView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate=self;
        self.dataSource=self;
        self.showsVerticalScrollIndicator=NO;
        self.separatorInset=UIEdgeInsetsZero;
        self.separatorColor=[UIColor whiteColor];
    }
    return self;
}

#pragma mark --tableView 代理和数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_purchaseOrderList count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"purchaseCell";
    PurchaseOrderCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[PurchaseOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    PurchaseOrderModel *purchase=_purchaseOrderList[indexPath.section];
    [cell cellDisplayWithModel:purchase];
    
    cell.cancelBtn.tag=indexPath.section;
    [cell.cancelBtn addTarget:self action:@selector(cancelOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.purchaseBtn.tag=indexPath.section;
    [cell.purchaseBtn addTarget:self action:@selector(payForOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.rePurchaseBtn.tag = indexPath.section;
    [cell.rePurchaseBtn addTarget:self action:@selector(rePayForOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PurchaseOrderModel *purchase=_purchaseOrderList[indexPath.section];
//    return [purchase.order_goods count]*80+75;
    return [purchase.goods count]*95+78;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(void)cancelOrder:(UIButton *)btn{
    PurchaseOrderModel *purchase=_purchaseOrderList[btn.tag];
    if ([_purDelegate respondsToSelector:@selector(cancelActionWithOrder:)]) {
        [_purDelegate cancelActionWithOrder:purchase];
    }
}

-(void)payForOrder:(UIButton *)btn{
    PurchaseOrderModel *purchase=_purchaseOrderList[btn.tag];
    if ([_purDelegate respondsToSelector:@selector(payActionWithOrder:)]) {
        [_purDelegate payActionWithOrder:purchase];
    }
}

- (void)rePayForOrder:(UIButton *)btn{
    PurchaseOrderModel *purchase=_purchaseOrderList[btn.tag];
    if ([_purDelegate respondsToSelector:@selector(rePayActionWithOrder:)]) {
        [_purDelegate rePayActionWithOrder:purchase];
    }
}

@end
