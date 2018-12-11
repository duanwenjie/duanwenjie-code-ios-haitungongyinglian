//
//  DistrictCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/4.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "DistrictCell.h"

@interface DistrictCell ()

@property (nonatomic, strong) UILabel *lblName;

@property (nonatomic, strong) UIImageView *imgTrue;

@end

@implementation DistrictCell


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
    [self.contentView addSubview:self.lblName];
    [self.contentView addSubview:self.imgTrue];
    
    [self.lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(20);
    }];
    
    [self.imgTrue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.lblName.mas_right).offset(10);
        make.width.mas_equalTo(10);
    }];
}

- (void)loadViewName:(NSString *)sName isSelect:(BOOL)bSelet
{
    self.lblName.text = sName;
    self.imgTrue.hidden = !bSelet;
    if (bSelet) {
        self.lblName.textColor = [UIColor colorWithHexString:@"12a0ea"];
    }
    else
    {
        self.lblName.textColor = [UIColor blackColor];
    }
    [self setNeedsLayout];
}



#pragma mark - 懒加载
- (UILabel *)lblName
{
    if (!_lblName) {
        _lblName = [[UILabel alloc] init];
        _lblName.font = [UIFont systemFontOfSize:14];
    }
    return _lblName;
}

- (UIImageView *)imgTrue
{
    if (!_imgTrue) {
        _imgTrue = [[UIImageView alloc] init];
        _imgTrue.contentMode = UIViewContentModeScaleAspectFit;
        _imgTrue.image = [UIImage imageNamed:@"Buy_Select"];
        _imgTrue.hidden = YES;
    }
    return _imgTrue;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
