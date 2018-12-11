//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "ShoppingInforView.h"
#import "OrderInforModel.h"

@implementation ShoppingInforView

-(instancetype)initWithFrame:(CGRect)frame Index:(int)index Infor:(OrderInforModel *)orderinfor
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGFloat marginx = 10;
        self.backgroundColor = [UIColor whiteColor];
        UILabel *orderSn_label = [[UILabel alloc]init];
        orderSn_label.frame = CGRectMake(marginx, 5.0, kDisWidth-20, 20);
        orderSn_label.text =[NSString stringWithFormat:@"采购单号：%@",orderinfor.order_sn];
        orderSn_label.textColor=kCustomBlack;
        orderSn_label.font=[UIFont systemFontOfSize:12];
        [self addSubview:orderSn_label];
        
        UILabel *time_label = [[UILabel alloc]init];
        time_label.frame = CGRectMake(marginx, orderSn_label.bottom, kDisWidth-30, 20);
        time_label.text = [NSString stringWithFormat:@"采购时间：%@",orderinfor.pay_time];
        time_label.font= [UIFont systemFontOfSize:12.0];
        time_label.textColor=kCustomBlack;
        [self addSubview:time_label];

        
        UILabel *price_label = [[UILabel alloc]init];
        price_label.frame = CGRectMake(marginx, time_label.bottom, 65, 20);
        price_label.text =@"采购价格：";
        price_label.textColor=kCustomBlack;
        price_label.font=[UIFont systemFontOfSize:12];
        price_label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:price_label];
        
        UILabel *price_lab = [[UILabel alloc]init];
        price_lab.frame = CGRectMake(price_label.right, time_label.bottom, kDisWidth-90, 20);
        NSString * price = [orderinfor.goods[0] objectForKey:@"price"];
        price_lab.text =[NSString stringWithFormat:@"¥%.2f",[price floatValue]];
        price_lab.textColor=[UIColor redColor];
        price_lab.font=[UIFont systemFontOfSize:12];
        [self addSubview:price_lab];
        
        UILabel *count_label = [[UILabel alloc]init];
        count_label.frame = CGRectMake(marginx, price_label.bottom, kDisWidth-30, 20);
        NSString * number = [orderinfor.goods[0] objectForKey:@"quantity"];
        count_label.text = [NSString stringWithFormat:@"采购数量：%d件",[number intValue]];
        count_label.textColor=kCustomBlack;
        count_label.font=[UIFont systemFontOfSize:12];
        [self addSubview:count_label];
        
        UILabel *total_label = [[UILabel alloc]init];
        total_label.frame = CGRectMake(marginx, count_label.bottom, 65, 20);
        total_label.text = @"总 价 格：";
        total_label.textColor=kCustomBlack;
        total_label.font=[UIFont systemFontOfSize:12];
        [self addSubview:total_label];
        
        UILabel *total_lab = [[UILabel alloc]init];
        total_lab.frame = CGRectMake(total_label.right, count_label.bottom, kDisWidth-60, 20);
        total_lab.text = [NSString stringWithFormat:@"¥%.2f",[price floatValue]*[number intValue]];
        total_lab.textColor=[UIColor redColor];
        total_lab.font=[UIFont systemFontOfSize:12];
        total_lab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:total_lab];
        
    }
    return self;
}


@end
