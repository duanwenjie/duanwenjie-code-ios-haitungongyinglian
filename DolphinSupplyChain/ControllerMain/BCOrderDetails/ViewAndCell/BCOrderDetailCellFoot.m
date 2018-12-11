//
//  BCOrderDetailCellFoot.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/15.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "BCOrderDetailCellFoot.h"

@interface BCOrderDetailCellFoot ()

@property (nonatomic, strong) UILabel *lblOrderNumber;

@property (nonatomic, strong) UILabel *lblOrderTime;

@property (nonatomic, strong) UIView *vBack;

@end

@implementation BCOrderDetailCellFoot

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        [self initView];
    }
    return self;
}


- (void)initView
{
    [self.contentView addSubview:self.vBack];
    [self.vBack addSubview:self.lblOrderNumber];
    [self.vBack addSubview:self.lblOrderTime];
    
    
    [self.vBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    
    [self.lblOrderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBack.mas_left).offset(15);
        make.right.equalTo(self.vBack.mas_right).offset(-15);
        make.top.equalTo(self.vBack.mas_top).offset(8);
        make.height.mas_equalTo(20);
    }];
    
    [self.lblOrderTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lblOrderNumber);
        make.top.equalTo(self.lblOrderNumber.mas_bottom).offset(2);
        make.height.mas_equalTo(20);
    }];
}

- (void)loadViewNumber:(NSString *)sNumber Time:(NSString *)sTime
{
    self.lblOrderNumber.text = [NSString stringWithFormat:@"平台订单号：%@", sNumber];
    self.lblOrderTime.text = [NSString stringWithFormat:@"下单时间：%@", sTime];
    
    [self setNeedsLayout];
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


- (UILabel *)lblOrderNumber
{
    if (!_lblOrderNumber) {
        _lblOrderNumber = [[UILabel alloc] init];
        _lblOrderNumber.textColor = [UIColor colorWithHexString:@"999999"];
        _lblOrderNumber.font = [UIFont systemFontOfSize:13];
    }
    return _lblOrderNumber;
}

- (UILabel *)lblOrderTime
{
    if (!_lblOrderTime) {
        _lblOrderTime = [[UILabel alloc] init];
        _lblOrderTime.textColor = [UIColor colorWithHexString:@"999999"];
        _lblOrderTime.font = [UIFont systemFontOfSize:13];
    }
    return _lblOrderTime;
}


@end
