//
//  SearchScreenHeadView.m
//  DolphinSupplyChain
//
//  Created by zhengxuening on 2017/2/13.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "SearchScreenHeadView.h"
#import "ZXNTool.h"

@interface SearchScreenHeadView ()

// 人气
@property (nonatomic, strong) UIButton *btnPopularity;

@property (nonatomic, strong) UIView *vLineTwo;

// 销量
@property (nonatomic, strong) UIButton *btnSales;

@property (nonatomic, strong) UIView *vLineThree;

// 价格
@property (nonatomic, strong) UIView *vPrice;

@property (nonatomic, strong) UILabel *lblPriceyName;

@property (nonatomic, strong) UIImageView *imgPriceArrows;

@property (nonatomic, strong) UIView *vLineFour;

// 仅看有货
@property (nonatomic, strong) UIButton *btnScreen;

@property (nonatomic, strong) UIView *vLineFive;

@property (nonatomic, assign) BOOL bHighOrLow;

@end

@implementation SearchScreenHeadView

- (instancetype)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.bHighOrLow = NO;
        [self initView];
    }
    return self;
}


- (void)initView
{
    CGFloat fWidth = kDisWidth/4;
    
    [self addSubview:self.btnPopularity];
    
    [self addSubview:self.vLineTwo];
    
    [self addSubview:self.btnSales];
    
    [self addSubview:self.vLineThree];
    
    [self addSubview:self.vPrice];
    [self.vPrice addSubview:self.lblPriceyName];
    [self.vPrice addSubview:self.imgPriceArrows];
    
    [self addSubview:self.vLineFour];
    
    [self addSubview:self.btnScreen];
    
    [self addSubview:self.vLineFive];
    
    [self.btnPopularity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.width.mas_equalTo(fWidth);
        make.height.mas_equalTo(43);
        make.left.equalTo(self.mas_left);
    }];
    
    [self.vLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.vLineFive.mas_top).offset(-10);
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.btnPopularity.mas_right);
        make.width.mas_equalTo(1);
    }];
    
    [self.btnSales mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.width.mas_equalTo(fWidth);
        make.height.mas_equalTo(43);
        make.left.equalTo(self.btnPopularity.mas_right);
    }];
    
    [self.vLineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.vLineFive.mas_top).offset(-10);
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.btnSales.mas_right);
        make.width.mas_equalTo(1);
    }];
    
    [self.vPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.width.mas_equalTo(fWidth);
        make.height.mas_equalTo(43);
        make.left.equalTo(self.btnSales.mas_right);
    }];
    
    [self.lblPriceyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vPrice.mas_centerY);
        make.width.mas_equalTo(30);
        make.height.equalTo(self.vPrice.mas_height);
        make.centerX.equalTo(self.vPrice.mas_centerX).offset(-4);
    }];
    
    [self.imgPriceArrows mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.vPrice.mas_height);
        make.width.mas_equalTo(10);
        make.left.equalTo(self.lblPriceyName.mas_right).offset(4);
        make.top.equalTo(self.lblPriceyName.mas_top);
    }];
    
    [self.vLineFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.vLineFive.mas_top).offset(-10);
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.vPrice.mas_right);
        make.width.mas_equalTo(1);
    }];
    
    [self.btnScreen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.width.mas_equalTo(fWidth);
        make.height.mas_equalTo(43);
        make.left.equalTo(self.vPrice.mas_right);
    }];
    
    [self.vLineFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.mas_top).offset(43);
    }];
}



#pragma mark - 点击事件
- (void)selectPopularity:(UIButton *)btn
{
    if (btn.selected) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapPopularity)]) {
        btn.selected = YES;
        self.btnSales.selected = NO;
        self.lblPriceyName.textColor = [UIColor colorWithHexString:@"333333"];
        self.imgPriceArrows.image = [UIImage imageNamed:@"Buy_List_NO_Select"];
        [self.delegate tapPopularity];
    }
}

- (void)selectSales:(UIButton *)btn
{
    if (btn.selected) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapSales)]) {
        btn.selected = YES;
        self.btnPopularity.selected = NO;
        self.lblPriceyName.textColor = [UIColor colorWithHexString:@"333333"];
        self.imgPriceArrows.image = [UIImage imageNamed:@"Buy_List_NO_Select"];
        [self.delegate tapSales];
    }
}

- (void)tapPriceView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapPriceHightOrLow:)]) {
        self.btnPopularity.selected = NO;
        self.btnSales.selected = NO;
        self.lblPriceyName.textColor = [UIColor colorWithHexString:@"12a0ea"];
        if (self.bHighOrLow == NO) {
            [self.delegate tapPriceHightOrLow:@"Low"];
            self.imgPriceArrows.image = [UIImage imageNamed:@"Buy_List_Select_Up"];
        }
        else
        {
            [self.delegate tapPriceHightOrLow:@"Hight"];
            self.imgPriceArrows.image = [UIImage imageNamed:@"Buy_List_Select_Down"];
        }
        self.bHighOrLow = !self.bHighOrLow;
    }
}

- (void)selectScreen:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapScreen:)]) {
        [self.delegate tapScreen:btn.selected];
    }
}

- (UIButton *)btnPopularity
{
    if (!_btnPopularity) {
        _btnPopularity = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnPopularity setTitle:@"人气" forState:UIControlStateNormal];
        [_btnPopularity setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [_btnPopularity setTitleColor:[UIColor colorWithHexString:@"12a0ea"] forState:UIControlStateSelected];
        _btnPopularity.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnPopularity.titleLabel.textAlignment = NSTextAlignmentCenter;
        _btnPopularity.selected = NO;
        [_btnPopularity addTarget:self action:@selector(selectPopularity:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPopularity;
}

- (UIButton *)btnSales
{
    if (!_btnSales) {
        _btnSales = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSales setTitle:@"销量" forState:UIControlStateNormal];
        [_btnSales setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [_btnSales setTitleColor:[UIColor colorWithHexString:@"12a0ea"] forState:UIControlStateSelected];
        _btnSales.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnSales.titleLabel.textAlignment = NSTextAlignmentCenter;
        _btnSales.selected = NO;
        [_btnSales addTarget:self action:@selector(selectSales:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSales;
}

- (UIView *)vPrice
{
    if (!_vPrice) {
        _vPrice = [[UIView alloc] init];
        
        UITapGestureRecognizer *tapPriceView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPriceView)];
        [_vPrice addGestureRecognizer:tapPriceView];
    }
    return _vPrice;
}

- (UILabel *)lblPriceyName
{
    if (!_lblPriceyName) {
        _lblPriceyName = [[UILabel alloc] init];
        _lblPriceyName.textColor = [UIColor colorWithHexString:@"333333"];
        _lblPriceyName.textAlignment = NSTextAlignmentCenter;
        _lblPriceyName.font = [UIFont systemFontOfSize:14];
        _lblPriceyName.text = @"价格";
    }
    return _lblPriceyName;
}

- (UIImageView *)imgPriceArrows
{
    if (!_imgPriceArrows) {
        _imgPriceArrows = [[UIImageView alloc] init];
        _imgPriceArrows.contentMode = UIViewContentModeScaleAspectFit;
        _imgPriceArrows.image = [UIImage imageNamed:@"Buy_List_NO_Select"];
    }
    return _imgPriceArrows;
}

- (UIButton *)btnScreen
{
    if (!_btnScreen) {
        _btnScreen = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnScreen setTitle:@"仅看有货" forState:UIControlStateNormal];
        [_btnScreen setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [_btnScreen setTitleColor:[UIColor colorWithHexString:@"12a0ea"] forState:UIControlStateSelected];
        [_btnScreen setTitleColor:[UIColor colorWithHexString:@"12a0ea"] forState:UIControlStateHighlighted];
        _btnScreen.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnScreen.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btnScreen addTarget:self action:@selector(selectScreen:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnScreen;
}


- (UIView *)vLineTwo
{
    if (!_vLineTwo) {
        _vLineTwo = [[UIView alloc] init];
        _vLineTwo.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _vLineTwo;
}

- (UIView *)vLineThree
{
    if (!_vLineThree) {
        _vLineThree = [[UIView alloc] init];
        _vLineThree.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _vLineThree;
}

- (UIView *)vLineFour
{
    if (!_vLineFour) {
        _vLineFour = [[UIView alloc] init];
        _vLineFour.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _vLineFour;
}

- (UIView *)vLineFive
{
    if (!_vLineFive) {
        _vLineFive = [[UIView alloc] init];
        _vLineFive.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _vLineFive;
}



@end
