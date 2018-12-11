//
//  HandleView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/5/16.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "HandleView.h"

@interface HandleView ()

@property (nonatomic, strong) UIView *vBack;

@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation HandleView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"efeff2"];
        [self initView];
        [self addViewLayout];
    }
    return self;
}

- (void)initView
{
    [self.contentView addSubview:self.vBack];
    [self.vBack addSubview:self.lblTitle];
}

- (void)addViewLayout
{
    [self.vBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBack.mas_left).offset(15);
        make.bottom.top.equalTo(self.vBack);
        make.right.equalTo(self.vBack.mas_right).offset(-15);
    }];
}

- (void)loadData:(NSString *)sTitle
{
    self.lblTitle.text = [NSString stringWithFormat:@"订单编号:%@", sTitle];
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

- (UILabel *)lblTitle
{
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.font = kFont12;
        _lblTitle.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _lblTitle;
}

@end
