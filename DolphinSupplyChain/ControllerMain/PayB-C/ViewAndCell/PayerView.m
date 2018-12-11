//
//  PayerView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/5/13.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "PayerView.h"

@interface PayerView ()

@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UIView *vBack;

@property (nonatomic, strong) UILabel *lblName;

@property (nonatomic, strong) UITextField *tfName;

@property (nonatomic, strong) UILabel *lblNumber;

@property (nonatomic, strong) UITextField *tfNumber;

@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UILabel *lblInfo;

@end

@implementation PayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ColorBackground;
        [self initView];
    }
    return self;
}


- (void)initView
{
    [self addSubview:self.lblTitle];
    [self addSubview:self.vBack];
    [self.vBack addSubview:self.lblName];
    [self.vBack addSubview:self.tfName];
    [self.vBack addSubview:self.vLine];
    [self.vBack addSubview:self.lblNumber];
    [self.vBack addSubview:self.tfNumber];
    [self addSubview:self.lblInfo];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(0);
        make.right.equalTo(self.mas_right).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    [self.vBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(0);
        make.height.mas_equalTo(80.5);
    }];
    
    [self.lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBack.mas_left).offset(15);
        make.top.equalTo(self.vBack.mas_top);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    
    [self.tfName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblName.mas_right).offset(5);
        make.right.equalTo(self.vBack.mas_right).offset(-15);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.vBack.mas_top);
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vBack);
        make.top.equalTo(self.lblName.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.lblNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBack.mas_left).offset(15);
        make.top.equalTo(self.vLine.mas_bottom);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    
    [self.tfNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblNumber.mas_right).offset(5);
        make.right.equalTo(self.vBack.mas_right).offset(-15);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.vLine.mas_bottom);
    }];
    
    [self.lblInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.vBack.mas_bottom).offset(0);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(35);
    }];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sName = [user objectForKey:@"YKS_Payer_Name"];
    if (sName.length > 0) {
        self.tfName.text = sName;
    }
    
    NSString *sNumber = [user objectForKey:@"YKS_Payer_Number"];
    if (sNumber.length > 0) {
        self.tfNumber.text = sNumber;
    }
}


- (BOOL)isPayerVerificationPassed
{
    BOOL a = [VerificationString Verify_Chinese:self.tfName.text];
    
    BOOL b = [VerificationString Verify_Identity:self.tfNumber.text];
    
    if (a && b) {
        return YES;
    }
    else
    {
        return NO;
    }
}


- (void)updatePayerInfo
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:self.tfName.text forKey:@"YKS_Payer_Name"];
    [user setValue:self.tfNumber.text forKey:@"YKS_Payer_Number"];
    [user synchronize];
}


#pragma mark - 懒加载
- (UILabel *)lblTitle
{
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.font = kFont12;
        _lblTitle.textColor = [UIColor colorWithHexString:@"666666"];
        _lblTitle.text = @"支付人信息";
    }
    return _lblTitle;
}

- (UIView *)vBack
{
    if (!_vBack) {
        _vBack = [[UIView alloc] init];
        _vBack.backgroundColor = [UIColor whiteColor];
    }
    return _vBack;
}

- (UILabel *)lblName
{
    if (!_lblName) {
        _lblName = [[UILabel alloc] init];
        _lblName.text = @"支付人姓名：";
        _lblName.font = kFont13;
    }
    return _lblName;
}

- (UITextField *)tfName
{
    if (!_tfName) {
        _tfName = [[UITextField alloc] init];
        _tfName.placeholder = @"请使用真实姓名";
        _tfName.font = kFont13;
        _tfName.borderStyle = UITextBorderStyleNone;
        _tfName.keyboardType = UIKeyboardTypeDefault;
    }
    return _tfName;
}

- (UILabel *)lblNumber
{
    if (!_lblNumber) {
        _lblNumber = [[UILabel alloc] init];
        _lblNumber.text = @"身份证号码：";
        _lblNumber.font = kFont13;
    }
    return _lblNumber;
}

- (UITextField *)tfNumber
{
    if (!_tfNumber) {
        _tfNumber = [[UITextField alloc] init];
        _tfNumber.placeholder = @"请使用真实身份证号";
        _tfNumber.font = kFont13;
        _tfNumber.borderStyle = UITextBorderStyleNone;
        _tfNumber.keyboardType = UIKeyboardTypeNamePhonePad;
    }
    return _tfNumber;
}

- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = ColorLine;
    }
    return _vLine;
}

- (UILabel *)lblInfo
{
    if (!_lblInfo) {
        _lblInfo = [[UILabel alloc] init];
        _lblInfo.text = @"请输入支付人身份信息，不然会引起退单，无法完成申报。";
        _lblInfo.font = kFont12;
        _lblInfo.textColor = [UIColor colorWithHexString:@"666666"];
        _lblInfo.numberOfLines = 2;
    }
    return _lblInfo;
}



@end
