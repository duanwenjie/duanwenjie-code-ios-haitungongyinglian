//
//  FavorableCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/22.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "FavorableCell.h"
#import "ZXNImageView.h"

@interface FavorableCell ()

@property (nonatomic, strong) ZXNImageView *imgFavorableOne;

@property (nonatomic, strong) ZXNImageView *imgFavorableTwo;

@end

@implementation FavorableCell

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
    
    [self.contentView addSubview:self.imgFavorableOne];
    [self.contentView addSubview:self.imgFavorableTwo];
    
    [self.imgFavorableOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.imgFavorableTwo.mas_left).offset(-10);
        make.width.equalTo(self.imgFavorableTwo.mas_width);
    }];
    
    [self.imgFavorableTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.imgFavorableOne.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.equalTo(self.imgFavorableOne.mas_width);
    }];
}

- (void)loadView:(NSString *)sUrlOne UrlTwo:(NSString *)sUrlTwo
{
    [self.imgFavorableOne downloadImage:sUrlOne backgroundImage:ZXNImageDefaul];
    [self.imgFavorableTwo downloadImage:sUrlTwo backgroundImage:ZXNImageDefaul];
    [self setNeedsLayout];
}


#pragma mark - 点击事件
- (void)tapFavorableOne
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFavorableSelectItemAtIndex:)]) {
        [self.delegate didFavorableSelectItemAtIndex:0];
    }
}

- (void)tapFavorableTwo
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFavorableSelectItemAtIndex:)]) {
        [self.delegate didFavorableSelectItemAtIndex:1];
    }
}


- (ZXNImageView *)imgFavorableOne
{
    if (!_imgFavorableOne) {
        _imgFavorableOne = [[ZXNImageView alloc] init];
        _imgFavorableOne.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapFavorableOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFavorableOne)];
        [_imgFavorableOne addGestureRecognizer:tapFavorableOne];
    }
    return _imgFavorableOne;
}

- (ZXNImageView *)imgFavorableTwo
{
    if (!_imgFavorableTwo) {
        _imgFavorableTwo = [[ZXNImageView alloc] init];
        _imgFavorableTwo.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapFavorableTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFavorableTwo)];
        [_imgFavorableTwo addGestureRecognizer:tapFavorableTwo];
    }
    return _imgFavorableTwo;
}

@end
