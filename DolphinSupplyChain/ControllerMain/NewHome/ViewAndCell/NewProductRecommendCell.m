//
//  NewProductRecommendCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/22.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "NewProductRecommendCell.h"
#import "ZXNImageView.h"

@interface NewProductRecommendCell ()

@property (nonatomic, strong) UIView *vLineOne;

@property (nonatomic, strong) UIView *vLineTwo;

@property (nonatomic, strong) UIView *vLineThree;

@property (nonatomic, strong) UIView *vBackOne;

@property (nonatomic, strong) UILabel *lblTitleOne;

@property (nonatomic, strong) UILabel *lblMoneyOne;

@property (nonatomic, strong) ZXNImageView *imgProductOne;

@property (nonatomic, strong) UIView *vBackTwo;

@property (nonatomic, strong) UILabel *lblTitleTwo;

@property (nonatomic, strong) UILabel *lblMoneyTwo;

@property (nonatomic, strong) ZXNImageView *imgProductTwo;

@property (nonatomic, strong) UIView *vBackThree;

@property (nonatomic, strong) UILabel *lblTitleThree;

@property (nonatomic, strong) UILabel *lblMoneyThree;

@property (nonatomic, strong) ZXNImageView *imgProductThree;

@end

@implementation NewProductRecommendCell


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
    [self.contentView addSubview:self.vLineOne];
    [self.contentView addSubview:self.vLineTwo];
    [self.contentView addSubview:self.vLineThree];
    
    [self.contentView addSubview:self.vBackOne];
    [self.contentView addSubview:self.vBackTwo];
    [self.contentView addSubview:self.vBackThree];
    
    [self.vBackOne addSubview:self.lblTitleOne];
    [self.vBackOne addSubview:self.lblMoneyOne];
    [self.vBackOne addSubview:self.imgProductOne];
    
    [self.vBackTwo addSubview:self.lblTitleTwo];
    [self.vBackTwo addSubview:self.lblMoneyTwo];
    [self.vBackTwo addSubview:self.imgProductTwo];
    
    [self.vBackThree addSubview:self.lblTitleThree];
    [self.vBackThree addSubview:self.lblMoneyThree];
    [self.vBackThree addSubview:self.imgProductThree];
    
    [self.vLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.vLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView.mas_centerX).offset(0);
        make.width.mas_equalTo(0.5);
    }];
    
    [self.vLineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
        make.right.equalTo(self.vLineTwo.mas_left).offset(0);
    }];
    
    [self.vBackOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.top.equalTo(self.vLineOne.mas_bottom).offset(0);
        make.bottom.equalTo(self.vLineThree.mas_top).offset(0);
        make.right.equalTo(self.vLineTwo.mas_left).offset(0);
    }];
    
    [self.lblTitleOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBackOne.mas_left).offset(15);
        make.top.equalTo(self.vBackOne.mas_top).offset(18);
        make.right.equalTo(self.vBackOne.mas_right).offset(-15);
        make.height.mas_equalTo(20);
    }];
    
    [self.lblMoneyOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBackOne.mas_left).offset(15);
        make.top.equalTo(self.lblTitleOne.mas_bottom).offset(4);
        make.height.mas_equalTo(20);
    }];
    
    [self.imgProductOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblTitleOne.mas_bottom).offset(4);
        make.bottom.equalTo(self.vBackOne.mas_bottom).offset(0);
        make.right.equalTo(self.vBackOne.mas_right).offset(-10);
        make.width.mas_equalTo(80);
    }];
    
    [self.vBackTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.top.equalTo(self.vLineThree.mas_bottom).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        make.right.equalTo(self.vLineTwo.mas_left).offset(0);
    }];
    
    [self.lblTitleTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBackTwo.mas_left).offset(15);
        make.top.equalTo(self.vBackTwo.mas_top).offset(18);
        make.right.equalTo(self.vBackTwo.mas_right).offset(-15);
        make.height.mas_equalTo(20);
    }];
    
    [self.lblMoneyTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBackTwo.mas_left).offset(15);
        make.top.equalTo(self.lblTitleTwo.mas_bottom).offset(4);
        make.height.mas_equalTo(20);
    }];
    
    [self.imgProductTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblTitleTwo.mas_bottom).offset(4);
        make.bottom.equalTo(self.vBackTwo.mas_bottom).offset(0);
        make.right.equalTo(self.vBackTwo.mas_right).offset(-10);
        make.width.mas_equalTo(80);
    }];
    
    [self.vBackThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vLineTwo.mas_right).offset(0);
        make.top.equalTo(self.vLineOne.mas_bottom).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
    }];
    
    [self.lblTitleThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBackThree.mas_left).offset(15);
        make.top.equalTo(self.vBackThree.mas_top).offset(18);
        make.right.equalTo(self.vBackThree.mas_right).offset(-15);
        make.height.mas_equalTo(20);
    }];
    
    [self.lblMoneyThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBackThree.mas_left).offset(15);
        make.top.equalTo(self.lblTitleThree.mas_bottom).offset(4);
        make.height.mas_equalTo(20);
    }];
    
    [self.imgProductThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblMoneyThree.mas_bottom).offset(10);
        make.left.equalTo(self.vBackThree.mas_left).offset(10);
        make.right.equalTo(self.vBackThree.mas_right).offset(-10);
        make.bottom.equalTo(self.vBackThree.mas_bottom).offset(-10);
    }];
}

- (void)loadViewOne:(NSString *)sTitleOne :(NSString *)sMoneyOne :(NSString *)sImageURLOne Two:(NSString *)sTitleTwo :(NSString *)sMoneyTwo :(NSString *)sImageURLTwo Three:(NSString *)sTitleThree :(NSString *)sMoneyThree :(NSString *)sImageURLThree
{
    self.lblTitleOne.text = sTitleOne;
    self.lblTitleTwo.text = sTitleTwo;
    self.lblTitleThree.text = sTitleThree;
    
    self.lblMoneyOne.text = [NSString stringWithFormat:@"￥%@",sMoneyOne];
    self.lblMoneyTwo.text = [NSString stringWithFormat:@"￥%@",sMoneyTwo];
    self.lblMoneyThree.text = [NSString stringWithFormat:@"￥%@",sMoneyThree];
    
    [self.imgProductOne downloadImage:sImageURLOne backgroundImage:ZXNImageDefaul];
    [self.imgProductTwo downloadImage:sImageURLTwo backgroundImage:ZXNImageDefaul];
    [self.imgProductThree downloadImage:sImageURLThree backgroundImage:ZXNImageDefaul];
    
    [self setNeedsLayout];
}



#pragma mark - 点击事件
- (void)tapBackOne
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didNewProductRecommendSelectItemAtIndex:)]) {
        [self.delegate didNewProductRecommendSelectItemAtIndex:0];
    }
}

- (void)tapBackTwo
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didNewProductRecommendSelectItemAtIndex:)]) {
        [self.delegate didNewProductRecommendSelectItemAtIndex:1];
    }
}

- (void)tapBackThree
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didNewProductRecommendSelectItemAtIndex:)]) {
        [self.delegate didNewProductRecommendSelectItemAtIndex:2];
    }
}


#pragma mark - 懒加载
- (UIView *)vLineOne
{
    if (!_vLineOne) {
        _vLineOne = [[UIView alloc] init];
        _vLineOne.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _vLineOne;
}

- (UIView *)vLineTwo
{
    if (!_vLineTwo) {
        _vLineTwo = [[UIView alloc] init];
        _vLineTwo.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _vLineTwo;
}

- (UIView *)vLineThree
{
    if (!_vLineThree) {
        _vLineThree = [[UIView alloc] init];
        _vLineThree.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _vLineThree;
}

- (UIView *)vBackOne
{
    if (!_vBackOne) {
        _vBackOne = [[UIView alloc] init];
        _vBackOne.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tapBackOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackOne)];
        [_vBackOne addGestureRecognizer:tapBackOne];
    }
    return _vBackOne;
}

- (UILabel *)lblTitleOne
{
    if (!_lblTitleOne) {
        _lblTitleOne = [[UILabel alloc] init];
        _lblTitleOne.font = [UIFont systemFontOfSize:13];
        _lblTitleOne.numberOfLines = 1;
    }
    return _lblTitleOne;
}

- (UILabel *)lblMoneyOne
{
    if (!_lblMoneyOne) {
        _lblMoneyOne = [[UILabel alloc] init];
        _lblMoneyOne.font = [UIFont systemFontOfSize:13];
        _lblMoneyOne.numberOfLines = 1;
        _lblMoneyOne.textColor = [UIColor colorWithHexString:@"e93140"];
    }
    return _lblMoneyOne;
}

- (ZXNImageView *)imgProductOne
{
    if (!_imgProductOne) {
        _imgProductOne = [[ZXNImageView alloc] init];
        _imgProductOne.contentMode = UIViewContentModeScaleAspectFit;
        _imgProductOne.userInteractionEnabled = YES;
    }
    return _imgProductOne;
}


- (UIView *)vBackTwo
{
    if (!_vBackTwo) {
        _vBackTwo = [[UIView alloc] init];
        _vBackTwo.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tapBackTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackTwo)];
        [_vBackTwo addGestureRecognizer:tapBackTwo];
    }
    return _vBackTwo;
}

- (UILabel *)lblTitleTwo
{
    if (!_lblTitleTwo) {
        _lblTitleTwo = [[UILabel alloc] init];
        _lblTitleTwo.font = [UIFont systemFontOfSize:13];
        _lblTitleTwo.numberOfLines = 1;
    }
    return _lblTitleTwo;
}

- (UILabel *)lblMoneyTwo
{
    if (!_lblMoneyTwo) {
        _lblMoneyTwo = [[UILabel alloc] init];
        _lblMoneyTwo.font = [UIFont systemFontOfSize:13];
        _lblMoneyTwo.numberOfLines = 1;
        _lblMoneyTwo.textColor = [UIColor colorWithHexString:@"e93140"];
    }
    return _lblMoneyTwo;
}

- (ZXNImageView *)imgProductTwo
{
    if (!_imgProductTwo) {
        _imgProductTwo = [[ZXNImageView alloc] init];
        _imgProductTwo.contentMode = UIViewContentModeScaleAspectFit;
        _imgProductTwo.userInteractionEnabled = YES;
    }
    return _imgProductTwo;
}


- (UIView *)vBackThree
{
    if (!_vBackThree) {
        _vBackThree = [[UIView alloc] init];
        _vBackThree.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tapBackThree = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackThree)];
        [_vBackThree addGestureRecognizer:tapBackThree];
    }
    return _vBackThree;
}

- (UILabel *)lblTitleThree
{
    if (!_lblTitleThree) {
        _lblTitleThree = [[UILabel alloc] init];
        _lblTitleThree.font = [UIFont systemFontOfSize:13];
        _lblTitleThree.numberOfLines = 1;
    }
    return _lblTitleThree;
}

- (UILabel *)lblMoneyThree
{
    if (!_lblMoneyThree) {
        _lblMoneyThree = [[UILabel alloc] init];
        _lblMoneyThree.font = [UIFont systemFontOfSize:13];
        _lblMoneyThree.numberOfLines = 1;
        _lblMoneyThree.textColor = [UIColor colorWithHexString:@"e93140"];
    }
    return _lblMoneyThree;
}

- (ZXNImageView *)imgProductThree
{
    if (!_imgProductThree) {
        _imgProductThree = [[ZXNImageView alloc] init];
        _imgProductThree.contentMode = UIViewContentModeScaleAspectFit;
        _imgProductThree.userInteractionEnabled = YES;
    }
    return _imgProductThree;
}

@end
