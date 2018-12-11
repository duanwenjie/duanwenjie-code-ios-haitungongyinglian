//
//  FooterView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/5/16.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "FooterView.h"
#import "ZXNTool.h"
@interface FooterView ()

@property (nonatomic, strong) UILabel *lblMoney;

@property (nonatomic, strong) UIButton *btnGoPay;

@property (nonatomic, strong) UILabel *lblMoneyTitle;

@property (nonatomic, assign) NSInteger iSection;

@end

@implementation FooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self initView];
        [self addViewLayout];
    }
    return self;
}

- (void)initView
{
    [self.contentView addSubview:self.lblMoneyTitle];
    [self.contentView addSubview:self.lblMoney];
    [self.contentView addSubview:self.btnGoPay];
}

- (void)addViewLayout
{
    [self.lblMoneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.bottom.top.equalTo(self.contentView);
    }];
    
    [self.lblMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblMoneyTitle.mas_right);
        make.bottom.top.equalTo(self.contentView);
    }];
    
    [self.btnGoPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.contentView.mas_top).offset(8);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-8);
        make.width.mas_equalTo(55);
    }];
}

- (void)loadData:(NSString *)sMoney Section:(NSInteger)iSection isPay:(BOOL)bIsPay
{
    self.iSection = iSection;
    self.lblMoney.attributedText = [ZXNTool addMoneySignal:sMoney font:11];
    if (bIsPay) {
        [self changeButtonPay];
    }
}

- (void)changeButtonPay
{
    self.btnGoPay.selected = YES;
    self.btnGoPay.userInteractionEnabled = NO;
    [self.btnGoPay setBackgroundColor:[UIColor whiteColor]];
}

- (void)selectGoPay:(UIButton *)btn
{
    if (!btn.selected) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(tapGoPay:)]) {
            [self.delegate tapGoPay:self.iSection];
        }
    }
}

#pragma mark - 懒加载
- (UILabel *)lblMoneyTitle
{
    if (!_lblMoneyTitle) {
        _lblMoneyTitle = [[UILabel alloc] init];
        _lblMoneyTitle.text = @"合计：";
        _lblMoneyTitle.textColor = [UIColor colorWithHexString:@"333333"];
        _lblMoneyTitle.font = kFont13;
    }
    return _lblMoneyTitle;
}

- (UILabel *)lblMoney
{
    if (!_lblMoney) {
        _lblMoney = [[UILabel alloc] init];
        _lblMoney.textColor = [UIColor colorWithHexString:@"333333"];
        _lblMoney.font = kFont13;
    }
    return _lblMoney;
}

- (UIButton *)btnGoPay
{
    if (!_btnGoPay) {
        _btnGoPay = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnGoPay setTitle:@"去支付" forState:UIControlStateNormal];
        [_btnGoPay setBackgroundColor:ColorAPPTheme];
        _btnGoPay.layer.cornerRadius = 3;
        _btnGoPay.clipsToBounds = YES;
        [_btnGoPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnGoPay.titleLabel.font = kFont12;
        
        [_btnGoPay setTitle:@"已支付" forState:UIControlStateSelected];
        [_btnGoPay setTitleColor:[UIColor colorWithHexString:@"ef2e23"] forState:UIControlStateSelected];
        
        [_btnGoPay addTarget:self action:@selector(selectGoPay:) forControlEvents:UIControlEventTouchUpInside];
        
        _btnGoPay.selected = NO;
    }
    return _btnGoPay;
}

@end
