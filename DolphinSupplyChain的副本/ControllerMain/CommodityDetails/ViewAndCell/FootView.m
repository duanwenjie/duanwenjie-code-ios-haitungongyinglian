//
//  FootView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/4.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "FootView.h"

@interface FootView ()

@property (nonatomic, strong) UIView *vLineUp;

/// ***** 客服View *****
@property (nonatomic, strong) UIView *vBackService;

@property (nonatomic, strong) UIImageView *imgService;

@property (nonatomic, strong) UILabel *lblService;

@property (nonatomic, strong) UIView *vLineService;

/// ***** 收藏View *****
@property (nonatomic, strong) UIView *vBackCollect;

@property (nonatomic, strong) UIImageView *imgCollect;

@property (nonatomic, strong) UILabel *lblCollect;

@property (nonatomic, strong) UIView *vLineCollect;

/// ***** 购物车View *****
@property (nonatomic, strong) UIView *vBackShoppingCart;

@property (nonatomic, strong) UIImageView *imgShoppingCart;

@property (nonatomic, strong) UILabel *lblShoppingCart;

@property (nonatomic, strong) UILabel *lblShoppingCartNumber;

/// ***** 加入购物车 *****
@property (nonatomic, strong) UIButton *btnComeInCart;

@property (nonatomic, assign) BOOL isCollect;

@property (nonatomic, assign) BOOL bHave;

@end

@implementation FootView

- (instancetype)initWithFootView;
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        [self initAddView];
        [self initLayoutView];
    }
    return self;
}

- (void)initAddView
{
    [self addSubview:self.vLineUp];
    
    [self addSubview:self.vBackService];
    [self.vBackService addSubview:self.imgService];
    [self.vBackService addSubview:self.lblService];
    [self.vBackService addSubview:self.vLineService];
    
    [self addSubview:self.vBackCollect];
    [self.vBackCollect addSubview:self.imgCollect];
    [self.vBackCollect addSubview:self.lblCollect];
    [self.vBackCollect addSubview:self.vLineCollect];
    
    [self addSubview:self.vBackShoppingCart];
    [self.vBackShoppingCart addSubview:self.imgShoppingCart];
    [self.vBackShoppingCart addSubview:self.lblShoppingCart];
    [self.vBackShoppingCart addSubview:self.lblShoppingCartNumber];
    
    [self addSubview:self.btnComeInCart];
}

- (void)initLayoutView
{
    CGFloat fW = (kDisWidth/2)/3;
    
    [self.vLineUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.vBackService mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self);
        make.width.mas_equalTo(fW);
        make.left.equalTo(self);
    }];
    
    [self.imgService mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerX.equalTo(self.vBackService.mas_centerX);
        make.centerY.equalTo(self.vBackService.mas_centerY).offset(-6);
    }];
    
    [self.lblService mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vBackService);
        make.top.equalTo(self.imgService.mas_bottom).offset(1);
        make.height.mas_equalTo(14);
    }];
    
    [self.vLineService mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self.vBackService);
        make.width.mas_equalTo(0.5);
    }];
    
    [self.vBackCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self);
        make.width.mas_equalTo(fW);
        make.left.equalTo(self.vBackService.mas_right);
    }];
    
    [self.imgCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerX.equalTo(self.vBackCollect.mas_centerX);
        make.centerY.equalTo(self.vBackCollect.mas_centerY).offset(-6);
    }];
    
    [self.lblCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vBackCollect);
        make.top.equalTo(self.imgCollect.mas_bottom).offset(1);
        make.height.mas_equalTo(14);
    }];
    
    [self.vLineCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self.vBackCollect);
        make.width.mas_equalTo(0.5);
    }];
    
    [self.vBackShoppingCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self);
        make.width.mas_equalTo(fW);
        make.left.equalTo(self.vBackCollect.mas_right);
    }];
    
    [self.imgShoppingCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerX.equalTo(self.vBackShoppingCart.mas_centerX);
        make.centerY.equalTo(self.vBackShoppingCart.mas_centerY).offset(-6);
    }];
    
    [self.lblShoppingCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vBackShoppingCart);
        make.top.equalTo(self.imgShoppingCart.mas_bottom).offset(1);
        make.height.mas_equalTo(14);
    }];
    
    [self.lblShoppingCartNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.vBackShoppingCart.mas_centerX).offset(10);
        make.top.equalTo(self.vBackShoppingCart.mas_top).offset(4);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    [self.btnComeInCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        make.left.equalTo(self.vBackShoppingCart.mas_right);
    }];
}

- (void)changeShoppingCartNumber:(NSString *)sNumber
{
    if (sNumber.length == 0 || [sNumber isEqualToString:@"0"]) {
        self.lblShoppingCartNumber.hidden = YES;
    }
    else
    {
        self.lblShoppingCartNumber.hidden = NO;
        self.lblShoppingCartNumber.text = sNumber;
    }
}

- (void)changeCollect:(BOOL)isCollect
{
    self.isCollect = isCollect;
    if (isCollect) {
        [self.imgCollect setImage:[UIImage imageNamed:@"Commodity_Collect_YES"]];
    }
    else
    {
        [self.imgCollect setImage:[UIImage imageNamed:@"Commodity_Collect_NO"]];
    }
}

- (void)changeAddShoppingCart:(BOOL)bHave
{
    self.bHave = bHave;
    if (bHave) {
        [self.btnComeInCart setTitle:@"加入购物车" forState:UIControlStateNormal];
    }
    else
    {
        [self.btnComeInCart setTitle:@"缺货登记" forState:UIControlStateNormal];
    }
}

#pragma mark - 点击客服
- (void)tapService
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchService)]) {
        [self.delegate touchService];
    }
}


#pragma mark - 点击收藏
- (void)tapCollect
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchCollect:)]) {
        [self.delegate touchCollect:!self.isCollect];
    }
}

#pragma mark - 点击购物车
- (void)tapShoppingCart
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchShoppingCart)]) {
        [self.delegate touchShoppingCart];
    }
}

#pragma mark - 点击加入购物车 或 缺货登记
- (void)ComeInCart
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchAddShoppingCart:)]) {
        [self.delegate touchAddShoppingCart:self.bHave];
    }
}


#pragma mark - 懒加载
- (UIView *)vLineUp
{
    if (!_vLineUp) {
        _vLineUp = [[UIView alloc] init];
        _vLineUp.backgroundColor = ColorLine;
    }
    return _vLineUp;
}

- (UIView *)vBackService
{
    if (!_vBackService) {
        _vBackService = [[UIView alloc] init];
        
        UITapGestureRecognizer *tapService = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapService)];
        [_vBackService addGestureRecognizer:tapService];
    }
    return _vBackService;
}

- (UIImageView *)imgService
{
    if (!_imgService) {
        _imgService = [[UIImageView alloc] init];
        _imgService.image = [UIImage imageNamed:@"Commodity_Service"];
        _imgService.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgService;
}

- (UILabel *)lblService
{
    if (!_lblService) {
        _lblService = [[UILabel alloc] init];
        _lblService.text = @"客服";
        _lblService.textColor = [UIColor colorWithHexString:@"666666"];
        _lblService.font = kFont12;
        _lblService.textAlignment = NSTextAlignmentCenter;
    }
    return _lblService;
}

- (UIView *)vLineService
{
    if (!_vLineService) {
        _vLineService = [[UIView alloc] init];
        _vLineService.backgroundColor = ColorLine;
    }
    return _vLineService;
}

- (UIView *)vBackCollect
{
    if (!_vBackCollect) {
        _vBackCollect = [[UIView alloc] init];
        
        UITapGestureRecognizer *tapCollect = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCollect)];
        [_vBackCollect addGestureRecognizer:tapCollect];
    }
    return _vBackCollect;
}

- (UIImageView *)imgCollect
{
    if (!_imgCollect) {
        _imgCollect = [[UIImageView alloc] init];
        _imgCollect.image = [UIImage imageNamed:@"Commodity_Collect_NO"];
        _imgCollect.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgCollect;
}

- (UILabel *)lblCollect
{
    if (!_lblCollect) {
        _lblCollect = [[UILabel alloc] init];
        _lblCollect.text = @"收藏";
        _lblCollect.textColor = [UIColor colorWithHexString:@"666666"];
        _lblCollect.font = kFont12;
        _lblCollect.textAlignment = NSTextAlignmentCenter;
    }
    return _lblCollect;
}

- (UIView *)vLineCollect
{
    if (!_vLineCollect) {
        _vLineCollect = [[UIView alloc] init];
        _vLineCollect.backgroundColor = ColorLine;
    }
    return _vLineCollect;
}

- (UIView *)vBackShoppingCart
{
    if (!_vBackShoppingCart) {
        _vBackShoppingCart = [[UIView alloc] init];
        
        UITapGestureRecognizer *tapShoppingCart = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShoppingCart)];
        [_vBackShoppingCart addGestureRecognizer:tapShoppingCart];
    }
    return _vBackShoppingCart;
}

- (UIImageView *)imgShoppingCart
{
    if (!_imgShoppingCart) {
        _imgShoppingCart = [[UIImageView alloc] init];
        _imgShoppingCart.image = [UIImage imageNamed:@"Commodity_Cart"];
        _imgShoppingCart.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgShoppingCart;
}

- (UILabel *)lblShoppingCart
{
    if (!_lblShoppingCart) {
        _lblShoppingCart = [[UILabel alloc] init];
        _lblShoppingCart.text = @"购物车";
        _lblShoppingCart.textColor = [UIColor colorWithHexString:@"666666"];
        _lblShoppingCart.font = kFont12;
        _lblShoppingCart.textAlignment = NSTextAlignmentCenter;
    }
    return _lblShoppingCart;
}

- (UILabel *)lblShoppingCartNumber
{
    if (!_lblShoppingCartNumber) {
        _lblShoppingCartNumber = [[UILabel alloc] init];
        _lblShoppingCartNumber.backgroundColor = [UIColor redColor];
        _lblShoppingCartNumber.layer.cornerRadius = 7;
        _lblShoppingCartNumber.hidden = YES;
        _lblShoppingCartNumber.font = [UIFont systemFontOfSize:9];
        _lblShoppingCartNumber.textColor = [UIColor whiteColor];
        _lblShoppingCartNumber.clipsToBounds = YES;
        _lblShoppingCartNumber.textAlignment = NSTextAlignmentCenter;
    }
    return _lblShoppingCartNumber;
}

- (UIButton *)btnComeInCart
{
    if (!_btnComeInCart) {
        _btnComeInCart = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnComeInCart.backgroundColor = ColorAPPTheme;
        [_btnComeInCart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnComeInCart.titleLabel.font = kFont14;
        [_btnComeInCart setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_btnComeInCart addTarget:self action:@selector(ComeInCart) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnComeInCart;
}


@end
