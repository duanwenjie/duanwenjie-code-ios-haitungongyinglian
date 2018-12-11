//
//  BCOrderDetailsFootView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/15.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "BCOrderDetailsFootView.h"

@interface BCOrderDetailsFootView ()

@property (nonatomic, strong) UIButton *btnTel;

@property (nonatomic, strong) UIButton *btnQQ;

@end

@implementation BCOrderDetailsFootView

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
    [self addSubview:self.btnTel];
    [self addSubview:self.btnQQ];
    
    [self.btnTel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(8);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.btnQQ.mas_left).offset(-15);
        make.width.equalTo(self.btnQQ.mas_width);
    }];
    
    [self.btnQQ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(8);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
        make.left.equalTo(self.btnTel.mas_right).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.width.equalTo(self.btnTel.mas_width);
    }];
}

#pragma mark - 点击事件
- (void)selectTel
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapTel)]) {
        [self.delegate tapTel];
    }
}

- (void)selectQQ
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapQQ)]) {
        [self.delegate tapQQ];
    }
}

- (UIButton *)btnTel
{
    if (!_btnTel) {
        _btnTel = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnTel.layer.cornerRadius = 4;
        _btnTel.layer.borderColor = [UIColor colorWithHexString:@"b4b4b4"].CGColor;
        _btnTel.layer.borderWidth = 1;
        [_btnTel setTitle:@"客服热线" forState:UIControlStateNormal];
        [_btnTel setTitleColor:[UIColor colorWithHexString:@"b4b4b4"] forState:UIControlStateNormal];
        _btnTel.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnTel addTarget:self action:@selector(selectTel) forControlEvents:UIControlEventTouchUpInside];
        [_btnTel setImage:[UIImage drawImageWithName:@"new_order_detal_service_phone" size:CGSizeMake(23, 23)] forState:UIControlStateNormal];
    }
    return _btnTel;
}

- (UIButton *)btnQQ
{
    if (!_btnQQ) {
        _btnQQ = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnQQ.layer.cornerRadius = 4;
        _btnQQ.layer.borderColor = [UIColor colorWithHexString:@"b4b4b4"].CGColor;
        _btnQQ.layer.borderWidth = 1;
        [_btnQQ setTitle:@"客服QQ" forState:UIControlStateNormal];
        [_btnQQ setTitleColor:[UIColor colorWithHexString:@"b4b4b4"] forState:UIControlStateNormal];
        _btnQQ.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnQQ setImage:[UIImage drawImageWithName:@"new_order_detal_service_qq" size:CGSizeMake(23, 23)] forState:UIControlStateNormal];
        
        
        [_btnQQ addTarget:self action:@selector(selectQQ) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _btnQQ;
}



@end
