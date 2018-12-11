//
//  PersonalHintView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/5/18.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "OrderListHintView.h"

@interface OrderListHintView ()

@property (nonatomic, strong) UIView *vBack;

@property (nonatomic, strong) UILabel *lblHintTitle;



@property (nonatomic, strong) UIView *vName;

@property (nonatomic, strong) UILabel *lblName;

@property (nonatomic, strong) UITextField *tfName;

@property (nonatomic, strong) UIView *vLine1;

@property (nonatomic, strong) UIView *vNumber;

@property (nonatomic, strong) UILabel *lblNumber;

@property (nonatomic, strong) UITextField *tfNumber;

@property (nonatomic, strong) UIView *vLine2;


@property (nonatomic, strong) UILabel *lblTitleHint;

@property (nonatomic, strong) UIButton *btnSelector;

@property (nonatomic, strong) UIButton *btnReportDelegate;


@property (nonatomic, strong) UIView *vLineOne;

@property (nonatomic, strong) UIView *vLineTwo;

@property (nonatomic, strong) UIButton *btnGoPay;

@property (nonatomic, strong) UIButton *btnCancel;

@end

@implementation OrderListHintView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addView];
        [self layoutView];
    }
    return self;
}


- (void)addView
{
    [self addSubview:self.vBack];
    [self.vBack addSubview:self.lblHintTitle];
    [self.vBack addSubview:self.vName];
    [self.vBack addSubview:self.vNumber];
    
    [self.vBack addSubview:self.vLine1];
    [self.vBack addSubview:self.vLine2];
    [self.vBack addSubview:self.lblTitleHint];
    [self.vBack addSubview:self.btnSelector];
    [self.vBack addSubview:self.btnReportDelegate];
    [self.vBack addSubview:self.vLineOne];
    [self.vBack addSubview:self.vLineTwo];
    
    [self.vBack addSubview:self.btnCancel];
    [self.vBack addSubview:self.btnGoPay];
    
    [self.vName addSubview:self.lblName];
    [self.vName addSubview:self.tfName];
    
    [self.vNumber addSubview:self.lblNumber];
    [self.vNumber addSubview:self.tfNumber];
}

- (void)layoutView
{
    [self.vBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(232.5);
        make.width.mas_equalTo(270);
    }];
    
    [self.lblHintTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.vBack);
        make.height.mas_equalTo(56);
    }];
    
    [self.vName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vBack);
        make.top.equalTo(self.lblHintTitle.mas_bottom);
        make.height.mas_equalTo(25);
    }];
    
    [self.lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vName.mas_left).offset(15);
        make.top.equalTo(self.vName.mas_top);
        make.right.equalTo(self.tfName.mas_left).offset(-9);
        make.bottom.equalTo(self.vName.mas_bottom);
        make.width.mas_equalTo(65);
    }];
    
    [self.tfName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblName.mas_right).offset(9);
        make.right.equalTo(self.vName.mas_right).offset(-15);
        make.bottom.equalTo(self.vName.mas_bottom);
        make.top.equalTo(self.vName.mas_top);
    }];
    
    [self.vLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblName.mas_left);
        make.right.equalTo(self.tfName.mas_right);
        make.top.equalTo(self.vName.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    
    [self.vNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vBack);
        make.top.equalTo(self.vName.mas_bottom).offset(5);
        make.height.mas_equalTo(25);
    }];
    
    [self.lblNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vNumber.mas_left).offset(15);
        make.top.equalTo(self.vNumber.mas_top);
        make.right.equalTo(self.tfNumber.mas_left).offset(-9);
        make.bottom.equalTo(self.vNumber.mas_bottom);
        make.width.mas_equalTo(65);
    }];
    
    [self.tfNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblNumber.mas_right).offset(9);
        make.right.equalTo(self.vNumber.mas_right).offset(-15);
        make.bottom.equalTo(self.vNumber.mas_bottom);
        make.top.equalTo(self.vNumber.mas_top);
    }];
    
    [self.vLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblNumber.mas_left);
        make.right.equalTo(self.tfNumber.mas_right);
        make.top.equalTo(self.vNumber.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.lblTitleHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBack.mas_left).offset(15);
        make.right.equalTo(self.vBack.mas_right).offset(-15);
        make.top.equalTo(self.vNumber.mas_bottom).offset(5);
        make.height.mas_equalTo(30);
    }];
    
    [self.btnSelector mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBack.mas_left).offset(5);
        make.top.equalTo(self.lblTitleHint.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.btnReportDelegate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnSelector.mas_right);
        make.top.equalTo(self.btnSelector.mas_top);
        make.bottom.equalTo(self.btnSelector.mas_bottom);
    }];
    
    [self.vLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vBack);
        make.top.equalTo(self.btnSelector.mas_bottom).offset(4);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.vBack);
        make.top.equalTo(self.vLineOne.mas_bottom);
        make.right.equalTo(self.vLineTwo.mas_left);
        make.width.equalTo(self.btnGoPay.mas_width);
    }];
    
    [self.vLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLineOne.mas_bottom);
        make.bottom.equalTo(self.vBack.mas_bottom);
        make.left.equalTo(self.btnCancel.mas_right);
        make.width.mas_equalTo(0.5);
    }];
    
    [self.btnGoPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.vBack);
        make.top.equalTo(self.vLineOne.mas_bottom);
        make.left.equalTo(self.vLineTwo.mas_right);
        make.width.equalTo(self.btnCancel.mas_width);
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


- (OrderListHintENUM)isPayerVerificationPassed
{
    BOOL a = [VerificationString Verify_Chinese:self.tfName.text];
    BOOL b = [VerificationString Verify_Identity:self.tfNumber.text];
    BOOL c = self.btnSelector.selected;
    
    if (!a) {
        [self makeToast:@"支付人姓名必填，且只能是中文" duration:1.0 position:CSToastPositionCenter];
        return HT_Name_NO;
    }
    if (!b) {
        [self makeToast:@"身份证号码必填，且必须是正确的" duration:1.0 position:CSToastPositionCenter];
        return HT_Number_NO;
    }
    if (!c) {
        [self makeToast:@"申报委托必须勾选" duration:1.0 position:CSToastPositionCenter];
        return HT_Report_NO;
    }
    
    [self updatePayerInfo];
    return HT_Pass;
}


- (void)updatePayerInfo
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:self.tfName.text forKey:@"YKS_Payer_Name"];
    [user setValue:self.tfNumber.text forKey:@"YKS_Payer_Number"];
    [user synchronize];
}

- (void)TapCancel
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancel)]) {
        [self.delegate cancel];
    }
}

- (void)TapGoPay
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectorGoPay)]) {
        [self.delegate selectorGoPay];
    }
}

- (void)buttonReportDelegate
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectorReportDelegate)]) {
        [self endEditing:YES];
        [self.delegate selectorReportDelegate];
    }
}

- (void)buttonCheck:(UIButton *)btn
{
    btn.selected = !btn.selected;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
}

#pragma mark - 懒加载
- (UIView *)vBack
{
    if (!_vBack) {
        _vBack = [[UIView alloc] init];
        _vBack.backgroundColor = [UIColor whiteColor];
        _vBack.layer.cornerRadius = 7;
        _vBack.clipsToBounds = YES;
    }
    return _vBack;
}

- (UILabel *)lblHintTitle
{
    if (!_lblHintTitle) {
        _lblHintTitle = [[UILabel alloc] init];
        _lblHintTitle.text = @"支付人信息";
        _lblHintTitle.textAlignment = NSTextAlignmentCenter;
        _lblHintTitle.font = kFont16;
    }
    return _lblHintTitle;
}

- (UIView *)vName
{
    if (!_vName) {
        _vName = [[UIView alloc] init];
    }
    return _vName;
}

- (UILabel *)lblName
{
    if (!_lblName) {
        _lblName = [[UILabel alloc] init];
        _lblName.text = @"支付人姓名";
        _lblName.font = kFont12;
    }
    return _lblName;
}

- (UITextField *)tfName
{
    if (!_tfName) {
        _tfName = [[UITextField alloc] init];
        _tfName.placeholder = @"请使用真实姓名";
        _tfName.font = kFont12;
        _tfName.borderStyle = UITextBorderStyleNone;
        _tfName.keyboardType = UIKeyboardTypeDefault;
    }
    return _tfName;
}

- (UIView *)vLine1
{
    if (!_vLine1) {
        _vLine1 = [[UIView alloc] init];
        _vLine1.backgroundColor = ColorLine;
    }
    return _vLine1;
}

- (UIView *)vNumber
{
    if (!_vNumber) {
        _vNumber = [[UIView alloc] init];
    }
    return _vNumber;
}

- (UILabel *)lblNumber
{
    if (!_lblNumber) {
        _lblNumber = [[UILabel alloc] init];
        _lblNumber.text = @"身份证号码";
        _lblNumber.font = kFont12;
    }
    return _lblNumber;
}

- (UITextField *)tfNumber
{
    if (!_tfNumber) {
        _tfNumber = [[UITextField alloc] init];
        _tfNumber.placeholder = @"请使用真实身份证号";
        _tfNumber.font = kFont12;
        _tfNumber.borderStyle = UITextBorderStyleNone;
        _tfNumber.keyboardType = UIKeyboardTypeNamePhonePad;
    }
    return _tfNumber;
}

- (UIView *)vLine2
{
    if (!_vLine2) {
        _vLine2 = [[UIView alloc] init];
        _vLine2.backgroundColor = ColorLine;
    }
    return _vLine2;
}

- (UILabel *)lblTitleHint
{
    if (!_lblTitleHint) {
        _lblTitleHint = [[UILabel alloc] init];
        _lblTitleHint.text = @"请输入支付人身份信息，不然会引起退单，无法完成申报。";
        _lblTitleHint.font = kFont12;
        _lblTitleHint.textColor = [UIColor colorWithHexString:@"666666"];
        _lblTitleHint.numberOfLines = 2;
    }
    return _lblTitleHint;
}


- (UIButton *)btnSelector
{
    if (!_btnSelector) {
        _btnSelector = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSelector setImage:[UIImage drawImageWithName:@"choose_default" size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
        [_btnSelector setImage:[UIImage drawImageWithName:@"choose_selected" size:CGSizeMake(20, 20)] forState:UIControlStateSelected];
        [_btnSelector addTarget:self action:@selector(buttonCheck:) forControlEvents:UIControlEventTouchUpInside];
        _btnSelector.selected = NO;
    }
    return _btnSelector;
}

- (UIButton *)btnReportDelegate
{
    if (!_btnReportDelegate) {
        _btnReportDelegate = [UIButton buttonWithType:UIButtonTypeCustom];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"本人同意并接受以下申报委托"];
        
        [str addAttribute:NSForegroundColorAttributeName
                    value:ColorAPPTheme
                    range:NSMakeRange(9,4)];
        
        [_btnReportDelegate setAttributedTitle:str forState:UIControlStateNormal];
        [_btnReportDelegate addTarget:self action:@selector(buttonReportDelegate) forControlEvents:UIControlEventTouchUpInside];
        _btnReportDelegate.titleLabel.font = kFont12;
        _btnReportDelegate.titleLabel.numberOfLines = 0;
    }
    return _btnReportDelegate;
}



- (UIView *)vLineOne
{
    if (!_vLineOne) {
        _vLineOne = [[UIView alloc] init];
        _vLineOne.backgroundColor = ColorLine;
    }
    return _vLineOne;
}

- (UIView *)vLineTwo
{
    if (!_vLineTwo) {
        _vLineTwo = [[UIView alloc] init];
        _vLineTwo.backgroundColor = ColorLine;
    }
    return _vLineTwo;
}

- (UIButton *)btnCancel
{
    if (!_btnCancel) {
        _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        _btnCancel.titleLabel.font = kFont14;
        [_btnCancel setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [_btnCancel addTarget:self action:@selector(TapCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCancel;
}


- (UIButton *)btnGoPay
{
    if (!_btnGoPay) {
        
        _btnGoPay = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnGoPay setTitle:@"去支付" forState:UIControlStateNormal];
        _btnGoPay.titleLabel.font = kFont14;
        [_btnGoPay setTitleColor:[UIColor colorWithHexString:@"0076ff"] forState:UIControlStateNormal];
        [_btnGoPay addTarget:self action:@selector(TapGoPay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnGoPay;
}

@end

