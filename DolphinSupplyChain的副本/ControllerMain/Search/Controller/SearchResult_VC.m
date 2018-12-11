//
//  SearchResult_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/3.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "SearchResult_VC.h"
#import "BuyListBll.h"
#import "BuyListCell.h"
#import "BuyGridCell.h"
#import "CommodityDetails_VC.h"
#import "BlankPageView.h"
#import "SearchViw.h"
#import "YKSSearchViewController.h"
#import "SearchScreenHeadView.h"
#import "HTCollectionView.h"

@interface SearchResult_VC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SearchScreenHeadDelegate>

@property (nonatomic, strong) HTCollectionView *collectionMain;

@property (nonatomic, strong) NSString *sKeyWork;

@property (nonatomic, strong) NSString *sBuyListSuperID;

/// 数据源
@property (nonatomic, strong) NSMutableDictionary *dicData;

@property (nonatomic, assign) NSInteger iPage;

/// 默认为List（YES） Grid为（NO）
@property (nonatomic, assign) BOOL bGridOrList;

@property (nonatomic, strong) BlankPageView *vBlankView;

@property (nonatomic, strong) SearchViw *vSearchBar;

@property (nonatomic, copy) NSString *sCategoryIdIn;

@property (nonatomic, copy) NSString *sBrandIdIn;

@property (nonatomic, copy) NSString *sGoodsIdIn;

@property (nonatomic, copy) NSString *sBrandId;

@property (nonatomic, assign) BOOL bHaveKeyWord;

@property (nonatomic, strong) SearchScreenHeadView *vScreenHead;

@property (nonatomic, assign) BOOL bLoadTrue;

@property (nonatomic, assign) BOOL bHaveOnlyGoods;

@property (nonatomic, copy) NSString *sType;

@end

@implementation SearchResult_VC

- (instancetype)initWithInfo:(NSString *)sKeyWork
              category_id_in:(NSString *)sCategory_id_in
                 brand_id_in:(NSString *)sBrand_id_in
                 goods_id_in:(NSString *)sGoods_id_in
                    brand_id:(NSString *)sBrand_id
                 HaveKeyWork:(BOOL)HaveKeyWork
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.sKeyWork = sKeyWork;
        self.sCategoryIdIn = sCategory_id_in;
        self.sBrandIdIn = sBrand_id_in;
        self.sGoodsIdIn = sGoods_id_in;
        self.bHaveKeyWord = HaveKeyWork;
        self.sBrandId = sBrand_id;
        self.bGridOrList = NO;
        self.bLoadTrue = NO;
        self.bHaveOnlyGoods = NO;
        self.sType = @"";
        self.iPage = 2;
        self.title = self.sKeyWork;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}


- (void)initView
{
    [self.view addSubview:self.collectionMain];
    [self.view addSubview:self.vBlankView];
    [self.view addSubview:self.vScreenHead];
    
    [self addNavigationType:YKS_Left_RightTwo NavigationTitle:@""];
    
    [self.btnRigthTwo setImage:[UIImage drawImageWithName:@"Buy_List" size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    [self.vNavigation addSubview:self.vSearchBar];
    
    [self.collectionMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.vScreenHead.mas_bottom);
    }];
    
    [self.vBlankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.vScreenHead.mas_bottom);
    }];
    
    [self.vScreenHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(44);
        make.top.equalTo(self.vNavigation.mas_bottom);
    }];
    
    WS(weakSelf);
    [self.collectionMain addFooterRefresh:^{
        [weakSelf loadDataMore];
    }];
    
    [self.collectionMain addHeaderRefresh:^{
        [weakSelf loadDataFirstType:weakSelf.sType];
    }];
    
    [self.collectionMain beginRefreshing];
}

#pragma mark - 加载网络数据
- (void)loadDataFirstType:(NSString *)sType
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.bHaveKeyWord) {
        [dic setObject:@"1" forKey:@"page"];
        [dic setObject:@"10" forKey:@"page_size"];
        [dic setObject:self.sKeyWork forKey:@"keyword"];
    }
    else
    {
        if (self.sBrandId.length == 0) {
            [dic setObject:@"1" forKey:@"page"];
            [dic setObject:@"10" forKey:@"page_size"];
            if (self.sCategoryIdIn.length != 0) {
                [dic setObject:self.sCategoryIdIn forKey:@"category_id_in"];
            }
            
            if (self.sBrandIdIn.length != 0) {
                [dic setObject:self.sBrandIdIn forKey:@"brand_id_in"];
            }
            
            if (self.sGoodsIdIn.length != 0) {
                [dic setObject:self.sGoodsIdIn forKey:@"goods_id_in"];
            }
        }
        else
        {
            [dic setObject:@"1" forKey:@"page"];
            [dic setObject:@"10" forKey:@"page_size"];
            [dic setObject:self.sBrandId forKey:@"brand_id"];
        }
    }
    
    if (self.bHaveOnlyGoods)
    {
        [dic setObject:@"1" forKey:@"has_stock"];
    }
    else
    {
        [dic setObject:@"0" forKey:@"has_stock"];
    }
    
    if ([sType isEqualToString:@"R"]) {
        [dic setObject:@"click_count" forKey:@"order_by"];
        [dic setObject:@"DESC" forKey:@"order_by_dir"];
    }
    else if ([sType isEqualToString:@"X"])
    {
        [dic setObject:@"purchase_count" forKey:@"order_by"];
        [dic setObject:@"DESC" forKey:@"order_by_dir"];
    }
    else if ([sType isEqualToString:@"JS"])
    {
        [dic setObject:@"price" forKey:@"order_by"];
        [dic setObject:@"ASC" forKey:@"order_by_dir"];
    }
    else if ([sType isEqualToString:@"JD"])
    {
        [dic setObject:@"price" forKey:@"order_by"];
        [dic setObject:@"DESC" forKey:@"order_by_dir"];
    }
        
    [AFHTTPClient POST:@"/search/index" params:dic successInfo:^(ResponseModel *response) {
        
        [self.collectionMain endHeaderRefreshing];
        
        [self.dicData removeAllObjects];
        
        self.dicData = [BuyListBll BuyListJson:response.dataResponse superId:nil isSuper:NO loadBrands:YES loadCategories:NO];
        
        if (((NSMutableArray *)self.dicData[@"list"]).count == 0) {
            self.vBlankView.hidden = NO;
        }
        else
        {
            self.vBlankView.hidden = YES;
            [self.collectionMain reloadData];
        }
        self.bLoadTrue = YES;
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        [self.collectionMain endHeaderRefreshing];
        
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}



- (void)loadDataPage:(NSInteger)iPage Type:(NSString *)sType
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.bHaveKeyWord) {
        [dic setObject:[NSNumber numberWithInteger:iPage] forKey:@"page"];
        [dic setObject:@"10" forKey:@"page_size"];
        [dic setObject:self.sKeyWork forKey:@"keyword"];
    }
    else
    {
        if (self.sBrandId.length == 0) {
            [dic setObject:[NSNumber numberWithInteger:iPage] forKey:@"page"];
            [dic setObject:@"10" forKey:@"page_size"];
            if (self.sCategoryIdIn.length != 0) {
                [dic setObject:self.sCategoryIdIn forKey:@"category_id_in"];
            }
            
            if (self.sBrandIdIn.length != 0) {
                [dic setObject:self.sBrandIdIn forKey:@"brand_id_in"];
            }
            
            if (self.sGoodsIdIn.length != 0) {
                [dic setObject:self.sGoodsIdIn forKey:@"goods_id_in"];
            }
        }
        else
        {
            [dic setObject:[NSNumber numberWithInteger:iPage] forKey:@"page"];
            [dic setObject:@"10" forKey:@"page_size"];
            [dic setObject:self.sBrandId forKey:@"brand_id"];
        }
    }
    
    if (self.bHaveOnlyGoods)
    {
        [dic setObject:@"1" forKey:@"has_stock"];
    }
    else
    {
        [dic setObject:@"0" forKey:@"has_stock"];
    }
    
    if ([sType isEqualToString:@"R"]) {
        [dic setObject:@"click_count" forKey:@"order_by"];
        [dic setObject:@"DESC" forKey:@"order_by_dir"];
    }
    else if ([sType isEqualToString:@"X"])
    {
        [dic setObject:@"purchase_count" forKey:@"order_by"];
        [dic setObject:@"DESC" forKey:@"order_by_dir"];
    }
    else if ([sType isEqualToString:@"JS"])
    {
        [dic setObject:@"price" forKey:@"order_by"];
        [dic setObject:@"ASC" forKey:@"order_by_dir"];
    }
    else if ([sType isEqualToString:@"JD"])
    {
        [dic setObject:@"price" forKey:@"order_by"];
        [dic setObject:@"DESC" forKey:@"order_by_dir"];
    }
    
    [AFHTTPClient POST:@"/search/index" params:dic successInfo:^(ResponseModel *response) {
        
        [self.collectionMain endFooterRefreshing];
        
        NSMutableDictionary* dic = [BuyListBll BuyListJson:response.dataResponse superId:nil isSuper:NO loadBrands:NO loadCategories:NO];
        
        NSMutableArray *arrDataOne = dic[@"list"];
        
        
        NSMutableArray *arrDataTwo = self.dicData[@"list"];
        NSInteger i = arrDataTwo.count;
        
        NSMutableArray *array = [NSMutableArray array];
        for (BuyListModel *obj in arrDataOne) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
            [array addObject:path];
            
            [((NSMutableArray *)self.dicData[@"list"]) addObject:obj];
            i += 1;
        }
        
        [self.collectionMain insertItemsAtIndexPaths:array];
        
        if (array.count != 0) {
            self.iPage += 1;
        }
        else
        {
            [self.collectionMain showNoMoreData];
        }
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        [self.collectionMain endFooterRefreshing];
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
    [self loadDataPage:self.iPage Type:self.sType];
}


#pragma mark - 按钮点击事件
- (void)tapRightTwo
{
    if (self.bGridOrList) {
        [self.btnRigthTwo setImage:[UIImage drawImageWithName:@"Buy_Grid" size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    }
    else
    {
        [self.btnRigthTwo setImage:[UIImage drawImageWithName:@"Buy_List" size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    }
    self.bGridOrList = !self.bGridOrList;
    [self.collectionMain reloadData];
}

- (void)tapSearchBar
{
    YKSSearchViewController * searchVC = [[YKSSearchViewController alloc] initWithIsHome:YES Block:^(NSString *sKeyWord, NSString *sType, NSString *sSKU) {
        
        if ([sType isEqualToString:@"list"]) {
            self.sKeyWork = sKeyWord;
            self.vBlankView.hidden = YES;
            [self.collectionMain.mj_header beginRefreshing];
            [self.vSearchBar loadView:self.sKeyWork];
        }
        else if ([sType isEqualToString:@"detail"])
        {
            // 跳转到商品详情
            CommodityDetails_VC *detail_VC = [[CommodityDetails_VC alloc]initWithSKU:sSKU];
//            detailVC.sku = sSKU;
            detail_VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detail_VC animated:YES];
        }
        else
        {
            
        }
    }];
    
    [self.navigationController presentViewController:searchVC animated:NO completion:nil];
}



#pragma mark - BuyListHeadDelegate
// 人气
- (void)tapPopularity
{
    if (!self.bLoadTrue) {
        return;
    }
    self.iPage = 2;
    self.sType = @"R";
    [self.collectionMain beginRefreshing];
}

// 销量
- (void)tapSales
{
    
    if (!self.bLoadTrue) {
        return;
    }
    
    self.sType = @"X";
    self.iPage = 2;
    [self.collectionMain beginRefreshing];
}

// 价格
- (void)tapPriceHightOrLow:(NSString *)sHighOrLow
{
    
    if (!self.bLoadTrue) {
        return;
    }
    
    
    self.iPage = 2;
    if ([sHighOrLow isEqualToString:@"Low"]) {
        
        self.sType = @"JS";
    }
    else
    {
        self.sType = @"JD";
    }
    
    [self.collectionMain beginRefreshing];
}

// 筛选
- (void)tapScreen:(BOOL)bHaveOnlyGoods
{
    if (!self.bLoadTrue) {
        return;
    }
    self.bHaveOnlyGoods = bHaveOnlyGoods;
    self.iPage = 2;
    [self.collectionMain beginRefreshing];
}


#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ((NSMutableArray *)self.dicData[@"list"]).count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.bGridOrList) {
        BuyListCell *listCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BuyListCell" forIndexPath:indexPath];
        
        BuyListModel *model = self.dicData[@"list"][indexPath.row];
        
        [listCell loadView:model.img_original BuyName:model.goods_name MoneyOne:model.price MoneyTwo:model.market_price Inventory:model.has_stock];
        return listCell;
    }
    else
    {
        BuyGridCell *gridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BuyGridCell" forIndexPath:indexPath];
        
        BuyListModel *model = self.dicData[@"list"][indexPath.row];
        
        [gridCell loadView:model.img_original BuyName:model.goods_name MoneyOne:model.price MoneyTwo:model.market_price Inventory:model.has_stock];
        
        return gridCell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BuyListModel *model = self.dicData[@"list"][indexPath.row];
    
    CommodityDetails_VC *detail_VC = [[CommodityDetails_VC alloc]initWithSKU:model.goods_sn];
//    detail_VC.sku = model.goods_sn;
    [self.navigationController pushViewController:detail_VC animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.bGridOrList) {
        return CGSizeMake(kDisWidth, 110);
    }
    else
    {
        return CGSizeMake(kDisWidth/2 - 0.25, kDisWidth/2 + 80);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.bGridOrList) {
        return 0;
    }
    return 0.5;
}

#pragma mark - 懒加载
- (UICollectionView *)collectionMain
{
    if (!_collectionMain) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _collectionMain = [[HTCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        _collectionMain.delegate = self;
        _collectionMain.dataSource = self;
        [_collectionMain registerClass:[BuyGridCell class] forCellWithReuseIdentifier:@"BuyGridCell"];
        [_collectionMain registerClass:[BuyListCell class] forCellWithReuseIdentifier:@"BuyListCell"];
        _collectionMain.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _collectionMain;
}

- (BlankPageView *)vBlankView
{
    if (!_vBlankView) {
        _vBlankView = [[BlankPageView alloc] init];
        _vBlankView.title = @"暂无产品";
        _vBlankView.hidden = YES;
    }
    return _vBlankView;
}

- (SearchViw *)vSearchBar
{
    if (!_vSearchBar) {
        _vSearchBar = [[SearchViw alloc] initWithKewWordName:self.sKeyWork];
        _vSearchBar.frame = CGRectMake(50, 27+KTop, kDisWidth - 100, 30);
        
        UITapGestureRecognizer *tapSearchBar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSearchBar)];
        [_vSearchBar addGestureRecognizer:tapSearchBar];
    }
    return _vSearchBar;
}


- (SearchScreenHeadView *)vScreenHead
{
    if (!_vScreenHead) {
        _vScreenHead = [[SearchScreenHeadView alloc] init];
        _vScreenHead.delegate = self;
    }
    return _vScreenHead;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
