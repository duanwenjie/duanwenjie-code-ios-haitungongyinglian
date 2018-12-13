//
//  ShoppingCartFoot.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/8.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ShoppingCartFoot.h"

@interface ShoppingCartFoot ()

@property (nonatomic, strong) UIButton *btnSelectAll;

@property (nonatomic, strong) UILabel *lblSum;

@property (nonatomic, strong) UILabel *lblMoney;

@property (nonatomic, strong) UIButton *btnSettle;

@property (nonatomic, strong) UIButton *btnPurchase;

@property (nonatomic, strong) UIButton *btnDelete;

@end


@implementation ShoppingCartFoot

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self addSubview:self.btnSelectAll];
    [self addSubview:self.lblSum];
    [self addSubview:self.lblMoney];
    [self addSubview:self.btnSettle];
    
    if (![YKSUserDefaults isUserIndividual]) {
        [self addSubview:self.btnPurchase];
    }
    
    [self addSubview:self.btnDelete];
    
    [self.btnSelectAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(9);
        make.width.mas_equalTo(60);
    }];
    
    [self.lblSum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(35);
        make.right.equalTo(self.lblMoney.mas_left).offset(-4);
    }];
    
    [self.lblMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.lblSum.mas_right).offset(4);
        make.right.equalTo(self.btnSettle.mas_left).offset(-12);
    }];
    
    [self.btnSettle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.lblMoney.mas_right).offset(12);
        [YKSUserDefaults isUserIndividual] ? make.right.equalTo(self.mas_right) : make.right.equalTo(self.btnPurchase.mas_left).offset(-1);
        if (kDisWidth == 320 || kDisWidth == 375) {
            make.width.mas_equalTo(kDisWidth/4 - 15);
        }
        else
        {
            make.width.mas_equalTo(kDisWidth/4);
        }
    }];

    if (![YKSUserDefaults isUserIndividual]) {
        //非C端普通用户可以下采购单
        [self.btnPurchase mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.btnSettle.mas_right).offset(1);
            make.right.equalTo(self.mas_right).offset(0);
            if (kDisWidth == 320 || kDisWidth == 375) {
                make.width.mas_equalTo(kDisWidth/4 - 15);
            }
            else
            {
                make.width.mas_equalTo(kDisWidth/4);
            }
        }];
    }
    
    [self.btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.top.equalTo(self.mas_top).offset(8);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
}

#pragma mark - 按钮点击事件
- (void)tapSeletcAllButton:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapSelectAll:)]) {
        [self.delegate tapSelectAll:btn.selected];
    }
}


- (void)tapSettle
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapCartSettle)]) {
        [self.delegate tapCartSettle];
    }
}


- (void)tapPurchase
{

    if (self.delegate && [self.delegate respondsToSelector:@selector(tapCartPurchase)]) {
        [self.delegate tapCartPurchase];
    }
}

- (void)tapDelete
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapCartDelete)]) {
        [self.delegate tapCartDelete];
    }
}


#pragma mark - 界面数据处理
- (void)isSelectAll:(BOOL)bSelectAll
{
    self.btnSelectAll.selected = bSelectAll;
}

- (void)updateAllMoney:(NSString *)sMoney
{
    self.lblMoney.text = [NSString stringWithFormat:@"¥ %@", sMoney];
}

- (void)isComeDeletePattern:(BOOL)bDelete
{
    if (bDelete) {
        self.lblSum.hidden = YES;
        self.lblMoney.hidden = YES;
        self.btnSettle.hidden = YES;
        if (![YKSUserDefaults isUserIndividual]) {
            self.btnPurchase.hidden = YES;
        }
        
        self.btnDelete.hidden = NO;
    }
    else
    {
        self.lblSum.hidden = NO;
        self.lblMoney.hidden = NO;
        self.btnSettle.hidden = NO;
        if (![YKSUserDefaults isUserIndividual]) {
            self.btnPurchase.hidden = NO;
        }
        
        self.btnDelete.hidden = YES;
    }
}

#pragma mark - 懒加载
- (UIButton *)btnSelectAll
{
    if (!_btnSelectAll) {
        _btnSelectAll = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSelectAll setImage:[UIImage drawImageWithName:@"choose_default" size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
        [_btnSelectAll setImage:[UIImage drawImageWithName:@"choose_selected" size:CGSizeMake(20, 20)] forState:UIControlStateSelected];
        
        _btnSelectAll.selected = YES;
        [_btnSelectAll addTarget:self action:@selector(tapSeletcAllButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [_btnSelectAll setTitle:@"全选" forState:UIControlStateNormal];
        
        [_btnSelectAll setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [_btnSelectAll setImageEdgeInsets:UIEdgeInsetsMake(0.0, -10, 0.0, 0.0)];
        _btnSelectAll.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _btnSelectAll;
}

- (UILabel *)lblSum
{
    if (!_lblSum) {
        _lblSum = [[UILabel alloc] init];
        _lblSum.textColor = [UIColor colorWithHexString:@"333333"];
        _lblSum.text = @"合计:";
        _lblSum.font = [UIFont systemFontOfSize:14];
        _lblSum.textAlignment = NSTextAlignmentRight;
    }
    return _lblSum;
}

- (UILabel *)lblMoney
{
    if (!_lblMoney) {
        _lblMoney = [[UILabel alloc] init];
        _lblMoney.textColor = [UIColor colorWithHexString:@"ef2e23"];
        _lblMoney.textAlignment = NSTextAlignmentRight;
        _lblMoney.font = [UIFont systemFontOfSize:14];
    }
    return _lblMoney;
}

- (UIButton *)btnSettle
{
    if (!_btnSettle) {
        _btnSettle = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSettle setBackgroundColor:[UIColor colorWithHexString:@"1ea5eb"]];
        [_btnSettle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSettle setTitle:@"立即购买" forState:UIControlStateNormal];
        _btnSettle.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_btnSettle addTarget:self action:@selector(tapSettle) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSettle;
}

- (UIButton *)btnPurchase
{
    if (!_btnPurchase) {
        _btnPurchase = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnPurchase setBackgroundColor:[UIColor colorWithHexString:@"1ea5eb"]];
        [_btnPurchase setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnPurchase setTitle:@"立即采购" forState:UIControlStateNormal];
        _btnPurchase.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_btnPurchase addTarget:self action:@selector(tapPurchase) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnPurchase;
}


- (UIButton *)btnDelete
{
    if (!_btnDelete) {
        _btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnDelete.layer.cornerRadius = 4;
        _btnDelete.layer.borderColor = [UIColor colorWithHexString:@"ef2e23"].CGColor;
        _btnDelete.layer.borderWidth = 1;
        [_btnDelete setTitle:@"删除" forState:UIControlStateNormal];
        [_btnDelete setTitleColor:[UIColor colorWithHexString:@"ef2e23"] forState:UIControlStateNormal];
        [_btnDelete addTarget:self action:@selector(tapDelete) forControlEvents:UIControlEventTouchUpInside];
        _btnDelete.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnDelete.hidden = YES;
    }
    return _btnDelete;
}


@end
