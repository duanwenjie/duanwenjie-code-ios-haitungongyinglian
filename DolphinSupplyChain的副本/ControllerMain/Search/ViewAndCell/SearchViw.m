//
//  SearchViw.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/3.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "SearchViw.h"

@interface SearchViw ()

@property (nonatomic, copy) NSString *sKeyWord;

@property (nonatomic, strong) UIImageView *imgSearch;

@property (nonatomic, strong) UILabel *lblSearchName;

@end

@implementation SearchViw

- (instancetype)initWithKewWordName:(NSString *)sName
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.sKeyWord = sName;
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 2;
    self.clipsToBounds = YES;
    [self addSubview:self.imgSearch];
    
    [self addSubview:self.lblSearchName];
    
    [self.imgSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(7);
        make.left.equalTo(self.mas_left).offset(7);
        make.bottom.equalTo(self.mas_bottom).offset(-7);
        make.width.equalTo(self.imgSearch.mas_height);
    }];
    
    [self.lblSearchName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        make.left.equalTo(self.imgSearch.mas_right).offset(6);
    }];
}

- (void)loadView:(NSString *)sKeyWord
{
    self.lblSearchName.text = sKeyWord;
}


- (UIImageView *)imgSearch
{
    if (!_imgSearch) {
        _imgSearch = [[UIImageView alloc] init];
        _imgSearch.contentMode = UIViewContentModeScaleAspectFit;
        _imgSearch.image = [UIImage imageNamed:@"searchPage_04"];
    }
    return _imgSearch;
}

- (UILabel *)lblSearchName
{
    if (!_lblSearchName) {
        _lblSearchName = [[UILabel alloc] init];
        _lblSearchName.textColor = [UIColor colorWithHexString:@"666666"];
        _lblSearchName.font = [UIFont systemFontOfSize:12];
        _lblSearchName.text = self.sKeyWord;
    }
    return _lblSearchName;
}

@end
