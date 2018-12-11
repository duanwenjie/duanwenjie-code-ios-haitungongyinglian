//
//  TextScrollView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/4.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "TextScrollView.h"
#import "DownImageView.h"

@interface TextScrollView ()

@property (nonatomic, strong) DownImageView *vDownImage;

@property (nonatomic, strong) UIView *vBack;

/// 产地
@property (nonatomic, strong) UILabel *lblProducingAreaName;

@property (nonatomic, strong) UILabel *lblProducingArea;

/// 成分
@property (nonatomic, strong) UILabel *lblElementName;

@property (nonatomic, strong) UILabel *lblElement;

/// 包装
@property (nonatomic, strong) UILabel *lblCasingName;

@property (nonatomic, strong) UILabel *lblCasing;

/// 适用人群
@property (nonatomic, strong) UILabel *lblSuitName;

@property (nonatomic, strong) UILabel *lblSuit;

/// 规格
@property (nonatomic, strong) UILabel *lblSpecsName;

@property (nonatomic, strong) UILabel *lblSpecs;

/// 包装种类
@property (nonatomic, strong) UILabel *lblCasingTypeName;

@property (nonatomic, strong) UILabel *lblCasingType;

/// 生产厂家
@property (nonatomic, strong) UILabel *lblManufacturersName;

@property (nonatomic, strong) UILabel *lblManufacturers;

/// 保质期
@property (nonatomic, strong) UILabel *lblQualityName;

@property (nonatomic, strong) UILabel *lblQuality;

@end

@implementation TextScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAddView];
        [self initLayoutView];
    }
    return self;
}

- (void)initAddView
{
    [self addSubview:self.vDownImage];
    
    [self addSubview:self.vBack];
    
    
    [self.vBack addSubview:self.lblProducingAreaName];
    [self.vBack addSubview:self.lblProducingArea];
    
    [self.vBack addSubview:self.lblElementName];
    [self.vBack addSubview:self.lblElement];
    
    [self.vBack addSubview:self.lblCasingName];
    [self.vBack addSubview:self.lblCasing];
    
    [self.vBack addSubview:self.lblSuitName];
    [self.vBack addSubview:self.lblSuit];
    
    [self.vBack addSubview:self.lblSpecsName];
    [self.vBack addSubview:self.lblSpecs];
    
    [self.vBack addSubview:self.lblCasingTypeName];
    [self.vBack addSubview:self.lblCasingType];
    
    [self.vBack addSubview:self.lblManufacturersName];
    [self.vBack addSubview:self.lblManufacturers];
    
    [self.vBack addSubview:self.lblQualityName];
    [self.vBack addSubview:self.lblQuality];
}

- (void)initLayoutView
{
    [self.vDownImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.vBack.mas_top).offset(0);
        make.left.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kDisWidth, 40));
    }];
    
    [self.vBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.width.mas_equalTo(kDisWidth);
        make.left.equalTo(self);
        make.height.mas_equalTo(kDisHeight - kDisNavgation - 43 - 40 + 1);
        make.bottom.equalTo(self);
    }];
    
    
    [self.lblProducingAreaName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.left.equalTo(self.mas_left).offset(15);
        make.width.mas_equalTo(78);
    }];
    
    [self.lblProducingArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.left.equalTo(self.lblProducingAreaName.mas_right).offset(10);
        make.right.equalTo(self.vBack.mas_right).offset(-15);
    }];
    
    [self.lblElementName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.width.mas_equalTo(78);
        make.top.equalTo(self.lblProducingArea.mas_bottom).offset(15);
    }];
    
    [self.lblElement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblElementName.mas_top);
        make.left.equalTo(self.lblElementName.mas_right).offset(10);
        make.right.equalTo(self.vBack.mas_right).offset(-15);
    }];
    
    [self.lblCasingName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.width.mas_equalTo(78);
        make.top.equalTo(self.lblElement.mas_bottom).offset(15);
    }];
    
    [self.lblCasing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblCasingName.mas_top);
        make.left.equalTo(self.lblCasingName.mas_right).offset(10);
        make.right.equalTo(self.vBack.mas_right).offset(-15);
    }];
    
    [self.lblSuitName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.width.mas_equalTo(78);
        make.top.equalTo(self.lblCasing.mas_bottom).offset(15);
    }];
    
    [self.lblSuit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblSuitName.mas_top);
        make.left.equalTo(self.lblSuitName.mas_right).offset(10);
        make.right.equalTo(self.vBack.mas_right).offset(-15);
    }];
    
    [self.lblSpecsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.width.mas_equalTo(78);
        make.top.equalTo(self.lblSuit.mas_bottom).offset(15);
    }];
    
    [self.lblSpecs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblSpecsName.mas_top);
        make.left.equalTo(self.lblSpecsName.mas_right).offset(10);
        make.right.equalTo(self.vBack.mas_right).offset(-15);
    }];
    
    [self.lblCasingTypeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.width.mas_equalTo(78);
        make.top.equalTo(self.lblSpecs.mas_bottom).offset(15);
    }];
    
    [self.lblCasingType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblCasingTypeName.mas_top);
        make.left.equalTo(self.lblCasingTypeName.mas_right).offset(10);
        make.right.equalTo(self.vBack.mas_right).offset(-15);
    }];
    
    [self.lblManufacturersName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.width.mas_equalTo(78);
        make.top.equalTo(self.lblCasingType.mas_bottom).offset(15);
    }];
    
    [self.lblManufacturers mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblManufacturersName.mas_top);
        make.left.equalTo(self.lblManufacturersName.mas_right).offset(10);
        make.right.equalTo(self.vBack.mas_right).offset(-15);
    }];
    
    [self.lblQualityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.width.mas_equalTo(78);
        make.top.equalTo(self.lblManufacturers.mas_bottom).offset(15);
    }];
    
    [self.lblQuality mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblQualityName.mas_top);
        make.left.equalTo(self.lblQualityName.mas_right).offset(10);
        make.right.equalTo(self.vBack.mas_right).offset(-15);
    }];
}

- (void)loadTextData:(NSMutableArray *)arrAllData
{
    self.lblProducingArea.text = @"暂无信息";
    self.lblElement.text = @"暂无信息";
    self.lblCasing.text = @"暂无信息";
    self.lblSuit.text = @"暂无信息";
    self.lblSpecs.text = @"暂无信息";
    self.lblCasingType.text = @"暂无信息";
    self.lblManufacturers.text = @"暂无信息";
    self.lblQuality.text = @"暂无信息";
    
    self.lblProducingAreaName.text = @"原产地:";
    self.lblElementName.text = @"成分含量:";
    self.lblCasingName.text = @"包装/型号:";
    self.lblSuitName.text = @"适用人群:";
    self.lblSpecsName.text = @"规格:";
    self.lblCasingTypeName.text = @"包装种类:";
    self.lblManufacturersName.text = @"生产厂家:";
    self.lblQualityName.text = @"保质期:";
    
    [arrAllData enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        switch (idx) {
            case 0:
            {
                self.lblProducingArea.text = obj[@"value"];
                self.lblProducingAreaName.text = [NSString stringWithFormat:@"%@:", obj[@"name"]];
            }
                break;
            case 1:
            {
                self.lblElement.text = obj[@"value"];
                self.lblElementName.text = [NSString stringWithFormat:@"%@:", obj[@"name"]];
            }
                break;
            case 2:
            {
                self.lblCasing.text = obj[@"value"];
                self.lblCasingName.text = [NSString stringWithFormat:@"%@:", obj[@"name"]];
            }
                break;
            case 3:
            {
                self.lblSuit.text = obj[@"value"];
                self.lblSuitName.text = [NSString stringWithFormat:@"%@:", obj[@"name"]];
            }
                break;
            case 4:
            {
                self.lblSpecs.text = obj[@"value"];
                self.lblSpecsName.text = [NSString stringWithFormat:@"%@:", obj[@"name"]];
            }
                break;
            case 5:
            {
                self.lblCasingType.text = obj[@"value"];
                self.lblCasingTypeName.text = [NSString stringWithFormat:@"%@:", obj[@"name"]];
            }
                break;
            case 6:
            {
                self.lblManufacturers.text = obj[@"value"];
                self.lblManufacturersName.text = [NSString stringWithFormat:@"%@:", obj[@"name"]];
            }
                break;
            case 7:
            {
                self.lblQuality.text = obj[@"value"];
                self.lblQualityName.text = [NSString stringWithFormat:@"%@:", obj[@"name"]];
            }
                break;

        }
    }];
}


#pragma mark - 懒加载
- (DownImageView *)vDownImage
{
    if (!_vDownImage) {
        _vDownImage = [[DownImageView alloc] init];
    }
    return _vDownImage;
}

- (UIView *)vBack
{
    if (!_vBack) {
        _vBack = [[UIView alloc] init];
        _vBack.backgroundColor = [UIColor whiteColor];
    }
    return _vBack;
}

- (UILabel *)lblProducingAreaName
{
    if (!_lblProducingAreaName) {
        _lblProducingAreaName = [[UILabel alloc] init];
        _lblProducingAreaName.font = kFont12;
        _lblProducingAreaName.text = @"原产地:";
    }
    return _lblProducingAreaName;
}

- (UILabel *)lblProducingArea
{
    if (!_lblProducingArea) {
        _lblProducingArea = [[UILabel alloc] init];
        _lblProducingArea.font = kFont12;
        _lblProducingArea.text = @"暂无信息";
        _lblProducingArea.numberOfLines = 0;
    }
    return _lblProducingArea;
}

- (UILabel *)lblElementName
{
    if (!_lblElementName) {
        _lblElementName = [[UILabel alloc] init];
        _lblElementName.font = kFont12;
        _lblElementName.text = @"成分含量:";
    }
    return _lblElementName;
}

- (UILabel *)lblElement
{
    if (!_lblElement) {
        _lblElement = [[UILabel alloc] init];
        _lblElement.font = kFont12;
        _lblElement.text = @"暂无信息";
        _lblElement.numberOfLines = 0;
    }
    return _lblElement;
}

- (UILabel *)lblCasingName
{
    if (!_lblCasingName) {
        _lblCasingName = [[UILabel alloc] init];
        _lblCasingName.font = kFont12;
        _lblCasingName.text = @"包装/型号:";
    }
    return _lblCasingName;
}

- (UILabel *)lblCasing
{
    if (!_lblCasing) {
        _lblCasing = [[UILabel alloc] init];
        _lblCasing.font = kFont12;
        _lblCasing.text = @"暂无信息";
        _lblCasing.numberOfLines = 0;
    }
    return _lblCasing;
}

- (UILabel *)lblSuitName
{
    if (!_lblSuitName) {
        _lblSuitName = [[UILabel alloc] init];
        _lblSuitName.font = kFont12;
        _lblSuitName.text = @"适用人群:";
    }
    return _lblSuitName;
}

- (UILabel *)lblSuit
{
    if (!_lblSuit) {
        _lblSuit = [[UILabel alloc] init];
        _lblSuit.font = kFont12;
        _lblSuit.text = @"暂无信息";
        _lblSuit.numberOfLines = 0;
    }
    return _lblSuit;
}

- (UILabel *)lblSpecsName
{
    if (!_lblSpecsName) {
        _lblSpecsName = [[UILabel alloc] init];
        _lblSpecsName.font = kFont12;
        _lblSpecsName.text = @"规格:";
    }
    return _lblSpecsName;
}

- (UILabel *)lblSpecs
{
    if (!_lblSpecs) {
        _lblSpecs = [[UILabel alloc] init];
        _lblSpecs.font = kFont12;
        _lblSpecs.text = @"暂无信息";
        _lblSpecs.numberOfLines = 0;
    }
    return _lblSpecs;
}

- (UILabel *)lblCasingTypeName
{
    if (!_lblCasingTypeName) {
        _lblCasingTypeName = [[UILabel alloc] init];
        _lblCasingTypeName.font = kFont12;
        _lblCasingTypeName.text = @"包装种类:";
    }
    return _lblCasingTypeName;
}

- (UILabel *)lblCasingType
{
    if (!_lblCasingType) {
        _lblCasingType = [[UILabel alloc] init];
        _lblCasingType.font = kFont12;
        _lblCasingType.text = @"暂无信息";
        _lblCasingType.numberOfLines = 0;
    }
    return _lblCasingType;
}

- (UILabel *)lblManufacturersName
{
    if (!_lblManufacturersName) {
        _lblManufacturersName = [[UILabel alloc] init];
        _lblManufacturersName.font = kFont12;
        _lblManufacturersName.text = @"生产厂家:";
    }
    return _lblManufacturersName;
}

- (UILabel *)lblManufacturers
{
    if (!_lblManufacturers) {
        _lblManufacturers = [[UILabel alloc] init];
        _lblManufacturers.font = kFont12;
        _lblManufacturers.text = @"暂无信息";
        _lblManufacturers.numberOfLines = 0;
    }
    return _lblManufacturers;
}

- (UILabel *)lblQualityName
{
    if (!_lblQualityName) {
        _lblQualityName = [[UILabel alloc] init];
        _lblQualityName.font = kFont12;
        _lblQualityName.text= @"保质期:";
    }
    return _lblQualityName;
}

- (UILabel *)lblQuality
{
    if (!_lblQuality) {
        _lblQuality = [[UILabel alloc] init];
        _lblQuality.font = kFont12;
        _lblQuality.text = @"暂无信息";
        _lblQuality.numberOfLines = 0;
    }
    return _lblQuality;
}



@end
