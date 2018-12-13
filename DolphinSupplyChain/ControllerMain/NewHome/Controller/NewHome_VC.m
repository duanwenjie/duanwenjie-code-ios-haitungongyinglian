//
//  NewHome_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/21.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "NewHome_VC.h"
#import "NewHomeRecommend_VC.h"
#import "NewHomeLayoutOne_VC.h"
#import "NewHomeSearchView.h"
#import "NewHomeHeadView.h"
#import "HTLoadingTool.h"
#import "NewHomeBll.h"
#import "NewHomeModel.h"
#import "YKSSearchViewController.h"
#import "SearchResult_VC.h"
#import "Message_VC.h"
#import "BlankPageView.h"
#import "XNGuideView.h"
#import "CommodityDetails_VC.h"
#import "CommodityDetails_VC.h"
#import "LoginViewController.h"
#import "AppDelegate.h"



@interface NewHome_VC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NewHomeSearchView *vSearch;

@property (nonatomic, strong) NewHomeHeadView *vHead;

@property (nonatomic, strong) BlankPageView *vBlankView;

@property (nonatomic, strong) UIButton *barRightItem;

@property (nonatomic, strong) UICollectionView *cltView;

@property (nonatomic, strong) NSMutableArray *arrController;

@property (nonatomic, strong) NSArray *arrCategories;

@property (assign, nonatomic) NSInteger selectedIndex;


@end

@implementation NewHome_VC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.arrController = [NSMutableArray array];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //禁用滚动到最顶部的属性
    self.cltView.scrollsToTop = NO;
    
    NSArray *array = nil;
    CGFloat fBottom = 0;
    if (kDisWidth == 320 && kDisHeight == 480) { // 3.5英寸
        fBottom = 30;
        array = @[@"Guide_3.5_1", @"Guide_3.5_2", @"Guide_3.5_3", @"Guide_3.5_4"];
    }
    else if (kDisWidth == 375) // 4.7英寸
    {
        fBottom = 51;
        array = @[@"Guide_4.7_1", @"Guide_4.7_2", @"Guide_4.7_3", @"Guide_4.7_4"];
    }
    else if (kDisWidth == 320 && kDisHeight == 568) // 4英寸
    {
        fBottom = 44;
        array = @[@"Guide_4.0_1", @"Guide_4.0_2", @"Guide_4.0_3", @"Guide_4.0_4"];
    }
    else if (kDisWidth == 414 && kDisHeight == 736)// 5.5英寸
    {
        fBottom = 56;
        array = @[@"Guide_5.5_1", @"Guide_5.5_2", @"Guide_5.5_3", @"Guide_5.5_4"];
    }
    else if (kDisHeight == 812)// 5.8英寸
    {
        fBottom = 56;
        array = @[@"Guide_5.8_1", @"Guide_5.8_2", @"Guide_5.8_3", @"Guide_5.8_4"];
    }
    else
    {
        fBottom = 30;
        array = @[@"Guide_5.5_1", @"Guide_5.5_2", @"Guide_5.5_3", @"Guide_5.5_4"];
    }
    [XNGuideView showGudieView:array top:fBottom];
    
    
    /// 添加页面控件
    [self viewControllerAddSubView];
    
    /// 设置页面布局
    [self viewControllerLayoutView];
    
    /// 确定是否需要更新
    [self isUpgrade];
    
    /// 加载网络数据
    [self loadViewData];
    
    [self.view addSubview:self.vBlankView];
    
    WS(weakSelf);
    self.vBlankView.block = ^{
        [weakSelf loadViewData];
    };    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    // 开启
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark - 添加页面控件及页面布局
- (void)viewControllerAddSubView
{
    [self.view addSubview:self.vHead];
    
    [self.view addSubview:self.cltView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.vHead.height + kDisNavgation, kDisWidth, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    [self.view addSubview:line];
    
    [self addNavigationType:YKSCustom NavigationTitle:@""];
    [self.vNavigation addSubview:self.vSearch];
    [self.vNavigation addSubview:self.barRightItem];
    
}
- (void)viewControllerLayoutView
{
    [self.vHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.vNavigation.mas_bottom).offset(0);
        make.height.mas_equalTo(37);
    }];
    
    [self.cltView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
        make.top.equalTo(self.vHead.mas_bottom).offset(0);
    }];
}

#pragma mark - 导航栏右边控件点击事件
- (void)pushToNews
{
    Message_VC *messageVC = [[Message_VC alloc] init];
    [self YKSRootPushViewController:messageVC];
}

- (void)tapSearch
{
    YKSSearchViewController * searchVC = [[YKSSearchViewController alloc] initWithIsHome:YES Block:^(NSString *sKeyWord, NSString *sType, NSString *sSKU) {
        
        if ([sType isEqualToString:@"list"]) {
            SearchResult_VC *sear_VC = [[SearchResult_VC alloc] initWithInfo:sKeyWord category_id_in:@"" brand_id_in:@"" goods_id_in:@"" brand_id:@"" HaveKeyWork:YES];
            sear_VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:sear_VC animated:YES];
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
    
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController presentViewController:searchVC animated:NO completion:nil];
}



#pragma mark - setting
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    CGFloat offsetX = self.view.bounds.size.width * selectedIndex;
    [self.cltView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (_selectedIndex <= 0 || _selectedIndex >= self.arrCategories.count) {
            return;
        }
        [self.arrController[_selectedIndex] loadviewCategoryId:self.arrCategories[_selectedIndex]];        
    });
    
}

#pragma mark - 加载网络数据
- (void)isUpgrade
{
    NSDictionary *dic = @{@"type":@"ios"};

    [AFHTTPClient POSTNODismiss:@"/AppVersion/getLastAppInfo" params:dic successInfo:^(ResponseModel *response) {
        if ([response.dataResponse count] == 0) {
            return ;
        }
        if ([[response.dataResponse allKeys] containsObject:@"ver_name"])
        {
            if ([self compareVersion:response.dataResponse[@"ver_name"]]) {
                [self updateVersion];
            }
        }
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {}];
}

-(BOOL)compareVersion:(NSString *)serviceVersion
{
    NSString * currentversion = [NSString stringWithFormat:@"%@",[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]];
    if ([currentversion compare:serviceVersion options:NSNumericSearch] == NSOrderedAscending)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)updateVersion
{
    UIAlertController *altController = [UIAlertController alertControllerWithTitle:@"发现新版本可供更新" message:@"  1. 日夜赶工,修复了一些小问题.\n  2. 改来改去,优化了一些功能.\n  3. 貌似性能提升了那么一点点." preferredStyle:UIAlertControllerStyleAlert];
    WS(weakSelf);
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"暂不更新" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //点击暂不更新就强制退出APP
        [weakSelf exitApplication];
    }];
    float floatString = [[[UIDevice currentDevice] systemVersion] floatValue];
    UIView *subView1 = altController.view.subviews[0];
    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
    UILabel *message = [[UILabel alloc]init];
    //适配iOS12
    if (floatString < 12){
        message = subView5.subviews[1];
    }else{
        message = subView5.subviews[2];
    }
     message.textAlignment = NSTextAlignmentLeft;
    UIAlertAction *trueAction = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/hai-tun-gong-ying-lian-zhong/id954817077?mt=8"]];
        //如果是C端用户就要注销登录
        if([YKSUserDefaults isUserIndividual]){
            LoginViewController * lg_VC = [[LoginViewController alloc]init];
            [lg_VC logout];
        }
    }];
    
    [altController addAction:cancelAction];
    [altController addAction:trueAction];
    
    [self.navigationController presentViewController:altController animated:YES completion:nil];
}

//强制退出APP程序
- (void)exitApplication
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    [UIView animateWithDuration:0.5f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

- (void)loadViewData
{
    
    self.vBlankView.hidden = YES;
    NSDictionary *dic = @{@"page":@"1",
                          @"page_size":@"10",
                          @"category_id":@"0"};
    
    [HTLoadingTool showLoading];
    
    [AFHTTPClient POST:@"/index/app_v2" params:dic successInfo:^(ResponseModel *response) {
        
        NewHomeModel *model = [NewHomeBll NewHomeJson:response.dataResponse];
        
        if (model == nil) {
            self.vBlankView.hidden = NO;
            return ;
        }
        
        [model.arrTopLevelCategories enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == 0) {
                NewHomeRecommend_VC *vcRecommend = [[NewHomeRecommend_VC alloc] init];
                [vcRecommend loadViewData:model];
                [self.arrController addObject:vcRecommend];
                [self addChildViewController:vcRecommend];
            }
            else
            {
                NewHomeLayoutOne_VC *vcOneLayout = [[NewHomeLayoutOne_VC alloc] init];
                [self.arrController addObject:vcOneLayout];
                [self addChildViewController:vcOneLayout];
            }
            
        }];
        
        self.arrCategories = model.arrTopLevelCategories;
        self.vHead.items = self.arrCategories;
        self.vHead.selectedItemIndex = 0;
        
        [self.cltView reloadData];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        if (type == NEED_HINT || type == NO_NETWORK)
        {
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

#pragma mark - UICollectionViewDelegate UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.arrController.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UIViewControllerCell" forIndexPath:indexPath];
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIView *view = [self.arrController[indexPath.item] view];
    
    [cell.contentView addSubview:view];
    
    view.frame = cell.bounds;
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kDisWidth, kDisHeight - 150);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


#pragma mark - collectionView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    self.vHead.selectedItemIndex = index;
    if (index <= 0 || index >= self.arrCategories.count) {
        return;
    }
    [self.arrController[index] loadviewCategoryId:self.arrCategories[index]];
}



#pragma mark - 懒加载
- (NewHomeSearchView *)vSearch
{
    if (!_vSearch) {
        _vSearch = [[NewHomeSearchView alloc] initWithFrame:CGRectMake(20, 27+KTop, kDisWidth - 80, 30)];
        _vSearch.backgroundColor = [UIColor colorWithHexString:@"#0073af"];
        _vSearch.layer.cornerRadius = 5;
        _vSearch.layer.masksToBounds = YES;
        
        UITapGestureRecognizer *tapSearch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSearch)];
        [_vSearch addGestureRecognizer:tapSearch];
    }
    return _vSearch;
}

- (UIButton *)barRightItem
{
    if (!_barRightItem) {
        _barRightItem = [[UIButton alloc] initWithFrame:CGRectMake(self.vSearch.right + 10, 22+KTop, 30, 40)];
        [_barRightItem setImage:[UIImage drawImageWithName:@"Personal_Center_Setting_Message" size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
        [_barRightItem addTarget:self action:@selector(pushToNews) forControlEvents:UIControlEventTouchUpInside];
        [_barRightItem setImageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        
        UIView *vRed = [[UIView alloc] initWithFrame:CGRectMake(26, 7, 6, 6)];
        vRed.backgroundColor = [UIColor redColor];
        vRed.layer.cornerRadius = 3;
        [_barRightItem addSubview:vRed];
    }
    return _barRightItem;
}

- (NewHomeHeadView *)vHead
{
    if (!_vHead) {
        WS(weakSelf);
        _vHead = [[NewHomeHeadView alloc] initWithItems:nil Frame:CGRectMake(0, kDisNavgation, kDisWidth, 37) itemClick:^(NSInteger selectedIndex) {
            [weakSelf setSelectedIndex:selectedIndex];
        }];
        _vHead.backgroundColor = [UIColor whiteColor];
    }
    return _vHead;
}

- (UICollectionView *)cltView
{
    if (!_cltView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(kDisWidth, kDisHeight - 150);
        
        //设置collectionView的属性
        _cltView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _cltView.pagingEnabled = YES;
        [_cltView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UIViewControllerCell"];
        _cltView.delegate = self;
        _cltView.dataSource = self;
        _cltView.backgroundColor = [UIColor whiteColor];
        _cltView.showsHorizontalScrollIndicator = NO;
    }
    return _cltView;
}

- (BlankPageView *)vBlankView
{
    if (!_vBlankView) {
        _vBlankView = [[BlankPageView alloc] initWithFrame:CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight - 113)];
        [_vBlankView switchToNoNetwork];
        _vBlankView.hidden = YES;
    }
    return _vBlankView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
