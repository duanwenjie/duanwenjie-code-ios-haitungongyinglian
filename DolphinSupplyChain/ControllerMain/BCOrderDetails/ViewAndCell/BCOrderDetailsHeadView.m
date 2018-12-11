//
//  BCOrderDetailsHeadView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/15.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "BCOrderDetailsHeadView.h"

@interface BCOrderDetailsHeadView ()

@property (nonatomic, strong) UILabel *lblState;

@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UILabel *lblNameAndPhone;

@property (nonatomic, strong) UILabel *lblIdentity;

@property (nonatomic, strong) UILabel *lblAddress;

@property (nonatomic, strong) UIImageView *imgIdentity;

@property (nonatomic, strong) UIImageView *imgAddress;

@property (nonatomic, assign) BOOL bB_COrder;

@end

@implementation BCOrderDetailsHeadView

- (instancetype)initWithBOrderOrCOrder:(BOOL)bB_COrder
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.bB_COrder = bB_COrder;
        [self initView];
    }
    return self;
}

#pragma mark - 初始化界面
- (void)initView
{
    [self addSubview:self.lblState];
    [self addSubview:self.vLine];

    
    [self addSubview:self.lblNameAndPhone];
    [self addSubview:self.lblIdentity];
    [self addSubview:self.lblAddress];
    
    [self addSubview:self.imgIdentity];
    [self addSubview:self.imgAddress];
    
    
    [self.lblState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.height.mas_equalTo(30);
        make.left.equalTo(self.mas_left).offset(35);
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.lblState.mas_bottom).offset(0);
        make.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    
    
    [self.lblNameAndPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLine.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(35);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.mas_right).offset(-30);
    }];
    
    [self.lblIdentity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblNameAndPhone.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(35);
        make.height.mas_equalTo(15);
        make.right.equalTo(self.mas_right).offset(-30);
    }];
    
    [self.lblAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblIdentity.mas_bottom).offset(5);
        make.left.equalTo(self.mas_left).offset(35);
        make.height.mas_equalTo(15);
        make.right.equalTo(self.mas_right).offset(-30);
    }];
    
    [self.imgIdentity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblIdentity);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.right.equalTo(self.lblIdentity.mas_left).offset(-5);
    }];
    
    [self.imgAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblAddress);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.right.equalTo(self.lblIdentity.mas_left).offset(-5);
    }];
    
}


#pragma mark - 渲染数据
- (void)loadViewStateTitle:(NSString *)sState
                      Name:(NSString *)sName
                  identity:(NSString *)sIdentity
                   address:(NSString *)sAddress
{
    self.lblState.text = [NSString stringWithFormat:@"订单状态：%@",sState];
    self.lblNameAndPhone.text = sName;
    self.lblIdentity.text = sIdentity;
    self.lblAddress.text = sAddress;
}


#pragma mark - 懒加载
- (UILabel *)lblState
{
    if (!_lblState) {
        _lblState = [[UILabel alloc] init];
        _lblState.font = [UIFont systemFontOfSize:15];
    }
    return _lblState;
}

- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
    }
    return _vLine;
}


- (UILabel *)lblNameAndPhone
{
    if (!_lblNameAndPhone) {
        _lblNameAndPhone = [[UILabel alloc] init];
        _lblNameAndPhone.font = [UIFont systemFontOfSize:14];
    }
    return _lblNameAndPhone;
}

- (UILabel *)lblIdentity
{
    if (!_lblIdentity) {
        _lblIdentity = [[UILabel alloc] init];
        _lblIdentity.font = [UIFont systemFontOfSize:12];
        _lblIdentity.textColor = [UIColor colorWithHexString:@"999999"];
    }
    return _lblIdentity;
}

- (UILabel *)lblAddress
{
    if (!_lblAddress) {
        _lblAddress = [[UILabel alloc] init];
        _lblAddress.font = [UIFont systemFontOfSize:12];
        _lblAddress.textColor = [UIColor colorWithHexString:@"999999"];
    }
    return _lblAddress;
}

- (UIImageView *)imgIdentity
{
    if (!_imgIdentity) {
        _imgIdentity = [[UIImageView alloc] init];
        _imgIdentity.image = [UIImage imageNamed:@"Default_Address_Identity"];
        _imgIdentity.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgIdentity;
}

- (UIImageView *)imgAddress
{
    if (!_imgAddress) {
        _imgAddress = [[UIImageView alloc] init];
        _imgAddress.image = [UIImage imageNamed:@"Default_Address"];
        _imgAddress.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgAddress;
}




@end
