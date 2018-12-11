//
//  PayInfoView.m
//  Distribution
//
//  Created by DIOS on 15/5/20.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import "PayInfoView.h"

@interface PayInfoView ()
{

    UILabel *label;
}

@end

@implementation PayInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, frame.size.width - 40, frame.size.height - 20)];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.textColor = [UIColor lightGrayColor];
    label.text = @"请填写支付信息(选填)";
    label.numberOfLines = 0;
    [self addSubview:label];
    
    UIImageView *accessory = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 12)];
    accessory.center = CGPointMake(frame.size.width - 20, frame.size.height/2);
    accessory.image = [UIImage imageNamed:@"accessory"];
    [self addSubview:accessory];

    
    return self;
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    NSString *type = [dic objectForKey:@"platType"];
    NSString *name = [dic objectForKey:@"platName"];
    NSString *num = [dic objectForKey:@"platformNum"];
    NSString *identity = [dic objectForKey:@"platIdentity"];
    
    label.text = [NSString stringWithFormat:@"%@        %@\n交易号:%@\n身份证号:%@",type,name,num,identity];
    label.textColor = [UIColor darkGrayColor];
}

@end
