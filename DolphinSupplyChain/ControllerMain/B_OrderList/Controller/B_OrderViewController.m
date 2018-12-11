//
//  B_OrderViewController.m
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/3/13.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "B_OrderViewController.h"
#import "B_OrderTableHeaderView.h"
#import "B_OrderTableView_VC.h"
#import "OrderModel.h"
#import "BCOrderDetails_VC.h"
#import "CreatNewOrderViewController.h"
#import "StorageViewController.h"
#import "OrderTableView.h"
#import "ZXNTool.h"
#import "ShopingCart_VC.h"
#import "LogisticsNewViewController.h"


static NSString * orderID = @"orderID";

static NSString * const kSaleOrderURL = @"/SalesOrder/getSalesOrderList";

static NSString * const KAddquickBuy = @"/cart/batchAdd";

static NSString * const kNoticeDevURL = @"/SalesOrder/notify";

static NSString * const kCancelOrderURL = @"/SalesOrder/cancel";

static NSString * const kSurelOrderURL = @"/SalesOrder/receive";

@interface B_OrderViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic ,strong)B_OrderTableHeaderView * vHead;

@property (nonatomic ,strong)BlankPageView * blankPageView;

@property (nonatomic ,strong)UICollectionView * collectionView;

@property (nonatomic ,strong)NSArray * arrList;

@property (nonatomic, strong) NSMutableArray *arrController;

@property (assign, nonatomic) NSInteger selectedIndex;

@property (nonatomic, strong) NSArray *arrCategories;

@property (nonatomic ,strong)UIButton * barRightOneItem;

@property (nonatomic ,strong)UIButton * barLeftOneItem;


@property (nonatomic ,strong)UIAlertView * deliverAlert;

@property (nonatomic ,strong)UIAlertView * cancelAlert;

@property (nonatomic ,strong)UIAlertView * cancelNotifyAlert;

@property (nonatomic ,strong)UIAlertView * surePayAlert;

@property (nonatomic ,copy)NSString * cancelOrderID;

@property (nonatomic ,copy)NSString * cancelNotifyID;

@property (nonatomic ,copy)NSString * surePayID;


@end

@implementation B_OrderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self loadViewData];
    WS(weakSelf);
    self.blankPageView.block = ^{
        [weakSelf loadViewData];
    };
    
    [self addNavigationType:YKSOnlyTitle NavigationTitle:@"销售发货"];
    [self.vNavigation addSubview:self.barRightOneItem];
    [self.vNavigation addSubview:self.barLeftOneItem];

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:orderID];
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
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectGoodsCelll:) name:@"kNotificationSelectCell" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectGoodsCelll:) name:@"kNotificationSelectHeader" object:nil];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"isPop"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kNotificationSelectCell" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kNotificationSelectHeader" object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isOredeType"] isEqualToString:@"isYes"]) {
        NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"OrderDataType"];
        NSInteger index = 0;
        if (str != nil) {
            if ([str isEqualToString:@"0"]) {
                index = 0;
            }else if ([str isEqualToString:@"1"]){
                index = 1;
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"OrderDataType"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else if ([str isEqualToString:@"2"]){
                index = 2;
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"OrderDataType"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else if ([str isEqualToString:@"3"]){
                index = 3;
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"OrderDataType"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                index = 3;
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"OrderDataType"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            [self setSelectIndexx:index];
            self.vHead.selectedItemIndex = index;
        }else{
            index = 0;
            [self setSelectIndexx:index];
            self.vHead.selectedItemIndex = index;
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"isOredeType"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
}


#pragma mark - 选择商品订单详情
-(void)didSelectGoodsCelll:(NSNotification *)notifi{
    NSDictionary *dict = [notifi userInfo];
    OrderModel * order = [dict objectForKey:@"order"];
    NSString * sOrderId = order.sales_order_id;
    
    BOOL isNopay = NO;
    if ([order.order_status isEqualToString:@"SALES_ORDER_STATUS_DELETED"] || [order.order_status isEqualToString:@"SALES_ORDER_STATUS_CANCELLED"] || [order.order_status isEqualToString:@"1"]) {
        isNopay = YES;
    }else{
        isNopay = NO;
    }
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    BCOrderDetails_VC * VC = [[BCOrderDetails_VC alloc] initWithOrderID:sOrderId B_COrder:NO isNoPay:isNopay];
    if ([order.order_status isEqualToString:@"1"] || [order.order_status isEqualToString:@"2"]) {
        VC.bNoRevise = YES;
    }
    else
    {
        VC.bNoRevise = NO;
    }
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    
}





#pragma mark - 加载数据
- (void)loadViewData
{
    [self.arrList enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        B_OrderTableView_VC * VC = [[B_OrderTableView_VC alloc] init];
        [self.arrController addObject:VC];
        [self addChildViewController:VC];
        
    }];
    
    self.vHead.items = @[@"缺货采购",@"待通知发货",@"待收货",@"全部订单"];
    self.vHead.selectedItemIndex = 0;
    
    [self.collectionView reloadData];
    
}





#pragma mark - 顶部View滑动事件
- (void)setSelectIndexx:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    CGFloat offsetX = self.view.bounds.size.width * selectedIndex;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    if (selectedIndex <= 0 || selectedIndex >= self.arrController.count) {
        return;
    }
    [self.arrController[_selectedIndex] loadviewCategoryId:selectedIndex isHeader:YES];
    
}


#pragma mark - collectionView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    self.vHead.selectedItemIndex = index;
    if (index <= 0 || index >= self.arrController.count) {
        return;
    }
    [self.arrController[_selectedIndex] loadviewCategoryId:index isHeader:NO];
    
}



#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrController.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:orderID forIndexPath:indexPath];
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIView *view = [self.arrController[indexPath.item] view];
    
    [self.arrController[1] loadviewCategoryId:1 isHeader:NO];
    
    [cell.contentView addSubview:view];
    
    view.frame = cell.bounds;

    return cell;
    
}


#pragma mark - 添加销售订单

- (void)orderOperation:(UIButton *)sender{
    if (![YKSUserDefaults isLogin]){
        [self.view makeToast:@"请先登录！" duration:1.0 position:CSToastPositionCenter];
    }else{
        CreatNewOrderViewController * newOrderVC = [[CreatNewOrderViewController alloc] init];
        newOrderVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:newOrderVC animated:YES];
        
    }
    
}

#pragma mark - 跳转到微仓库存

-(void)orderOperationLeft:(UIButton *)sender{
    if (![YKSUserDefaults isLogin]){
        [self.view makeToast:@"请先登录！" duration:1.0 position:CSToastPositionCenter];
    }else{
        StorageViewController * storageVC = [[StorageViewController alloc]init];
        storageVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:storageVC animated:YES];
    }
    
}


#pragma mark - 懒加载


//-(BlankPageView *)blankPageView{
//
//    if (!_blankPageView) {
//        _blankPageView = [[BlankPageView alloc]initWithFrame:CGRectMake(0, 104, kDisWidth, kDisHeight-154)];
//        _blankPageView.title = @"该状态下还没有订单哦～";
//        _blankPageView.hidden = YES;
//    }
//    return _blankPageView;
//}

- (B_OrderTableHeaderView *)vHead
{
    if (!_vHead) {
        WS(weakSelf);
        _vHead = [[B_OrderTableHeaderView alloc] initWithItems:nil Frame:CGRectMake(0, kDisNavgation, kDisWidth, 37) itemClick:^(NSInteger selectedIndex) {
            [weakSelf setSelectIndexx:selectedIndex];
        }];
        _vHead.backgroundColor = [UIColor whiteColor];
    }
    return _vHead;
}
-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.itemSize = CGSizeMake(kDisWidth, kDisHeight - 150);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:orderID];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
//        _collectionView.scrollEnabled = NO;
        
    }
    return _collectionView;
}

-(NSArray *)arrList{
    
    if (!_arrList) {
        _arrList = [[NSArray alloc]init];
        _arrList = @[@"缺货采购",@"待通知发货",@"待收货",@"全部订单"];
    }
    return _arrList;
}

-(NSMutableArray *)arrController{
    
    if (!_arrController) {
        _arrController = [[NSMutableArray alloc]init];
        
    }
    return _arrController;
}

-(UIButton *)barRightOneItem{
    
    if (!_barRightOneItem) {
        _barRightOneItem = [[UIButton alloc]initWithFrame:CGRectMake(kDisWidth-90, 27+KTop, 80, 30)];
        [_barRightOneItem setTitle:@"销售订单" forState:UIControlStateNormal];
        [_barRightOneItem addTarget:self action:@selector(orderOperation:) forControlEvents:UIControlEventTouchUpInside];
        _barRightOneItem.titleLabel.font = [UIFont systemFontOfSize:15.5];
    }
    return _barRightOneItem;
}

-(UIButton *)barLeftOneItem{
    
    if (!_barLeftOneItem) {
        _barLeftOneItem = [[UIButton alloc]initWithFrame:CGRectMake(10, 27+KTop, 80, 30)];
        [_barLeftOneItem setTitle:@"微仓库存" forState:UIControlStateNormal];
        [_barLeftOneItem addTarget:self action:@selector(orderOperationLeft:) forControlEvents:UIControlEventTouchUpInside];
        _barLeftOneItem.titleLabel.font = [UIFont systemFontOfSize:15.5];
    }
    return _barLeftOneItem;
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
