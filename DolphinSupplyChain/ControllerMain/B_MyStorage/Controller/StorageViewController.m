//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "StorageViewController.h"
#import "StorageModel.h"
#import "LoginViewController.h"
#import "UnLoginView.h"
#import "ProductDetailModel.h"
#import "StorageViewCell.h"
#import "B_MyStoryDetailViewController.h"
#import "HTTabbleView.h"
//我的微仓
static NSString * const kMyStorageURL = @"/MwStock/getStockList";


@interface StorageViewController ()<UITableViewDataSource,UITableViewDelegate,UnLoginViewDelegate>{
    HTTabbleView *table;
    NSMutableArray *storageArray;
    BlankPageView  *blankView;
    
    NSInteger currentPage;
    UnLoginView *unLoginView;
    
    NSMutableArray * arrMsku;
}



@property (nonatomic ,strong)UIButton * barRightOneItem;
@end

@implementation StorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    storageArray = [[NSMutableArray alloc]init];
    
    CGRect bottomFrame = CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight-kDisNavgation);
    
    table = [[HTTabbleView alloc] initWithFrame:CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight-kDisNavgation) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    table.showsVerticalScrollIndicator=NO;
    table.separatorInset=UIEdgeInsetsZero;
    [self.view addSubview:table];
    
    table.tableFooterView = [[UIView alloc] init];
    
    blankView = [[BlankPageView alloc] initWithFrame:bottomFrame];
    blankView.title = @"您的微仓中还没有商品～";
    [self.view addSubview:blankView];
    
    unLoginView = [[UnLoginView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, kDisHeight)];
    [self.view addSubview:unLoginView];
    unLoginView.hidden = YES;
    unLoginView.delegate = self;
    
    blankView.hidden = YES;
    [self addNavigationType:YKSDefaults NavigationTitle:@"微仓库存"];
    [self.vNavigation addSubview:self.barRightOneItem];
    [self addRefresh];
    [self loadData];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([YKSUserDefaults isLogin]) {
        [self loadData];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)goToTheIndex{
    
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(void)loadAction{
    [self loadData];
}


-(void)loadData{
    
    unLoginView.hidden = YES;
    table.hidden=NO;
    [table beginRefreshing];
}

- (void)turnToLoginVC{
    LoginViewController *VC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)login:(UIButton *)btn{

    LoginViewController *VC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark- 添加刷新控件
-(void)addRefresh
{
    WS(weakSelf);
    [table addFooterRefresh:^{
        [weakSelf loadMoreStorageData];
    }];
    
    [table addHeaderRefresh:^{
        [weakSelf loadNewStorageData];
    }];
}

-(void)loadNewStorageData{
    currentPage = 1;
    [self loadStorageData];
}

-(void)loadMoreStorageData{
    currentPage++;
    [self loadStorageData];
}

#pragma mark - 刷新代理方法

-(void)loadStorageData{
    [HTLoadingTool showLoadingForView:self.view];
    NSDictionary *dic = @{
                          @"page":[NSString stringWithFormat:@"%ld",(long)currentPage ]
                          };
    
    [AFHTTPClient POST:kMyStorageURL params:dic successInfo:^(ResponseModel *response) {
        
        
        //解析数据
        id json = @{@"data":response.dataResponse};
        [self loadStorageDataRefresh:json];
        
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        [self endRefresh];
        if (type == NEED_HINT || type == NO_NETWORK)
        {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            return ;
        }
        
        if (type == SERVICE_ERROR) {
            return ;
        }
        
        if (type == NO_NETWORK) {
            table.hidden=YES;
            blankView.hidden=YES;
            unLoginView.hidden=YES;
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            return;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
            [self loadNewStorageData];
        }
    }];
}


-(void)loadStorageDataRefresh:(id)json{
    NSDictionary *listData = [json objectForKey:@"data"];
    NSMutableArray * list = [[NSMutableArray alloc]init];
    if (listData.count != 0) {
        list = [listData objectForKey:@"list"];
    }
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    arrMsku = [[NSMutableArray alloc]init];
    for (NSDictionary *tempDict in list) {
        StorageModel *storages = [[StorageModel alloc] init];
        ProductDetailModel *storagess = [[ProductDetailModel alloc]init];
        [storages setValues:tempDict];
        [tempArray addObject:storages];
        [arrMsku addObject:storagess];
    }
    if (currentPage == 1) {
        if (tempArray.count == 0) {
            table.hidden = YES;
            blankView.hidden = NO;
        }else{
            table.hidden = NO;
            blankView.hidden = YES;
        }
        storageArray = tempArray;
        if (tempArray.count >= 10) {
            table.mj_footer.hidden = NO;
        }
    }else{
        [storageArray addObjectsFromArray:tempArray];
        if ([tempArray count] == 0)
        {
            [self.view makeToast:@"亲，没有更多商品了" duration:1.0 position:CSToastPositionCenter];
            table.mj_footer.hidden=YES;
        }
    }
    [table reloadData];
    [self endRefresh];
    
}

-(void)endRefresh{

    [table endFooterRefreshing];
    [table endHeaderRefreshing];
}


#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [storageArray count];
}

 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * storeCellID = @"storeCellID";
    StorageViewCell * cell = [tableView dequeueReusableCellWithIdentifier:storeCellID];
   
    if (cell == nil) {
        cell = [[StorageViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:storeCellID];
    }
    StorageModel * storageModel = storageArray[indexPath.section];
    [cell setData:storageModel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark - tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StorageModel *storage = storageArray[indexPath.section];
    B_MyStoryDetailViewController * VC = [[B_MyStoryDetailViewController alloc]initWithSKU:storage.sku];
    [self.navigationController pushViewController:VC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.0;
}

-(UIButton *)barRightOneItem{
    
    if (!_barRightOneItem) {
        _barRightOneItem = [[UIButton alloc]initWithFrame:CGRectMake(kDisWidth-50, 27+KTop, 40, 30)];
        [_barRightOneItem setTitle:@"进货" forState:UIControlStateNormal];
        [_barRightOneItem addTarget:self action:@selector(goToTheIndex) forControlEvents:UIControlEventTouchUpInside];
        _barRightOneItem.titleLabel.font = [UIFont systemFontOfSize:15.5];
    }
    return _barRightOneItem;
}

@end
