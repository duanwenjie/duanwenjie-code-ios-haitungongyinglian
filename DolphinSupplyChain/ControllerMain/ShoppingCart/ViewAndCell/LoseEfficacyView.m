//
//  LoseEfficacyView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/17.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "LoseEfficacyView.h"

@interface LoseEfficacyView ()

@property (nonatomic, strong) UILabel *lblLoseEfficacyName;

@property (nonatomic, strong) UIButton *btnEmpty;

@property (nonatomic, strong) UIView *vLine;

@end

@implementation LoseEfficacyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initAddView];
        [self initLayoutView];
    }
    return self;
}

- (void)initAddView
{
    [self addSubview:self.lblLoseEfficacyName];
    [self addSubview:self.btnEmpty];
    [self addSubview:self.vLine];
}

- (void)initLayoutView
{
    [self.lblLoseEfficacyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(12);
    }];
    
    [self.btnEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(8);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
        make.right.equalTo(self.mas_right).offset(-15);
        make.width.mas_equalTo(97);
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)tapEmpty
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(emptyAll)]) {
        [self.delegate emptyAll];
    }
}

#pragma mark - 懒加载
- (UILabel *)lblLoseEfficacyName
{
    if (!_lblLoseEfficacyName) {
        _lblLoseEfficacyName = [[UILabel alloc] init];
        _lblLoseEfficacyName.text = @"失效商品";
        _lblLoseEfficacyName.font = kFont13;
    }
    return _lblLoseEfficacyName;
}

- (UIButton *)btnEmpty
{
    if (!_btnEmpty) {
        _btnEmpty = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnEmpty.layer.borderWidth = 0.5;
        _btnEmpty.layer.borderColor = ColorLine.CGColor;
        _btnEmpty.layer.cornerRadius = 5;
        [_btnEmpty addTarget:self action:@selector(tapEmpty) forControlEvents:UIControlEventTouchUpInside];
        [_btnEmpty setTitle:@"清空失效商品" forState:UIControlStateNormal];
        [_btnEmpty setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btnEmpty.titleLabel.font = kFont13;
    }
    return _btnEmpty;
}

- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = ColorLine;
    }
    return _vLine;
}

@end
