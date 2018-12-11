//
//  BuyGridCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/29.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "BuyGridCell.h"
#import "ZXNImageView.h"
#import "ZXNTool.h"

@interface BuyGridCell ()

@property (nonatomic, strong) ZXNImageView *imgBuy;

@property (nonatomic, strong) UIImageView *imgNOInventory;

@property (nonatomic, strong) UILabel *lblBuyName;

@property (nonatomic, strong) UILabel *lblBuyMoneyOne;

@property (nonatomic, strong) UILabel *lblBuyMoneyTwo;


@end

@implementation BuyGridCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self.contentView addSubview:self.imgBuy];
    [self.imgBuy addSubview:self.imgNOInventory];
    
    [self.contentView addSubview:self.lblBuyName];
    [self.contentView addSubview:self.lblBuyMoneyOne];
    [self.contentView addSubview:self.lblBuyMoneyTwo];
    
    [self.imgBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(self.imgBuy.mas_width);
    }];
    
    [self.imgNOInventory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgBuy.mas_top).offset(50);
        make.left.equalTo(self.imgBuy.mas_left).offset(50);
        make.right.equalTo(self.imgBuy.mas_right).offset(-50);
        make.bottom.equalTo(self.imgBuy.mas_bottom).offset(-50);
    }];
    
    [self.lblBuyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgBuy.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(8);
        make.right.equalTo(self.contentView.mas_right).offset(-8);
    }];
    
    
    [self.lblBuyMoneyOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.contentView.mas_left).offset(8);
        make.height.mas_offset(18);
        make.right.equalTo(self.lblBuyMoneyTwo.mas_left).offset(-4);
    }];
    
    
    [self.lblBuyMoneyTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-11);
        make.left.equalTo(self.lblBuyMoneyOne.mas_right).offset(4);
        make.height.mas_offset(16);
    }];
    
}

- (void)loadView:(NSString *)sImageURL
         BuyName:(NSString *)sName
        MoneyOne:(NSString *)sMoneyOne
        MoneyTwo:(NSString *)sMoneyTwo
       Inventory:(NSString *)sInventory
{
    [self.imgBuy downloadImage:sImageURL backgroundImage:ZXNImageDefaul];
    self.lblBuyName.text = sName;
    self.lblBuyMoneyOne.text = [NSString stringWithFormat:@"¥ %@",sMoneyOne];
    self.lblBuyMoneyTwo.text = [NSString stringWithFormat:@"¥ %@",sMoneyTwo];
    
    if ([sInventory isEqualToString:@"1"]) {
        self.imgNOInventory.hidden = YES;
    }
    else
    {
        self.imgNOInventory.hidden = YES;
    }
    
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

- (UIImageView *)imgNOInventory
{
    if (!_imgNOInventory) {
        _imgNOInventory = [[UIImageView alloc] init];
        _imgNOInventory.contentMode = UIViewContentModeScaleAspectFit;
        _imgNOInventory.image = [UIImage imageNamed:@"Buy_List_NO_Inventory"];
        _imgNOInventory.hidden = YES;
    }
    return _imgNOInventory;
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
        _lblBuyMoneyOne.font = [UIFont boldSystemFontOfSize:15];
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


@end
