//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "SaleGoodsModel.h"

@interface OrderTableViewCell (){
    ProductShowTable *productListView;
    UILabel          *line;
    UILabel          *line2;
    UILabel          *labLogistic;
}
@end

@implementation OrderTableViewCell
@synthesize time_lab;
@synthesize num_lab;
@synthesize accessoryImage;
@synthesize remindlbl;

@synthesize paybtn;
@synthesize deliverbtn;
@synthesize logisticBtn;
@synthesize logisticBtn1;
@synthesize modifyBtn;
@synthesize cancelbtn;
@synthesize cancelNotiBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat margin = 15;
        num_lab=[[UILabel alloc] initWithFrame:CGRectMake(margin, 0, 190, 30)];
        num_lab.font=[UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:num_lab];
        
        time_lab=[[UILabel alloc] initWithFrame:CGRectMake(kDisWidth-135, 0, 110, 30.0)];
        time_lab.font=[UIFont systemFontOfSize:10];
        time_lab.textAlignment=NSTextAlignmentRight;
        time_lab.textColor=[UIColor lightGrayColor];
        [self.contentView addSubview:time_lab];
        
        accessoryImage=[[UIImageView alloc] initWithFrame:CGRectMake(kDisWidth-25,7, 16, 16)];
        accessoryImage.image=[UIImage imageNamed:@"accessory"];
        [self.contentView addSubview:accessoryImage];
        
        line=[[UILabel alloc] initWithFrame:CGRectMake(margin, num_lab.bottom, kDisWidth-25, 0.5)];
        line.backgroundColor = kLineColer;
        line.text=@"";
        [self.contentView addSubview:line];
        
        line2=[[UILabel alloc] initWithFrame:CGRectMake(margin, productListView.bottom+44.5, kDisWidth-25, 0.5)];
        line2.backgroundColor = kLineColer;
        line2.text=@"";
        [self.contentView addSubview:line2];
        
        productListView=[[ProductShowTable alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        productListView.bounces=NO;
        productListView.showsHorizontalScrollIndicator=NO;
        productListView.showsVerticalScrollIndicator=NO;
        [self.contentView addSubview:productListView];
        
        labLogistic = [[UILabel alloc]init];
        labLogistic.textAlignment = NSTextAlignmentLeft;
        labLogistic.textColor = [UIColor colorWithHexString:@"#333333"];
        labLogistic.font = [UIFont systemFontOfSize:12];
        labLogistic.text = @"寄往: ";
        labLogistic.numberOfLines = 0;
        [self.contentView addSubview:labLogistic];
        
        remindlbl=[[UILabel alloc] initWithFrame:CGRectZero];
        remindlbl.font=[UIFont systemFontOfSize:12.0];
        remindlbl.textColor=[UIColor redColor];
        [self.contentView addSubview:remindlbl];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)orderTableViewDisplayCellWithModel:(OrderModel *)order status:(NSNumber *)status{
    num_lab.text=[NSString stringWithFormat:@"订单号:%@",order.sales_order_sn];
    time_lab.text=[NSString stringWithFormat:@"%@",order.add_time];
    
    labLogistic.text = [NSString stringWithFormat:@"寄往: %@%@%@  %@(收)",order.city,order.district,order.address,order.consignee];
    
    NSArray *list=order.goods;
    NSMutableArray *data=[[NSMutableArray alloc] init];
    for (NSDictionary *dict in list) {
        SaleGoodsModel *goods=[[SaleGoodsModel alloc] init];
        [goods setValues:dict];
        [data addObject:goods];
    }
    productListView.productList=data;
    productListView.model = order;
    productListView.scrollEnabled = NO;
    productListView.status=status;
    [productListView setFrame:CGRectMake(0, num_lab.bottom+5, kDisWidth, 95 * list.count)];
    [productListView reloadData];
    
    line2.frame = CGRectMake(0, productListView.bottom+44.5, kDisWidth, 0.5);
    
    labLogistic.frame = CGRectMake(15, productListView.bottom, kDisWidth-30, 45);
    
    [remindlbl setFrame:CGRectMake(15, productListView.bottom+7.0+45, 120, 30.0)];
    cancelbtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [cancelbtn setBackgroundColor:[UIColor clearColor]];
    [cancelbtn setTitle:@"取消订单" forState:UIControlStateNormal];
    cancelbtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [cancelbtn setTitleColor:kCustomBlack forState:UIControlStateNormal];
    [cancelbtn.layer setCornerRadius:3.0f];
    cancelbtn.layer.borderColor=kCustomBlack.CGColor;
    cancelbtn.layer.borderWidth=0.5;
    
    [self.contentView addSubview:cancelbtn];
    [self.contentView addSubview:line];
    [self.contentView addSubview:line2];
    [self.contentView addSubview:time_lab];
    [self.contentView addSubview:num_lab];
    [self.contentView addSubview:remindlbl];
    [self.contentView addSubview:accessoryImage];
    [self.contentView addSubview:productListView];
    [self.contentView addSubview:labLogistic];
    
    NSInteger index=[status integerValue];
    
    if (index<3) {
        [self makeCellDisplayWithIndex:index order:order];
    }
    else{
        remindlbl.text=order.order_status;
        if ([order.order_status isEqualToString:@"SALES_ORDER_STATUS_CANCELLED"]) {
            remindlbl.text=@"已取消";
            cancelbtn.hidden=YES;
        }else if([order.order_status isEqualToString:@"2"]){
            NSMutableArray *tempArray=[[NSMutableArray alloc] init];
            for (SaleGoodsModel *goods in data) {
                NSInteger stock= [goods.mw_stock integerValue];
                NSInteger quatity=[goods.quantity integerValue];
                if (quatity>stock) {
                    [tempArray addObject:goods];
                }
            }
            if (tempArray.count>0) {
                [self makeCellDisplayWithIndex:0 order:order];
                remindlbl.text = @"缺货采购";
            }else{
                [self makeCellDisplayWithIndex:1 order:order];
                remindlbl.text=@"待通知发货";
                cancelbtn.hidden = YES;
                deliverbtn.hidden = YES;
            }
        }else if([order.order_status isEqualToString:@"SALES_ORDER_STATUS_RECEIVED"]){
            remindlbl.text=@"已收货";
            cancelbtn.hidden = YES;
        }else if([order.order_status isEqualToString:@"SALES_ORDER_STATUS_DELETED"]){
            remindlbl.text=@"已删除";
            cancelbtn.hidden = YES;
        }else if([order.order_status isEqualToString:@"SALES_ORDER_STATUS_NOTIFY"]){
            remindlbl.text=@"通知发货处理中";
            cancelbtn.hidden = YES;
            deliverbtn.hidden = YES;
        }else if([order.order_status isEqualToString:@"1"]){
            remindlbl.text = @"缺货采购";
            cancelbtn.hidden = YES;
        }else if ([order.order_status isEqualToString:@"SALES_ORDER_STATUS_NOTIFY_SUCCESS"]){
            remindlbl.text = @"已通知发货";
            cancelbtn.hidden = YES;
            deliverbtn.hidden = YES;
        }else if ([order.order_status isEqualToString:@"SALES_ORDER_STATUS_SYNC_ERP"]){
            remindlbl.text = @"发货处理中";
            cancelbtn.hidden = YES;
            deliverbtn.hidden = YES;
        }else if ([order.order_status isEqualToString:@"3"]){
            remindlbl.text = @"待收货";
            cancelbtn.hidden = YES;
            deliverbtn.hidden = YES;
        }else if ([order.order_status_str isEqualToString:@"SALES_ORDER_STATUS_SYNC_ERP_FAIL"]){
            cancelbtn.hidden = YES;
            deliverbtn.hidden = YES;
            remindlbl.text = @"通知发货失败，请联系客服";
        }
    }
    
}


-(void)makeCellDisplayWithIndex:(NSInteger)index order:(OrderModel *)order{
    if (index==0){
        cancelbtn.hidden=NO;
        remindlbl.text=@"缺货采购";
        
        [cancelbtn setFrame:CGRectMake(kDisWidth-160, productListView.bottom + 9.5+45, 65.0, 25)];
        
        paybtn = [[UIButton alloc] initWithFrame:CGRectMake(kDisWidth-80.0, productListView.bottom + 9.5+45, 65.0, 25)];
        [paybtn setBackgroundColor:ColorAPPTheme];
        [paybtn setTitle:@"去采购" forState:UIControlStateNormal];
        paybtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [paybtn.layer setCornerRadius:3.0f];
        [self.contentView addSubview:paybtn];
    }else if (index==1){
        cancelbtn.hidden=NO;
        remindlbl.text=@"待通知发货";
        
        if ([order.order_status isEqualToString:@"2"]) {
            [cancelbtn setFrame:CGRectMake(kDisWidth-160, productListView.bottom + 9.5+45, 65.0, 25)];
            
            deliverbtn=[[UIButton alloc] initWithFrame:CGRectMake(kDisWidth-80, productListView.bottom + 9.5+45, 65.0, 25)];
            [deliverbtn setBackgroundColor:ColorAPPTheme];
            [deliverbtn setTitle:@"通知发货" forState:UIControlStateNormal];
            deliverbtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            [deliverbtn.layer setCornerRadius:3.0f];
            [self.contentView addSubview:deliverbtn];
            
        }
    }else if ([order.order_status isEqualToString:@"SALES_ORDER_STATUS_NOTIFY"]){
        cancelbtn.hidden = YES;
        deliverbtn.hidden = YES;
        remindlbl.text = @"通知发货处理中";
    }else if ([order.order_status_str isEqualToString:@"SALES_ORDER_STATUS_SYNC_ERP_FAIL"]){
        cancelbtn.hidden = YES;
        deliverbtn.hidden = YES;
        remindlbl.text = @"通知发货失败，请联系客服";
    }
    
    else if (index==2){
        cancelbtn.hidden=YES;
        cancelbtn.frame = CGRectMake(50, productListView.bottom+9.5+45, 50, 25);
        cancelbtn.backgroundColor = [UIColor redColor];
        remindlbl.text=@"待收货";
        
        logisticBtn=[[UIButton alloc] initWithFrame:CGRectMake(kDisWidth-80.0, productListView.bottom + 9.5+45, 65.0, 25)];
        [logisticBtn setBackgroundColor:[UIColor whiteColor]];
        logisticBtn.layer.borderWidth=0.5;
        logisticBtn.layer.borderColor=ColorAPPTheme.CGColor;
        [logisticBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        [logisticBtn setTitleColor:ColorAPPTheme forState:UIControlStateNormal];
        logisticBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [logisticBtn.layer setCornerRadius:3.0f];
        [self.contentView addSubview:logisticBtn];
        
        logisticBtn1=[[UIButton alloc] initWithFrame:CGRectMake(kDisWidth-165, productListView.bottom + 9.5+45, 65.0, 25)];
        [logisticBtn1 setBackgroundColor:[UIColor whiteColor]];
        logisticBtn1.layer.borderWidth=0.5;
        logisticBtn1.layer.borderColor=ColorAPPTheme.CGColor;
        [logisticBtn1 setTitle:@"确认收货" forState:UIControlStateNormal];
        [logisticBtn1 setTitleColor:ColorAPPTheme forState:UIControlStateNormal];
        logisticBtn1.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [logisticBtn1.layer setCornerRadius:3.0f];
        logisticBtn1.hidden = NO;
        if ([order.order_status isEqual:@"3"]) {
            logisticBtn1.hidden = NO;
        }else{
            logisticBtn1.hidden = YES;
        }
        [self.contentView addSubview:logisticBtn1];
        
    }
    
}



@end
