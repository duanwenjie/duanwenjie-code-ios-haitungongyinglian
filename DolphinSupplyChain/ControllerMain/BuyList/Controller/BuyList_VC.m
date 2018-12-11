//
//  BuyList_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/29.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "BuyList_VC.h"
#import "BuyListCell.h"
#import "BuyGridCell.h"
#import "ZXNTool.h"
#import "BuyListHeadView.h"
#import "BuyListClassifyView.h"
#import "BuyListScreenView.h"
#import "BuyListBll.h"
#import "BlankPageView.h"

#import "CommodityDetails_VC.h"
#import "HTLoadingTool.h"

#import "HTCollectionView.h"

@interface BuyList_VC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, BuyListHeadDelegate, BuyListScreenDelegate>

// 父类ID
@property (nonatomic, copy) NSString *sBuyListSuperID;

// 子类ID
@property (nonatomic, copy) NSString *sBuyListSubID;

// 品牌ID
@property (nonatomic, copy) NSString *sBrands;

// 人气-R 销量-X 价格（少到多）-JS 价格（多到少）-JD
@property (nonatomic, copy) NSString *sType;

@property (nonatomic, assign) NSInteger iPage;

/// 默认为List（YES） Grid为（NO）
@property (nonatomic, assign) BOOL bGridOrList;

@property (nonatomic, strong) HTCollectionView *collectionMain;

@property (nonatomic, strong) BuyListHeadView *vBuyListHead;

@property (nonatomic, strong) BuyListClassifyView *vClassify;

@property (nonatomic, strong) BuyListScreenView *vScreen;

/// 数据源
@property (nonatomic, strong) NSMutableDictionary *dicData;

/// 品牌数据源
@property (nonatomic, strong) NSMutableArray *arrayBrands;

/// 分类数据源
@property (nonatomic, strong) NSMutableArray *arrayCategories;

@property (nonatomic, strong) NSString *sClassify;

@property (nonatomic, assign) BOOL bLoadTrue;

@property (nonatomic, strong) BlankPageView *vBlankpage;

@property (nonatomic, assign) NSString *sTitle;

/// 是否有库存
@property (nonatomic, assign) BOOL bHaveOnlyGoods;

@end

@implementation BuyList_VC

- (instancetype)initWithBuySuperListID:(NSString *)sSuperListId
                             subListID:(NSString *)sSubListID
                            NavBarName:(NSString *)sName
                          ClassifyName:(NSString *)sClassify
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        self.sBuyListSuperID = sSuperListId;
        self.sBuyListSubID = sSubListID;
        self.dicData = [NSMutableDictionary dictionary];
        self.bGridOrList = NO;
        self.bHaveOnlyGoods = NO;
        
        self.arrayBrands = [NSMutableArray array];
        
        self.arrayCategories = [NSMutableArray array];
        
        self.bLoadTrue = NO;
        
        self.sClassify = sClassify;
        
        self.sBrands = @"";
        
        self.sType = @"";
        
        self.iPage = 2;
        
        self.sTitle = sName;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
    
    [self loadDataFirst:@""];
}

#pragma mark - 渲染界面
- (void)initView
{
    [self.view addSubview:self.vBuyListHead];
    [self.view addSubview:self.collectionMain];
    
    if (![_sBuyListSuperID isEqualToString:_sBuyListSubID]) {
        [self.vBuyListHead loadView:self.sClassify];
    }
    

    [self.view addSubview:self.vBlankpage];
    [self.vBlankpage switchToNoDataPrompt:@"亲~暂时没有商品数据哦！"];
    
    [self addNavigationType:YKS_Left_Title_RightTwo NavigationTitle:self.sTitle];
    [self.btnRigthTwo setImage:[UIImage drawImageWithName:@"Buy_List" size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    
    [self.vBlankpage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vBuyListHead.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    
    [self.vBuyListHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.vNavigation.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    [self.collectionMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vBuyListHead.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    
    WS(weakSelf);
    self.vBlankpage.block = ^(){
        [weakSelf.vBlankpage switchToNoDataPrompt:@"亲~暂时没有商品数据哦！"];
        [weakSelf loadData:weakSelf.sBuyListSubID Brands:weakSelf.sBrands Type:weakSelf.sType];
    };
    
    
    [self.collectionMain addFooterRefresh:^{
        [weakSelf loadDataMore];
    }];
}


#pragma mark - 加载网络数据

- (void)loadDataFirst:(NSString *)sSubID
{
    [HTLoadingTool showLoadingForView:self.view];
    self.vBlankpage.hidden = YES;
    NSDictionary *dic = @{@"page":@"1",
                          @"page_size":@"10",
                          @"has_brand":@"1",
                          @"has_category":@"1",
                          @"category_id":self.sBuyListSubID,
                          @"top_category_id":self.sBuyListSuperID};
    [AFHTTPClient POST:@"/search/index" params:dic successInfo:^(ResponseModel *response) {
        
        if ([_sBuyListSuperID isEqualToString:_sBuyListSubID]) {
            self.dicData = [BuyListBll BuyListJson:response.dataResponse superId:_sBuyListSuperID isSuper:YES loadBrands:YES loadCategories:YES];
        }
        else
        {
            self.dicData = [BuyListBll BuyListJson:response.dataResponse superId:_sBuyListSubID isSuper:NO loadBrands:YES loadCategories:YES];
        }
        
        NSMutableArray *arr = self.dicData[@"list"];
        if (arr.count == 0) {
            self.vBlankpage.hidden = NO;
        }
        
        self.arrayBrands = self.dicData[@"brands"];
        self.arrayCategories = self.dicData[@"categories"];
        
        [self.collectionMain reloadData];
        self.bLoadTrue = YES;
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            return ;
        }
        
        if (type == SERVICE_ERROR) {
            self.vBlankpage.hidden = NO;
            [self.vBlankpage switchToNoNetwork];
            return ;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}


- (void)loadData:(NSString *)sSubID Brands:(NSString *)sBrands Type:(NSString *)sType
{
    self.vBlankpage.hidden = YES;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setValue:@"1" forKey:@"page"];
    [dic setValue:self.sBuyListSuperID forKey:@"top_category_id"];
    [dic setValue:sSubID forKey:@"category_id"];
    
    if (self.bHaveOnlyGoods)
    {
        [dic setValue:@"1" forKey:@"has_stock"];
    }
    else
    {
        [dic setValue:@"0" forKey:@"has_stock"];
    }
    
    if (sBrands.length != 0) {
        [dic setValue:sBrands forKey:@"brand_id"];
    }
    
    if ([sType isEqualToString:@"R"]) {
        [dic setValue:@"click_count" forKey:@"order_by"];
        [dic setValue:@"DESC" forKey:@"order_by_dir"];
    }
    else if ([sType isEqualToString:@"X"])
    {
        [dic setValue:@"purchase_count" forKey:@"order_by"];
        [dic setValue:@"DESC" forKey:@"order_by_dir"];
    }
    else if ([sType isEqualToString:@"JS"])
    {
        [dic setValue:@"price" forKey:@"order_by"];
        [dic setValue:@"ASC" forKey:@"order_by_dir"];
    }
    else if ([sType isEqualToString:@"JD"])
    {
        [dic setValue:@"price" forKey:@"order_by"];
        [dic setValue:@"DESC" forKey:@"order_by_dir"];
    }
    
    [HTLoadingTool showLoadingForView:self.view];
    
    [AFHTTPClient POST:@"/search/index" params:dic successInfo:^(ResponseModel *response) {
        
        [self.dicData removeAllObjects];
        
        if ([_sBuyListSuperID isEqualToString:_sBuyListSubID]) {
            self.dicData = [BuyListBll BuyListJson:response.dataResponse superId:_sBuyListSuperID isSuper:YES loadBrands:NO loadCategories:NO];
        }
        else
        {
            self.dicData = [BuyListBll BuyListJson:response.dataResponse superId:_sBuyListSubID isSuper:NO loadBrands:NO loadCategories:NO];
        }
        
        NSMutableArray *arr = self.dicData[@"list"];
        if (arr.count == 0) {
            self.vBlankpage.hidden = NO;
        }
        
        
        [self.collectionMain reloadData];
        self.bLoadTrue = YES;
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            return ;
        }
        
        if (type == SERVICE_ERROR) {
            self.vBlankpage.hidden = NO;
            [self.vBlankpage switchToNoNetwork];
            return ;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}


- (void)loadData:(NSString *)sSubID Brands:(NSString *)sBrands Type:(NSString *)sType Page:(NSInteger)iPage
{
    self.bLoadTrue = NO;
    self.vBlankpage.hidden = YES;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setValue:[NSNumber numberWithInteger:iPage] forKey:@"page"];
    [dic setValue:@"10" forKey:@"page_size"];
    [dic setValue:self.sBuyListSuperID forKey:@"top_category_id"];
    [dic setValue:sSubID forKey:@"category_id"];
    
    if (sBrands.length != 0) {
        [dic setValue:sBrands forKey:@"brand_id"];
    }
    
    if ([sType isEqualToString:@"R"]) {
        [dic setValue:@"click_count" forKey:@"order_by"];
        [dic setValue:@"DESC" forKey:@"order_by_dir"];
    }
    else if ([sType isEqualToString:@"X"])
    {
        [dic setValue:@"purchase_count" forKey:@"order_by"];
        [dic setValue:@"DESC" forKey:@"order_by_dir"];
    }
    else if ([sType isEqualToString:@"JS"])
    {
        [dic setValue:@"price" forKey:@"order_by"];
        [dic setValue:@"ASC" forKey:@"order_by_dir"];
    }
    else if ([sType isEqualToString:@"JD"])
    {
        [dic setValue:@"price" forKey:@"order_by"];
        [dic setValue:@"DESC" forKey:@"order_by_dir"];
    }
    
    [AFHTTPClient POST:@"/search/index" params:dic successInfo:^(ResponseModel *response) {
        
        [self.collectionMain endFooterRefreshing];
        
        NSMutableDictionary* dic = [BuyListBll BuyListJson:response.dataResponse superId:_sBuyListSubID isSuper:NO loadBrands:NO loadCategories:NO];
        
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
        
        self.bLoadTrue = YES;
        if (array.count != 0) {
            self.iPage += 1;
        }
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        if (type == NEED_HINT || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            return ;
        }
        
        if (type == SERVICE_ERROR) {
            self.vBlankpage.hidden = NO;
            [self.vBlankpage switchToNoNetwork];
            return ;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}

- (void)loadDataMore
{
    [self loadData:self.sBuyListSubID Brands:self.sBrands Type:self.sType Page:self.iPage];
}


#pragma mark - 按钮点击事件
- (void)tapRightTwo
{
    if (self.bGridOrList) {
        [self.btnRigthTwo setImage:[UIImage drawImageWithName:@"Buy_List" size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    }
    else
    {
        [self.btnRigthTwo setImage:[UIImage drawImageWithName:@"Buy_Grid" size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    }
    self.bGridOrList = !self.bGridOrList;
    [self.collectionMain reloadData];
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

#pragma mark - BuyListHeadDelegate
// 二级分类
- (void)tapClassify
{
    if (!self.bLoadTrue) {
        return;
    }
    
    self.iPage = 2;
    if (self.vClassify.hidden) {
        self.vScreen.hidden = YES;
        self.vClassify.hidden = NO;
        self.vClassify.arrClassify = self.arrayCategories;
    }
    else
    {
        self.vClassify.hidden = YES;
    }
}

// 人气
- (void)tapPopularity
{
    if (!self.bLoadTrue) {
        return;
    }
    self.vClassify.hidden = YES;
    self.vScreen.hidden = YES;
    self.sType = @"R";
    self.iPage = 2;
    [self loadData:self.sBuyListSubID Brands:self.sBrands Type:self.sType];
}

// 销量
- (void)tapSales
{
    
    if (!self.bLoadTrue) {
        return;
    }
    
    
    self.vClassify.hidden = YES;
    self.vScreen.hidden = YES;
    self.sType = @"X";
    self.iPage = 2;
    [self loadData:self.sBuyListSubID Brands:self.sBrands Type:self.sType];
}

// 价格
- (void)tapPriceHightOrLow:(NSString *)sHighOrLow
{
    
    if (!self.bLoadTrue) {
        return;
    }
    
    
    self.iPage = 2;
    self.vClassify.hidden = YES;
    self.vScreen.hidden = YES;
    if ([sHighOrLow isEqualToString:@"Low"]) {
        
        self.sType = @"JS";
        [self loadData:self.sBuyListSubID Brands:self.sBrands Type:self.sType];
    }
    else
    {
        self.sType = @"JD";
        [self loadData:self.sBuyListSubID Brands:self.sBrands Type:self.sType];
    }
}

// 筛选
- (void)tapScreen
{
    if (!self.bLoadTrue) {
        return;
    }
    
    self.iPage = 2;
    if (self.vScreen.hidden) {
        self.vClassify.hidden = YES;
        self.vScreen.hidden = NO;
        
        self.vScreen.arrScree = self.arrayBrands;
    }
    else
    {
        self.vScreen.hidden = YES;
    }
}

- (void)tapDeleteOnlyGoods
{
    if ([self.vBuyListHead deleteOnlyHaveGoods])
    {
        [self.vBuyListHead mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
        }];
    }
    else
    {
        [self.vScreen amendSwitchState];
        self.bHaveOnlyGoods = NO;
        [self loadData:self.sBuyListSubID Brands:self.sBrands Type:self.sType];
    }
}

- (void)tapDeleteBrand
{
    if ([self.vBuyListHead deleteBrandButton]) {
        [self.vBuyListHead mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
        }];
    }
    else
    {
        self.sBrands = @"";
        [self.arrayBrands enumerateObjectsUsingBlock:^(BrandsModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            model.bSelect = NO;
        }];
        
        [self loadData:self.sBuyListSubID Brands:self.sBrands Type:self.sType];
    }
}

- (void)tapDeleteAll
{
    [self.vScreen amendSwitchState];
    self.bHaveOnlyGoods = NO;
    self.sBrands = @"";
    
    [self.arrayBrands enumerateObjectsUsingBlock:^(BrandsModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        model.bSelect = NO;
    }];
    
    [self.vBuyListHead mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
    }];
    
    [self loadData:self.sBuyListSubID Brands:self.sBrands Type:self.sType];
    
}

#pragma mark - BuyListScreenDelegate
- (void)selectOnlyGoods:(BOOL)bHaveOnlyGoods
{
    if (bHaveOnlyGoods) {
        [self.vBuyListHead mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44 + 41);
        }];
        
        [self.vBuyListHead addOnlyGoods];
    }
    else
    {
        if ([self.vBuyListHead deleteOnlyHaveGoods])
        {
            [self.vBuyListHead mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(44);
            }];
        }
    }
    
    _vScreen.hidden = YES;
    self.bHaveOnlyGoods = bHaveOnlyGoods;

    [self loadData:self.sBuyListSubID Brands:self.sBrands Type:self.sType];
}

- (void)selectBrand:(NSString *)sScreenID ScreenName:(NSString *)sScreenName ScreenData:(NSMutableArray *)arrScreen
{
    [self.vBuyListHead mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44 + 41);
    }];
    
    [self.vBuyListHead addBrand:sScreenName];
    
    self.arrayBrands = arrScreen;
    
    self.sBrands = sScreenID;
    _vScreen.hidden = YES;
    
    [self loadData:self.sBuyListSubID Brands:self.sBrands Type:self.sType];
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

- (BuyListHeadView *)vBuyListHead
{
    if (!_vBuyListHead) {
        _vBuyListHead = [[BuyListHeadView alloc] init];
        _vBuyListHead.delegate = self;
    }
    return _vBuyListHead;
}

- (BuyListClassifyView *)vClassify
{
    if (!_vClassify) {
        _vClassify = [[BuyListClassifyView alloc] initWithBlock:^(NSString *sClassifyID, NSString *sClassifyName, NSMutableArray *arrClassify) {
            
            self.arrayCategories = arrClassify;
            [self.vBuyListHead loadView:sClassifyName];
            
            self.sBuyListSubID = sClassifyID;
            
            _vClassify.hidden = YES;

            // 发起网络请求--商品二级分类列表请求
            [self loadData:self.sBuyListSubID Brands:self.sBrands Type:self.sType];
            
        }];
        _vClassify.frame = CGRectMake(0, kDisNavgation + 44, kDisWidth, kDisHeight - 108);
        [self.view addSubview:_vClassify];
        
        _vClassify.hidden = YES;
    }
    return _vClassify;
}

- (BuyListScreenView *)vScreen
{
    if (!_vScreen) {
        _vScreen = [[BuyListScreenView alloc] initWithList];
        _vScreen.delegate = self;
        _vScreen.frame = CGRectMake(0, kDisNavgation + 44, kDisWidth, kDisHeight - kDisNavgation + 44);
        [self.view addSubview:_vScreen];
        
        _vScreen.hidden = YES;
    }
    return _vScreen;
}

- (BlankPageView *)vBlankpage
{
    if (!_vBlankpage) {
        _vBlankpage = [[BlankPageView alloc] init];
        _vBlankpage.hidden = YES;
    }
    return _vBlankpage;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
