//
//  OrderListCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/5.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "OrderListCell.h"
#import "ZXNImageView.h"
#import "ZXNTool.h"


@interface OrderListCell ()

@property (nonatomic, strong) ZXNImageView *imgBuy;

@property (nonatomic, strong) UILabel *lblBuyName;

@property (nonatomic, strong) UILabel *lblBuyQuantity;

@property (nonatomic, strong) UILabel *lblBuySKU;

@property (nonatomic, strong) UILabel *lblBuyMoneyOne;

@property (nonatomic, strong) UILabel *lblBuyMoneyTwo;

@property (nonatomic, strong) UIView *vLine;

@end

@implementation OrderListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self.contentView addSubview:self.imgBuy];
    [self.contentView addSubview:self.lblBuyName];
    
    [self.contentView addSubview:self.lblBuyQuantity];
    [self.contentView addSubview:self.lblBuySKU];
    
    [self.contentView addSubview:self.lblBuyMoneyOne];
    [self.contentView addSubview:self.lblBuyMoneyTwo];
    [self.contentView addSubview:self.vLine];
    
    [self.imgBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.equalTo(self.contentView.mas_height);
    }];
    
    
    [self.lblBuyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgBuy.mas_right).offset(8);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-8);
    }];
    
    
    [self.lblBuyQuantity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgBuy.mas_right).offset(8);
        make.height.mas_equalTo(18);
        make.bottom.equalTo(self.lblBuyMoneyOne.mas_top).offset(-4);
    }];
    
    [self.lblBuySKU mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-8);
        make.height.mas_equalTo(18);
        make.bottom.equalTo(self.lblBuyMoneyOne.mas_top).offset(-4);
    }];
    
    
    [self.lblBuyMoneyOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgBuy.mas_right).offset(8);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.height.mas_offset(18);
        make.right.equalTo(self.lblBuyMoneyTwo.mas_left).offset(-2);
    }];
    
    
    [self.lblBuyMoneyTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.height.mas_offset(16);
        make.left.equalTo(self.lblBuyMoneyOne.mas_right).offset(2);
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)loadView:(NSString *)sImageURL
         BuyName:(NSString *)sName
        Quantity:(NSString *)sQuantity
             SKU:(NSString *)sSKU
        MoneyOne:(NSString *)sMoneyOne
        MoneyTwo:(NSString *)sMoneyTwo
{
    [self.imgBuy downloadImage:sImageURL backgroundImage:ZXNImageDefaul];
    self.lblBuyName.text = sName;
    
    self.lblBuyQuantity.text = [NSString stringWithFormat:@"数量：%@", sQuantity];
    self.lblBuySKU.text = [NSString stringWithFormat:@"商品编号：%@", sSKU];
    self.lblBuyMoneyOne.attributedText = [ZXNTool addMoneySignal:sMoneyOne font:12];
    self.lblBuyMoneyTwo.text = [NSString stringWithFormat:@"¥ %@",sMoneyTwo];
    
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

- (UILabel *)lblBuyQuantity
{
    if (!_lblBuyQuantity) {
        _lblBuyQuantity = [[UILabel alloc] init];
        _lblBuyQuantity.textColor = [UIColor colorWithHexString:@"666666"];
        _lblBuyQuantity.font = [UIFont systemFontOfSize:13];
    }
    return _lblBuyQuantity;
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

- (UILabel *)lblBuyMoneyOne
{
    if (!_lblBuyMoneyOne) {
        _lblBuyMoneyOne = [[UILabel alloc] init];
        _lblBuyMoneyOne.textColor = [UIColor colorWithHexString:@"e93140"];
        _lblBuyMoneyOne.font = [UIFont systemFontOfSize:15];
    }
    return _lblBuyMoneyOne;
}

- (UILabel *)lblBuyMoneyTwo
{
    if (!_lblBuyMoneyTwo) {
        _lblBuyMoneyTwo = [[UILabel alloc] init];
        _lblBuyMoneyTwo.textColor = [UIColor colorWithHexString:@"999999"];
        _lblBuyMoneyTwo.font = [UIFont systemFontOfSize:13];
        
        UIView *vLine = [[UIView alloc] init];
        vLine.backgroundColor = [UIColor colorWithHexString:@"999999"];
        [_lblBuyMoneyTwo addSubview:vLine];
        
        [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_lblBuyMoneyTwo);
            make.centerY.equalTo(_lblBuyMoneyTwo.mas_centerY);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _lblBuyMoneyTwo;
}

- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
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
