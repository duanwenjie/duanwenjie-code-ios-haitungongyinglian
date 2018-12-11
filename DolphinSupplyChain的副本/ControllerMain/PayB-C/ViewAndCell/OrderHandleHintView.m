//
//  OrderHandleHintView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/5/17.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "OrderHandleHintView.h"

@interface OrderHandleHintView ()

@property (nonatomic, strong) UIView *vBack;

@property (nonatomic, strong) UILabel *lblHintTitle;

@property (nonatomic, strong) UIView *vZhiFuBao;

@property (nonatomic, strong) UIImageView *imgZhiFuBao;

@property (nonatomic, strong) UIImageView *imgSelectZhiFuBao;

@property (nonatomic, strong) UILabel *lblTitleZhiFuBao;

@property (nonatomic, strong) UILabel *lblNumberZhiFuBao;

@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UIView *vWeiXin;

@property (nonatomic, strong) UIImageView *imgWeiXin;

@property (nonatomic, strong) UIImageView *imgSelectWeiXin;

@property (nonatomic, strong) UILabel *lblTitleWeiXin;

@property (nonatomic, strong) UILabel *lblNumberWeiXin;

@property (nonatomic, strong) UIView *vLineOne;

@property (nonatomic, strong) UIView *vLineTwo;

@property (nonatomic, strong) UIButton *btnGoPay;

@property (nonatomic, strong) UIButton *btnCancel;

@property (nonatomic, assign) BOOL bZFBOrWX;

@end

@implementation OrderHandleHintView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bZFBOrWX = YES;
        [self addView];
        [self layoutView];
    }
    return self;
}


- (void)addView
{
    [self addSubview:self.vBack];
    [self.vBack addSubview:self.lblHintTitle];
    [self.vBack addSubview:self.vZhiFuBao];
    [self.vBack addSubview:self.vWeiXin];
    
    [self.vBack addSubview:self.vLine];
    [self.vBack addSubview:self.vLineOne];
    [self.vBack addSubview:self.vLineTwo];
    
    [self.vBack addSubview:self.btnCancel];
    [self.vBack addSubview:self.btnGoPay];
    
    [self.vZhiFuBao addSubview:self.imgZhiFuBao];
    [self.vZhiFuBao addSubview:self.imgSelectZhiFuBao];
    [self.vZhiFuBao addSubview:self.lblTitleZhiFuBao];
    [self.vZhiFuBao addSubview:self.lblNumberZhiFuBao];
    
    [self.vWeiXin addSubview:self.imgWeiXin];
    [self.vWeiXin addSubview:self.imgSelectWeiXin];
    [self.vWeiXin addSubview:self.lblTitleWeiXin];
    [self.vWeiXin addSubview:self.lblNumberWeiXin];
}

- (void)layoutView
{
    [self.vBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(190);
        make.width.mas_equalTo(270);
    }];
    
    [self.lblHintTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.vBack);
        make.height.mas_equalTo(56);
    }];
    
    [self.vZhiFuBao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vBack);
        make.top.equalTo(self.lblHintTitle.mas_bottom);
        make.height.mas_equalTo(37);
    }];
    
    [self.imgZhiFuBao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.centerY.equalTo(self.vZhiFuBao.mas_centerY);
        make.left.equalTo(self.vZhiFuBao.mas_left).offset(15);
    }];
    
    [self.lblTitleZhiFuBao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgZhiFuBao.mas_right).offset(9);
        make.top.equalTo(self.vZhiFuBao.mas_top).offset(4);
        make.right.equalTo(self.imgSelectZhiFuBao.mas_left).offset(-9);
        make.height.mas_equalTo(15);
    }];
    
    [self.lblNumberZhiFuBao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgZhiFuBao.mas_right).offset(9);
        make.right.equalTo(self.imgSelectZhiFuBao.mas_left).offset(-9);
        make.height.mas_equalTo(15);
        make.top.equalTo(self.lblTitleZhiFuBao.mas_bottom);
    }];
    
    [self.imgSelectZhiFuBao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self.vZhiFuBao.mas_centerY);
        make.right.equalTo(self.vZhiFuBao.mas_right).offset(-15);
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgZhiFuBao.mas_left);
        make.right.equalTo(self.imgSelectZhiFuBao.mas_right);
        make.top.equalTo(self.vZhiFuBao.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    
    [self.vWeiXin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vBack);
        make.top.equalTo(self.vZhiFuBao.mas_bottom).offset(10);
        make.height.mas_equalTo(37);
    }];
    
    [self.imgWeiXin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.centerY.equalTo(self.vWeiXin.mas_centerY);
        make.left.equalTo(self.vWeiXin.mas_left).offset(15);
    }];
    
    [self.lblTitleWeiXin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgWeiXin.mas_right).offset(9);
        make.top.equalTo(self.vWeiXin.mas_top).offset(4);
        make.right.equalTo(self.imgSelectWeiXin.mas_left).offset(-9);
        make.height.mas_equalTo(15);
    }];
    
    [self.lblNumberWeiXin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgWeiXin.mas_right).offset(9);
        make.right.equalTo(self.imgSelectWeiXin.mas_left).offset(-9);
        make.height.mas_equalTo(15);
        make.top.equalTo(self.lblTitleWeiXin.mas_bottom);
    }];
    
    [self.imgSelectWeiXin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self.vWeiXin.mas_centerY);
        make.right.equalTo(self.vWeiXin.mas_right).offset(-15);
    }];
    
    [self.vLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vBack);
        make.top.equalTo(self.vWeiXin.mas_bottom).offset(12);
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
    
    
}


- (void)TapZhiFuBao
{
    if (self.bZFBOrWX) {
        return;
    }
    self.bZFBOrWX = YES;
    self.imgSelectZhiFuBao.image = [UIImage imageNamed:@"choose_selected"];
    self.imgSelectWeiXin.image = [UIImage imageNamed:@"choose_default"];
}

- (void)TapWeiXin
{
    if (!self.bZFBOrWX) {
        return;
    }
    self.bZFBOrWX = NO;
    self.imgSelectZhiFuBao.image = [UIImage imageNamed:@"choose_default"];
    self.imgSelectWeiXin.image = [UIImage imageNamed:@"choose_selected"];
}

- (void)TapCancel
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancel)]) {
        [self.delegate cancel];
    }
}

- (void)TapGoPay
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectorGoPay:)]) {
        [self.delegate selectorGoPay:self.bZFBOrWX ? HT_ZhiFuBao : HT_WeiXin];
    }
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
        _lblHintTitle.text = @"请选择支付方式";
        _lblHintTitle.textAlignment = NSTextAlignmentCenter;
        _lblHintTitle.font = kFont16;
    }
    return _lblHintTitle;
}

- (UIView *)vZhiFuBao
{
    if (!_vZhiFuBao) {
        _vZhiFuBao = [[UIView alloc] init];
        
        UITapGestureRecognizer *tapZFB = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapZhiFuBao)];
        [_vZhiFuBao addGestureRecognizer:tapZFB];
    }
    return _vZhiFuBao;
}

- (UIImageView *)imgZhiFuBao
{
    if (!_imgZhiFuBao) {
        _imgZhiFuBao = [[UIImageView alloc] init];
        _imgZhiFuBao.image = [UIImage imageNamed:@"alipay"];
    }
    return _imgZhiFuBao;
}

- (UIImageView *)imgSelectZhiFuBao
{
    if (!_imgSelectZhiFuBao) {
        _imgSelectZhiFuBao = [[UIImageView alloc] init];
        _imgSelectZhiFuBao.image = [UIImage imageNamed:@"choose_selected"];
    }
    return _imgSelectZhiFuBao;
}

- (UILabel *)lblTitleZhiFuBao
{
    if (!_lblTitleZhiFuBao) {
        _lblTitleZhiFuBao = [[UILabel alloc] init];
        _lblTitleZhiFuBao.text = @"支付宝";
        _lblTitleZhiFuBao.font = kFont12;
    }
    return _lblTitleZhiFuBao;
}

- (UILabel *)lblNumberZhiFuBao
{
    if (!_lblNumberZhiFuBao) {
        _lblNumberZhiFuBao = [[UILabel alloc] init];
        _lblNumberZhiFuBao.textColor = [UIColor colorWithHexString:@"999999"];
        _lblNumberZhiFuBao.font = kFont11;
        _lblNumberZhiFuBao.text = @"数亿用户都在用，安全可托付";
    }
    return _lblNumberZhiFuBao;
}

- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = ColorLine;
    }
    return _vLine;
}

- (UIView *)vWeiXin
{
    if (!_vWeiXin) {
        _vWeiXin = [[UIView alloc] init];
        
        UITapGestureRecognizer *tapWX = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapWeiXin)];
        [_vWeiXin addGestureRecognizer:tapWX];
    }
    return _vWeiXin;
}

- (UIImageView *)imgWeiXin
{
    if (!_imgWeiXin) {
        _imgWeiXin = [[UIImageView alloc] init];
        _imgWeiXin.image = [UIImage imageNamed:@"wei_xin_pay"];
    }
    return _imgWeiXin;
}

- (UIImageView *)imgSelectWeiXin
{
    if (!_imgSelectWeiXin) {
        _imgSelectWeiXin = [[UIImageView alloc] init];
        _imgSelectWeiXin.image = [UIImage imageNamed:@"choose_default"];
    }
    return _imgSelectWeiXin;
}

- (UILabel *)lblTitleWeiXin
{
    if (!_lblTitleWeiXin) {
        _lblTitleWeiXin = [[UILabel alloc] init];
        _lblTitleWeiXin.text = @"微信支付";
        _lblTitleWeiXin.font = kFont12;
    }
    return _lblTitleWeiXin;
}

- (UILabel *)lblNumberWeiXin
{
    if (!_lblNumberWeiXin) {
        _lblNumberWeiXin = [[UILabel alloc] init];
        _lblNumberWeiXin.textColor = [UIColor colorWithHexString:@"999999"];
        _lblNumberWeiXin.font = kFont11;
        _lblNumberWeiXin.text = @"亿万用户的选择，更快更安全";
    }
    return _lblNumberWeiXin;
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
