//
//  ShopView.m
//  Distribution
//
//  Created by fei on 15/1/24.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import "ShopView.h"
#import "FrameView.h"

@interface ShopView ()
{
    UITextField *order_id;
    
}
@end


@implementation ShopView
@synthesize shoplbl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *shop_lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 30)];
        shop_lab.text=@"平台信息";
        shop_lab.font = [UIFont systemFontOfSize:12];
        [self addSubview:shop_lab];
        
        FrameView *fram3=[[FrameView alloc] initWithFrame:CGRectMake(10, shop_lab.bottom, frame.size.width - 20, 88)];
        [fram3 setIndex:1];
        [self addSubview:fram3];
        
        UILabel *shopLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, 44)];
        shopLab.text = @"平台店铺:";
        shopLab.font = [UIFont systemFontOfSize:12.0f];
        shopLab.textColor = kCustomBlack;
        [fram3 addSubview:shopLab];
 
        shoplbl=[[UILabel alloc] initWithFrame:CGRectMake(shopLab.right, 0, fram3.width-80-20, 44)];
        shoplbl.font=[UIFont systemFontOfSize:12];
        shoplbl.userInteractionEnabled=YES;
        shoplbl.textColor=kCustomBlack;
        [fram3 addSubview:shoplbl];
        
        UILabel *orderNum = [[UILabel alloc] initWithFrame:CGRectMake(10, 44, 70, 44)];
        orderNum.text = @"平台订单号:";
        orderNum.font = [UIFont systemFontOfSize:12.0f];
        orderNum.textColor = kCustomBlack;
        [fram3 addSubview:orderNum];
        
        order_id = [[UITextField alloc] initWithFrame:CGRectMake(orderNum.right, 45.5, frame.size.width-80, 44)];
        order_id.clearButtonMode = UITextFieldViewModeWhileEditing;
        order_id.font = [UIFont systemFontOfSize:12.0f];
        order_id.placeholder = @"请填写真实的平台订单号";
        order_id.textColor = kCustomBlack;
        order_id.returnKeyType=UIReturnKeyDone;
        order_id.tag = 1000;
        order_id.clearButtonMode=UITextFieldViewModeWhileEditing;
        [fram3 addSubview:order_id];

        
        UIImageView *imgView=[[UIImageView alloc] init];
        [imgView setFrame:CGRectMake(shoplbl.right,8, 12.0, 15.0)];
        [imgView setImage:[UIImage drawImageWithName:@"accessory" size:CGSizeMake(12.0, 22.0)]];
//        [fram3 addSubview:imgView];
        
        UITapGestureRecognizer *shopChooseTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseShopAction)];
        [shoplbl addGestureRecognizer:shopChooseTap];
    }
    return self;
}

-(void)chooseShopAction{
    if ([_delegate respondsToSelector:@selector(shopViewClickAction)]) {
        [_delegate shopViewClickAction];
    }
}

- (void)setOrderNum:(NSString *)orderNum{

    _orderNum = orderNum;
    
    order_id.text = orderNum;
}

@end
