//
//  BuyListHeadView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/30.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "BuyListHeadView.h"
#import "ZXNTool.h"

@interface BuyListHeadView ()

// 分类视图
@property (nonatomic, strong) UIView *vClassify;

@property (nonatomic, strong) UILabel *lblClassifyName;

@property (nonatomic, strong) UIImageView *imgClassifyArrows;

@property (nonatomic, strong) UIView *vLineOne;

// 人气
@property (nonatomic, strong) UIButton *btnPopularity;

@property (nonatomic, strong) UIView *vLineTwo;

// 销量
@property (nonatomic, strong) UIButton *btnSales;

@property (nonatomic, strong) UIView *vLineThree;

// 价格
@property (nonatomic, strong) UIView *vPrice;

@property (nonatomic, strong) UILabel *lblPriceyName;

@property (nonatomic, strong) UIImageView *imgPriceArrows;

@property (nonatomic, strong) UIView *vLineFour;

// 筛选
@property (nonatomic, strong) UIButton *btnScreen;

@property (nonatomic, strong) UIView *vLineFive;

@property (nonatomic, assign) BOOL bHighOrLow;

// 筛选条件

@property (nonatomic, strong) UIView *vLineSix;

@property (nonatomic, strong) UIView *vScreen;

@property (nonatomic, strong) UIButton *btnOnlyGoods;

@property (nonatomic, strong) UIButton *btnBrand;

@property (nonatomic, strong) UIButton *btnDelete;

@end

@implementation BuyListHeadView


- (instancetype)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.bHighOrLow = NO;
        [self initView];
    }
    return self;
}


- (void)initView
{
    CGFloat fWidth = kDisWidth/6;
    
    [self addSubview:self.vClassify];
    [self.vClassify addSubview:self.lblClassifyName];
    [self.vClassify addSubview:self.imgClassifyArrows];
    
    [self addSubview:self.vLineOne];
    
    [self addSubview:self.btnPopularity];
    
    [self addSubview:self.vLineTwo];
    
    [self addSubview:self.btnSales];
    
    [self addSubview:self.vLineThree];
    
    [self addSubview:self.vPrice];
    [self.vPrice addSubview:self.lblPriceyName];
    [self.vPrice addSubview:self.imgPriceArrows];
    
    [self addSubview:self.vLineFour];
    
    [self addSubview:self.btnScreen];
    
    [self addSubview:self.vLineFive];
    
    [self addSubview:self.vScreen];
    [self.vScreen addSubview:self.btnOnlyGoods];
    [self.vScreen addSubview:self.btnBrand];
    [self.vScreen addSubview:self.btnDelete];
    
    [self addSubview:self.vLineSix];
    
    [self.vClassify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.height.mas_equalTo(43);
        make.width.mas_equalTo(fWidth * 2);
    }];
    
    
    [self.lblClassifyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vClassify.mas_centerY);
        make.centerX.equalTo(self.vClassify.mas_centerX).offset(-6);
        make.height.equalTo(self.vClassify.mas_height);
    }];
    
    [self.imgClassifyArrows mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.vClassify.mas_height);
        make.width.mas_equalTo(10);
        make.left.equalTo(self.lblClassifyName.mas_right).offset(5);
        make.top.equalTo(self.lblPriceyName.mas_top);
    }];
    
    [self.vLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.vLineFive.mas_top).offset(-10);
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.vClassify.mas_right).offset(0);
        make.width.mas_equalTo(1);
    }];
    
    [self.btnPopularity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.width.mas_equalTo(fWidth);
        make.height.mas_equalTo(43);
        make.left.equalTo(self.vClassify.mas_right);
    }];
    
    [self.vLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.vLineFive.mas_top).offset(-10);
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.btnPopularity.mas_right);
        make.width.mas_equalTo(1);
    }];
    
    [self.btnSales mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.width.mas_equalTo(fWidth);
        make.height.mas_equalTo(43);
        make.left.equalTo(self.btnPopularity.mas_right);
    }];
    
    [self.vLineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.vLineFive.mas_top).offset(-10);
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.btnSales.mas_right);
        make.width.mas_equalTo(1);
    }];
    
    [self.vPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.width.mas_equalTo(fWidth);
        make.height.mas_equalTo(43);
        make.left.equalTo(self.btnSales.mas_right);
    }];
    
    [self.lblPriceyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vPrice.mas_centerY);
        make.width.mas_equalTo(30);
        make.height.equalTo(self.vPrice.mas_height);
        make.centerX.equalTo(self.vPrice.mas_centerX).offset(-4);
    }];
    
    [self.imgPriceArrows mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.vPrice.mas_height);
        make.width.mas_equalTo(10);
        make.left.equalTo(self.lblPriceyName.mas_right).offset(4);
        make.top.equalTo(self.lblPriceyName.mas_top);
    }];
    
    [self.vLineFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.vLineFive.mas_top).offset(-10);
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.vPrice.mas_right);
        make.width.mas_equalTo(1);
    }];
    
    [self.btnScreen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.width.mas_equalTo(fWidth);
        make.height.mas_equalTo(43);
        make.left.equalTo(self.vPrice.mas_right);
    }];
    
    [self.vLineFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.mas_top).offset(43);
    }];
    
    [self.vScreen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLineFive.mas_bottom).offset(0);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    
    [self.btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vScreen.mas_top).offset(7);
        make.bottom.equalTo(self.vScreen.mas_bottom).offset(-7);
        make.right.equalTo(self.vScreen.mas_right).offset(-12);
        make.width.mas_equalTo(40);
    }];
    
    [self.vLineSix mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.mas_top).offset(84);
    }];
    
    self.btnOnlyGoods.hidden = YES;
    self.btnBrand.hidden = YES;
}


- (void)loadView:(NSString *)sLblClassifyName
{
    self.lblClassifyName.text = sLblClassifyName;
}

#pragma mark - 点击事件
- (void)tapClassifyView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapClassify)]) {
        [self.delegate tapClassify];
    }
}

- (void)selectPopularity:(UIButton *)btn
{
    if (btn.selected) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapPopularity)]) {
        btn.selected = YES;
        self.btnSales.selected = NO;
        self.lblPriceyName.textColor = [UIColor colorWithHexString:@"333333"];
        self.imgPriceArrows.image = [UIImage imageNamed:@"Buy_List_NO_Select"];
        [self.delegate tapPopularity];
    }
}

- (void)selectSales:(UIButton *)btn
{
    if (btn.selected) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapSales)]) {
        btn.selected = YES;
        self.btnPopularity.selected = NO;
        self.lblPriceyName.textColor = [UIColor colorWithHexString:@"333333"];
        self.imgPriceArrows.image = [UIImage imageNamed:@"Buy_List_NO_Select"];
        [self.delegate tapSales];
    }
}

- (void)tapPriceView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapPriceHightOrLow:)]) {
        self.btnPopularity.selected = NO;
        self.btnSales.selected = NO;
        self.lblPriceyName.textColor = [UIColor colorWithHexString:@"12a0ea"];
        if (self.bHighOrLow == NO) {
            [self.delegate tapPriceHightOrLow:@"Low"];
            self.imgPriceArrows.image = [UIImage imageNamed:@"Buy_List_Select_Up"];
        }
        else
        {
            [self.delegate tapPriceHightOrLow:@"Hight"];
            self.imgPriceArrows.image = [UIImage imageNamed:@"Buy_List_Select_Down"];
        }
        self.bHighOrLow = !self.bHighOrLow;
    }
}

- (void)selectScreen:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapScreen)]) {
        [self.delegate tapScreen];
    }
}

- (void)DeleteOnlyGoods
{
    if (self.btnBrand.hidden) {
        [self DeleteAll];
    }
    else
    {
        self.btnOnlyGoods.hidden = YES;
        [self.btnBrand setFrame:CGRectMake(12, 7, self.btnBrand.width, 26)];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(tapDeleteOnlyGoods)]) {
            [self.delegate tapDeleteOnlyGoods];
        }
    }
}

- (void)DeleteBrand
{
    if (self.btnOnlyGoods.hidden) {
        [self DeleteAll];
    }
    else
    {
        self.btnBrand.hidden = YES;
        if (self.delegate && [self.delegate respondsToSelector:@selector(tapDeleteBrand)]) {
            [self.delegate tapDeleteBrand];
        }
    }
}

- (void)DeleteAll
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapDeleteAll)]) {
        
        self.btnOnlyGoods.hidden = YES;
        self.btnBrand.hidden = YES;
        
        [self.delegate tapDeleteAll];
    }
}


- (void)addOnlyGoods
{
    self.btnOnlyGoods.hidden = NO;
    if (!self.btnBrand.hidden) {
        
        [self.btnBrand setFrame:CGRectMake((self.btnOnlyGoods.right + 10), 7, self.btnBrand.width, 26)];
    }
}

- (void)addBrand:(NSString *)sText
{
    CGSize size = [ZXNTool gainTextSize:kFont13 text:sText];
    [self.btnBrand setTitle:sText forState:UIControlStateNormal];
    self.btnBrand.hidden = NO;
    if (self.btnOnlyGoods.hidden) {
        [self.btnBrand setFrame:CGRectMake(12, 7, size.width + 30, 26)];
    }
    else
    {
        [self.btnBrand setFrame:CGRectMake((self.btnOnlyGoods.right + 10), 7, size.width + 30, 26)];
    }
}


- (BOOL)deleteOnlyHaveGoods
{
    if (self.btnBrand.hidden) {
        [self DeleteAll];
        return YES;
    }
    else
    {
        self.btnOnlyGoods.hidden = YES;
        
        [self.btnBrand setFrame:CGRectMake(12, 7, self.btnBrand.width, 26)];
        return NO;
    }
}

- (BOOL)deleteBrandButton
{
    if (self.btnOnlyGoods.hidden) {
        [self DeleteAll];
        return YES;
    }
    else
    {
        self.btnBrand.hidden = YES;
        return NO;
    }
}


#pragma mark - 懒加载
- (UIView *)vClassify
{
    if (!_vClassify) {
        _vClassify = [[UIView alloc] init];
        _vClassify.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tapClassifyView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClassifyView)];
        [_vClassify addGestureRecognizer:tapClassifyView];
    }
    return _vClassify;
}

- (UILabel *)lblClassifyName
{
    if (!_lblClassifyName) {
        _lblClassifyName = [[UILabel alloc] init];
        _lblClassifyName.textColor = [UIColor colorWithHexString:@"333333"];
        _lblClassifyName.textAlignment = NSTextAlignmentCenter;
        _lblClassifyName.font = [UIFont systemFontOfSize:14];
        _lblClassifyName.text = @"全部";
    }
    return _lblClassifyName;
}

- (UIImageView *)imgClassifyArrows
{
    if (!_imgClassifyArrows) {
        _imgClassifyArrows = [[UIImageView alloc] init];
        _imgClassifyArrows.contentMode = UIViewContentModeScaleAspectFit;
        _imgClassifyArrows.image = [UIImage imageNamed:@"Buy_List_Triangle"];
    }
    return _imgClassifyArrows;
}


- (UIButton *)btnPopularity
{
    if (!_btnPopularity) {
        _btnPopularity = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnPopularity setTitle:@"人气" forState:UIControlStateNormal];
        [_btnPopularity setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [_btnPopularity setTitleColor:[UIColor colorWithHexString:@"12a0ea"] forState:UIControlStateSelected];
        _btnPopularity.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnPopularity.titleLabel.textAlignment = NSTextAlignmentCenter;
        _btnPopularity.selected = NO;
        [_btnPopularity addTarget:self action:@selector(selectPopularity:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPopularity;
}

- (UIButton *)btnSales
{
    if (!_btnSales) {
        _btnSales = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSales setTitle:@"销量" forState:UIControlStateNormal];
        [_btnSales setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [_btnSales setTitleColor:[UIColor colorWithHexString:@"12a0ea"] forState:UIControlStateSelected];
        _btnSales.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnSales.titleLabel.textAlignment = NSTextAlignmentCenter;
        _btnSales.selected = NO;
        [_btnSales addTarget:self action:@selector(selectSales:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSales;
}

- (UIView *)vPrice
{
    if (!_vPrice) {
        _vPrice = [[UIView alloc] init];
        
        UITapGestureRecognizer *tapPriceView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPriceView)];
        [_vPrice addGestureRecognizer:tapPriceView];
    }
    return _vPrice;
}

- (UILabel *)lblPriceyName
{
    if (!_lblPriceyName) {
        _lblPriceyName = [[UILabel alloc] init];
        _lblPriceyName.textColor = [UIColor colorWithHexString:@"333333"];
        _lblPriceyName.textAlignment = NSTextAlignmentCenter;
        _lblPriceyName.font = [UIFont systemFontOfSize:14];
        _lblPriceyName.text = @"价格";
    }
    return _lblPriceyName;
}

- (UIImageView *)imgPriceArrows
{
    if (!_imgPriceArrows) {
        _imgPriceArrows = [[UIImageView alloc] init];
        _imgPriceArrows.contentMode = UIViewContentModeScaleAspectFit;
        _imgPriceArrows.image = [UIImage imageNamed:@"Buy_List_NO_Select"];
    }
    return _imgPriceArrows;
}

- (UIButton *)btnScreen
{
    if (!_btnScreen) {
        _btnScreen = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnScreen setTitle:@"筛选" forState:UIControlStateNormal];
        [_btnScreen setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [_btnScreen setTitleColor:[UIColor colorWithHexString:@"12a0ea"] forState:UIControlStateSelected];
        [_btnScreen setTitleColor:[UIColor colorWithHexString:@"12a0ea"] forState:UIControlStateHighlighted];
        _btnScreen.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnScreen.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btnScreen addTarget:self action:@selector(selectScreen:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnScreen;
}

- (UIView *)vLineOne
{
    if (!_vLineOne) {
        _vLineOne = [[UIView alloc] init];
        _vLineOne.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _vLineOne;
}

- (UIView *)vLineTwo
{
    if (!_vLineTwo) {
        _vLineTwo = [[UIView alloc] init];
        _vLineTwo.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _vLineTwo;
}

- (UIView *)vLineThree
{
    if (!_vLineThree) {
        _vLineThree = [[UIView alloc] init];
        _vLineThree.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _vLineThree;
}

- (UIView *)vLineFour
{
    if (!_vLineFour) {
        _vLineFour = [[UIView alloc] init];
        _vLineFour.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _vLineFour;
}

- (UIView *)vLineFive
{
    if (!_vLineFive) {
        _vLineFive = [[UIView alloc] init];
        _vLineFive.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _vLineFive;
}


- (UIView *)vScreen
{
    if (!_vScreen) {
        _vScreen = [[UIView alloc] init];
        _vScreen.backgroundColor = [UIColor whiteColor];
    }
    return _vScreen;
}

- (UIButton *)btnOnlyGoods
{
    if (!_btnOnlyGoods) {
        _btnOnlyGoods = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnOnlyGoods setTitle:@"仅看有货" forState:UIControlStateNormal];
        [_btnOnlyGoods setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        _btnOnlyGoods.titleLabel.font = kFont13;
        _btnOnlyGoods.layer.borderColor = ColorLine.CGColor;
        _btnOnlyGoods.layer.borderWidth = 0.5;
        
        
        
        [_btnOnlyGoods setImage:[UIImage drawImageWithName:@"close_Two" size:CGSizeMake(15, 15)] forState:UIControlStateNormal];
        [_btnOnlyGoods setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        _btnOnlyGoods.frame = CGRectMake(12, 7, 80, 26);
        
        [_btnOnlyGoods addTarget:self action:@selector(DeleteOnlyGoods) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnOnlyGoods;
}

- (UIButton *)btnBrand
{
    if (!_btnBrand) {
        _btnBrand = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnBrand setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        _btnBrand.frame = CGRectMake(12, 7, 100, 26);
        _btnBrand.titleLabel.font = kFont13;
        _btnBrand.layer.borderColor = ColorLine.CGColor;
        _btnBrand.layer.borderWidth = 0.5;
        
        [_btnBrand setImage:[UIImage drawImageWithName:@"close_Two" size:CGSizeMake(15, 15)] forState:UIControlStateNormal];
        [_btnBrand setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [_btnBrand addTarget:self action:@selector(DeleteBrand) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnBrand;
}

- (UIButton *)btnDelete
{
    if (!_btnDelete) {
        _btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnDelete setTitle:@"清空" forState:UIControlStateNormal];
        [_btnDelete setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        
        _btnDelete.titleLabel.font = kFont13;
        _btnDelete.layer.borderColor = ColorLine.CGColor;
        _btnDelete.layer.borderWidth = 0.5;
        
        [_btnDelete addTarget:self action:@selector(DeleteAll) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnDelete;
}

- (UIView *)vLineSix
{
    if (!_vLineSix) {
        _vLineSix = [[UIView alloc] init];
        _vLineSix.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _vLineSix;
}



@end
