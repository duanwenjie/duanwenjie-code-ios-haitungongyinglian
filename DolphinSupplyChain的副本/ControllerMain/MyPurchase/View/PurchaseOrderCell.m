//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "PurchaseOrderCell.h"
#import "PurchaseGoodsModel.h"


@interface PurchaseOrderCell (){
    UILabel     *price_lab;
}

@end

@implementation PurchaseOrderCell
@synthesize num_lab;
@synthesize time_lab;
@synthesize purchaseGoodsView;
@synthesize purchaseBtn;
@synthesize rePurchaseBtn;
@synthesize cancelBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat margin = 15;
        num_lab=[self makeLabelWithframe:CGRectMake(margin, 5.0, 200, 20.0) size:12 color:[UIColor blackColor]];
        
        time_lab=[self makeLabelWithframe:CGRectMake(kDisWidth-110-margin, 5.0, 110.0, 20.0) size:10 color:[UIColor lightGrayColor]];
        time_lab.font=[UIFont systemFontOfSize:10.0];
        
        UILabel *line=[[UILabel alloc] initWithFrame:CGRectMake(margin, time_lab.bottom+5.0, kDisWidth-2*margin, 0.5)];
        line.backgroundColor = kLineColer;
        line.text=@"";
        [self.contentView addSubview:line];
        
        purchaseGoodsView=[[PurchaseGoodsView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        purchaseGoodsView.bounces=NO;
        purchaseGoodsView.showsHorizontalScrollIndicator=NO;
        purchaseGoodsView.showsVerticalScrollIndicator=NO;
        [self.contentView addSubview:purchaseGoodsView];
        
        price_lab=[self makeLabelWithframe:CGRectZero size:12 color:[UIColor colorWithHexString:@"666666"]];
        
        cancelBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [cancelBtn setBackgroundColor:[UIColor clearColor]];
        [cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn.layer setCornerRadius:3.0f];
        cancelBtn.layer.borderColor=[UIColor colorWithHexString:@"#666666"].CGColor;
        cancelBtn.layer.borderWidth=0.5;
        [self.contentView addSubview:cancelBtn];
        
        purchaseBtn=[[UIButton alloc] initWithFrame:CGRectZero];
        [purchaseBtn setTitle:@"付款" forState:UIControlStateNormal];
        purchaseBtn.layer.cornerRadius=3.0;
        purchaseBtn.titleLabel.font=[UIFont boldSystemFontOfSize:12.0];
        [purchaseBtn setBackgroundColor:ColorAPPTheme];
        [purchaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:purchaseBtn];
        
        rePurchaseBtn=[[UIButton alloc] initWithFrame:CGRectZero];
        [rePurchaseBtn setTitle:@"再次购买" forState:UIControlStateNormal];
        rePurchaseBtn.layer.cornerRadius=3.0;
        rePurchaseBtn.layer.borderColor=ColorAPPTheme.CGColor;
        rePurchaseBtn.layer.borderWidth=0.5;
        rePurchaseBtn.titleLabel.font=[UIFont boldSystemFontOfSize:12.0];
        [rePurchaseBtn setBackgroundColor:[UIColor whiteColor]];
        [rePurchaseBtn setTitleColor:ColorAPPTheme forState:UIControlStateNormal];
        [self.contentView addSubview:rePurchaseBtn];
        
    }
    return self;
}


-(UILabel *)makeLabelWithframe:(CGRect)frame size:(CGFloat)fontSize color:(UIColor *)color{
    UILabel *lab=[[UILabel alloc] initWithFrame:frame];
    lab.textColor=color;
    lab.font = [UIFont systemFontOfSize:fontSize];
    lab.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:lab];
    return lab;
}


-(void)cellDisplayWithModel:(PurchaseOrderModel *)model{

    num_lab.text=[NSString stringWithFormat:@"订单号: %@",model.purchase_order_sn];

    NSString *timeStr=[NSString stringWithFormat:@"%@",model.add_time];
    time_lab.text=[NSString stringWithFormat:@"%@",timeStr];
     NSArray *list=model.goods;
    [purchaseGoodsView setFrame:CGRectMake(0.0, time_lab.bottom+10, kDisWidth, [list count]*95)];
    
    NSMutableArray *array =[[NSMutableArray alloc] init];
    for (NSDictionary *dict in list) {
        PurchaseGoodsModel *goods=[[PurchaseGoodsModel alloc] init];
        [goods setValues:dict];
        [array addObject:goods];
    }
    purchaseGoodsView.purchaseGoodsList=array;
    [purchaseGoodsView reloadData];
    
    [price_lab setFrame:CGRectMake(15, purchaseGoodsView.bottom+12.0,kDisWidth-80-100-10, 20.0)];
    
    [cancelBtn setFrame:CGRectMake(kDisWidth-65-95, purchaseGoodsView.bottom+9.5, 65, 25)];
    [purchaseBtn setFrame:CGRectMake(kDisWidth-80, purchaseGoodsView.bottom+9.5, 65, 25)];
    [rePurchaseBtn setFrame:CGRectMake(kDisWidth-80, purchaseGoodsView.bottom+9.5, 65, 25)];
    
    float orderAmount=[model.order_amount floatValue];
    float moneyPaid=[model.order_amount floatValue];
    NSString * order_status = model.order_status;
    int status = -1;
    //C_CREATE_ORDER SALES_ORDER_STATUS_CREATE
    if ([order_status isEqualToString:@"PURCHASE_ORDER_STATUS_CREATE"]) {
        status = 0;
    }else if([order_status isEqualToString:@"PURCHASE_ORDER_STATUS_PAID"]){
        status = 2;
}
//    int status=[model.pay_status intValue];
    if (status == 0) {
        cancelBtn.hidden = NO;
        NSString *btnTitle = @"付款";
        purchaseBtn.hidden = NO;
        rePurchaseBtn.hidden = YES;
        [purchaseBtn setTitle:btnTitle forState:UIControlStateNormal];
        
        NSMutableAttributedString *abs = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"应付款 : ¥%.2f",orderAmount]];
        [abs beginEditing];
        [abs addAttribute:NSForegroundColorAttributeName value:kCustomBlack range:NSMakeRange(0, 5)];
        NSDictionary *dict = [[NSDictionary alloc] initWithObjects:@[[UIColor redColor],[UIFont systemFontOfSize:15]] forKeys:@[NSForegroundColorAttributeName,NSFontAttributeName]];
        [abs addAttributes:dict range:NSMakeRange(5, abs.length-5)];
        price_lab.attributedText = abs;
    }else if(status == 2){
        cancelBtn.hidden = YES;
        NSString *btnTitle = @"再次购买";
        purchaseBtn.hidden = YES;
        rePurchaseBtn.hidden = NO;
        [rePurchaseBtn setTitle:btnTitle forState:UIControlStateNormal];
        NSMutableAttributedString *abs = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付款 : ¥%.2f",moneyPaid]];
        [abs beginEditing];
        [abs addAttribute:NSForegroundColorAttributeName value:kCustomBlack range:NSMakeRange(0, 5)];
        NSDictionary *dict = [[NSDictionary alloc] initWithObjects:@[[UIColor redColor],[UIFont systemFontOfSize:15]] forKeys:@[NSForegroundColorAttributeName,NSFontAttributeName]];
        [abs addAttributes:dict range:NSMakeRange(5, abs.length-5)];
        price_lab.attributedText = abs;
//        price_lab.text=[NSString stringWithFormat:@"实付款：¥%.2f",moneyPaid];
        
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
