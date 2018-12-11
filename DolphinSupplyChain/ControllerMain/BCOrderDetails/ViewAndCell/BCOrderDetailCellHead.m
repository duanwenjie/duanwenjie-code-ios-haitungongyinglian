//
//  BCOrderDetailCellHead.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/15.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "BCOrderDetailCellHead.h"

@interface BCOrderDetailCellHead ()

@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UILabel *lblLogisticsState;

@property (nonatomic, strong) UILabel *lblLogisticsTime;

@property (nonatomic, strong) UIImageView *imgArrows;

@property (nonatomic, assign) NSInteger iSection;

@end

@implementation BCOrderDetailCellHead

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self.contentView addSubview:self.vLine];
    [self.contentView addSubview:self.lblLogisticsState];
    [self.contentView addSubview:self.lblLogisticsTime];
    [self.contentView addSubview:self.imgArrows];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(4);
    }];
    
    [self.lblLogisticsState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-40);
        make.top.equalTo(self.vLine.mas_bottom).offset(6);
        make.height.mas_equalTo(15);
    }];
    
    [self.lblLogisticsTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-40);
        make.top.equalTo(self.lblLogisticsState.mas_bottom).offset(0);
        make.height.mas_equalTo(11);
    }];
    
    [self.imgArrows mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLine.mas_bottom).offset(0);
        make.left.equalTo(self.lblLogisticsState.mas_right).offset(14);
        make.width.mas_equalTo(15);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    UITapGestureRecognizer *tapLogistics = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectLogistics)];
    [self.contentView addGestureRecognizer:tapLogistics];
}

- (void)selectLogistics
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectLogistics:)]) {
        [self.delegate selectLogistics:self.iSection];
    }
}

#pragma mark - 渲染界面
- (void)loadView:(NSString *)sLogisticsState
   LogisticsTime:(NSString *)sLogisticsTime
         section:(NSInteger)isection
{
    if ([sLogisticsState isEqualToString:@"订单物品列表信息"]) {
        self.imgArrows.hidden = YES;
    }
    else
    {
        self.imgArrows.hidden = NO;
    }
    self.iSection = isection;
    self.lblLogisticsState.text = sLogisticsState;
    self.lblLogisticsTime.text = sLogisticsTime;
    [self setNeedsLayout];
}


#pragma mark - 懒加载
- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    }
    return _vLine;
}

- (UILabel *)lblLogisticsState
{
    if (!_lblLogisticsState) {
        _lblLogisticsState = [[UILabel alloc] init];
        _lblLogisticsState.textColor = [UIColor colorWithHexString:@"24a02d"];
        _lblLogisticsState.font = [UIFont systemFontOfSize:12];
    }
    return _lblLogisticsState;
}

- (UILabel *)lblLogisticsTime
{
    if (!_lblLogisticsTime) {
        _lblLogisticsTime = [[UILabel alloc] init];
        _lblLogisticsTime.textColor = [UIColor colorWithHexString:@"999999"];
        _lblLogisticsTime.font = [UIFont systemFontOfSize:11];
    }
    return _lblLogisticsTime;
}

- (UIImageView *)imgArrows
{
    if (!_imgArrows) {
        _imgArrows = [[UIImageView alloc] init];
        _imgArrows.contentMode = UIViewContentModeScaleAspectFit;
        _imgArrows.image = [UIImage imageNamed:@"accessory"];
    }
    return _imgArrows;
}

@end
