//
//  CarouselCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/22.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "CarouselCell.h"
#import "SDCycleScrollView.h"
#import "CarouselModel.h"

@interface CarouselCell () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *sroCycle;

@property (nonatomic, strong) NSArray *arrImageData;

@end


@implementation CarouselCell

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
    [self.contentView addSubview:self.sroCycle];
    
    [self.sroCycle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.equalTo(self.contentView);
    }];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndex:)]) {
        [self.delegate didSelectItemAtIndex:index];
    }
}

- (void)loadView:(NSArray *)arrImageUrl isRefresh:(BOOL)bRefresh
{
    self.arrImageData = arrImageUrl;
    
    if (bRefresh) {
        self.sroCycle.imageURLStringsGroup = nil;
        
        NSMutableArray *arrURL = [NSMutableArray array];
        [self.arrImageData enumerateObjectsUsingBlock:^(CarouselModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrURL addObject:obj.image];
        }];
    
        self.sroCycle.imageURLStringsGroup = arrURL;
    }
    else
    {
        if (self.sroCycle.imageURLStringsGroup.count != 0) {
            return;
        }
        NSMutableArray *arrURL = [NSMutableArray array];
        [self.arrImageData enumerateObjectsUsingBlock:^(CarouselModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrURL addObject:obj.image];
        }];
        
        self.sroCycle.imageURLStringsGroup = arrURL;
    }
}


- (SDCycleScrollView *)sroCycle
{
    if (!_sroCycle) {
        _sroCycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"Default_Logo"]];
        _sroCycle.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _sroCycle.autoScrollTimeInterval = 4;
        _sroCycle.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _sroCycle.pageControlDotSize = CGSizeMake(8, 8);
        _sroCycle.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    }
    return _sroCycle;
}


@end
