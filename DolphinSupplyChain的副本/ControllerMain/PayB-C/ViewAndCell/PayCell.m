//
//  PayCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "PayCell.h"

@interface PayCell ()

@property (nonatomic, strong) UIImageView *imgIcon;

@property (nonatomic, strong) UIImageView *imgSelect;

@property (nonatomic, strong) UILabel *lblPayTypeName;

@property (nonatomic, strong) UILabel *lblPaysubhead;

@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UIImageView *imgRecommend;

@end


@implementation PayCell

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
    [self.contentView addSubview:self.imgIcon];
    [self.contentView addSubview:self.lblPayTypeName];
    [self.contentView addSubview:self.lblPaysubhead];
    [self.contentView addSubview:self.imgRecommend];
    [self.contentView addSubview:self.imgSelect];
    
    [self.contentView addSubview:self.vLine];
    
    [self.imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(8);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [self.lblPayTypeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(6);
        make.left.equalTo(self.imgIcon.mas_right).offset(10);
        make.height.mas_equalTo(15);
    }];
    
    [self.lblPaysubhead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblPayTypeName.mas_bottom).offset(4);
        make.left.equalTo(self.imgIcon.mas_right).offset(10);
        make.height.mas_equalTo(10);
        make.right.equalTo(self.contentView.mas_right).offset(-60);
    }];
    
    [self.imgRecommend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(6);
        make.left.equalTo(self.lblPayTypeName.mas_right).offset(8);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(17);
    }];
    
    [self.imgSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.width.mas_equalTo(20);
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)loadViewIcon:(NSString *)sIcon
             PayName:(NSString *)sPayName
           PayNeiRon:(NSString *)sPayNeiRon
              Select:(NSString *)sSelect
{
    self.imgIcon.image = [UIImage imageNamed:sIcon];
    self.lblPayTypeName.text = [NSString stringWithFormat:@"%@",sPayName];
    self.lblPaysubhead.text = [NSString stringWithFormat:@"%@",sPayNeiRon];
    
    if ([self.lblPayTypeName.text isEqualToString:@"支付宝"]) {
        self.imgRecommend.hidden = NO;
    }
    else
    {
        self.imgRecommend.hidden = YES;
    }
    if ([sSelect isEqualToString:@"1"]) {
        self.imgSelect.image = [UIImage imageNamed:@"choose_selected"];
    }
    else
    {
        self.imgSelect.image = [UIImage imageNamed:@"choose_default"];
    }
    
    [self setNeedsLayout];
}

- (UIImageView *)imgIcon
{
    if (!_imgIcon) {
        _imgIcon = [[UIImageView alloc] init];
        _imgIcon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgIcon;
}

- (UIImageView *)imgSelect
{
    if (!_imgSelect) {
        _imgSelect = [[UIImageView alloc] init];
        _imgSelect.contentMode = UIViewContentModeScaleAspectFit;
        _imgSelect.userInteractionEnabled = YES;
    }
    return _imgSelect;
}

- (UILabel *)lblPaysubhead
{
    if (!_lblPaysubhead) {
        _lblPaysubhead = [[UILabel alloc] init];
        _lblPaysubhead.font = [UIFont systemFontOfSize:10];
        _lblPaysubhead.textColor = [UIColor colorWithHexString:@"666666"];
    }
    return _lblPaysubhead;
}

- (UILabel *)lblPayTypeName
{
    if (!_lblPayTypeName) {
        _lblPayTypeName = [[UILabel alloc] init];
        _lblPayTypeName.font = [UIFont systemFontOfSize:12];
    }
    return _lblPayTypeName;
}

- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    }
    return _vLine;
}

- (UIImageView *)imgRecommend
{
    if (!_imgRecommend) {
        _imgRecommend = [[UIImageView alloc] init];
        _imgRecommend.image = [UIImage imageNamed:@"Paly_Recommend"];
        _imgRecommend.contentMode = UIViewContentModeScaleAspectFit;
        _imgRecommend.hidden = YES;
    }
    return _imgRecommend;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
