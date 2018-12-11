//
//  CollectBuyCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/1.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "CollectBuyCell.h"
#import "ZXNImageView.h"
#import "ZXNTool.h"

@interface CollectBuyCell ()

@property (nonatomic, strong) ZXNImageView *imgBuy;

@property (nonatomic, strong) UIImageView *imgLoseEfficacy;

@property (nonatomic, strong) UILabel *lblLoseEfficacy;

@property (nonatomic, strong) UILabel *lblBuyName;

@property (nonatomic, strong) UILabel *lblBuyMoneyOne;

@property (nonatomic, strong) UILabel *lblBuyMoneyTwo;

@property (nonatomic, strong) UIView *vLineMoney;

@property (nonatomic, strong) UIView *vLine;

@end

@implementation CollectBuyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self.contentView addSubview:self.imgBuy];
    [self.imgBuy addSubview:self.imgLoseEfficacy];
    [self.imgBuy addSubview:self.lblLoseEfficacy];
    
    [self.contentView addSubview:self.lblBuyName];
    [self.contentView addSubview:self.lblBuyMoneyOne];
    [self.contentView addSubview:self.lblBuyMoneyTwo];
    [self.lblBuyMoneyTwo addSubview:self.vLineMoney];
    
    [self.contentView addSubview:self.vLine];
    
    [self.imgBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.equalTo(self.contentView.mas_height);
    }];
    
    [self.imgLoseEfficacy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.imgBuy);
    }];
    
    [self.lblLoseEfficacy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.centerX.equalTo(self.imgBuy.mas_centerX);
        make.centerY.equalTo(self.imgBuy.mas_centerY);
        make.left.right.equalTo(self.imgBuy);
    }];
    
    
    [self.lblBuyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgBuy.mas_right).offset(8);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-8);
    }];
    
    
    [self.lblBuyMoneyOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgBuy.mas_right).offset(8);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.height.mas_offset(18);
    }];
    
    
    [self.lblBuyMoneyTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.height.mas_offset(16);
        make.left.equalTo(self.lblBuyMoneyOne.mas_right).offset(5);
    }];
    
    [self.vLineMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lblBuyMoneyTwo);
        make.height.mas_equalTo(1);
        make.centerY.equalTo(self.lblBuyMoneyTwo.mas_centerY);
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (void)loadView:(NSString *)sImageURL
         BuyName:(NSString *)sName
        MoneyOne:(NSString *)sMoneyOne
        MoneyTwo:(NSString *)sMoneyTwo
  isLoseEfficacy:(BOOL)bLoseEfficacy
{
    [self.imgBuy downloadImage:sImageURL backgroundImage:ZXNImageDefaul];
    self.lblBuyName.text = sName;
    self.lblBuyMoneyOne.attributedText = [ZXNTool addMoneySignal:sMoneyOne font:12];
    self.lblBuyMoneyTwo.text = [NSString stringWithFormat:@"¥ %@",sMoneyTwo];
//    self.imgLoseEfficacy.hidden = !bLoseEfficacy;
//    self.lblLoseEfficacy.hidden = !bLoseEfficacy;
//    if (bLoseEfficacy) {
//        self.lblBuyName.textColor = [UIColor colorWithHexString:@"999999"];
//        self.lblBuyMoneyOne.textColor = [UIColor colorWithHexString:@"999999"];
//    }
//    else
//    {
//        self.lblBuyName.textColor = [UIColor colorWithHexString:@"333333"];
//        self.lblBuyMoneyOne.textColor = [UIColor colorWithHexString:@"e93140"];
//    }
    
    [self setNeedsLayout];
}

#pragma mark - 懒加载
- (ZXNImageView *)imgBuy
{
    if (!_imgBuy) {
        _imgBuy = [[ZXNImageView alloc] init];
        _imgBuy.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgBuy;
}

- (UIImageView *)imgLoseEfficacy
{
    if (!_imgLoseEfficacy) {
        _imgLoseEfficacy = [[UIImageView alloc] init];
        _imgLoseEfficacy.image = [UIImage imageNamed:@"CollectBuy_Lose_Efficacy"];
        _imgLoseEfficacy.hidden = YES;
    }
    return _imgLoseEfficacy;
}

- (UILabel *)lblLoseEfficacy
{
    if (!_lblLoseEfficacy) {
        _lblLoseEfficacy = [[UILabel alloc] init];
        _lblLoseEfficacy.font = kFont12;
        _lblLoseEfficacy.textColor = [UIColor whiteColor];
        _lblLoseEfficacy.textAlignment = NSTextAlignmentCenter;
        _lblLoseEfficacy.text = @"已失效";
        _lblLoseEfficacy.hidden = YES;
    }
    return _lblLoseEfficacy;
}


- (UILabel *)lblBuyName
{
    if (!_lblBuyName) {
        _lblBuyName = [[UILabel alloc] init];
        _lblBuyName.textColor = [UIColor colorWithHexString:@"333333"];
        _lblBuyName.font = [UIFont systemFontOfSize:14];
        _lblBuyName.numberOfLines = 2;
    }
    return _lblBuyName;
}

- (UILabel *)lblBuyMoneyOne
{
    if (!_lblBuyMoneyOne) {
        _lblBuyMoneyOne = [[UILabel alloc] init];
        _lblBuyMoneyOne.textColor = [UIColor colorWithHexString:@"e93140"];
        _lblBuyMoneyOne.font = [UIFont systemFontOfSize:14];
    }
    return _lblBuyMoneyOne;
}

- (UILabel *)lblBuyMoneyTwo
{
    if (!_lblBuyMoneyTwo) {
        _lblBuyMoneyTwo = [[UILabel alloc] init];
        _lblBuyMoneyTwo.textColor = [UIColor colorWithHexString:@"999999"];
        _lblBuyMoneyTwo.font = [UIFont systemFontOfSize:12];
    }
    return _lblBuyMoneyTwo;
}

- (UIView *)vLineMoney
{
    if (!_vLineMoney) {
        _vLineMoney = [[UIView alloc] init];
        _vLineMoney.backgroundColor = [UIColor colorWithHexString:@"999999"];
    }
    return _vLineMoney;
}

- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = [UIColor colorWithHexString:@"efeff2"];
    }
    return _vLine;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
