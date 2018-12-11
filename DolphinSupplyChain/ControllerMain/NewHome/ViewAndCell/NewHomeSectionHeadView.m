//
//  NewHomeSectionHeadView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/22.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "NewHomeSectionHeadView.h"

@interface NewHomeSectionHeadView ()

@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UIView *vBack;

@property (nonatomic, strong) UIButton *btnTitle;

@end

@implementation NewHomeSectionHeadView

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
    [self addSubview:self.vLine];
    [self addSubview:self.vBack];
    [self.vBack addSubview:self.btnTitle];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(10);
    }];
    
    [self.vBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLine.mas_bottom).offset(0);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(45);
    }];
    
    [self.btnTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 30));
        make.centerX.equalTo(self.vBack);
        make.centerY.equalTo(self.vBack);
    }];
}


- (void)loadView:(NSString *)sTitle ImageURL:(NSString *)sURL
{
    [self.btnTitle setTitle:sTitle forState:UIControlStateNormal];
    [self.btnTitle setImage:[UIImage imageNamed:sURL] forState:UIControlStateNormal];
    [self setNeedsLayout];
}



- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    }
    return _vLine;
}

- (UIView *)vBack
{
    if (!_vBack) {
        _vBack = [[UIView alloc] init];
        _vBack.backgroundColor = [UIColor whiteColor];
    }
    return _vBack;
}

- (UIButton *)btnTitle
{
    if (!_btnTitle) {
        _btnTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btnTitle.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [_btnTitle setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [_btnTitle setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
    }
    return _btnTitle;
}

@end
