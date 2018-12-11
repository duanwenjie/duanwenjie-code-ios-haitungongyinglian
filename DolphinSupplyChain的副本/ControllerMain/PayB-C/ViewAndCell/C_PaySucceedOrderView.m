//
//  C_PaySucceedOrderView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/2.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "C_PaySucceedOrderView.h"
#import "ZXNTool.h"

@interface C_PaySucceedOrderView ()

@property (nonatomic, assign) BOOL bDisperseOrder;

@property (nonatomic, copy) NSMutableArray *arrOrderNumber;

@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UIButton *btnOrderNumber;

@property (nonatomic, strong) UIButton *btnGoHome;

@property (nonatomic, strong) UILabel *lblHint;

@end

@implementation C_PaySucceedOrderView

- (instancetype)initWithNODisperseOrder:(BOOL)bDisperseOrder OrderNumberList:(NSMutableArray *)arrOrderNumber
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.bDisperseOrder = bDisperseOrder;
        self.arrOrderNumber = arrOrderNumber;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (instancetype)initWithServePayQueryFails
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initServePayFailurView];
    }
    return self;
}


- (void)initView
{
    [self addSubview:self.vLine];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    if (self.bDisperseOrder) {
        [self addSubview:self.btnOrderNumber];
        [self addSubview:self.btnGoHome];
        
        [self.btnOrderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(-60);
            make.size.mas_equalTo(CGSizeMake(85, 30));
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [self.btnGoHome mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(60);
            make.size.mas_equalTo(CGSizeMake(85, 30));
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    else
    {
        CGFloat fW = (kDisWidth - 255)/4;
        [self.arrOrderNumber enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btnOrder = [UIButton buttonWithType:UIButtonTypeCustom];
            btnOrder.frame = CGRectMake(fW + (idx%3 * (85 + fW)), 30 + (idx/3 * (30 + 10)), 85, 30);
            btnOrder.titleLabel.font = kFont13;
            btnOrder.layer.cornerRadius = 4;
            btnOrder.layer.borderColor = [UIColor colorWithHexString:@"666666"].CGColor;
            btnOrder.layer.borderWidth = 0.5;
            [btnOrder addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
            [btnOrder setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btnOrder.tag = idx;
            if ((idx + 1) == self.arrOrderNumber.count) {
                [btnOrder setTitle:@"回首页" forState:UIControlStateNormal];
            }
            else
            {
                [btnOrder setTitle:[NSString stringWithFormat:@"子订单%zu详情", (idx + 1)] forState:UIControlStateNormal];
            }
            
            [self addSubview:btnOrder];
        }];
        
        NSString *sT = @"尊敬的客户，由于您商品不在同一库房，您的订单被系统拆分为多个子订单分开配送，所产生的额外运费由海豚供应链承担，给您带来的不便请谅解。";
        CGSize size = [ZXNTool gainTextSize:kFont12 text:sT Width:kDisWidth - 30];
        
        [self addSubview:self.lblHint];
        self.lblHint.frame = CGRectMake(15, 40 + (((self.arrOrderNumber.count - 1)/3 + 1) * (30 + 10)), kDisWidth - 30, size.height + 10);
        
    }
}

- (void)initServePayFailurView
{
    [self addSubview:self.vLine];
    [self addSubview:self.btnGoHome];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    [self.btnGoHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(85, 30));
    }];
}

- (void)tapAllOrderNumber
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(C_PayGoToOrderInfo:)]) {
        [self.delegate C_PayGoToOrderInfo:@"总订单"];
    }
}

- (void)tapGoHome
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(C_PayGoHome)]) {
        [self.delegate C_PayGoHome];
    }
}

- (void)tap:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(C_PayGoToOrderInfo:)])
    {
        if (btn.tag == self.arrOrderNumber.count - 1) {
            [self.delegate C_PayGoToOrderInfo:@"总订单"];
        }
        else
        {
            [self.delegate C_PayGoToOrderInfo:self.arrOrderNumber[btn.tag]];
        }
    }
}

#pragma mark - 懒加载
- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = ColorLine;
    }
    return _vLine;
}


- (UIButton *)btnOrderNumber
{
    if (!_btnOrderNumber) {
        _btnOrderNumber = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnOrderNumber.titleLabel.font = kFont13;
        [_btnOrderNumber setTitle:@"订单详情" forState:UIControlStateNormal];
        _btnOrderNumber.layer.cornerRadius = 4;
        _btnOrderNumber.layer.borderColor = [UIColor colorWithHexString:@"666666"].CGColor;
        _btnOrderNumber.layer.borderWidth = 0.5;
        [_btnOrderNumber addTarget:self action:@selector(tapAllOrderNumber) forControlEvents:UIControlEventTouchUpInside];
        [_btnOrderNumber setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _btnOrderNumber;
}

- (UIButton *)btnGoHome
{
    if (!_btnGoHome) {
        _btnGoHome = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnGoHome.titleLabel.font = kFont13;
        [_btnGoHome setTitle:@"回首页" forState:UIControlStateNormal];
        _btnGoHome.layer.cornerRadius = 4;
        _btnGoHome.layer.borderColor = [UIColor colorWithHexString:@"666666"].CGColor;
        _btnGoHome.layer.borderWidth = 0.5;
        [_btnGoHome addTarget:self action:@selector(tapGoHome) forControlEvents:UIControlEventTouchUpInside];
        [_btnGoHome setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _btnGoHome;
}

- (UILabel *)lblHint
{
    if (!_lblHint) {
        _lblHint = [[UILabel alloc] init];
        _lblHint.font = kFont12;
        _lblHint.text = @"尊敬的客户，由于您商品不在同一库房，您的订单被系统拆分为多个子订单分开配送，所产生的额外运费由海豚供应链承担，给您带来的不便请谅解。";
        _lblHint.numberOfLines = 0;
        _lblHint.textColor = [UIColor colorWithHexString:@"666666"];
    }
    return _lblHint;
}

@end
