//
//  ConsigneeInfoView.m
//  Distribution
//
//  Created by DIOS on 15/5/13.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import "ConsigneeInfoView.h"

@interface ConsigneeInfoView ()
{
    UILabel *name;
    UILabel *phone;
    UILabel *label;
    UILabel *identity;
    NSString *isChange;
}
@end

@implementation ConsigneeInfoView

- (id) initWithFrame:(CGRect)frame withInfo:(OrderModel *)model andIsModify:(NSString *)isModify{
    self = [super initWithFrame:frame];
    isChange = isModify;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5.0, 12, 20, 20)];
    imageView.image = [UIImage drawImageWithName:@"order_detal_addr" size:CGSizeMake(20, 20)];
    [self addSubview:imageView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 5, imageView.top, 40, 20)];
    lab.text = @"收货人:";
    lab.textColor = kCustomBlack;
    lab.font = [UIFont systemFontOfSize:12];
    [self addSubview:lab];
    
    if ([isModify isEqualToString:@"yes"]) {
        imageView.hidden = YES;
        lab.frame = CGRectMake(5, 12, 50, 20);
        UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touch)];
        [self addGestureRecognizer:touch];
    }
    
    name = [[UILabel alloc] initWithFrame:CGRectMake(lab.right, lab.top, 80, 20)];
    name.text = model.consignee;
    name.textColor = kCustomBlack;
    name.font = [UIFont systemFontOfSize:12];
    name.textColor = [UIColor darkGrayColor];
    [self addSubview:name];

    phone = [[UILabel alloc] initWithFrame:CGRectMake(name.right, name.top, self.frame.size.width - name.right - 10, name.height)];
    if ([isModify isEqualToString:@"yes"]) {
        phone.frame = CGRectMake(name.right, name.top, self.frame.size.width - name.right - 40, name.height);
        UIImageView *accessory = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 15)];
        accessory.center = CGPointMake(frame.size.width - 20, frame.size.height/2-5.0);
        accessory.image = [UIImage imageNamed:@"accessory"];
    }
    phone.textAlignment = NSTextAlignmentRight;
    phone.text = [NSString stringWithFormat:@"电话 :%@",model.mobile];
    phone.textColor = kCustomBlack;
    phone.font = [UIFont systemFontOfSize:12.0f];
    [self addSubview:phone];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(lab.left, 49, frame.size.width - lab.left - 25,34)];
    label.text = [NSString stringWithFormat:@"收货地址：%@%@%@%@",model.province,model.city,model.district,model.address];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.numberOfLines = 0;
    label.textColor = kCustomBlack;
    label.textAlignment = NSTextAlignmentJustified;
    [self addSubview:label];
    
    identity = [[UILabel alloc] initWithFrame:CGRectMake(lab.left, 100, frame.size.width - lab.left - 25, 20)];
    identity.font = [UIFont systemFontOfSize:12.0f];
    identity.textColor =kCustomBlack;
    [self addSubview:identity];
    if ([isModify isEqualToString:@"yes"]) identity.text = [NSString stringWithFormat:@"身份证号码 :%@",model.id_card_number];
    
    return self;
}

- (void)touch{
    [_delegate touchViewResponse];
}

- (void)setOrderModel:(OrderModel *)orderModel{
    _orderModel = orderModel;
    name.text = orderModel.consignee;
    phone.text = orderModel.mobile;
    label.text = [NSString stringWithFormat:@"收货地址：%@%@%@%@",orderModel.province,orderModel.city,orderModel.district,orderModel.address];
    if ([isChange isEqualToString:@"yes"]){
        identity.text = orderModel.id_card_number;
    }
}

@end
