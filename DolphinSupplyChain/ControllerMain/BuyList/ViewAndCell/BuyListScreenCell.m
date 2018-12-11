//
//  BuyListScreenCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/1.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "BuyListScreenCell.h"

@interface BuyListScreenCell ()

@property (nonatomic, strong) UILabel *lblScreenName;

@property (nonatomic, strong) UIImageView *imgTrue;

@end

@implementation BuyListScreenCell

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
    [self.contentView addSubview:self.lblClassifyName];
    [self.lblClassifyName addSubview:self.imgTrue];
    
    [self.lblClassifyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(15);
    }];
    
    [self.imgTrue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.width.mas_equalTo(10);
    }];
}


- (void)loadViewClassifyName:(NSString *)sClassifyName isSelect:(BOOL)bSelect
{
    self.lblScreenName.text = sClassifyName;
    
    if (!bSelect) {
        self.lblScreenName.textColor = [UIColor colorWithHexString:@"333333"];
        self.imgTrue.hidden = YES;
    }
    else
    {
        self.lblScreenName.textColor = [UIColor colorWithHexString:@"12a0ea"];
        self.imgTrue.hidden = NO;
    }
    [self setNeedsLayout];
}


#pragma mark - 懒加载
- (UILabel *)lblClassifyName
{
    if (!_lblScreenName) {
        _lblScreenName = [[UILabel alloc] init];
        _lblScreenName.textColor = [UIColor colorWithHexString:@"333333"];
        _lblScreenName.font = [UIFont systemFontOfSize:13];
    }
    return _lblScreenName;
}

- (UIImageView *)imgTrue
{
    if (!_imgTrue) {
        _imgTrue = [[UIImageView alloc] init];
        _imgTrue.image = [UIImage imageNamed:@"Buy_Select"];
        _imgTrue.contentMode = UIViewContentModeScaleAspectFit;
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
