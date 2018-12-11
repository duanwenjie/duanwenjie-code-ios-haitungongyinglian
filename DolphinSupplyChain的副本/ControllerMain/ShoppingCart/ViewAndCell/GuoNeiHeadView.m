//
//  GuoNeiHeadView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/28.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "GuoNeiHeadView.h"

@interface GuoNeiHeadView ()

@property (nonatomic, strong) UIView *vBack;

@property (nonatomic, strong) UIButton *btnSelect;

@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation GuoNeiHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        [self initAddView];
        [self initLayoutView];
    }
    return self;
}

- (void)initAddView
{
    [self addSubview:self.vBack];
    [self.vBack addSubview:self.btnSelect];
    [self.vBack addSubview:self.lblTitle];
}

- (void)initLayoutView
{
    [self.vBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    
    [self.btnSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.vBack);
        make.width.mas_equalTo(43);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self.vBack);
        make.left.equalTo(self.btnSelect.mas_right);
    }];
}


- (void)tapHaiWaiSection:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapGuoNeiHead:)]) {
        [self.delegate tapGuoNeiHead:!btn.selected];
        btn.selected = !btn.selected;
    }
}


/**
 改变选择圆圈是否选中
 
 @param isSelect YES为选中  NO为不勾选
 */
- (void)changeImageSelectState:(BOOL)isSelect
{
    self.btnSelect.selected = isSelect;
}

#pragma mark - 懒加载
- (UIView *)vBack
{
    if (!_vBack) {
        _vBack = [[UIView alloc] init];
        _vBack.backgroundColor = [UIColor whiteColor];
    }
    return _vBack;
}


- (UIButton *)btnSelect
{
    if (!_btnSelect) {
        _btnSelect = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSelect setImage:[UIImage drawImageWithName:@"choose_default" size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
        [_btnSelect setImage:[UIImage drawImageWithName:@"choose_selected" size:CGSizeMake(20, 20)] forState:UIControlStateSelected];
        [_btnSelect addTarget:self action:@selector(tapHaiWaiSection:) forControlEvents:UIControlEventTouchUpInside];
        _btnSelect.selected = YES;
    }
    return _btnSelect;
}

- (UILabel *)lblTitle
{
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.text = @"一般贸易";
        _lblTitle.font = kFont13;
    }
    return _lblTitle;
}

@end
