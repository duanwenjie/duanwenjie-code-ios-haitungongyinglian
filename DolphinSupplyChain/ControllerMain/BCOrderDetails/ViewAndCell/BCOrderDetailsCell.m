//
//  BCOrderDetailsCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/15.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "BCOrderDetailsCell.h"
#import "ZXNImageView.h"

@interface BCOrderDetailsCell ()

@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) ZXNImageView *imgBuy;

@property (nonatomic, strong) UILabel *lblBuyName;

@property (nonatomic, strong) UILabel *lblBuyNumber;

@property (nonatomic, strong) UILabel *lblBuySKU;

@end


@implementation BCOrderDetailsCell


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
    [self.contentView addSubview:self.vLine];
    [self.contentView addSubview:self.imgBuy];
    [self.contentView addSubview:self.lblBuyName];
    [self.contentView addSubview:self.lblBuyNumber];
    [self.contentView addSubview:self.lblBuySKU];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.contentView.mas_left).offset(15);
    }];
    
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
        make.bottom.equalTo(self.imgBuy.mas_bottom).offset(0);
        make.height.mas_offset(16);
        make.right.equalTo(self.lblBuySKU.mas_left).offset(0);
    }];
    
    
    [self.lblBuySKU mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imgBuy.mas_bottom).offset(0);
        make.height.mas_offset(16);
        make.left.equalTo(self.lblBuyNumber.mas_right).offset(0);;
        make.right.equalTo(self.contentView.mas_right).offset(-8);
    }];
}

- (void)loadView:(NSString *)sImageURL
         BuyName:(NSString *)sName
        MoneyOne:(NSString *)sNumber
        MoneyTwo:(NSString *)sSKU
{
    [self.imgBuy downloadImage:sImageURL backgroundImage:ZXNImageDefaul];
    self.lblBuyName.text = sName;
    self.lblBuyNumber.text = [NSString stringWithFormat:@"数量: %@",sNumber];
    self.lblBuySKU.text = [NSString stringWithFormat:@"商品编号:%@",sSKU];
    
    [self setNeedsLayout];
}

#pragma mark - 懒加载
- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
    }
    return _vLine;
}

- (ZXNImageView *)imgBuy
{
    if (!_imgBuy) {
        _imgBuy = [[ZXNImageView alloc] init];
        _imgBuy.contentMode = UIViewContentModeScaleAspectFit;
        _imgBuy.layer.borderColor = [UIColor colorWithHexString:@"c1c1c1"].CGColor;
        _imgBuy.layer.borderWidth = 0.5;
        _imgBuy.layer.cornerRadius = 2;
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
        _lblBuyNumber.font = [UIFont systemFontOfSize:13];
    }
    return _lblBuyNumber;
}

- (UILabel *)lblBuySKU
{
    if (!_lblBuySKU) {
        _lblBuySKU = [[UILabel alloc] init];
        _lblBuySKU.textColor = [UIColor colorWithHexString:@"666666"];
        _lblBuySKU.font = [UIFont systemFontOfSize:13];
        _lblBuySKU.textAlignment = NSTextAlignmentRight;
    }
    return _lblBuySKU;
}




- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
