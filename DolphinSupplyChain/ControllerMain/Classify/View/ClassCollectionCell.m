//
//  ClassCollectionCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/13.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ClassCollectionCell.h"


@implementation ClassCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)loadView:(NSString *)sName
{
    self.lblName.text = sName;
    
    [self setNeedsLayout];
}


- (void)initView
{
    [self.contentView addSubview:self.lblName];
    
    [self.lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.contentView);
    }];
}


- (UILabel *)lblName
{
    if (!_lblName) {
        _lblName = [[UILabel alloc] init];
        _lblName.textColor = [UIColor blackColor];
        _lblName.font = [UIFont systemFontOfSize:12];
    }
    return _lblName;
}


@end
