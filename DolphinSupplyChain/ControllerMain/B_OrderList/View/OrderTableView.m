//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "OrderTableView.h"
#import "OrderTableViewCell.h"
#import "OrderModel.h"
#import "AutoScrollLabel.h"


@interface OrderTableView(){
    UILabel *name_lab;
    AutoScrollLabel *view;
    UISegmentedControl *segment;
}

@end

@implementation OrderTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorColor = [UIColor whiteColor];
        
        self.separatorInset = UIEdgeInsetsMake(0,10, 0, 10);
        
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return self;
}


-(void)setStatus:(NSNumber *)status{
    _status = status;
    NSInteger index = [_status integerValue];
    switch (index) {
        case 0:
        {
            UIImageView * vImageView = [[UIImageView alloc]init];
            vImageView.frame = CGRectMake(10, 7.5, 15, 15);
            vImageView.image = [UIImage imageNamed:@"icon-paoma"];
            
            view = [[AutoScrollLabel alloc]init];
            [view setFrame:CGRectMake(vImageView.right+10, 0.0, kDisWidth-30, 30.0)];
            view.textColor = [UIColor colorWithHexString:@"f74c00"];
            view.font = [UIFont systemFontOfSize:12];
            view.text=@"注：该状态订单中存在库存不足的商品，请及时去采购，以免影响正常发货";
            
            UIView * groupView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDisWidth, 30)];
            groupView.backgroundColor = [UIColor colorWithHexString:@"fefcec"];
            [groupView addSubview:vImageView];
            [groupView addSubview:view];
            self.tableHeaderView = groupView;
            

        }
            break;
        case 1:
        {
            UIImageView * vImageView = [[UIImageView alloc]init];
            vImageView.frame = CGRectMake(10, 7.5, 15, 15);
            vImageView.image = [UIImage imageNamed:@"icon-paoma"];
            
            view = [[AutoScrollLabel alloc]init];
            [view setFrame:CGRectMake(vImageView.right+10, 0.0, kDisWidth-30, 30.0)];
            view.textColor = [UIColor colorWithHexString:@"f74c00"];
            view.font = [UIFont systemFontOfSize:12];
            view.text = @"注：该状态下订单海豚将不予发货，请点击【通知发货】，以免影响正常发货";
            
            UIView * groupView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDisWidth, 30)];
            groupView.backgroundColor = [UIColor colorWithHexString:@"fefcec"];
            [groupView addSubview:vImageView];
            [groupView addSubview:view];
            self.tableHeaderView = groupView;
        }
            break;
        case 2:
        {
            UIView * groupView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDisWidth-20, 0.1)];
            groupView.backgroundColor = [UIColor colorWithHexString:@"fefcec"];
            self.tableHeaderView = groupView;
        }
            break;
        case 3:
        {
            UIView * groupView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDisWidth-20, 0.1)];
            groupView.backgroundColor = [UIColor colorWithHexString:@"fefcec"];
            self.tableHeaderView = groupView;
        }
            break;
        default:
        {
            UIView * groupView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDisWidth-20, 0.1)];
            groupView.backgroundColor = [UIColor colorWithHexString:@"fefcec"];
            self.tableHeaderView = groupView;
        }
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.orderList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderModel *order=[self.orderList objectAtIndex:indexPath.section];
    return 125 + order.goods.count * 95;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    OrderModel *order=[_orderList objectAtIndex:indexPath.section];
    [cell orderTableViewDisplayCellWithModel:order status:_status];
    
    cell.paybtn.tag=indexPath.section;
    [cell.paybtn addTarget:self action:@selector(payOrder:) forControlEvents:UIControlEventTouchUpInside];

    
    cell.deliverbtn.tag=indexPath.section;
    [cell.deliverbtn addTarget:self action:@selector(deliverOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.logisticBtn.tag=indexPath.section;
    [cell.logisticBtn addTarget:self action:@selector(checkLogisticOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.logisticBtn1.tag=indexPath.section;
    [cell.logisticBtn1 addTarget:self action:@selector(checkSureOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.cancelbtn.tag=indexPath.section;
    [cell.cancelbtn addTarget:self action:@selector(cancelOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderModel *order=[_orderList objectAtIndex:indexPath.section];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:order forKey:@"order"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationSelectHeader" object:nil userInfo:dict];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5.0;
}


-(void)payOrder:(UIButton *)sender{
    OrderModel *order = _orderList[sender.tag];
    if ([_orderDelegate respondsToSelector:@selector(orderListPayActionWithModel:)]) {
        [_orderDelegate orderListPayActionWithModel:order];
    }
}

-(void)deliverOrder:(UIButton *)sender{
    OrderModel *order = _orderList[sender.tag];
    if ([_orderDelegate respondsToSelector:@selector(orderListDeliverActionWithModel:)]) {
        [_orderDelegate orderListDeliverActionWithModel:order];
    }
}


-(void)checkLogisticOrder:(UIButton *)sender{
    OrderModel *order = _orderList[sender.tag];
    if ([_orderDelegate respondsToSelector:@selector(orderlistLogisticActionWithModel:)]) {
        [_orderDelegate orderlistLogisticActionWithModel:order];
    }
}

-(void)checkSureOrder:(UIButton *)sender{
    OrderModel *order = _orderList[sender.tag];
    if ([_orderDelegate respondsToSelector:@selector(orderlistSureActionWithModel:)]) {
        [_orderDelegate orderlistSureActionWithModel:order];
    }
}


-(void)cancelOrder:(UIButton *)sender{
    OrderModel *order = _orderList[sender.tag];
    if ([_orderDelegate respondsToSelector:@selector(orderListCancelActionWithModel:)]) {
        [_orderDelegate orderListCancelActionWithModel:order];
    }
}



@end
