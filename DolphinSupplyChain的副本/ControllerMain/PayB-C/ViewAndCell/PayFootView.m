//
//  PayFootView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "PayFootView.h"

@interface PayFootView ()

@property (nonatomic, strong) PayFootBlock payBlock;

@property (nonatomic, strong) UIButton *btnPay;

@end

@implementation PayFootView

- (instancetype)initWithTap:(PayFootBlock)block
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.payBlock = block;
        self.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self addSubview:self.btnPay];
    
    [self.btnPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(25);
        make.left.equalTo(self.mas_left).offset(65);
        make.bottom.equalTo(self.mas_bottom).offset(-25);
        make.right.equalTo(self.mas_right).offset(-65);
    }];
}


- (void)selectPay
{
    self.payBlock();
}

- (UIButton *)btnPay
{
    if (!_btnPay) {
        _btnPay = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnPay setBackgroundColor:[UIColor colorWithHexString:@"12a0ea"]];
        [_btnPay setTitle:@"确认支付" forState:UIControlStateNormal];
        [_btnPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnPay.titleLabel.font = [UIFont systemFontOfSize:16];
        _btnPay.layer.cornerRadius = 6;
        _btnPay.layer.masksToBounds = YES;
        [_btnPay addTarget:self action:@selector(selectPay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPay;
}

@end
