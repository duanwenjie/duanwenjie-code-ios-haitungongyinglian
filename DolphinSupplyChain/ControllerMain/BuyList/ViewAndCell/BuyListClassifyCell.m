//
//  BuyListClassifyCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/30.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "BuyListClassifyCell.h"

@interface BuyListClassifyCell ()

@property (nonatomic, strong) UILabel *lblClassifyName;

@property (nonatomic, strong) UIImageView *imgTrue;

@end

@implementation BuyListClassifyCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.imgTrue.mas_left).offset(-5);
    }];
    
    [self.imgTrue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(10);
        make.left.equalTo(self.lblClassifyName.mas_right).offset(5);
    }];
}

- (void)loadViewClassifyName:(NSString *)sClassifyName isSelect:(BOOL)bSelect
{
    self.lblClassifyName.text = sClassifyName;
    
    if (!bSelect) {
        self.lblClassifyName.textColor = [UIColor colorWithHexString:@"333333"];
        self.imgTrue.hidden = YES;
    }
    else
    {
        self.lblClassifyName.textColor = [UIColor colorWithHexString:@"12a0ea"];
        self.imgTrue.hidden = NO;
    }
    [self setNeedsLayout];
}

#pragma mark - 懒加载
- (UILabel *)lblClassifyName
{
    if (!_lblClassifyName) {
        _lblClassifyName = [[UILabel alloc] init];
        _lblClassifyName.textColor = [UIColor colorWithHexString:@"333333"];
        _lblClassifyName.font = [UIFont systemFontOfSize:13];
    }
    return _lblClassifyName;
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

@end
