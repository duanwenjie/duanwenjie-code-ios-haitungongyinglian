//
//  HomeClassifyCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/22.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "HomeClassifyCell.h"
#import "ZXNImageView.h"
#import "HomeClassifyModel.h"

@interface HomeClassifyCell ()

@property (nonatomic, strong) UIView *vBackOne;

@property (nonatomic, strong) ZXNImageView *imgOne;

@property (nonatomic, strong) UILabel *lblOne;

@property (nonatomic, strong) UIView *vBackTwo;

@property (nonatomic, strong) ZXNImageView *imgTwo;

@property (nonatomic, strong) UILabel *lblTwo;

@property (nonatomic, strong) UIView *vBackThree;

@property (nonatomic, strong) ZXNImageView *imgThree;

@property (nonatomic, strong) UILabel *lblThree;

@property (nonatomic, strong) UIView *vBackFour;

@property (nonatomic, strong) ZXNImageView *imgFour;

@property (nonatomic, strong) UILabel *lblFour;


@end

@implementation HomeClassifyCell


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
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.vBackOne];
    [self.vBackOne addSubview:self.imgOne];
    [self.vBackOne addSubview:self.lblOne];
    
    [self.contentView addSubview:self.vBackTwo];
    [self.vBackTwo addSubview:self.imgTwo];
    [self.vBackTwo addSubview:self.lblTwo];
    
    [self.contentView addSubview:self.vBackThree];
    [self.vBackThree addSubview:self.imgThree];
    [self.vBackThree addSubview:self.lblThree];
    
    [self.contentView addSubview:self.vBackFour];
    [self.vBackFour addSubview:self.imgFour];
    [self.vBackFour addSubview:self.lblFour];
    
    
    [self.vBackOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.vBackTwo.mas_left).offset(0);
        make.width.equalTo(self.vBackTwo.mas_width);
    }];
    
    [self.imgOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.vBackOne.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerY.equalTo(self.vBackOne.mas_centerY).offset(-10);
    }];
    
    [self.lblOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.vBackOne.mas_centerX);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(self.vBackOne.mas_centerY).offset(35);
    }];
    
    
    [self.vBackTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.vBackOne.mas_right).offset(0);
        make.right.equalTo(self.vBackThree.mas_left).offset(0);
        make.width.equalTo(self.vBackThree.mas_width);
    }];
    
    [self.imgTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.vBackTwo.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerY.equalTo(self.vBackTwo.mas_centerY).offset(-10);
    }];
    
    [self.lblTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.vBackTwo.mas_centerX);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(self.vBackTwo.mas_centerY).offset(35);
    }];
    
    [self.vBackThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.vBackTwo.mas_right).offset(0);
        make.right.equalTo(self.vBackFour.mas_left).offset(0);
        make.width.equalTo(self.vBackFour.mas_width);
    }];
    
    [self.imgThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.vBackThree.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerY.equalTo(self.vBackThree.mas_centerY).offset(-10);
    }];
    
    [self.lblThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.vBackThree.mas_centerX);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(self.vBackThree.mas_centerY).offset(35);
    }];
    
    [self.vBackFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.vBackThree.mas_right).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.width.equalTo(self.vBackOne.mas_width);
    }];
    
    [self.imgFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.vBackFour.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerY.equalTo(self.vBackFour.mas_centerY).offset(-10);
    }];
    
    [self.lblFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.vBackFour.mas_centerX);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(self.vBackFour.mas_centerY).offset(35);
    }];
    
}

- (void)loadView:(NSArray *)arrData
{
    if (arrData.count != 4) {
        return;
    }
    
    HomeClassifyModel *model1 = arrData[0];
    HomeClassifyModel *model2 = arrData[1];
    HomeClassifyModel *model3 = arrData[2];
    HomeClassifyModel *model4 = arrData[3];
    
    [self.imgOne downloadImage:model1.image_thumbnail backgroundImage:ZXNImageDefaul];
    [self.imgTwo downloadImage:model2.image_thumbnail backgroundImage:ZXNImageDefaul];
    [self.imgThree downloadImage:model3.image_thumbnail backgroundImage:ZXNImageDefaul];
    [self.imgFour downloadImage:model4.image_thumbnail backgroundImage:ZXNImageDefaul];
    
    self.lblOne.text = model1.category_name;
    self.lblTwo.text = model2.category_name;
    self.lblThree.text = model3.category_name;
    self.lblFour.text = model4.category_name;
    
    [self setNeedsLayout];
}

- (void)tapOne
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didHomeClassifySelectItemAtIndex:)]) {
        [self.delegate didHomeClassifySelectItemAtIndex:0];
    }
}

- (void)tapTwo
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didHomeClassifySelectItemAtIndex:)]) {
        [self.delegate didHomeClassifySelectItemAtIndex:1];
    }
}

- (void)tapThree
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didHomeClassifySelectItemAtIndex:)]) {
        [self.delegate didHomeClassifySelectItemAtIndex:2];
    }
}

- (void)tapFour
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didHomeClassifySelectItemAtIndex:)]) {
        [self.delegate didHomeClassifySelectItemAtIndex:3];
    }
}


- (UIView *)vBackOne
{
    if (!_vBackOne) {
        _vBackOne = [[UIView alloc] init];
        
        UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOne)];
        [_vBackOne addGestureRecognizer:tapOne];
    }
    return _vBackOne;
}

- (ZXNImageView *)imgOne
{
    if (!_imgOne) {
        _imgOne = [[ZXNImageView alloc] init];
        _imgOne.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgOne;
}

- (UILabel *)lblOne
{
    if (!_lblOne) {
        _lblOne = [[UILabel alloc] init];
        _lblOne.textAlignment = NSTextAlignmentCenter;
        _lblOne.font = [UIFont systemFontOfSize:13];
    }
    return _lblOne;
}

- (UIView *)vBackTwo
{
    if (!_vBackTwo) {
        _vBackTwo = [[UIView alloc] init];
        
        UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTwo)];
        [_vBackTwo addGestureRecognizer:tapTwo];
    }
    return _vBackTwo;
}

- (ZXNImageView *)imgTwo
{
    if (!_imgTwo) {
        _imgTwo = [[ZXNImageView alloc] init];
        _imgTwo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgTwo;
}

- (UILabel *)lblTwo
{
    if (!_lblTwo) {
        _lblTwo = [[UILabel alloc] init];
        _lblTwo.textAlignment = NSTextAlignmentCenter;
        _lblTwo.font = [UIFont systemFontOfSize:13];
    }
    return _lblTwo;
}

- (UIView *)vBackThree
{
    if (!_vBackThree) {
        _vBackThree = [[UIView alloc] init];
        
        UITapGestureRecognizer *tapThree = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapThree)];
        [_vBackThree addGestureRecognizer:tapThree];
    }
    return _vBackThree;
}

- (ZXNImageView *)imgThree
{
    if (!_imgThree) {
        _imgThree = [[ZXNImageView alloc] init];
        _imgThree.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgThree;
}

- (UILabel *)lblThree
{
    if (!_lblThree) {
        _lblThree = [[UILabel alloc] init];
        _lblThree.textAlignment = NSTextAlignmentCenter;
        _lblThree.font = [UIFont systemFontOfSize:13];
    }
    return _lblThree;
}

- (UIView *)vBackFour
{
    if (!_vBackFour) {
        _vBackFour = [[UIView alloc] init];
        
        UITapGestureRecognizer *tapFour = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFour)];
        [_vBackFour addGestureRecognizer:tapFour];
    }
    return _vBackFour;
}

- (ZXNImageView *)imgFour
{
    if (!_imgFour) {
        _imgFour = [[ZXNImageView alloc] init];
        _imgFour.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgFour;
}

- (UILabel *)lblFour
{
    if (!_lblFour) {
        _lblFour = [[UILabel alloc] init];
        _lblFour.textAlignment = NSTextAlignmentCenter;
        _lblFour.font = [UIFont systemFontOfSize:13];
    }
    return _lblFour;
}



@end
