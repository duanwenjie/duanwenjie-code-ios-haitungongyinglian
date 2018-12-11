//
//  NewHomeLayoutOne_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/21.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "NewHomeLayoutOne_VC.h"
#import "NewHomeSectionHeadView.h"
#import "HomeClassifyModel.h"

#import "CarouselCell.h"
#import "HotBrandCell.h"
#import "HotCommodityCell.h"
#import "HomeClassifyCell.h"

#import "CarouselModel.h"
#import "HotBrandModel.h"
#import "HotCommodityModel.h"
#import "HomeClassifyModel.h"

#import "HTLoadingTool.h"
#import "NewHomeBll.h"

#import "SearchResult_VC.h"
#import "BuyList_VC.h"
#import "CommodityDetails_VC.h"

#import "BlankPageView.h"
#import "HTCollectionView.h"


@interface NewHomeLayoutOne_VC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CarouselDelegate, HomeClassifyDelegate, HotBrandDelegate>

@property (nonatomic, strong) HTCollectionView *cltMain;

@property (nonatomic, strong) NSArray *arrTextData;

@property (nonatomic, strong) NSArray *arrImageData;

@property (nonatomic, strong) NewHomeModel *HomeModel;

@property (nonatomic, strong) BlankPageView *vBlankView;

@property (nonatomic, assign) BOOL bCarousel;

@property (nonatomic, assign) BOOL bHotBrand;

@property (nonatomic, assign) NSInteger iPage;

@property (nonatomic, copy) NSString *sCategoryID;

@property (nonatomic, copy) NSString *sCategoryName;

@property (nonatomic, strong) UIButton *btnTop;

@end

@implementation NewHomeLayoutOne_VC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.iPage = 2;
        self.bCarousel = YES;
        self.bHotBrand = YES;
        self.arrTextData = @[@"热门品牌", @"热销排行"];
        self.arrImageData = @[@"New_Home_Hot_Brand", @"New_Home_Hot_Commodity"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.cltMain];
    [self.view addSubview:self.btnTop];
    
    [self.cltMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
    
    
    [self.btnTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
    
    WS(weakSelf);
    [self.cltMain addHeaderRefresh:^{
        [weakSelf loadDataFirst];
    }];
    
    [self.cltMain addFooterRefresh:^{
        [weakSelf loadDataMore];
    }];
    
    [self.view addSubview:self.vBlankView];
    
    self.vBlankView.block = ^{
        [weakSelf loadDataFirst];
    };
    
}



#pragma mark - 按钮点击事件
- (void)GoViewTop
{
    [self.cltMain setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - 加载网络数据
- (void)loadviewCategoryId:(NSDictionary *)dicCategory
{
    self.sCategoryID = dicCategory[@"category_id"];
    self.sCategoryName = dicCategory[@"category_name"];
    if (self.HomeModel == nil)
    {
        [self.cltMain beginRefreshing];
    }
}

- (void)loadDataFirst
{
    NSDictionary *dic = @{@"page":@"1",
                          @"page_size":@"10",
                          @"category_id":self.sCategoryID};
    self.iPage = 2;
    self.vBlankView.hidden = YES;
    
    [AFHTTPClient POST:@"/index/app_v2" params:dic successInfo:^(ResponseModel *response) {
        
        [self.cltMain endHeaderRefreshing];
        self.HomeModel = [NewHomeBll NewHomeCategory:response.dataResponse];
        
        if (self.HomeModel == nil) {
            self.vBlankView.hidden = NO;
            return ;
        }
        self.bCarousel = YES;
        self.bHotBrand = YES;
        [self.cltMain reloadData];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        [self.cltMain endHeaderRefreshing];
        
        if (type == NEED_HINT || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            self.vBlankView.hidden = NO;
            return ;
        }
        
        if (type == SERVICE_ERROR) {
            self.vBlankView.hidden = NO;
            return ;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
    
}

- (void)loadDataMore
{
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.iPage],
                          @"page_size":@"10",
                          @"category_id":self.sCategoryID};
    
    [AFHTTPClient POST:@"/index/app_v2" params:dic successInfo:^(ResponseModel *response) {
        
        
        [self.cltMain endFooterRefreshing];
        
        NSMutableArray* arrHotGoods = [NewHomeBll NewHomeHotGoodsJson:response.dataResponse];
        
        
        NSInteger i = self.HomeModel.arrHotGoods.count;
        
        NSMutableArray *array = [NSMutableArray array];
        
        if (self.HomeModel.arrCategory.count > 0) {
            
            for (HotCommodityCell *obj in arrHotGoods) {
                NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:3];
                [array addObject:path];
                
                [self.HomeModel.arrHotGoods addObject:obj];
                i += 1;
            }
        }
        else
        {
            for (HotCommodityCell *obj in arrHotGoods) {
                NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:2];
                [array addObject:path];
                
                [self.HomeModel.arrHotGoods addObject:obj];
                i += 1;
            }
        }
        
        [self.cltMain insertItemsAtIndexPaths:array];
        
        if (array.count != 0) {
            self.iPage += 1;
            if (self.iPage >= 4) {
                [self.cltMain showNoMoreData];
            }
        }
        else
        {
            [self.cltMain showNoMoreData];
        }
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        [self.cltMain endFooterRefreshing];
        
        if (type == NEED_HINT || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            return ;
        }
        
        if (type == SERVICE_ERROR) {
            
            return ;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}


- (void)loadViewData:(NewHomeModel *)model
{
    self.HomeModel = model;
}

#pragma mark - CarouselDelegate
- (void)didSelectItemAtIndex:(NSInteger)index
{
    CarouselModel *model = self.HomeModel.arrPictureAdLists[index];
    SearchResult_VC *sear_VC = [[SearchResult_VC alloc] initWithInfo:@"" category_id_in:model.category_id_in brand_id_in:model.brand_id_in goods_id_in:model.goods_id_in brand_id:@"" HaveKeyWork:NO];
    sear_VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sear_VC animated:YES];
}

#pragma mark - HomeClassifyDelegate
- (void)didHomeClassifySelectItemAtIndex:(NSInteger)index
{
    HomeClassifyModel *model = self.HomeModel.arrCategory[index];
    BuyList_VC * VC = [[BuyList_VC alloc] initWithBuySuperListID:self.sCategoryID subListID:model.category_id NavBarName:self.sCategoryName ClassifyName:model.category_name];
    VC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - HotBrandDelegate
- (void)didHotBrandSelectItemAtIndex:(NSInteger)index
{
    HotBrandModel *model = self.HomeModel.arrBrands[index];
    SearchResult_VC *sear_VC = [[SearchResult_VC alloc] initWithInfo:@"" category_id_in:@"" brand_id_in:@"" goods_id_in:@"" brand_id:model.brand_id HaveKeyWork:NO];
    sear_VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sear_VC animated:YES];
}

#pragma mark - UICollectionViewDelegate UICollectionViewDataSource UICollectionViewDelegateFlowLayout

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.HomeModel == nil) {
        return 0;
    }
    if (self.HomeModel.arrCategory.count > 0) {
        return 4;
    }
    else
    {
        return 3;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.HomeModel.arrCategory.count > 0) {
        if (section == 3) {
            return self.HomeModel.arrHotGoods.count;
        }
        return 1;
    }
    else
    {
        if (section == 2) {
            return self.HomeModel.arrHotGoods.count;
        }
        return 1;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            CarouselCell *carouselCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CarouselCell" forIndexPath:indexPath];
            carouselCell.delegate = self;
            [carouselCell loadView:self.HomeModel.arrPictureAdLists isRefresh:self.bCarousel];
            if (self.HomeModel.arrPictureAdLists.count > 0) {
                self.bCarousel = NO;
            }
            else
            {
                self.bCarousel = YES;
            }
            return carouselCell;
        }
            break;
        case 1:
        {
            if (self.HomeModel.arrCategory.count > 0) {
                HomeClassifyCell *homeClassify = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeClassifyCell" forIndexPath:indexPath];
                homeClassify.delegate = self;
                [homeClassify loadView:self.HomeModel.arrCategory];
                return homeClassify;
            }
            else
            {
                HotBrandCell *hotBrandCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotBrandCell" forIndexPath:indexPath];
                hotBrandCell.delegate = self;
                [hotBrandCell loadView:self.HomeModel.arrBrands isRefresh:self.bHotBrand];
                if (self.HomeModel.arrBrands.count > 0) {
                    self.bHotBrand = NO;
                }
                else
                {
                    self.bHotBrand = YES;
                }
                return hotBrandCell;
            }
            
        }
            break;
        case 2:
        {
            if (self.HomeModel.arrCategory.count > 0) {
                HotBrandCell *hotBrandCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotBrandCell" forIndexPath:indexPath];
                hotBrandCell.delegate = self;
                [hotBrandCell loadView:self.HomeModel.arrBrands isRefresh:self.bHotBrand];
                if (self.HomeModel.arrBrands.count > 0) {
                    self.bHotBrand = NO;
                }
                else
                {
                    self.bHotBrand = YES;
                }
                return hotBrandCell;
            }
            else
            {
                HotCommodityCell *hotCommodityCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotCommodityCell" forIndexPath:indexPath];
                HotCommodityModel *dic = self.HomeModel.arrHotGoods[indexPath.row];
                [hotCommodityCell loadView:dic.img_original BuyName:dic.goods_name MoneyOne:dic.price MoneyTwo:dic.market_price Inventory:dic.stock];
                
                return hotCommodityCell;
            }
            
        }
            break;
        default:
        {
            HotCommodityCell *hotCommodityCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotCommodityCell" forIndexPath:indexPath];
            
            HotCommodityModel *dic = self.HomeModel.arrHotGoods[indexPath.row];
            [hotCommodityCell loadView:dic.img_original BuyName:dic.goods_name MoneyOne:dic.price MoneyTwo:dic.market_price Inventory:dic.stock];
            
            return hotCommodityCell;
        }
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.HomeModel.arrCategory.count > 0)
    {
        if (indexPath.section == 3) {
            HotCommodityModel *model = self.HomeModel.arrHotGoods[indexPath.row];
            
            CommodityDetails_VC *detail_VC = [[CommodityDetails_VC alloc]initWithSKU:model.goods_sn];
//            detailVC.sku = model.goods_sn;
            detail_VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detail_VC animated:YES];
        }
    }
    else
    {
        if (indexPath.section == 2) {
            HotCommodityModel *model = self.HomeModel.arrHotGoods[indexPath.row];
            
            CommodityDetails_VC *detail_VC = [[CommodityDetails_VC alloc]initWithSKU:model.goods_sn];
//            detailVC.sku = model.goods_sn;
            detail_VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detail_VC animated:YES];
        }
    }
}

// 配置 每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(kDisWidth, 195);
            break;
        case 1:
            if (self.HomeModel.arrCategory.count > 0) {
                return CGSizeMake(kDisWidth, 110);
            }
            else
            {
                return CGSizeMake(kDisWidth, 205);
            }
            break;
        case 2:
            if (self.HomeModel.arrCategory.count > 0) {
                return CGSizeMake(kDisWidth, 205);
            }
            else
            {
                return CGSizeMake(kDisWidth/2 - 0.25, kDisWidth/2 + 80);
            }
            break;
        default:
            return CGSizeMake(kDisWidth/2 - 0.25, kDisWidth/2 + 80);
            break;
    }
}

// 配置 HeadView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NewHomeSectionHeadView *vHeadCell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NewHomeSectionHeadView" forIndexPath:indexPath];
    
    if (self.HomeModel.arrCategory.count > 0) {
        if (indexPath.section == 2) {
            [vHeadCell loadView:self.arrTextData[0] ImageURL:self.arrImageData[0]];
        }
        if (indexPath.section == 3) {
            [vHeadCell loadView:self.arrTextData[1] ImageURL:self.arrImageData[1]];
        }
    }
    else
    {
        if (indexPath.section == 1) {
            [vHeadCell loadView:self.arrTextData[0] ImageURL:self.arrImageData[0]];
        }
        if (indexPath.section == 2) {
            [vHeadCell loadView:self.arrTextData[1] ImageURL:self.arrImageData[1]];
        }
    }
    return vHeadCell;
}



// 配置 页眉size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.HomeModel.arrCategory.count > 0) {
        if (section == 0 || section == 1) {
            return CGSizeZero;
        }
        CGSize size = CGSizeMake(kDisWidth, 55);
        return size;
    }
    else
    {
        if (section == 0) {
            return CGSizeZero;
        }
        CGSize size = CGSizeMake(kDisWidth, 55);
        return size;
    }
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.5;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y >= kDisHeight - 150) {
        self.btnTop.hidden = NO;
    }
    else
    {
        self.btnTop.hidden = YES;
    }
    
}



#pragma mark - 懒加载
- (UICollectionView *)cltMain
{
    if (!_cltMain) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _cltMain = [[HTCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        _cltMain.delegate = self;
        _cltMain.dataSource = self;
        
        [_cltMain registerClass:[CarouselCell class] forCellWithReuseIdentifier:@"CarouselCell"];
        [_cltMain registerClass:[HomeClassifyCell class] forCellWithReuseIdentifier:@"HomeClassifyCell"];
        [_cltMain registerClass:[HotBrandCell class] forCellWithReuseIdentifier:@"HotBrandCell"];
        [_cltMain registerClass:[HotCommodityCell class] forCellWithReuseIdentifier:@"HotCommodityCell"];
        [_cltMain registerClass:[NewHomeSectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NewHomeSectionHeadView"];
        _cltMain.showsVerticalScrollIndicator = NO;
        
        _cltMain.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    }
    return _cltMain;
}

- (BlankPageView *)vBlankView
{
    if (!_vBlankView) {
        _vBlankView = [[BlankPageView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, kDisHeight - 150)];
        [_vBlankView switchToNoNetwork];
        _vBlankView.hidden = YES;
    }
    return _vBlankView;
}

- (UIButton *)btnTop
{
    if (!_btnTop) {
        _btnTop = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnTop.backgroundColor = [UIColor clearColor];
        [_btnTop setImage:[UIImage imageNamed:@"New_Home_Top_Up"] forState:UIControlStateNormal];
        [_btnTop addTarget:self action:@selector(GoViewTop) forControlEvents:UIControlEventTouchUpInside];
        _btnTop.hidden = YES;
    }
    return _btnTop;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
