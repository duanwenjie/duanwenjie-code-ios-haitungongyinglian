//
//  NewHomeRecommend_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/21.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "NewHomeRecommend_VC.h"
#import "NewHomeSectionHeadView.h"
#import "CarouselCell.h"
#import "FavorableCell.h"
#import "NewProductRecommendCell.h"
#import "BargainPriceCell.h"
#import "HotBrandCell.h"
#import "HotCommodityCell.h"
#import "CarouselModel.h"
#import "FavorableModel.h"
#import "NewProductRecommendModel.h"
#import "BargainPriceModel.h"
#import "HotBrandModel.h"
#import "HotCommodityModel.h"
#import "HTLoadingTool.h"
#import "NewHomeBll.h"
#import "BuyList_VC.h"
#import "CommodityDetails_VC.h"
#import "SearchResult_VC.h"

#import "BlankPageView.h"
#import "HTCollectionView.h"



@interface NewHomeRecommend_VC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CarouselDelegate, FavorableDelegate, NewProductRecommendDelegate, BargainPriceDelegate, HotBrandDelegate>

@property (nonatomic, strong) HTCollectionView *cltMain;

@property (nonatomic, strong) NSArray *arrTextData;

@property (nonatomic, strong) NSArray *arrImageData;

@property (nonatomic, strong) NewHomeModel *HomeModelOne;

@property (nonatomic, strong) BlankPageView *vBlankView;

@property (nonatomic, assign) BOOL bCarousel;

@property (nonatomic, assign) BOOL bHotBrand;

@property (nonatomic, assign) NSInteger iPage;

@property (nonatomic, strong) UIButton *btnTop;

@end

@implementation NewHomeRecommend_VC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.iPage = 2;
        self.bCarousel = YES;
        self.bHotBrand = YES;
        self.arrTextData = @[@"新品推荐", @"海豚优惠购", @"热门品牌", @"热销排行"];
        self.arrImageData = @[@"New_Home_Recommend", @"New_Home_Bargain_Price", @"New_Home_Hot_Brand", @"New_Home_Hot_Commodity"];
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
- (void)loadDataFirst
{
    NSDictionary *dic = @{@"page":@"1",
                          @"page_size":@"10",
                          @"category_id":@"0"};
    
    self.vBlankView.hidden = YES;
    
    [AFHTTPClient POST:@"/index/app_v2" params:dic successInfo:^(ResponseModel *response) {
        
        [self.cltMain endHeaderRefreshing];
        self.iPage = 2;
        self.HomeModelOne = [NewHomeBll NewHomeJson:response.dataResponse];
        
        if (self.HomeModelOne == nil) {
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
                          @"category_id":@"0"};
    
    [AFHTTPClient POST:@"/index/app_v2" params:dic successInfo:^(ResponseModel *response) {
        
        
        [self.cltMain endFooterRefreshing];
        
        NSMutableArray* arrHotGoods = [NewHomeBll NewHomeHotGoodsJson:response.dataResponse];
        
        
        NSInteger i = self.HomeModelOne.arrHotGoods.count;
        
        NSMutableArray *array = [NSMutableArray array];
        for (HotCommodityCell *obj in arrHotGoods) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:5];
            [array addObject:path];
            
            [self.HomeModelOne.arrHotGoods addObject:obj];
            i += 1;
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
    self.HomeModelOne = model;
}


#pragma mark - CarouselDelegate
- (void)didSelectItemAtIndex:(NSInteger)index
{
    CarouselModel *model = self.HomeModelOne.arrPictureAdLists[index];
    if ([model.url_type isEqualToString:@"list"]) {
        SearchResult_VC *sear_VC = [[SearchResult_VC alloc] initWithInfo:@"" category_id_in:model.category_id_in brand_id_in:model.brand_id_in goods_id_in:model.goods_id_in brand_id:@"" HaveKeyWork:NO];
        sear_VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sear_VC animated:YES];
    }
    else if ([model.url_type isEqualToString:@"detail"])
    {
        CommodityDetails_VC *detail_VC = [[CommodityDetails_VC alloc]initWithSKU:model.sku];
//        detailVC.sku = model.sku;
        detail_VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail_VC animated:YES];
    }
    else
    {
        
    }
}


#pragma mark - FavorableDelegate
- (void)didFavorableSelectItemAtIndex:(NSInteger)index
{
    FavorableModel *model = self.HomeModelOne.arrPromotion[index];

    if ([model.url_type isEqualToString:@"list"]) {
        SearchResult_VC *sear_VC = [[SearchResult_VC alloc] initWithInfo:@"" category_id_in:model.category_id_in brand_id_in:model.brand_id_in goods_id_in:model.goods_id_in brand_id:@"" HaveKeyWork:NO];
        sear_VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sear_VC animated:YES];
    }
    else if ([model.url_type isEqualToString:@"detail"])
    {
        CommodityDetails_VC *detail_VC = [[CommodityDetails_VC alloc]initWithSKU:model.sku];
        
        detail_VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail_VC animated:YES];
    }
    else
    {
        
    }
}


#pragma mark - NewProductRecommendDelegate
- (void)didNewProductRecommendSelectItemAtIndex:(NSInteger)index
{
    NewProductRecommendModel *model = self.HomeModelOne.arrNewGoods[index];
    CommodityDetails_VC *detail_VC = [[CommodityDetails_VC alloc]initWithSKU:model.goods_sn];

    detail_VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail_VC animated:YES];
}

#pragma mark - BargainPriceDelegate
- (void)didBargainPriceSelectItemAtIndex:(NSInteger)index
{
    BargainPriceModel *model = self.HomeModelOne.arrDefective_list[index];
    CommodityDetails_VC *detail_VC = [[CommodityDetails_VC alloc]initWithSKU:model.goods_sn];

    detail_VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail_VC animated:YES];
}

- (void)didBargainPriceLastMore
{
    BargainPriceModel *model = [self.HomeModelOne.arrDefective_list lastObject];
    BuyList_VC * VC = [[BuyList_VC alloc]initWithBuySuperListID:model.category_id subListID:model.category_id NavBarName:@"海豚优惠购" ClassifyName:@"海豚优惠购"];
    VC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - HotBrandDelegate
- (void)didHotBrandSelectItemAtIndex:(NSInteger)index
{
    HotBrandModel *model = self.HomeModelOne.arrBrands[index];
    SearchResult_VC *sear_VC = [[SearchResult_VC alloc] initWithInfo:@"" category_id_in:@"" brand_id_in:@"" goods_id_in:@"" brand_id:model.brand_id HaveKeyWork:NO];
    sear_VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sear_VC animated:YES];
}



#pragma mark - UICollectionViewDelegate UICollectionViewDataSource UICollectionViewDelegateFlowLayout

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 6;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 5) {
        return self.HomeModelOne.arrHotGoods.count;
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            CarouselCell *carouselCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CarouselCell" forIndexPath:indexPath];
            carouselCell.delegate = self;
            [carouselCell loadView:self.HomeModelOne.arrPictureAdLists isRefresh:self.bCarousel];
            if (self.HomeModelOne.arrPictureAdLists.count > 0) {
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
            FavorableCell *favorableCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FavorableCell" forIndexPath:indexPath];
            favorableCell.delegate = self;
            if (self.HomeModelOne.arrPromotion.count == 2) {
                FavorableModel *model1 = self.HomeModelOne.arrPromotion[0];
                FavorableModel *model2 = self.HomeModelOne.arrPromotion[1];
                [favorableCell loadView:model1.image UrlTwo:model2.image];
            }
            return favorableCell;
        }
            break;
        case 2:
        {
            NewProductRecommendCell *newProductRecommendCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewProductRecommendCell" forIndexPath:indexPath];
            newProductRecommendCell.delegate = self;
            if (self.HomeModelOne.arrNewGoods.count == 3) {
                NewProductRecommendModel *model1 = self.HomeModelOne.arrNewGoods[0];
                NewProductRecommendModel *model2 = self.HomeModelOne.arrNewGoods[1];
                NewProductRecommendModel *model3 = self.HomeModelOne.arrNewGoods[2];
                
                [newProductRecommendCell loadViewOne:model1.goods_name :model1.price :model1.img_original Two:model2.goods_name :model2.price :model2.img_original Three:model3.goods_name :model3.price :model3.img_original];
            }
            
            return newProductRecommendCell;
        }
            break;
        case 3:
        {
            BargainPriceCell *bargainPriceCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BargainPriceCell" forIndexPath:indexPath];
            bargainPriceCell.delegate = self;
            [bargainPriceCell loadView:self.HomeModelOne.arrDefective_list];
            return bargainPriceCell;
        }
            break;
        case 4:
        {
            HotBrandCell *hotBrandCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotBrandCell" forIndexPath:indexPath];
            hotBrandCell.delegate = self;
            [hotBrandCell loadView:self.HomeModelOne.arrBrands isRefresh:self.bHotBrand];
            if (self.HomeModelOne.arrBrands.count > 0) {
                self.bHotBrand = NO;
            }
            else
            {
                self.bHotBrand = YES;
            }
            return hotBrandCell;
        }
            break;
        default:
        {
            HotCommodityCell *carouselCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotCommodityCell" forIndexPath:indexPath];
            
            HotCommodityModel *dic = self.HomeModelOne.arrHotGoods[indexPath.row];
            [carouselCell loadView:dic.img_original BuyName:dic.goods_name MoneyOne:dic.price MoneyTwo:dic.market_price Inventory:dic.stock];
            
            return carouselCell;
        }
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 5) {
        
        HotCommodityModel *model = self.HomeModelOne.arrHotGoods[indexPath.row];
        CommodityDetails_VC *detail_VC = [[CommodityDetails_VC alloc]initWithSKU:model.goods_sn];
//        detailVC.sku = model.goods_sn;
        detail_VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail_VC animated:YES];
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
            return CGSizeMake(kDisWidth, 110);
            break;
        case 2:
            return CGSizeMake(kDisWidth, 242);
            break;
        case 3:
            return CGSizeMake(kDisWidth, 205.5);
            break;
        case 4:
            return CGSizeMake(kDisWidth, 205);
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
    if (indexPath.section == 2) {
        [vHeadCell loadView:self.arrTextData[0] ImageURL:self.arrImageData[0]];
    }
    if (indexPath.section == 3) {
        [vHeadCell loadView:self.arrTextData[1] ImageURL:self.arrImageData[1]];
    }
    if (indexPath.section == 4) {
        [vHeadCell loadView:self.arrTextData[2] ImageURL:self.arrImageData[2]];
    }
    if (indexPath.section == 5) {
        [vHeadCell loadView:self.arrTextData[3] ImageURL:self.arrImageData[3]];
    }
    
    return vHeadCell;
}



// 配置 页眉size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return CGSizeZero;
    }
    CGSize size = CGSizeMake(kDisWidth, 55);
    return size;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.5;
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
        [_cltMain registerClass:[FavorableCell class] forCellWithReuseIdentifier:@"FavorableCell"];
        [_cltMain registerClass:[NewProductRecommendCell class] forCellWithReuseIdentifier:@"NewProductRecommendCell"];
        [_cltMain registerClass:[BargainPriceCell class] forCellWithReuseIdentifier:@"BargainPriceCell"];
        [_cltMain registerClass:[HotBrandCell class] forCellWithReuseIdentifier:@"HotBrandCell"];
        [_cltMain registerClass:[HotCommodityCell class] forCellWithReuseIdentifier:@"HotCommodityCell"];
        [_cltMain registerClass:[NewHomeSectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NewHomeSectionHeadView"];
        _cltMain.showsVerticalScrollIndicator = NO;

        _cltMain.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    }
    return _cltMain;
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
