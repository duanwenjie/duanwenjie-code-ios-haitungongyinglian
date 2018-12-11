//
//  ClassifViewController.m
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "ClassifViewController.h"
#import "ClassTableViewCell.h"
#import "ClassCategoryModel.h"
#import "YKSSearchViewController.h"
#import "BuyList_VC.h"
#import "SearchResult_VC.h"
#import "LogisticsNewViewController.h"
#import "HTTabbleView.h"
#import "CommodityDetails_VC.h"

@interface ClassifViewController () <UITableViewDelegate,UITableViewDataSource,ClassTableViewCellDelegate>

@property (nonatomic, strong) HTTabbleView *tbMain;

@property (nonatomic, strong) ClassCategoryModel *mCateGory;

@property (nonatomic, strong) BlankPageView *vBlank;

@property (nonatomic, strong) NSMutableArray *arrCategory;

@end

@implementation ClassifViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.arrCategory = [NSMutableArray array];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    if (self.arrCategory.count == 0) {
        [self loadData];
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


#pragma mark --界面初始化
-(void)setUI
{
    //navBar设置
    UIView * vTitleView = [[UIView alloc]initWithFrame:CGRectMake(20, 27+KTop, kDisWidth - 40, 30)];
    vTitleView.backgroundColor = [UIColor colorWithHexString:@"#0073af"];
    vTitleView.layer.cornerRadius = 5;
    vTitleView.layer.masksToBounds = YES;
    
    UIImageView * vSearchImgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 8.5, 13, 13)];
    vSearchImgView.image = [UIImage drawImageWithName:@"icon-search" size:CGSizeMake(15, 15)];
    [vTitleView addSubview:vSearchImgView];
    
    UILabel * lbTitle = [[UILabel alloc]initWithFrame:CGRectMake(vSearchImgView.right + 15, 0, kDisWidth/2, 30)];
    lbTitle.text = @"请输入商品名称或关键字";
    lbTitle.textColor = [UIColor colorWithHexString:@"#ffffff"];
    lbTitle.textAlignment = NSTextAlignmentLeft;
    lbTitle.font = [UIFont systemFontOfSize:12];
    [vTitleView addSubview: lbTitle];
    
    UIButton * btnTitle =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kDisWidth - 40, 30)];
    [btnTitle addTarget:self action:@selector(searchTo) forControlEvents:UIControlEventTouchUpInside];
    [vTitleView addSubview:btnTitle];
    
    self.tbMain = [[HTTabbleView alloc] initWithFrame:CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight - kDisNavgation - 49) style:UITableViewStyleGrouped];
    self.tbMain.dataSource = self;
    self.tbMain.delegate = self;
    self.tbMain.showsVerticalScrollIndicator = NO;
    self.tbMain.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tbMain];
    
    self.vBlank = [[BlankPageView alloc] initWithFrame:CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight - kDisNavgation)];
    self.vBlank.hidden = YES;
    [self.view addSubview:self.vBlank];
    
    
    
    [self addNavigationType:YKSCustom NavigationTitle:@""];
    [self.vNavigation addSubview:vTitleView];
    
    WS(weakSelf);
    self.vBlank.block = ^{
        [weakSelf loadData];
    };
}


#pragma mark --数据加载
- (void)loadData
{
    [HTLoadingTool showLoadingForView:self.view];
    NSDictionary *dic = nil;
    
    [AFHTTPClient POST:@"/Category/getCategoryTree?category_id=0" params:dic successInfo:^(ResponseModel *response) {
        
        self.vBlank.hidden = YES;
        //解析数据
        id json = @{@"data":response.dataResponse};
        [self loadDataRefresh:json];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == NO_NETWORK)
        {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            self.vBlank.hidden = NO;
            return ;
        }
        
        if (type == SERVICE_ERROR) {
            self.vBlank.hidden = NO;
            return ;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
    
}

-(void)loadDataRefresh:(id)json
{
    NSArray * arr = [json objectForKey:@"data"];
    NSMutableArray * arrM = [[NSMutableArray alloc]init];
    for (int i =0; i< arr.count; i++) {
        NSDictionary * dict = arr[i];
        self.mCateGory = [[ClassCategoryModel alloc] init];
        [self.mCateGory setValues:dict];
        [arrM addObject:self.mCateGory];
        
        if (self.mCateGory.subCategories.count % 4 == 0) {
            self.mCateGory.fWitdh = kDisWidth/3.12 + 20 + (self.mCateGory.subCategories.count/4 * 30);
        }
        else
        {
            self.mCateGory.fWitdh = kDisWidth/3.12 + 20 + ((self.mCateGory.subCategories.count/4 + 1) * 30);
        }
    }
    self.arrCategory = arrM;
    
    [self.tbMain reloadData];
}



#pragma mark --UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.arrCategory.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ClassTableViewCell * cell = [[ClassTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"resuse"];
    
    if (cell == nil)
    {
        cell = [[ClassTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"resuse"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell loadView:self.arrCategory[indexPath.section]];
    return  cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassCategoryModel * model = self.arrCategory[indexPath.section];
    return model.fWitdh;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == self.arrCategory.count - 1) {
        return 13;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 13;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark --ClassTableViewCellDelegate

-(void)headerBtnDidClick:(NSString *)firstID :(NSString *)nextID :(NSString *)name{
    BuyList_VC * VC = [[BuyList_VC alloc] initWithBuySuperListID:firstID subListID:nextID NavBarName:name ClassifyName:@""];
    VC.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:VC animated:YES];
    }


-(void)childBtnDidClick:(NSString *)firstID :(NSString *)nextID :(NSString *)name :(NSString *)sCategoryName
{
    BuyList_VC * VC = [[BuyList_VC alloc] initWithBuySuperListID:firstID subListID:nextID NavBarName:name ClassifyName:sCategoryName];
    VC.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark --跳转到搜索界面
-(void)searchTo
{
    YKSSearchViewController * searchVC = [[YKSSearchViewController alloc] initWithIsHome:NO Block:^(NSString *sKeyWord, NSString *sType, NSString *sSKU) {
        
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


@end
