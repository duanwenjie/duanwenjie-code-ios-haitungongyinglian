//
//  UpAndDownImageView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/4.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "DownImageView.h"

@interface DownImageView ()

@property (nonatomic, strong) UIImageView *imgDown;

@property (nonatomic, strong) UILabel *lblDown;

@end

@implementation DownImageView

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
    [self addSubview:self.imgDown];
    [self addSubview:self.lblDown];
}

- (void)initLayoutView
{
    [self.imgDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self);
        make.width.mas_equalTo(20);
        make.centerX.equalTo(self.mas_centerX).offset(-55);
    }];
    
    [self.lblDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self);
        make.left.equalTo(self.imgDown.mas_right).offset(10);
    }];
}

#pragma mark - 懒加载
- (UIImageView *)imgDown
{
    if (!_imgDown) {
        _imgDown = [[UIImageView alloc] init];
        _imgDown.image = [UIImage imageNamed:@"Commodity_Down"];
        _imgDown.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgDown;
}

- (UILabel *)lblDown
{
    if (!_lblDown) {
        _lblDown = [[UILabel alloc] init];
        _lblDown.text = @"下拉返回产品详情";
        _lblDown.textColor = [UIColor colorWithHexString:@"666666"];
        _lblDown.font = kFont13;
    }
    return _lblDown;
}

@end
