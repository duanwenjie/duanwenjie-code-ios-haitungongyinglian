//
//  DetailsRecommendCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/4.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "DetailsRecommendCell.h"

@interface DetailsRecommendCell ()

@property (nonatomic, strong) ZXNImageView *imgProduct;

@property (nonatomic, strong) UILabel *lblProductTitle;

@property (nonatomic, strong) UILabel *lblProductPrice;

@end

@implementation DetailsRecommendCell

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
    [self.contentView addSubview:self.imgProduct];
    [self.contentView addSubview:self.lblProductTitle];
    [self.contentView addSubview:self.lblProductPrice];
    
    [self.imgProduct mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(120);
    }];
    
    [self.lblProductTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgProduct.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
    }];
    
    [self.lblProductPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-8);
        make.height.mas_equalTo(15);
    }];
}

- (void)loadView:(CommodityRecommendModel *)model
{
    [self.imgProduct downloadImage:model.img_original backgroundImage:ZXNImageDefaul];
    self.lblProductTitle.text = model.goods_name;
    self.lblProductPrice.text = [NSString stringWithFormat:@"￥%@",model.price];
    
    [self setNeedsLayout];
}

#pragma mark - 懒加载
- (ZXNImageView *)imgProduct
{
    if (!_imgProduct) {
        _imgProduct = [[ZXNImageView alloc] init];
        _imgProduct.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgProduct;
}

- (UILabel *)lblProductTitle
{
    if (!_lblProductTitle) {
        _lblProductTitle = [[UILabel alloc] init];
        _lblProductTitle.font = [UIFont systemFontOfSize:13];
        _lblProductTitle.textColor = [UIColor colorWithHexString:@"333333"];
        _lblProductTitle.numberOfLines = 2;
    }
    return _lblProductTitle;
}

- (UILabel *)lblProductPrice
{
    if (!_lblProductPrice) {
        _lblProductPrice = [[UILabel alloc] init];
        _lblProductPrice.font = [UIFont systemFontOfSize:13];
        _lblProductPrice.numberOfLines = 1;
        _lblProductPrice.textColor = [UIColor colorWithHexString:@"e93140"];
        _lblProductPrice.textAlignment = NSTextAlignmentCenter;
    }
    return _lblProductPrice;
}


@end
