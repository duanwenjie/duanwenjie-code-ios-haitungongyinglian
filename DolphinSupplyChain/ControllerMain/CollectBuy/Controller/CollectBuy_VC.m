//
//  CollectBuy_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/1.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "CollectBuy_VC.h"
#import "CollectBuyCell.h"
#import "BlankPageView.h"
#import "CollectModel.h"
#import "CollectBll.h"

#import "CommodityDetails_VC.h"

#import "HTTabbleView.h"

@interface CollectBuy_VC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) HTTabbleView *tbMain;

@property (nonatomic, strong) NSMutableArray *arrData;

@property (nonatomic, strong) BlankPageView *vBlankView;

@property (nonatomic, assign) NSInteger iPage;

@end

@implementation CollectBuy_VC


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.arrData = [NSMutableArray array];
        self.iPage = 2;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView
{
    [self.view addSubview:self.tbMain];
    [self.view addSubview:self.vBlankView];
    
    [self addNavigationType:YKSDefaults NavigationTitle:@"我的收藏"];
    
    [self.tbMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.vNavigation.mas_bottom);
    }];
    
    WS(weakSelf);
    [self.tbMain addHeaderRefresh:^{
        [weakSelf loadDataFirst];
    }];
    
    [self.tbMain addFooterRefresh:^{
        [weakSelf loadDataMore];
    }];
    
    [self.tbMain beginRefreshing];
}

- (void)noticeNoMoreData
{
    [self.tbMain showNoMoreData];
}

#pragma mark - 加载数据
- (void)loadDataFirst
{
    NSDictionary *dic = @{@"page":@"1",
                          @"page_size":@"10"};
    
    [AFHTTPClient POST:@"/CollectGoods/getSelfList" params:dic successInfo:^(ResponseModel *response) {
        
        [self.tbMain endHeaderRefreshing];
        
        [self.arrData removeAllObjects];
        
        self.arrData = [CollectBll gainCollectList:response.dataResponse];
        
        if (self.arrData.count == 0) {
            self.vBlankView.hidden = NO;
        }
        else
        {
            self.vBlankView.hidden = YES;
            [self.tbMain reloadData];
        }
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        [self.tbMain endHeaderRefreshing];
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}



- (void)loadDataPage:(NSInteger)iPage
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setValue:[NSNumber numberWithInteger:iPage] forKey:@"page"];
    [dic setValue:@"10" forKey:@"page_size"];
    
    [AFHTTPClient POST:@"/CollectGoods/getSelfList" params:dic successInfo:^(ResponseModel *response) {
        
        [self.tbMain endFooterRefreshing];
        
        NSMutableArray* arrayCollect = [CollectBll gainCollectList:response.dataResponse];
        
        if (arrayCollect.count != 0) {
            self.iPage += 1;
            
            NSInteger i = self.arrData.count;
            
            NSMutableArray *array = [NSMutableArray array];
            for (CollectModel *obj in arrayCollect) {
                NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
                [array addObject:path];
                
                [self.arrData addObject:obj];
                i += 1;
            }
            
            [self.tbMain insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationTop];
        }
        else
        {
            [self.tbMain showNoMoreData];
        }
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        [self.tbMain endFooterRefreshing];
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}

- (void)loadDataMore
{
    [self loadDataPage:self.iPage];
}

#pragma mark - 删除收藏商品
- (void)deleteCollect:(NSString *)sMessage_id index:(NSIndexPath *)iIndex
{
    NSDictionary *dic = @{@"goods_id":sMessage_id};
    
    [AFHTTPClient POST:@"/CollectGoods/delSelfCollectGoods" params:dic successInfo:^(ResponseModel *response) {
        [self.view makeToast:@"删除成功" duration:1.0 position:CSToastPositionCenter];
        
        [self.arrData removeObjectAtIndex:iIndex.row];
        
        [self.tbMain deleteRowsAtIndexPaths:@[iIndex] withRowAnimation:UITableViewRowAnimationFade];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}



#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectBuyCell"];
    if (cell == nil) {
        cell = [[CollectBuyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CollectBuyCell"];
        CollectModel *Model = self.arrData[indexPath.row];
        [cell loadView:Model.img_original BuyName:Model.goods_name MoneyOne:Model.price MoneyTwo:Model.market_price isLoseEfficacy:YES];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CollectModel *Model = self.arrData[indexPath.row];
//    if (YES) { // 如果产品失效那么不能进入产品详情
//        return;
//    }
    CommodityDetails_VC *detail_VC = [[CommodityDetails_VC alloc]initWithSKU:Model.sku];
    [self.navigationController pushViewController:detail_VC animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

/// 处理删除事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        CollectModel *Model = self.arrData[indexPath.row];
        [self deleteCollect:Model.goods_id index:indexPath];
    }
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"取消\n收藏";
}



#pragma mark - 懒加载
- (HTTabbleView *)tbMain
{
    if (!_tbMain) {
        _tbMain = [[HTTabbleView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tbMain.delegate = self;
        _tbMain.dataSource = self;
        _tbMain.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbMain.showsVerticalScrollIndicator = NO;
        _tbMain.backgroundColor = [UIColor colorWithHexString:@"efeff2"];
    }
    return _tbMain;
}


- (BlankPageView *)vBlankView
{
    if (!_vBlankView) {
        _vBlankView = [[BlankPageView alloc] initWithFrame:CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight - kDisNavgation)];
        _vBlankView.title = @"暂无收藏商品";
        _vBlankView.hidden = YES;
    }
    return _vBlankView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
