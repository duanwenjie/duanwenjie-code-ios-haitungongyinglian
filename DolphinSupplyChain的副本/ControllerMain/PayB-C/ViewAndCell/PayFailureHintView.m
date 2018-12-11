//
//  PayFailureHintView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "PayFailureHintView.h"

@interface PayFailureHintView ()

@property (nonatomic, strong) UIImageView *imgError;

@property (nonatomic, strong) UILabel *lblError;

@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UILabel *lblOrderName;

@property (nonatomic, strong) UILabel *lblOrderNumber;

@property (nonatomic, strong) UILabel *lblMoneyName;

@property (nonatomic, strong) UILabel *lblMoneyNumber;

@end

@implementation PayFailureHintView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self addSubview:self.imgError];
    [self addSubview:self.lblError];
    
    [self addSubview:self.vLine];
    
    [self addSubview:self.lblOrderName];
    [self addSubview:self.lblOrderNumber];
    
    [self addSubview:self.lblMoneyName];
    [self addSubview:self.lblMoneyNumber];

    
    [self.imgError mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(45);
        make.centerX.equalTo(self.mas_centerX).offset(-75);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    [self.lblError mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(45);
        make.centerX.equalTo(self.mas_centerX).offset(30);
        make.height.mas_equalTo(35);
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(125);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.lblOrderName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLine.mas_bottom).offset(14);
        make.left.equalTo(self.mas_left).offset(15);
        make.bottom.equalTo(self.lblMoneyName.mas_top).offset(-15);
        make.right.equalTo(self.lblOrderNumber.mas_left).offset(-5);
        make.height.equalTo(self.lblMoneyName.mas_height);
    }];
    
    [self.lblOrderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLine.mas_bottom).offset(14);
        make.left.equalTo(self.lblOrderName.mas_right).offset(5);
        make.bottom.equalTo(self.lblMoneyName.mas_top).offset(-15);
        make.right.equalTo(self.mas_right).offset(-5);
    }];
    
    [self.lblMoneyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblOrderName.mas_bottom).offset(15);
        make.bottom.equalTo(self.mas_bottom).offset(-14);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.lblMoneyNumber.mas_left).offset(-5);
        make.height.equalTo(self.lblOrderName.mas_height);
    }];
    
    [self.lblMoneyNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblOrderName.mas_bottom).offset(15);
        make.left.equalTo(self.lblMoneyName.mas_right).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-14);
        make.right.equalTo(self.mas_right).offset(-5);
    }];
}

- (void)loadViewOrderNumber:(NSString *)sOrderNumber
                MoneyNumber:(NSString *)sMoneyNumber
{
    if (sOrderNumber.length != 0 || sOrderNumber != nil) {
        self.lblOrderNumber.text = sOrderNumber;
    }
    if (sMoneyNumber.length != 0 || sMoneyNumber != nil) {
        self.lblMoneyNumber.text = [NSString stringWithFormat:@"¥ %@",sMoneyNumber];
    }
}

#pragma mark - 懒加载

- (UIImageView *)imgError
{
    if (!_imgError) {
        _imgError = [[UIImageView alloc] init];
        _imgError.image = [UIImage imageNamed:@"Paly_False"];
        _imgError.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgError;
}

- (UILabel *)lblError
{
    if (!_lblError) {
        _lblError = [[UILabel alloc] init];
        _lblError.text = @"支付失败，请重新支付";
        _lblError.font = kFont16;
    }
    return _lblError;
}

- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = ColorLine;
    }
    return _vLine;
}

- (UILabel *)lblOrderName
{
    if (!_lblOrderName) {
        _lblOrderName = [[UILabel alloc] init];
        _lblOrderName.textColor = [UIColor colorWithHexString:@"666666"];
        _lblOrderName.font = [UIFont systemFontOfSize:13];
        _lblOrderName.text = @"订单号：";
    }
    return _lblOrderName;
}

- (UILabel *)lblOrderNumber
{
    if (!_lblOrderNumber) {
        _lblOrderNumber = [[UILabel alloc] init];
        _lblOrderNumber.font = [UIFont systemFontOfSize:13];
    }
    return _lblOrderNumber;
}

- (UILabel *)lblMoneyName
{
    if (!_lblMoneyName) {
        _lblMoneyName = [[UILabel alloc] init];
        _lblMoneyName.textColor = [UIColor colorWithHexString:@"666666"];
        _lblMoneyName.font = [UIFont systemFontOfSize:13];
        _lblMoneyName.text = @"总金额：";
    }
    return _lblMoneyName;
}

- (UILabel *)lblMoneyNumber
{
    if (!_lblMoneyNumber) {
        _lblMoneyNumber = [[UILabel alloc] init];
        _lblMoneyNumber.font = [UIFont systemFontOfSize:13];
        _lblMoneyNumber.textColor = [UIColor redColor];
    }
    return _lblMoneyNumber;
}


@end
