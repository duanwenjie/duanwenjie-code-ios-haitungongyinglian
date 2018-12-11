//
//  OrderInfoView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/2.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "OrderInfoView.h"

@interface OrderInfoView ()

@property (nonatomic, strong) UILabel *lblOrderNumberType;

@property (nonatomic, strong) UILabel *lblOrderMoneyType;

@property (nonatomic, strong) UILabel *lblOrderNumber;

@property (nonatomic, strong) UILabel *lblOrderMoney;

@end

@implementation OrderInfoView

- (instancetype)initWithOrderNumber:(NSString *)sOrderNumber
                         OrderMoney:(NSString *)sOrderMoney
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self initView];
        [self loadDataOrderNumber:sOrderNumber OrderMoney:sOrderMoney];
    }
    return self;
}

- (void)initView
{
    [self addSubview:self.lblOrderNumberType];
    [self addSubview:self.lblOrderNumber];
    [self addSubview:self.lblOrderMoneyType];
    [self addSubview:self.lblOrderMoney];
    
    [self.lblOrderNumberType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(13);
        make.left.equalTo(self.mas_left).offset(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.lblOrderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(13);
        make.left.equalTo(self.lblOrderNumberType.mas_right).offset(5);
        make.height.mas_equalTo(15);
    }];
    
    [self.lblOrderMoneyType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-13);
        make.left.equalTo(self.mas_left).offset(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.lblOrderMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-13);
        make.left.equalTo(self.lblOrderMoneyType.mas_right).offset(5);
        make.height.mas_equalTo(15);
    }];
    
    
}

- (void)loadDataOrderNumber:(NSString *)sOrderNumber
                 OrderMoney:(NSString *)sOrderMoney
{
    self.lblOrderNumber.text = sOrderNumber;
    self.lblOrderMoney.text = [NSString stringWithFormat:@"￥%@", sOrderMoney];
}

- (UILabel *)lblOrderNumberType
{
    if (!_lblOrderNumberType) {
        _lblOrderNumberType = [[UILabel alloc] init];
        _lblOrderNumberType.font = kFont13;
        _lblOrderNumberType.textColor = [UIColor colorWithHexString:@"666666"];
        _lblOrderNumberType.text = @"订单号：";
    }
    return _lblOrderNumberType;
}

- (UILabel *)lblOrderMoneyType
{
    if (!_lblOrderMoneyType) {
        _lblOrderMoneyType = [[UILabel alloc] init];
        _lblOrderMoneyType.font = kFont13;
        _lblOrderMoneyType.textColor = [UIColor colorWithHexString:@"666666"];
        _lblOrderMoneyType.text = @"总金额：";
    }
    return _lblOrderMoneyType;
}

- (UILabel *)lblOrderNumber
{
    if (!_lblOrderNumber) {
        _lblOrderNumber = [[UILabel alloc] init];
        _lblOrderNumber.font = kFont13;
    }
    return _lblOrderNumber;
}

- (UILabel *)lblOrderMoney
{
    if (!_lblOrderMoney) {
        _lblOrderMoney = [[UILabel alloc] init];
        _lblOrderMoney.font = kFont13;
    }
    return _lblOrderMoney;
}

@end
