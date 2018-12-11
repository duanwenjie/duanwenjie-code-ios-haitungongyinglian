//
//  PaySucceedHintView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/3.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "PaySucceedHintView.h"

@interface PaySucceedHintView ()

@property (nonatomic, strong) UIImageView *imgError;

@property (nonatomic, strong) UILabel *lblError;

@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UILabel *lblOrderName;

@property (nonatomic, strong) UILabel *lblOrderNumber;

@property (nonatomic, strong) UILabel *lblOrderPayTypeName;

@property (nonatomic, strong) UILabel *lblOrderPayType;

@property (nonatomic, strong) UILabel *lblMoneyName;

@property (nonatomic, strong) UILabel *lblMoneyNumber;

@property (nonatomic, strong) UILabel *lblPayNumberName;

@property (nonatomic, strong) UILabel *lblPayNumber;

@end

@implementation PaySucceedHintView

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
    
    [self addSubview:self.lblOrderPayTypeName];
    [self addSubview:self.lblOrderPayType];
    
    [self addSubview:self.lblMoneyName];
    [self addSubview:self.lblMoneyNumber];
    
    [self addSubview:self.lblPayNumberName];
    [self addSubview:self.lblPayNumber];
    
    
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
        make.height.mas_equalTo(15);
    }];
    
    [self.lblOrderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLine.mas_bottom).offset(14);
        make.left.equalTo(self.lblOrderName.mas_right).offset(5);
        make.height.equalTo(self.lblOrderName.mas_height);
    }];
    
    [self.lblOrderPayTypeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblOrderName.mas_bottom).offset(8);
        make.left.equalTo(self.mas_left).offset(15);
        make.height.equalTo(self.lblOrderName.mas_height);
    }];
    

    [self.lblOrderPayType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblOrderName.mas_bottom).offset(8);
        make.left.equalTo(self.lblOrderPayTypeName.mas_right).offset(5);
        make.height.equalTo(self.lblOrderName.mas_height);
    }];
    
    [self.lblMoneyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblOrderPayTypeName.mas_bottom).offset(8);
        make.left.equalTo(self.mas_left).offset(15);
        make.height.equalTo(self.lblOrderName.mas_height);
    }];
    
    [self.lblMoneyNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblOrderPayTypeName.mas_bottom).offset(8);
        make.left.equalTo(self.lblMoneyName.mas_right).offset(5);
        make.height.equalTo(self.lblOrderName.mas_height);
    }];
    
    [self.lblPayNumberName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblMoneyName.mas_bottom).offset(8);
        make.left.equalTo(self.mas_left).offset(15);
        make.height.equalTo(self.lblOrderName.mas_height);
    }];
    
    [self.lblPayNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblMoneyName.mas_bottom).offset(8);
        make.left.equalTo(self.lblPayNumberName.mas_right).offset(5);
        make.height.equalTo(self.lblOrderName.mas_height);
    }];
}

- (void)loadViewOrderNumber:(NSString *)sOrderNumber
                    PayType:(NSString *)sPayType
                MoneyNumber:(NSString *)sMoneyNumber
                  PayNumber:(NSString *)sPayNumber

{
    if (sOrderNumber.length != 0 || sOrderNumber != nil) {
        self.lblOrderNumber.text = sOrderNumber;
    }
    
    if (sPayType.length != 0) {
        self.lblOrderPayType.text = sPayType;
    }
    
    if (sMoneyNumber.length != 0 || sMoneyNumber != nil) {
        self.lblMoneyNumber.text = [NSString stringWithFormat:@"¥ %@",sMoneyNumber];
    }
    
    if (sPayNumber.length != 0) {
        self.lblPayNumber.text = sPayNumber;
    }
}

#pragma mark - 懒加载
- (UIImageView *)imgError
{
    if (!_imgError) {
        _imgError = [[UIImageView alloc] init];
        _imgError.image = [UIImage imageNamed:@"Paly_Succeed"];
        _imgError.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgError;
}

- (UILabel *)lblError
{
    if (!_lblError) {
        _lblError = [[UILabel alloc] init];
        _lblError.text = @"恭喜您，支付成功！";
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

- (UILabel *)lblOrderPayTypeName
{
    if (!_lblOrderPayTypeName) {
        _lblOrderPayTypeName = [[UILabel alloc] init];
        _lblOrderPayTypeName.font = kFont13;
        _lblOrderPayTypeName.text = @"支付方式：";
        _lblOrderPayTypeName.textColor = [UIColor colorWithHexString:@"666666"];
    }
    return _lblOrderPayTypeName;
}

- (UILabel *)lblOrderPayType
{
    if (!_lblOrderPayType) {
        _lblOrderPayType = [[UILabel alloc] init];
        _lblOrderPayType.font = kFont13;
    }
    return _lblOrderPayType;
}

- (UILabel *)lblMoneyName
{
    if (!_lblMoneyName) {
        _lblMoneyName = [[UILabel alloc] init];
        _lblMoneyName.textColor = [UIColor colorWithHexString:@"666666"];
        _lblMoneyName.font = [UIFont systemFontOfSize:13];
        _lblMoneyName.text = @"实付款：";
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

- (UILabel *)lblPayNumberName
{
    if (!_lblPayNumberName) {
        _lblPayNumberName = [[UILabel alloc] init];
        _lblPayNumberName.font = kFont13;
        _lblPayNumberName.textColor = [UIColor colorWithHexString:@"666666"];
        _lblPayNumberName.text = @"商户单号：";
    }
    return _lblPayNumberName;
}

- (UILabel *)lblPayNumber
{
    if (!_lblPayNumber) {
        _lblPayNumber = [[UILabel alloc] init];
        _lblPayNumber.font = kFont13;
    }
    return _lblPayNumber;
}


@end
