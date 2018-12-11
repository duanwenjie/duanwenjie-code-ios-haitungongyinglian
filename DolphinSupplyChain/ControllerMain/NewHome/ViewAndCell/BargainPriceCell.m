//
//  BargainPriceCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/22.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "BargainPriceCell.h"
#import "ZXNImageView.h"
#import "BargainPriceModel.h"

@interface BargainPriceCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UICollectionView *cltMain;

@property (nonatomic, strong) NSArray *arrData;

@end

@implementation BargainPriceCell

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
    [self.contentView addSubview:self.vLine];
    [self.contentView addSubview:self.cltMain];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.cltMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.top.equalTo(self.vLine.mas_bottom).offset(0);
    }];
}

- (void)loadView:(NSArray *)array
{
    self.arrData = array;
    [self.cltMain reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BargainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BargainCell" forIndexPath:indexPath];
    [cell loadView:self.arrData[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.arrData.count - 1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didBargainPriceLastMore)]) {
            [self.delegate didBargainPriceLastMore];
        }
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didBargainPriceSelectItemAtIndex:)]) {
            [self.delegate didBargainPriceSelectItemAtIndex:indexPath.row];
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(145, 205);
}


- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _vLine;
}

- (UICollectionView *)cltMain
{
    if (!_cltMain) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _cltMain = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        _cltMain.showsHorizontalScrollIndicator = NO;
        _cltMain.delegate = self;
        _cltMain.dataSource = self;
        [_cltMain registerClass:[BargainCell class] forCellWithReuseIdentifier:@"BargainCell"];
        _cltMain.backgroundColor = [UIColor whiteColor];
    }
    return _cltMain;
}


@end


@interface BargainCell ()

@property (nonatomic, strong) ZXNImageView *imgProduct;

@property (nonatomic, strong) UILabel *lblProductTitle;

@property (nonatomic, strong) UILabel *lblProductPrice;

@property (nonatomic, strong) UIView *vMore;

@property (nonatomic, strong) UILabel *lblMore;

@property (nonatomic, strong) UIView *vLineMore;

@property (nonatomic, strong) UILabel *lblEnglishMore;

@end

@implementation BargainCell


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
    [self.contentView addSubview:self.imgProduct];
    [self.contentView addSubview:self.lblProductTitle];
    [self.contentView addSubview:self.lblProductPrice];
    
    [self.contentView addSubview:self.vMore];
    [self.vMore addSubview:self.lblMore];
    [self.vMore addSubview:self.vLineMore];
    [self.vMore addSubview:self.lblEnglishMore];
    
    [self.imgProduct mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(120);
    }];
    
    [self.lblProductTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgProduct.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
    }];
    
    [self.lblProductPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-8);
        make.height.mas_equalTo(15);
    }];
    
    [self.vMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 120));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.lblMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.centerX.equalTo(self.vMore.mas_centerX);
        make.centerY.equalTo(self.vMore.mas_centerY).offset(-8);
    }];
    
    [self.vLineMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblMore.mas_left).offset(0);
        make.right.equalTo(self.lblMore.mas_right).offset(0);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(self.lblMore.mas_bottom).offset(0);
    }];
    
    [self.lblEnglishMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.centerX.equalTo(self.vMore.mas_centerX);
        make.centerY.equalTo(self.vMore.mas_centerY).offset(8);
    }];
    
}

- (void)loadView:(BargainPriceModel *)dic
{
    if (dic.goods_name.length == 0 && dic.goods_sn.length == 0) {
        self.imgProduct.hidden = YES;
        self.lblProductTitle.hidden = YES;
        self.lblProductPrice.hidden = YES;
        
        self.vMore.hidden = NO;
    }
    else
    {
        self.imgProduct.hidden = NO;
        self.lblProductTitle.hidden = NO;
        self.lblProductPrice.hidden = NO;
        
        self.vMore.hidden = YES;
        
        [self.imgProduct downloadImage:dic.img_original backgroundImage:ZXNImageDefaul];
        self.lblProductTitle.text = dic.goods_name;
        self.lblProductPrice.text = [NSString stringWithFormat:@"￥%@",dic.price];
    }
    
    
    [self setNeedsLayout];
}

- (ZXNImageView *)imgProduct
{
    if (!_imgProduct) {
        _imgProduct = [[ZXNImageView alloc] init];
        _imgProduct.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgProduct;
}

- (UILabel *)lblProductTitle
{
    if (!_lblProductTitle) {
        _lblProductTitle = [[UILabel alloc] init];
        _lblProductTitle.font = [UIFont systemFontOfSize:13];
        _lblProductTitle.textColor = [UIColor colorWithHexString:@"333333"];
        _lblProductTitle.numberOfLines = 2;
    }
    return _lblProductTitle;
}

- (UILabel *)lblProductPrice
{
    if (!_lblProductPrice) {
        _lblProductPrice = [[UILabel alloc] init];
        _lblProductPrice.font = [UIFont systemFontOfSize:13];
        _lblProductPrice.numberOfLines = 1;
        _lblProductPrice.textColor = [UIColor colorWithHexString:@"e93140"];
        _lblProductPrice.textAlignment = NSTextAlignmentCenter;
    }
    return _lblProductPrice;
}

- (UIView *)vMore
{
    if (!_vMore) {
        _vMore = [[UIView alloc] init];
        _vMore.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
        _vMore.layer.borderWidth = 0.5;
        _vMore.hidden = YES;
    }
    return _vMore;
}

- (UILabel *)lblMore
{
    if (!_lblMore) {
        _lblMore = [[UILabel alloc] init];
        _lblMore.text = @"查看全部";
        _lblMore.textColor = [UIColor colorWithHexString:@"12a0ea"];
        _lblMore.font = [UIFont systemFontOfSize:14];
        _lblMore.textAlignment = NSTextAlignmentCenter;
    }
    return _lblMore;
}

- (UIView *)vLineMore
{
    if (!_vLineMore) {
        _vLineMore = [[UIView alloc] init];
        _vLineMore.backgroundColor = [UIColor colorWithHexString:@"999999"];
    }
    return _vLineMore;
}

- (UILabel *)lblEnglishMore
{
    if (!_lblEnglishMore) {
        _lblEnglishMore = [[UILabel alloc] init];
        _lblEnglishMore.text = @"See more";
        _lblEnglishMore.textColor = [UIColor colorWithHexString:@"666666"];
        _lblEnglishMore.font = [UIFont systemFontOfSize:14];
        _lblEnglishMore.textAlignment = NSTextAlignmentCenter;
    }
    return _lblEnglishMore;
}


@end


