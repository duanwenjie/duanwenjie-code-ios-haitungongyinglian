//
//  OrderHandleFootView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/5/16.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "OrderHandleFootView.h"

@interface OrderHandleFootView ()

@property (nonatomic, strong) UIButton *btnOrderList;

@property (nonatomic, strong) UIButton *btnBackCart;

@end

@implementation OrderHandleFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        [self initView];
        [self addViewLayout];
    }
    return self;
}

- (void)initView
{
    [self addSubview:self.btnOrderList];
    [self addSubview:self.btnBackCart];
}

- (void)addViewLayout
{
    [self.btnOrderList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.centerX.equalTo(self.mas_centerX).offset(-55);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    [self.btnBackCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.centerX.equalTo(self.mas_centerX).offset(55);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
}

#pragma mark - 点击事件
- (void)backOrderList
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapGoOrderList)]) {
        [self.delegate tapGoOrderList];
    }
}

- (void)backCart
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapGoShopingCart)]) {
        [self.delegate tapGoShopingCart];
    }
}

#pragma mark - 懒加载
- (UIButton *)btnOrderList
{
    if (!_btnOrderList) {
        _btnOrderList = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnOrderList setTitle:@"订单列表" forState:UIControlStateNormal];
        _btnOrderList.layer.borderColor = [UIColor colorWithHexString:@"9c9c9c"].CGColor;
        _btnOrderList.layer.borderWidth = 0.5;
        _btnOrderList.layer.cornerRadius = 5;
        _btnOrderList.clipsToBounds = YES;
        [_btnOrderList setBackgroundColor:[UIColor whiteColor]];
        [_btnOrderList setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [_btnOrderList addTarget:self action:@selector(backOrderList) forControlEvents:UIControlEventTouchUpInside];
        _btnOrderList.titleLabel.font = kFont13;
    }
    return _btnOrderList;
}

- (UIButton *)btnBackCart
{
    if (!_btnBackCart) {
        _btnBackCart = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnBackCart setTitle:@"返回购物车" forState:UIControlStateNormal];
        _btnBackCart.layer.borderColor = [UIColor colorWithHexString:@"9c9c9c"].CGColor;
        _btnBackCart.layer.borderWidth = 0.5;
        _btnBackCart.layer.cornerRadius = 5;
        _btnBackCart.clipsToBounds = YES;
        [_btnBackCart setBackgroundColor:[UIColor whiteColor]];
        [_btnBackCart setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [_btnBackCart addTarget:self action:@selector(backCart) forControlEvents:UIControlEventTouchUpInside];
        _btnBackCart.titleLabel.font = kFont13;
    }
    return _btnBackCart;
}

@end
