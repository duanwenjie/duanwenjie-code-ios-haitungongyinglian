//
//  NewHomeSearchView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/22.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "NewHomeSearchView.h"

@interface NewHomeSearchView ()

@property (nonatomic, strong) UIImageView *imgSearch;

@property (nonatomic, strong) UILabel *lblSearch;

@end

@implementation NewHomeSearchView

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
    [self addSubview:self.imgSearch];
    [self addSubview:self.lblSearch];
    
    [self.imgSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(15);
    }];
    
    [self.lblSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.imgSearch.mas_right).offset(8);
        make.right.equalTo(self.mas_right).offset(0);
    }];
}

- (UIImageView *)imgSearch
{
    if (!_imgSearch) {
        _imgSearch = [[UIImageView alloc] init];
        _imgSearch.image = [UIImage drawImageWithName:@"icon-search" size:CGSizeMake(15, 15)];
        _imgSearch.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgSearch;
}

- (UILabel *)lblSearch
{
    if (!_lblSearch) {
        _lblSearch = [[UILabel alloc] init];
        _lblSearch.text = @"请输入商品名称或关键字";
        _lblSearch.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _lblSearch.textAlignment = NSTextAlignmentLeft;
        _lblSearch.font = [UIFont systemFontOfSize:12];
    }
    return _lblSearch;
}


@end
