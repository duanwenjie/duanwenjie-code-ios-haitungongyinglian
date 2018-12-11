//
//  OrderHandleHeadView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/5/16.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "OrderHandleHeadView.h"

@interface OrderHandleHeadView ()

@property (nonatomic, strong) UIImageView *imgTrue;

@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation OrderHandleHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
        [self addViewLayout];
    }
    return self;
}

- (void)initView
{
    [self addSubview:self.imgTrue];
    [self addSubview:self.lblTitle];
}

- (void)addViewLayout
{
    [self.imgTrue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.equalTo(self.lblTitle.mas_left).offset(-10);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.centerX.equalTo(self.mas_centerX).offset(15);
        make.height.mas_equalTo(20);
    }];
}

#pragma mark - 懒加载
- (UIImageView *)imgTrue
{
    if (!_imgTrue) {
        _imgTrue = [[UIImageView alloc] init];
        _imgTrue.image = [UIImage imageNamed:@""];
    }
    return _imgTrue;
}

- (UILabel *)lblTitle
{
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.text = @"提交订单成功，现在只差最后一步啦！";
        _lblTitle.font = kFont14;
    }
    return _lblTitle;
}

@end
