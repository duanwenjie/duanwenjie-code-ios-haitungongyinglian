//
//  LoseEfficacyCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/17.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "LoseEfficacyCell.h"
#import "CartZXNModel.h"


@interface LoseEfficacyCell ()

@property (nonatomic, strong) UILabel *lblLoseEfficacyText;

@property (nonatomic, strong) ZXNImageView *imgCommodity;

@property (nonatomic, strong) UILabel *lblCommodityName;

@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) CartZXNModel *CartModel;

@property (nonatomic, strong) NSIndexPath *indexP;

@end

@implementation LoseEfficacyCell



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
    [self.contentView addSubview:self.lblLoseEfficacyText];
    [self.contentView addSubview:self.imgCommodity];
    [self.contentView addSubview:self.lblCommodityName];
    [self.contentView addSubview:self.vLine];
    
    [self.lblLoseEfficacyText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(23, 14));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(10);
    }];
    
    [self.imgCommodity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.left.equalTo(self.lblLoseEfficacyText.mas_right).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        make.width.equalTo(self.imgCommodity.mas_height);
    }];
    
    [self.lblCommodityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.left.equalTo(self.imgCommodity.mas_right).offset(8);
        make.right.equalTo(self.contentView.mas_right).offset(-8);
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark - 界面渲染
- (void)loadViewModel:(CartZXNModel *)model Index:(NSIndexPath *)index isEdit:(BOOL)bEdit
{
    self.CartModel = model;
    self.indexP = index;
    
    [self.imgCommodity downloadImage:model.img_thumb backgroundImage:ZXNImageDefaul];
    self.lblCommodityName.text = model.goods_name;
    
    
}





#pragma mark - 懒加载
- (UILabel *)lblLoseEfficacyText
{
    if (!_lblLoseEfficacyText) {
        _lblLoseEfficacyText = [[UILabel alloc] init];
        _lblLoseEfficacyText.text = @"失效";
        _lblLoseEfficacyText.textAlignment = NSTextAlignmentCenter;
        _lblLoseEfficacyText.textColor = [UIColor whiteColor];
        _lblLoseEfficacyText.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
        _lblLoseEfficacyText.font = kFont10;
    }
    return _lblLoseEfficacyText;
}

- (ZXNImageView *)imgCommodity
{
    if (!_imgCommodity) {
        _imgCommodity = [[ZXNImageView alloc] init];
        _imgCommodity.contentMode = UIViewContentModeScaleAspectFit;
        _imgCommodity.layer.borderColor = [UIColor colorWithHexString:@"c1c1c1"].CGColor;
        _imgCommodity.layer.borderWidth = 0.5;
    }
    return _imgCommodity;
}

- (UILabel *)lblCommodityName
{
    if (!_lblCommodityName) {
        _lblCommodityName = [[UILabel alloc] init];
        _lblCommodityName.font = [UIFont systemFontOfSize:13];
        _lblCommodityName.numberOfLines = 2;
        _lblCommodityName.textColor = [UIColor colorWithHexString:@"999999"];
    }
    return _lblCommodityName;
}

- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = ColorLine;
    }
    return _vLine;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end


