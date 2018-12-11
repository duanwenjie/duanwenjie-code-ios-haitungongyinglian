//
//  ConfirmOrderCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ConfirmOrderCell.h"
#import "ZXNImageView.h"

@interface ConfirmOrderCell ()

@property (nonatomic, strong) ZXNImageView *imgBuy;

@property (nonatomic, strong) UILabel *lblBuyName;

@property (nonatomic, strong) UILabel *lblBuyNumber;

@property (nonatomic, strong) UILabel *lblBuyMoney;

@property (nonatomic, strong) UILabel *lblWarning;


@end


@implementation ConfirmOrderCell

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
    [self.contentView addSubview:self.lblBuyName];
    [self.contentView addSubview:self.lblBuyNumber];
    [self.contentView addSubview:self.lblBuyMoney];
    [self.contentView addSubview:self.lblWarning];

    [self.imgBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        make.width.equalTo(self.imgBuy.mas_height);
    }];
    
    
    [self.lblBuyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgBuy.mas_right).offset(8);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-8);
    }];
    
    
    [self.lblBuyNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgBuy.mas_right).offset(8);
        make.bottom.equalTo(self.lblBuyMoney.mas_top).offset(0);
        make.height.mas_offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-8);
    }];
    
    
    [self.lblBuyMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        make.height.mas_offset(18);
        make.left.equalTo(self.imgBuy.mas_right).offset(8);;
        make.right.equalTo(self.lblWarning.mas_left).offset(-8);
    }];
    
    [self.lblWarning mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        make.height.mas_offset(18);
        make.right.equalTo(self.contentView.mas_right).offset(-8);
        make.width.mas_offset(140);
    }];

}

- (void)loadView:(NSString *)sImageURL
         BuyName:(NSString *)sName
        MoneyOne:(NSString *)sNumber
        MoneyTwo:(NSString *)sMoney
         Warning:(BOOL)bWarning
        isB_Or_C:(BOOL)bC_Or_B

{
    [self.imgBuy downloadImage:sImageURL backgroundImage:ZXNImageDefaul];
    self.lblBuyName.text = sName;
    self.lblBuyNumber.text = [NSString stringWithFormat:@"数量: %@",sNumber];
    self.lblBuyMoney.text = [NSString stringWithFormat:@"¥ %@",sMoney];
    
    if (!bC_Or_B) {
        if (bWarning) {
            self.lblWarning.hidden = NO;
        }
        else
        {
            self.lblWarning.hidden = YES;
        }
    }
    [self setNeedsLayout];

}

#pragma mark - 懒加载
- (ZXNImageView *)imgBuy
{
    if (!_imgBuy) {
        _imgBuy = [[ZXNImageView alloc] init];
        _imgBuy.contentMode = UIViewContentModeScaleAspectFit;
        _imgBuy.layer.borderColor = [UIColor colorWithHexString:@"dcdcdc"].CGColor;
        _imgBuy.layer.borderWidth = 0.5;
    }
    return _imgBuy;
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

- (UILabel *)lblBuyNumber
{
    if (!_lblBuyNumber) {
        _lblBuyNumber = [[UILabel alloc] init];
        _lblBuyNumber.textColor = [UIColor colorWithHexString:@"666666"];
        _lblBuyNumber.font = [UIFont systemFontOfSize:12];
    }
    return _lblBuyNumber;
}

- (UILabel *)lblBuyMoney
{
    if (!_lblBuyMoney) {
        _lblBuyMoney = [[UILabel alloc] init];
        _lblBuyMoney.textColor = [UIColor redColor];
        _lblBuyMoney.font = [UIFont systemFontOfSize:14];
    }
    return _lblBuyMoney;
}

- (UILabel *)lblWarning
{
    if (!_lblWarning) {
        _lblWarning = [[UILabel alloc] init];
        _lblWarning.textColor = [UIColor redColor];
        _lblWarning.font = [UIFont systemFontOfSize:15];
        _lblWarning.text = @"采购该商品需审核";
        _lblWarning.textAlignment = NSTextAlignmentCenter;
        _lblWarning.hidden = YES;
    }
    return _lblWarning;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
