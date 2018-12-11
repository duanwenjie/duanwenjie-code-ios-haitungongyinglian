//
//  HTTabbleView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/1/13.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "HTTabbleView.h"

@interface HTTabbleView ()

@property (nonatomic, strong) MJRefreshNormalHeader *head;

@property (nonatomic, strong) MJRefreshAutoNormalFooter *foot;

@end

@implementation HTTabbleView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = false;
            self.estimatedRowHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
            self.estimatedSectionFooterHeight = 0;
        } else {
            // Fallback on earlier versions
        }
      
    }
    
    return self;
}

- (void)addHeaderRefresh:(HeaderBlock)block
{
    self.head = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.foot != nil) {
            [self.foot resetNoMoreData];
        }
        block();
    }];
    self.head.lastUpdatedTimeLabel.hidden = YES;
    [self.head setTitle:@"轻轻下拉，刷新精彩" forState:MJRefreshStateIdle];
    [self.head setTitle:@"该放手了，我要刷新" forState:MJRefreshStatePulling];
    [self.head setTitle:@"小豚努力的刷新中..." forState:MJRefreshStateRefreshing];
    [self.head setTitle:@"该放手了，我要刷新" forState:MJRefreshStateWillRefresh];
    self.mj_header = self.head;
}


- (void)addFooterRefresh:(FooterBlock)block
{
    self.foot = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        block();
    }];
    [self.foot setTitle:@"" forState:MJRefreshStateIdle];
    [self.foot setTitle:@"加载中..." forState:MJRefreshStatePulling];
    [self.foot setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [self.foot setTitle:@"加载中..." forState:MJRefreshStateWillRefresh];
    [self.foot setTitle:@"别拉了，到底了~" forState:MJRefreshStateNoMoreData];
    self.mj_footer = self.foot;
}


- (void)beginRefreshing
{
    if (self.head == nil) {
        return;
    }
    if (self.foot != nil) {
        [self.foot resetNoMoreData];
    }
    [self.head beginRefreshing];
}


- (void)endHeaderRefreshing
{
    if (self.head == nil) {
        return;
    }
    [self.head endRefreshing];
}



- (void)endFooterRefreshing
{
    if (self.foot == nil) {
        return;
    }
    [self.foot endRefreshing];
}



- (void)showNoMoreData
{
    if (self.foot == nil) {
        return;
    }
    [self.foot endRefreshingWithNoMoreData];
}



- (void)showNoMoreData:(NSString *)sTitle
{
    if (self.foot == nil) {
        return;
    }
    [self.foot endRefreshingWithNoMoreData];
    self.foot.stateLabel.text = sTitle;
}



@end
