//
//  ImageAndTextView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/4.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "ImageAndTextView.h"

@interface ImageAndTextView ()

@property (nonatomic, strong) UIButton *btnImage;

@property (nonatomic, strong) UIButton *btnText;

@property (nonatomic, strong) UIView *vLineImage;

@property (nonatomic, strong) UIView *vLineText;

@property (nonatomic, strong) UIView *vLine;

@end

@implementation ImageAndTextView

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
    [self addSubview:self.btnImage];
    [self addSubview:self.btnText];
    
    [self addSubview:self.vLine];
    
    [self addSubview:self.vLineImage];
    [self addSubview:self.vLineText];
}

- (void)initLayoutView
{
    [self.btnImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.height.mas_equalTo(37);
        make.right.equalTo(self.btnText.mas_left);
        make.width.equalTo(self.btnText.mas_width);
    }];
    
    [self.btnText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.height.mas_equalTo(37);
        make.left.equalTo(self.btnImage.mas_right);
        make.width.equalTo(self.btnText.mas_width);
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.vLineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.height.mas_equalTo(3);
        make.right.equalTo(self.btnImage.mas_right).offset(0);
    }];
    
    [self.vLineText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo(3);
        make.left.equalTo(self.btnText.mas_left).offset(0);
    }];
    
    self.btnImage.selected = YES;
    self.vLineImage.hidden = NO;
}

- (void)changeImageAndTextShow:(BOOL)bImage
{
    self.btnImage.selected = bImage;
    self.btnText.selected = !bImage;
    self.vLineImage.hidden = !bImage;
    self.vLineText.hidden = bImage;
}

#pragma mark - 点击图文详情
- (void)tapWebImage
{
    if (self.btnImage.selected) {
        return;
    }
    self.btnImage.selected = YES;
    self.btnText.selected = NO;
    self.vLineImage.hidden = NO;
    self.vLineText.hidden = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeImageAndTextScrollView:)]) {
        [self.delegate changeImageAndTextScrollView:YES];
    }
}

#pragma mark - 点击商品属性
- (void)tapText
{
    if (self.btnText.selected) {
        return;
    }
    self.btnText.selected = YES;
    self.btnImage.selected = NO;
    self.vLineText.hidden = NO;
    self.vLineImage.hidden = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeImageAndTextScrollView:)]) {
        [self.delegate changeImageAndTextScrollView:NO];
    }
}

#pragma mark - 懒加载
- (UIButton *)btnImage
{
    if (!_btnImage) {
        _btnImage = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnImage setTitle:@"图文详情" forState:UIControlStateNormal];
        [_btnImage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnImage setTitleColor:ColorAPPTheme forState:UIControlStateSelected];
        _btnImage.titleLabel.font = kFont14;
        [_btnImage addTarget:self action:@selector(tapWebImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnImage;
}

- (UIButton *)btnText
{
    if (!_btnText) {
        _btnText = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnText setTitle:@"商品属性" forState:UIControlStateNormal];
        [_btnText setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnText setTitleColor:ColorAPPTheme forState:UIControlStateSelected];
        _btnText.titleLabel.font = kFont14;
        [_btnText addTarget:self action:@selector(tapText) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnText;
}

- (UIView *)vLineImage
{
    if (!_vLineImage) {
        _vLineImage = [[UIView alloc] init];
        _vLineImage.backgroundColor = ColorAPPTheme;
        _vLineImage.hidden = YES;
    }
    return _vLineImage;
}

- (UIView *)vLineText
{
    if (!_vLineText) {
        _vLineText = [[UIView alloc] init];
        _vLineText.backgroundColor = ColorAPPTheme;
        _vLineText.hidden = YES;
    }
    return _vLineText;
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
