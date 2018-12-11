//
//  BuyProtocolView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/29.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "BuyProtocolView.h"
#import "ZXNTool.h"

@interface BuyProtocolView ()

@property (nonatomic, strong) UIButton *btnSelectProtocol;

@property (nonatomic, strong) UIView *vBack;

@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation BuyProtocolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self initAddView];
        [self initLayoutView];
    }
    return self;
}

- (void)initAddView
{
    [self addSubview:self.btnSelectProtocol];
    [self addSubview:self.vBack];
    [self.vBack addSubview:self.lblTitle];
    
}

- (void)initLayoutView
{
    [self.btnSelectProtocol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(15);
        make.bottom.equalTo(self.vBack.mas_top);
        make.height.mas_equalTo(37);
        make.width.mas_equalTo(80);
    }];
    
    [self.vBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.btnSelectProtocol.mas_bottom);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vBack.mas_top).offset(7);
        make.left.equalTo(self.vBack.mas_left).offset(15);
        make.right.equalTo(self.vBack.mas_right).offset(-15);
        make.bottom.equalTo(self.vBack.mas_bottom).offset(-7);
    }];
}

- (void)tapBuyProtocol:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(buyProtocolIsSelect:)]) {
        [self.delegate buyProtocolIsSelect:!btn.selected];
        btn.selected = !btn.selected;
    }
}


#pragma mark - 懒加载
- (UIButton *)btnSelectProtocol
{
    if (!_btnSelectProtocol) {
        _btnSelectProtocol = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSelectProtocol setImage:[UIImage imageNamed:@"Pay_Buy_Protocol_NO"] forState:UIControlStateNormal];
        [_btnSelectProtocol setImage:[UIImage imageNamed:@"Pay_Buy_Protocol_YES"] forState:UIControlStateSelected];
        
        [_btnSelectProtocol setTitle:@"购买协议" forState:UIControlStateNormal];
        [_btnSelectProtocol setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        _btnSelectProtocol.titleLabel.font = kFont13;
        
        [_btnSelectProtocol setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
        _btnSelectProtocol.selected = YES;
        [_btnSelectProtocol addTarget:self action:@selector(tapBuyProtocol:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnSelectProtocol;
}

- (UIView *)vBack
{
    if (!_vBack) {
        _vBack = [[UIView alloc] init];
        _vBack.backgroundColor = [UIColor whiteColor];
    }
    return _vBack;
}

- (UILabel *)lblTitle
{
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.textColor = [UIColor colorWithHexString:@"333333"];
        _lblTitle.text = @"本人承诺本次购买商品为本人自用合理数量，愿承担相应法律责任。";
        _lblTitle.numberOfLines = 0;
        _lblTitle.font = kFont13;
    }
    return _lblTitle;
}

@end
