//
//  HandleCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/5/16.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "HandleCell.h"
#import "ZXNTool.h"

@interface HandleCell ()

@property (nonatomic, strong) UILabel *lblGoodsName;

@property (nonatomic, strong) UILabel *lblAddress;

@property (nonatomic, strong) UILabel *lblMoney;


@end

@implementation HandleCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        [self initView];
        [self addViewLayout];
    }
    return self;
}


- (void)initView
{
    [self.contentView addSubview:self.lblGoodsName];
    [self.contentView addSubview:self.lblAddress];
    [self.contentView addSubview:self.lblMoney];
}

- (void)addViewLayout
{
    [self.lblGoodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    
    [self.lblAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblMoney.mas_top);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.lblMoney.mas_left).offset(-5);
    }];
    
    [self.lblMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(80);
    }];
}

- (void)loadDataGoodsName:(NSString *)sGoodsName
                  Address:(NSString *)sAddress
                    Money:(NSString *)sMonye
{
    self.lblGoodsName.text = sGoodsName;
    self.lblAddress.text = [NSString stringWithFormat:@"发货地:%@", sAddress];
    self.lblMoney.attributedText = [ZXNTool addMoneySignal:sMonye font:11];
    
    [self setNeedsLayout];
}



#pragma mark - 懒加载
- (UILabel *)lblGoodsName
{
    if (!_lblGoodsName) {
        _lblGoodsName = [[UILabel alloc] init];
        _lblGoodsName.numberOfLines = 2;
        _lblGoodsName.textColor = [UIColor colorWithHexString:@"333333"];
        _lblGoodsName.font = kFont13;
    }
    return _lblGoodsName;
}

- (UILabel *)lblAddress
{
    if (!_lblAddress) {
        _lblAddress = [[UILabel alloc] init];
        _lblAddress.textColor = [UIColor colorWithHexString:@"666666"];
        _lblAddress.font = kFont12;
        _lblAddress.numberOfLines = 2;
    }
    return _lblAddress;
}

- (UILabel *)lblMoney
{
    if (!_lblMoney) {
        _lblMoney = [[UILabel alloc] init];
        _lblMoney.textColor = [UIColor colorWithHexString:@"333333"];
        _lblMoney.textAlignment = NSTextAlignmentRight;
    }
    return _lblMoney;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
