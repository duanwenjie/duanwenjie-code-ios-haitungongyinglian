//
//  PaySucceedFootImageView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/3.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "PaySucceedFootImageView.h"

@interface PaySucceedFootImageView ()

@property (nonatomic, strong) UIView *vLineOne;

@property (nonatomic, strong) UILabel *lblShipmentsName;

@property (nonatomic, strong) UIButton *btnShipments;

@property (nonatomic, strong) UIView *vLineTwo;

@property (nonatomic, strong) UILabel *lblGoHomeName;

@property (nonatomic, strong) UIButton *btnGoHome;

@property (nonatomic, strong) PaySucceedGoBlock GoBlocl;

@end


@implementation PaySucceedFootImageView

- (instancetype)initWithShipmentsOrHomeNameBlock:(PaySucceedGoBlock)block
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.GoBlocl = block;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self addSubview:self.vLineOne];
    [self addSubview:self.vLineTwo];
    
    [self addSubview:self.lblShipmentsName];
    [self addSubview:self.btnShipments];
    [self addSubview:self.lblGoHomeName];
    [self addSubview:self.btnGoHome];
    
    [self.vLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.lblShipmentsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self);
        make.height.mas_equalTo(36);
    }];
    
    [self.btnShipments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(4);
        make.size.mas_equalTo(CGSizeMake(65, 28));
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    [self.vLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self.lblShipmentsName.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.lblGoHomeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.vLineTwo.mas_bottom);
        make.height.mas_equalTo(36);
    }];
    
    [self.btnGoHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLineTwo.mas_top).offset(4);
        make.size.mas_equalTo(CGSizeMake(65, 28));
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
}


- (void)selectShipment
{
    self.GoBlocl(@"Go_Order");
}

- (void)selectGoHome
{
    self.GoBlocl(@"Go_Home");
}



- (UIView *)vLineOne
{
    if (!_vLineOne) {
        _vLineOne = [[UIView alloc] init];
        _vLineOne.backgroundColor = ColorLine;
    }
    return _vLineOne;
}

- (UILabel *)lblShipmentsName
{
    if (!_lblShipmentsName) {
        _lblShipmentsName = [[UILabel alloc] init];
        _lblShipmentsName.textColor = [UIColor colorWithHexString:@"666666"];
        _lblShipmentsName.text = @"立即发货，还需创建销售订单";
        _lblShipmentsName.font = [UIFont systemFontOfSize:13];
    }
    return _lblShipmentsName;
}

- (UIButton *)btnShipments
{
    if (!_btnShipments) {
        _btnShipments = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnShipments setTitleColor:[UIColor colorWithHexString:@"12a0ea"] forState:UIControlStateNormal];
        [_btnShipments setTitle:@"销售订单" forState:UIControlStateNormal];
        _btnShipments.layer.cornerRadius = 4;
        _btnShipments.layer.borderColor = [UIColor colorWithHexString:@"12a0ea"].CGColor;
        _btnShipments.layer.borderWidth = 1;
        [_btnShipments addTarget:self action:@selector(selectShipment) forControlEvents:UIControlEventTouchUpInside];
        _btnShipments.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _btnShipments;
}

- (UIView *)vLineTwo
{
    if (!_vLineTwo) {
        _vLineTwo = [[UIView alloc] init];
        _vLineTwo.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    }
    return _vLineTwo;
}

- (UILabel *)lblGoHomeName
{
    if (!_lblGoHomeName) {
        _lblGoHomeName = [[UILabel alloc] init];
        _lblGoHomeName.textColor = [UIColor colorWithHexString:@"666666"];
        _lblGoHomeName.text = @"暂不发货，去首页再逛逛";
        _lblGoHomeName.font = [UIFont systemFontOfSize:13];
    }
    return _lblGoHomeName;
}

- (UIButton *)btnGoHome
{
    if (!_btnGoHome) {
        _btnGoHome = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnGoHome setTitleColor:[UIColor colorWithHexString:@"12a0ea"] forState:UIControlStateNormal];
        [_btnGoHome setTitle:@"回首页" forState:UIControlStateNormal];
        _btnGoHome.layer.cornerRadius = 4;
        _btnGoHome.layer.borderColor = [UIColor colorWithHexString:@"12a0ea"].CGColor;
        _btnGoHome.layer.borderWidth = 1;
        [_btnGoHome addTarget:self action:@selector(selectGoHome) forControlEvents:UIControlEventTouchUpInside];
        _btnGoHome.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _btnGoHome;
}



@end
