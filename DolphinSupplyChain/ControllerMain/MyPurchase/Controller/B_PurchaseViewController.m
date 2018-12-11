//
//  B_PurchaseViewController.m
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/3/7.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "B_PurchaseViewController.h"
#import "HTTabbleView.h"
#import "PurchaseOrderView.h"
#import "B_PurchaseViewController.h"
#import "B_PuchaseTableView_VC.h"
#import "B_PuchaseHeaderView.h"
#import "CommodityDetails_VC.h"

static NSString * const kMyPurchaseURL = @"/PurchaseOrder/getPurchaseOrderList";
static NSString * collectID = @"collectID";

@interface B_PurchaseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic ,assign)NSInteger selectIndex ;

@property (nonatomic ,strong)BlankPageView * blankPageView;

@property (nonatomic ,assign)NSInteger * page;

@property (nonatomic ,strong)NSMutableArray * purchaseList;

@property (nonatomic ,strong)NSArray * arrList;

@property (nonatomic ,assign)NSIndexPath * indexPath;

@property (nonatomic ,strong)UICollectionView * collectionView;

@property (nonatomic ,strong)B_PuchaseHeaderView * vHead;

@property (assign, nonatomic) NSInteger selectedIndex;

@property (nonatomic, strong) NSMutableArray *arrController;

@property (nonatomic, strong) NSArray *arrCategories;


@end

@implementation B_PurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    
    [self initView];
    [self loadViewData];
    WS(weakSelf);
    self.blankPageView.block = ^{
        [weakSelf loadViewData];
    };

    [self addNavigationType:YKSOnlyTitle NavigationTitle:@"采购进货"];
     [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectID];

}




#pragma mark - 初始化
-(void)initView{
    
    
    [self.view addSubview:self.vHead];
    
    [self.view addSubview:self.collectionView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.vHead.height + kDisNavgation, kDisWidth, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    [self.view addSubview:line];
    
    [self.vHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(kDisNavgation);
        make.height.mas_equalTo(37);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(101+KTop);
        make.bottom.equalTo(self.view).offset(-50);
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseGoodsActionn:) name:@"kNotificationPurchaseCell" object:nil];
   
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kNotificationPurchaseCell" object:nil];
}





#pragma mark - 加载数据
- (void)loadViewData
{
    [self.arrList enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
            B_PuchaseTableView_VC * VC = [[B_PuchaseTableView_VC alloc] init];
        if (idx == 0) {
            [VC loadviewCategoryId:0];
        }
            [self.arrController addObject:VC];
            [self addChildViewController:VC];
        
    }];
    
    self.vHead.items = @[@"未支付",@"已支付"];
    self.vHead.selectedItemIndex = 0;
    
    [self.collectionView reloadData];
}





#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrController.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectID forIndexPath:indexPath];
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIView *view = [self.arrController[indexPath.item] view];
    
    [self.arrController[1] loadviewCategoryId:1];
    
    [cell.contentView addSubview:view];
    
    view.frame = cell.bounds;
    
    return cell;

}




#pragma mark - 选择商品
-(void)purchaseGoodsActionn:(NSNotification *)notifi{
    
    NSDictionary *dict=[notifi userInfo];
    NSString * goods_sn = [dict objectForKey:@"goods_sn"];
    CommodityDetails_VC *detail=[[CommodityDetails_VC alloc] initWithSKU:goods_sn];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}



#pragma mark - 顶部View滑动事件
- (void)setSelectIndexx:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    CGFloat offsetX = self.view.bounds.size.width * selectedIndex;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    [self.arrController[_selectedIndex] loadviewCategoryId:selectedIndex];
    
}


#pragma mark - collectionView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    self.vHead.selectedItemIndex = index;
    if (index <= 0 || index >= self.arrController.count) {
        return;
    }
    [self.arrController[index] loadviewCategoryId:index];
    
}



#pragma mark - 懒加载

-(NSMutableArray *)purchaseList{

    if (!_purchaseList) {
        _purchaseList = [[NSMutableArray alloc]init];
    }
    return _purchaseList;
    
}



//-(BlankPageView *)blankPageView{
//
////    if (!_blankPageView) {
////        _blankPageView = [[BlankPageView alloc]initWithFrame:CGRectMake(0, 104, kDisWidth, kDisHeight-154)];
////        _blankPageView.title = @"该状态下还没有订单哦～";
////        _blankPageView.hidden = YES;
////    }
//    return _blankPageView;
//}

-(NSArray *)arrList{

    if (!_arrList) {
        _arrList = [[NSArray alloc]init];
        _arrList = @[@"未付款",@"已付款"];
    }
    return _arrList;
}

-(NSMutableArray *)arrController{

    if (!_arrController) {
        _arrController = [[NSMutableArray alloc]init];
        
    }
    return _arrController;
}

-(UICollectionView *)collectionView{

    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.itemSize = CGSizeMake(kDisWidth, kDisHeight - 150-KTop);
        
        //设置collectionView的属性
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectID];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
//        _collectionView.scrollEnabled = NO;
    }
    return _collectionView;
}

- (B_PuchaseHeaderView *)vHead
{
    if (!_vHead) {
        WS(weakSelf);
        _vHead = [[B_PuchaseHeaderView alloc] initWithItems:nil Frame:CGRectMake(0, kDisNavgation, kDisWidth, 37) itemClick:^(NSInteger selectedIndex) {
            [weakSelf setSelectIndexx:selectedIndex];
        }];
        _vHead.backgroundColor = [UIColor whiteColor];
    }
    return _vHead;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
