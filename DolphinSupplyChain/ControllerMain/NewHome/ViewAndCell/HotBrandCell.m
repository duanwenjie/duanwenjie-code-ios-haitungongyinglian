//
//  HotBrandCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/22.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "HotBrandCell.h"
#import "ZXNImageView.h"
#import "HotBrandModel.h"

@interface HotBrandCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *sroMain;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *arrayData;

@property (nonatomic, strong) UIView *vBack;

@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, assign) BOOL bShow;

@end

@implementation HotBrandCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bShow = YES;
        [self initView];
    }
    return self;
}


- (void)initView
{
    [self.contentView addSubview:self.vLine];
    [self.contentView addSubview:self.vBack];
    [self.vBack addSubview:self.sroMain];
    [self.vBack addSubview:self.pageControl];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.vBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.vLine.mas_bottom).offset(0);
    }];
    
    [self.sroMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vBack);
        make.top.equalTo(self.vBack.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.top.equalTo(self.sroMain.mas_bottom).offset(3);
        make.height.mas_equalTo(15);
    }];
}

- (void)tapBrand:(UITapGestureRecognizer *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didHotBrandSelectItemAtIndex:)]) {
        [self.delegate didHotBrandSelectItemAtIndex:[sender view].tag];
    }
}


// scrollview 减速停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / kDisWidth;
    self.pageControl.currentPage = index;
}



- (void)loadView:(NSArray *)arrData isRefresh:(BOOL)bRefresh
{
    self.arrayData = arrData;
    if (bRefresh) {
        self.bShow = YES;
        [self.sroMain.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    
    if (!self.bShow) {
        return;
    }
    
    if (self.arrayData.count <= 6) {
        [self.sroMain setContentSize:CGSizeMake(kDisWidth, 178)];
        self.pageControl.numberOfPages = 0;
        self.pageControl.hidden = YES;
    }
    
    if (self.arrayData.count > 6 && self.arrayData.count <= 12) {
        [self.sroMain setContentSize:CGSizeMake(kDisWidth * 2, 178)];
        self.pageControl.numberOfPages = 2;
        self.pageControl.hidden = NO;
    }
    
    if (self.arrayData.count > 12 && self.arrayData.count <= 18) {
        [self.sroMain setContentSize:CGSizeMake(kDisWidth * 3, 178)];
        self.pageControl.numberOfPages = 3;
        self.pageControl.hidden = NO;
    }
    
    [self.arrayData enumerateObjectsUsingBlock:^(HotBrandModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == 0 || idx == 1 || idx == 2) {
            UIView *vBrand = [self returnBrandView:obj.logo :obj.brand_name :idx];
            vBrand.frame = CGRectMake(15 + (idx * ((kDisWidth - 48)/3 + 9)), 10, (kDisWidth - 48)/3, 75);
        }
        if (idx == 3 || idx == 4 || idx == 5) {
            UIView *vBrand = [self returnBrandView:obj.logo :obj.brand_name :idx];
            vBrand.frame = CGRectMake(15 + ((idx - 3) * ((kDisWidth - 48)/3 + 9)), 94, (kDisWidth - 48)/3, 75);
        }
        if (idx == 6 || idx == 7 || idx == 8) {
            UIView *vBrand = [self returnBrandView:obj.logo :obj.brand_name :idx];
            vBrand.frame = CGRectMake(15 + ((idx - 6) * ((kDisWidth - 48)/3 + 9)) + kDisWidth, 10, (kDisWidth - 48)/3, 75);
        }
        if (idx == 9 || idx == 10 || idx == 11) {
            UIView *vBrand = [self returnBrandView:obj.logo :obj.brand_name :idx];
            vBrand.frame = CGRectMake(15 + ((idx - 9) * ((kDisWidth - 48)/3 + 9)) + kDisWidth, 94, (kDisWidth - 48)/3, 75);
        }
        if (idx == 12 || idx == 13 || idx == 14) {
            UIView *vBrand = [self returnBrandView:obj.logo :obj.brand_name :idx];
            vBrand.frame = CGRectMake(15 + ((idx - 12) * ((kDisWidth - 48)/3 + 9)) + (kDisWidth * 2), 10, (kDisWidth - 48)/3, 75);
        }
        if (idx == 15 || idx == 16 || idx == 17) {
            UIView *vBrand = [self returnBrandView:obj.logo :obj.brand_name :idx];
            vBrand.frame = CGRectMake(15 + ((idx - 15) * ((kDisWidth - 48)/3 + 9)) + (kDisWidth * 2), 94, (kDisWidth - 48)/3, 75);
        }
        
        self.bShow = NO;
    }];    
}


- (UIView *)returnBrandView:(NSString *)sImageURL :(NSString *)sName :(NSInteger)iPage
{
    UIView *vBack = [[UIView alloc] init];
    vBack.layer.borderColor = [UIColor colorWithHexString:@"dcdcdc"].CGColor;
    vBack.layer.borderWidth = 0.5;
    vBack.tag = iPage;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBrand:)];
    
    [vBack addGestureRecognizer:tap];
    
    [self.sroMain addSubview:vBack];
    
    ZXNImageView *imgBrand = [[ZXNImageView alloc] init];
    imgBrand.contentMode = UIViewContentModeScaleAspectFit;
    [imgBrand downloadImage:sImageURL backgroundImage:ZXNImageDefaul];
    [vBack addSubview:imgBrand];
    
    [imgBrand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(vBack);
        make.height.mas_equalTo(48);
    }];
    
    UILabel *lblName = [[UILabel alloc] init];
    lblName.text = sName;
    lblName.font = [UIFont systemFontOfSize:13];
    lblName.textColor = [UIColor colorWithHexString:@"414141"];
    lblName.textAlignment = NSTextAlignmentCenter;
    [vBack addSubview:lblName];
    
    [lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vBack.mas_left).offset(4);
        make.right.equalTo(vBack.mas_right).offset(-4);
        make.height.mas_equalTo(22);
        make.top.equalTo(imgBrand.mas_bottom).offset(0);
    }];
    
    return vBack;
}

- (UIScrollView *)sroMain
{
    if (!_sroMain) {
        _sroMain = [[UIScrollView alloc] init];
        _sroMain.pagingEnabled = YES;
        _sroMain.delegate = self;
        _sroMain.bounces = NO;
        _sroMain.showsHorizontalScrollIndicator = NO;
        //禁用滚动到最顶部的属性
        _sroMain.scrollsToTop = NO;
    }
    return _sroMain;
}

- (UIView *)vBack
{
    if (!_vBack) {
        _vBack = [[UIView alloc] init];
        _vBack.backgroundColor = [UIColor whiteColor];
    }
    return _vBack;
}

- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _vLine;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        
        // 设置非选中页的圆点颜色
        _pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"c8c8c8"];
        // 设置选中页的圆点颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        // 禁止默认的点击功能
        _pageControl.enabled = NO;
    }
    return _pageControl;
}


@end
