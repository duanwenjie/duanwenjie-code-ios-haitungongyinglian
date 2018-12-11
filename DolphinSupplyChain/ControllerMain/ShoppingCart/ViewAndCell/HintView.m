//
//  HintView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/27.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "HintView.h"

@interface HintView ()

@property (nonatomic, strong) UIView *vBack;

@property (nonatomic, strong) UILabel *lblHintTitle;

@property (nonatomic, strong) UIView *vHaiWai;

@property (nonatomic, strong) UIImageView *imgSelectHaiWai;

@property (nonatomic, strong) UILabel *lblTitleHaiWai;

@property (nonatomic, strong) UILabel *lblNumberHaiWai;

@property (nonatomic, strong) UIView *vGuoNie;

@property (nonatomic, strong) UIImageView *imgSelectGuoNie;

@property (nonatomic, strong) UILabel *lblTitleGuoNie;

@property (nonatomic, strong) UILabel *lblNumberGuoNie;

@property (nonatomic, strong) UIView *vLineOne;

@property (nonatomic, strong) UIView *vLineTwo;

@property (nonatomic, strong) UIButton *btnGoShoppingCart;

@property (nonatomic, strong) UIButton *btnGoAccount;

@property (nonatomic, assign) BOOL bHaiWaiOrGuoNie;

@end

@implementation HintView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bHaiWaiOrGuoNie = YES;
        [self addView];
        [self layoutView];
    }
    return self;
}


- (void)addView
{
    [self addSubview:self.vBack];
    [self.vBack addSubview:self.lblHintTitle];
    [self.vBack addSubview:self.vHaiWai];
    [self.vBack addSubview:self.vGuoNie];
    
    [self.vBack addSubview:self.vLineOne];
    [self.vBack addSubview:self.vLineTwo];
    
    [self.vBack addSubview:self.btnGoShoppingCart];
    [self.vBack addSubview:self.btnGoAccount];
    
    [self.vHaiWai addSubview:self.imgSelectHaiWai];
    [self.vHaiWai addSubview:self.lblTitleHaiWai];
    [self.vHaiWai addSubview:self.lblNumberHaiWai];
    
    [self.vGuoNie addSubview:self.imgSelectGuoNie];
    [self.vGuoNie addSubview:self.lblTitleGuoNie];
    [self.vGuoNie addSubview:self.lblNumberGuoNie];
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
    
    [self.vHaiWai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vBack);
        make.top.equalTo(self.lblHintTitle.mas_bottom);
        make.height.mas_equalTo(37);
    }];
    
    [self.imgSelectHaiWai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self.vHaiWai.mas_centerY);
        make.left.equalTo(self.vHaiWai.mas_left).offset(15);
    }];
    
    [self.lblTitleHaiWai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgSelectHaiWai.mas_right).offset(9);
        make.top.equalTo(self.vHaiWai.mas_top).offset(4);
        make.right.equalTo(self.vHaiWai.mas_right).offset(-7);
        make.height.mas_equalTo(15);
    }];
    
    [self.lblNumberHaiWai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgSelectHaiWai.mas_right).offset(9);
        make.right.equalTo(self.vHaiWai.mas_right).offset(-7);
        make.height.mas_equalTo(15);
        make.top.equalTo(self.lblTitleHaiWai.mas_bottom);
    }];
    
    [self.vGuoNie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vBack);
        make.top.equalTo(self.vHaiWai.mas_bottom).offset(10);
        make.height.mas_equalTo(37);
    }];
    
    [self.imgSelectGuoNie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self.vGuoNie.mas_centerY);
        make.left.equalTo(self.vGuoNie.mas_left).offset(15);
    }];
    
    [self.lblTitleGuoNie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgSelectGuoNie.mas_right).offset(9);
        make.top.equalTo(self.vGuoNie.mas_top).offset(4);
        make.right.equalTo(self.vGuoNie.mas_right).offset(-7);
        make.height.mas_equalTo(15);
    }];
    
    [self.lblNumberGuoNie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgSelectGuoNie.mas_right).offset(9);
        make.right.equalTo(self.vGuoNie.mas_right).offset(-7);
        make.height.mas_equalTo(15);
        make.top.equalTo(self.lblTitleGuoNie.mas_bottom);
    }];
    
    [self.vLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vBack);
        make.top.equalTo(self.vGuoNie.mas_bottom).offset(12);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.btnGoShoppingCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.vBack);
        make.top.equalTo(self.vLineOne.mas_bottom);
        make.right.equalTo(self.vLineTwo.mas_left);
        make.width.equalTo(self.btnGoAccount.mas_width);
    }];
    
    [self.vLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLineOne.mas_bottom);
        make.bottom.equalTo(self.vBack.mas_bottom);
        make.left.equalTo(self.btnGoShoppingCart.mas_right);
        make.width.mas_equalTo(0.5);
    }];
    
    [self.btnGoAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.vBack);
        make.top.equalTo(self.vLineOne.mas_bottom);
        make.left.equalTo(self.vLineTwo.mas_right);
        make.width.equalTo(self.btnGoShoppingCart.mas_width);
    }];
    
    
}


- (void)changeHaiWaiAndGuoNie:(NSInteger)iHaiWaiNumber :(NSInteger)iGuoNieNumber
{
    self.lblNumberHaiWai.text = [NSString stringWithFormat:@"%d件", iHaiWaiNumber];
    self.lblNumberGuoNie.text = [NSString stringWithFormat:@"%d件", iGuoNieNumber];
}




- (void)TapHaiWai
{
    if (self.bHaiWaiOrGuoNie) {
        return;
    }
    self.bHaiWaiOrGuoNie = YES;
    self.imgSelectHaiWai.image = [UIImage imageNamed:@"choose_selected"];
    self.imgSelectGuoNie.image = [UIImage imageNamed:@"choose_default"];
}

- (void)TapGuoNie
{
    if (!self.bHaiWaiOrGuoNie) {
        return;
    }
    self.bHaiWaiOrGuoNie = NO;
    self.imgSelectHaiWai.image = [UIImage imageNamed:@"choose_default"];
    self.imgSelectGuoNie.image = [UIImage imageNamed:@"choose_selected"];
}

- (void)TapGoShopping
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(TapGoShopping)]) {
        [self.delegate TapGoShopping];
    }
}

- (void)TapGoAccount
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(TapGoAccount:)]) {
        [self.delegate TapGoAccount:self.bHaiWaiOrGuoNie ? HT_HaiWai : HT_GuoNie];
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
        _lblHintTitle.text = @"请分开结算以下商品";
        _lblHintTitle.textAlignment = NSTextAlignmentCenter;
        _lblHintTitle.font = kFont16;
    }
    return _lblHintTitle;
}

- (UIView *)vHaiWai
{
    if (!_vHaiWai) {
        _vHaiWai = [[UIView alloc] init];
        
        UITapGestureRecognizer *tapHaiWai = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapHaiWai)];
        [_vHaiWai addGestureRecognizer:tapHaiWai];
    }
    return _vHaiWai;
}

- (UIImageView *)imgSelectHaiWai
{
    if (!_imgSelectHaiWai) {
        _imgSelectHaiWai = [[UIImageView alloc] init];
        _imgSelectHaiWai.image = [UIImage imageNamed:@"choose_selected"];
    }
    return _imgSelectHaiWai;
}

- (UILabel *)lblTitleHaiWai
{
    if (!_lblTitleHaiWai) {
        _lblTitleHaiWai = [[UILabel alloc] init];
        _lblTitleHaiWai.text = @"境外购";
        _lblTitleHaiWai.font = kFont12;
    }
    return _lblTitleHaiWai;
}

- (UILabel *)lblNumberHaiWai
{
    if (!_lblNumberHaiWai) {
        _lblNumberHaiWai = [[UILabel alloc] init];
        _lblNumberHaiWai.textColor = [UIColor colorWithHexString:@"999999"];
        _lblNumberHaiWai.font = kFont12;
        _lblNumberHaiWai.text = @"2件";
    }
    return _lblNumberHaiWai;
}

- (UIView *)vGuoNie
{
    if (!_vGuoNie) {
        _vGuoNie = [[UIView alloc] init];
        
        UITapGestureRecognizer *tapGuoNie = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGuoNie)];
        [_vGuoNie addGestureRecognizer:tapGuoNie];
    }
    return _vGuoNie;
}

- (UIImageView *)imgSelectGuoNie
{
    if (!_imgSelectGuoNie) {
        _imgSelectGuoNie = [[UIImageView alloc] init];
        _imgSelectGuoNie.image = [UIImage imageNamed:@"choose_default"];
    }
    return _imgSelectGuoNie;
}

- (UILabel *)lblTitleGuoNie
{
    if (!_lblTitleGuoNie) {
        _lblTitleGuoNie = [[UILabel alloc] init];
        _lblTitleGuoNie.text = @"一般贸易";
        _lblTitleGuoNie.font = kFont12;
    }
    return _lblTitleGuoNie;
}

- (UILabel *)lblNumberGuoNie
{
    if (!_lblNumberGuoNie) {
        _lblNumberGuoNie = [[UILabel alloc] init];
        _lblNumberGuoNie.textColor = [UIColor colorWithHexString:@"999999"];
        _lblNumberGuoNie.font = kFont12;
        _lblNumberGuoNie.text = @"2件";
    }
    return _lblNumberGuoNie;
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

- (UIButton *)btnGoShoppingCart
{
    if (!_btnGoShoppingCart) {
        _btnGoShoppingCart = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnGoShoppingCart setTitle:@"返回购物车" forState:UIControlStateNormal];
        _btnGoShoppingCart.titleLabel.font = kFont14;
        [_btnGoShoppingCart setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [_btnGoShoppingCart addTarget:self action:@selector(TapGoShopping) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnGoShoppingCart;
}


- (UIButton *)btnGoAccount
{
    if (!_btnGoAccount) {
        
        _btnGoAccount = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnGoAccount setTitle:@"去结算" forState:UIControlStateNormal];
        _btnGoAccount.titleLabel.font = kFont14;
        [_btnGoAccount setTitleColor:[UIColor colorWithHexString:@"0076ff"] forState:UIControlStateNormal];
        [_btnGoAccount addTarget:self action:@selector(TapGoAccount) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnGoAccount;
}


@end
