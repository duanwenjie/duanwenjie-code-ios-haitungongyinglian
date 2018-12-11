//
//  DefaultAddressHeadView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "DefaultAddressHeadView.h"

@interface DefaultAddressHeadView ()

@property (nonatomic, strong) UILabel *lblNameAndPhone;

@property (nonatomic, strong) UILabel *lblIdentity;

@property (nonatomic, strong) UILabel *lblAddress;

@property (nonatomic, strong) UIImageView *imgIdentity;

@property (nonatomic, strong) UIImageView *imgAddress;

@property (nonatomic, strong) UIImageView *imgLine;

@property (nonatomic, strong) UIImageView *imgArrows;

@property (nonatomic, strong) UIButton *btnAddAddress;

@end

@implementation DefaultAddressHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark - 初始化界面
- (void)initView
{
    [self addSubview:self.lblNameAndPhone];
    [self addSubview:self.lblIdentity];
    [self addSubview:self.lblAddress];
    
    [self addSubview:self.imgIdentity];
    [self addSubview:self.imgAddress];
    [self addSubview:self.imgLine];
    [self addSubview:self.imgArrows];
    [self addSubview:self.btnAddAddress];
    
    [self.lblNameAndPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
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
    
    [self.imgLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(4);
    }];
    
    [self.imgArrows mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.lblNameAndPhone.mas_right);
        make.width.mas_equalTo(15);
    }];
    
    [self.btnAddAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 30));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}


#pragma mark - 按钮点击事件
- (void)selectorAddAddress
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapAddAddress)]) {
        [self.delegate tapAddAddress];
    }
}


#pragma mark - 渲染数据
- (void)loadViewName:(NSString *)sName
            identity:(NSString *)sIdentity
             address:(NSString *)sAddress
              isData:(BOOL )bData
{
    if (bData) {
        
        self.imgArrows.hidden = NO;
        self.imgAddress.hidden = NO;
        self.imgIdentity.hidden = NO;
        self.lblNameAndPhone.hidden = NO;
        self.lblIdentity.hidden = NO;
        self.lblAddress.hidden = NO;
        
        self.btnAddAddress.hidden = YES;
        
        
        self.lblNameAndPhone.text = sName;
        self.lblIdentity.text = sIdentity;
        self.lblAddress.text = sAddress;
    }
    else
    {
        
        self.lblNameAndPhone.text = @"";
        self.lblIdentity.text = @"";
        self.lblAddress.text = @"";
        
        self.imgArrows.hidden = YES;
        self.imgAddress.hidden = YES;
        self.imgIdentity.hidden = YES;
        self.lblNameAndPhone.hidden = YES;
        self.lblIdentity.hidden = YES;
        self.lblAddress.hidden = YES;
        
        self.btnAddAddress.hidden = NO;
    }
}


#pragma mark - 懒加载
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
    }
    return _lblIdentity;
}

- (UILabel *)lblAddress
{
    if (!_lblAddress) {
        _lblAddress = [[UILabel alloc] init];
        _lblAddress.font = [UIFont systemFontOfSize:12];
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

- (UIImageView *)imgLine
{
    if (!_imgLine) {
        _imgLine = [[UIImageView alloc] init];
        _imgLine.image = [UIImage imageNamed:@"Default_Address_Line"];
    }
    return _imgLine;
}

- (UIImageView *)imgArrows
{
    if (!_imgArrows) {
        _imgArrows = [[UIImageView alloc] init];
        _imgArrows.image = [UIImage imageNamed:@"accessory"];
        _imgArrows.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgArrows;
}

- (UIButton *)btnAddAddress
{
    if (!_btnAddAddress) {
        _btnAddAddress = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAddAddress setImage:[UIImage imageNamed:@"Address_Add"] forState:UIControlStateNormal];
        [_btnAddAddress setTitle:@"请添加收货地址" forState:UIControlStateNormal];
        [_btnAddAddress setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [_btnAddAddress setImageEdgeInsets:UIEdgeInsetsMake(0.0, -10, 0.0, 0.0)];
        _btnAddAddress.hidden = YES;
        _btnAddAddress.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnAddAddress addTarget:self action:@selector(selectorAddAddress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAddAddress;
}


@end
