//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "GetGoodsViewController.h"
#import "SuspendView.h"

static NSString * const kMyAttentionURL = @"/CollectGoods/getSelfList";

static NSString * const kMyStorageURL = @"/MwStock/getStockList";

@interface GetGoodsViewController ()<UITableViewDataSource,UITableViewDelegate,SuspendViewDelegate>{
    HTTabbleView    *table;
    NSMutableArray  *goodsList;
    UIView         *cover;
    SuspendView    *suspendView;
    
    BlankPageView  *blankPageView;
    
    NSInteger currentPage;
}

@end

@implementation GetGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect bottomFrame = CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight -66);
    
    table = [[HTTabbleView alloc] initWithFrame:bottomFrame style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.showsVerticalScrollIndicator = NO;
    [self.view addSubview:table];
    
    table.tableFooterView = [[UIView alloc] init];
    
    goodsList = [[NSMutableArray alloc] init];
    
    [self reloadGoodsListView];
    
    blankPageView = [[BlankPageView alloc] initWithFrame:bottomFrame];
    blankPageView.title = @"亲，您还没有商品哦～";
    [self.view addSubview:blankPageView];
    
    blankPageView.hidden = YES;
    
    [self addNavigationType:YKSDefaults NavigationTitle:@"选择商品"];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self hideTabBar];
    // 禁用 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 禁用 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }

}
- (void)showTabBar

{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}

-(void)reloadGoodsListView{
    
    if (_type==0) {
        NSString *urlStr = [NSString stringWithFormat:kMyAttentionURL];
        [self getGoodsListWithUrl:urlStr];
    }else{
        [self addRefresh];
    }
}

#pragma mark- 添加刷新控件
-(void)addRefresh
{
    MJRefreshNormalHeader * header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden =YES;
    table.mj_header = header;
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    table.mj_footer = footer;
    table.mj_footer.hidden = YES;
    [table.mj_header beginRefreshing];
}

-(void)loadNewData{
    currentPage = 1;
    [self loadGoodsData];
}

-(void)loadMoreData{
    currentPage ++;
    [self loadGoodsData];
}
-(void)loadGoodsData{
    
    NSDictionary *dic = @{@"page":[NSString stringWithFormat:@"%ld",(long)currentPage]};
    
    [HTLoadingTool showLoadingForView:self.view];
    
    [AFHTTPClient POST:kMyStorageURL params:dic successInfo:^(ResponseModel *response) {
        
        //解析数据
        id json = @{@"data":response.dataResponse};
        [self loadGoodsDataRefresh:json];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == NO_NETWORK)
        {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            blankPageView.hidden = NO;
            return ;
        }
        
        if (type == SERVICE_ERROR) {
            blankPageView.hidden = NO;
            return ;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
    
}

-(void)loadGoodsDataRefresh:(id)json{
    NSDictionary *listData = [json objectForKey:@"data"];
    NSMutableArray * list = [[NSMutableArray alloc]init];
    if (listData.count != 0) {
        list = [listData objectForKey:@"list"];
    }
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray addObjectsFromArray:list];
    if (currentPage == 1) {
        goodsList = tempArray;
        if (tempArray.count >= 10) {
            table.mj_footer.hidden = NO;
        }
    }else{
        [goodsList addObjectsFromArray:tempArray];
        table.mj_footer.hidden = YES;
        if ([tempArray count] == 0)
        {
            [self.view makeToast:@"亲，没有更多商品了" duration:1.0 position:CSToastPositionCenter];
        }
    }
    [self makeViewShow];
    [table reloadData];
    [table.mj_header endRefreshing];
    [table.mj_footer endRefreshing];
    
}
#pragma mark--获取商品列表信息
-(void)getGoodsListWithUrl:(NSString *)urlStr
{
    
    [HTLoadingTool showLoadingDontOperation];
    NSDictionary *dic = @{
                          @"page":[NSString stringWithFormat:@"%ld",(long)currentPage]
                          };
    
    [AFHTTPClient POST:kMyAttentionURL params:dic successInfo:^(ResponseModel *response) {
        
        
        //解析数据
        id json = @{@"data":response.dataResponse};
        NSDictionary *listData = [json objectForKey:@"data"];
        NSMutableArray * list ;
        if (listData.count != 0) {
            list = [listData objectForKey:@"list"];
            goodsList = list;
        }
        
        [table reloadData];
        [self makeViewShow];
        
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == NO_NETWORK)
        {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            blankPageView.hidden = NO;
            return ;
        }
        
        if (type == SERVICE_ERROR) {
            blankPageView.hidden = NO;
            return ;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
    
}


-(void)makeViewShow{
    BOOL show = goodsList.count == 0?YES:NO;
    table.hidden = show;
    blankPageView.hidden = !show;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [goodsList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = goodsList[indexPath.row];
    
    ZXNImageView *imgeView = [[ZXNImageView alloc] initWithFrame:CGRectMake(5.0, 5.0, 65.0, 65.0)];
    imgeView.layer.borderWidth = 0.5;
    imgeView.layer.borderColor = kLineColer.CGColor;
    imgeView.layer.masksToBounds = YES;
    [cell.contentView addSubview:imgeView];
    
    NSString *imgurl = _type == 0?[dict objectForKey:@"img_original"]:[dict objectForKey:@"img_url"];

    [imgeView downloadImage:imgurl backgroundImage:ZXNImageDefaul];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(imgeView.right+5.0, 0.0, kDisWidth-85.0, 35.0)];
    lab.numberOfLines=0;
    lab.text = [dict objectForKey:@"goods_name"];
    lab.font = [UIFont systemFontOfSize:12.0f];
    [cell.contentView addSubview:lab];
    
    UILabel *sn_lab = [[UILabel alloc] initWithFrame:CGRectMake(imgeView.right+5.0, lab.bottom, kDisWidth-170.0, 20.0)];
    NSString *sn=_type == 0?[dict objectForKey:@"sku"]:[dict objectForKey:@"sku"];
    sn_lab.text = [NSString stringWithFormat:@"商品编号：%@",sn];
    sn_lab.font = [UIFont systemFontOfSize:11.0f];
    [cell.contentView addSubview:sn_lab];
    
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(sn_lab.left, sn_lab.bottom , kDisWidth - sn_lab.right, sn_lab.height)];
    NSString *stock = _type==0?[dict objectForKey:@"purchase_count"]:[dict objectForKey:@"available"];
    numLab.text = [NSString stringWithFormat:@"库存：%@件",stock];
    numLab.font = [UIFont systemFontOfSize:11.0f];
    numLab.textColor = [UIColor colorWithHexString:@"#333333"];
    [cell.contentView addSubview:numLab];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = goodsList[indexPath.row];
    [self makeShowCover];
    [self makeSuspendViewWithDict:dict];
}

#pragma mark--显示悬浮视图
-(void)makeSuspendViewWithDict:(NSDictionary *)dict{
    suspendView = [[SuspendView alloc] initWithFrame:CGRectMake(0, kDisHeight - 300, kDisWidth, 300)];
    NSString *img = [dict objectForKey:@"img_original"];
    if (![img isEqualToString:@"<null>"]) {
        NSString *str = [NSString stringWithFormat:@"%@", img];
        [suspendView.imgView downloadImage:str backgroundImage:ZXNImageDefaul];
    }
    
    if(_type == 0){
        suspendView.status=0;
        suspendView.goods_sn=[dict objectForKey:@"sku"];
        suspendView.min_sale_quantity = [dict objectForKey:@"min_sale_quantity"];
        suspendView.max_sale_quantity = [dict objectForKey:@"max_sale_quantity"];
        suspendView.is_modulo = [dict objectForKey:@"is_modulo"];
        suspendView.img_original = [dict objectForKey:@"img_original"];
        if ([dict objectForKey:@"spe"]) {
            NSDictionary *speDict=[dict objectForKey:@"spe"];
            suspendView.speName=[speDict objectForKey:@"name"];
            suspendView.speValues=[speDict objectForKey:@"values"];
        }else{
            suspendView.speValues=nil;
        }
    }else{
        suspendView.status=1;
        suspendView.goods_sn=[dict objectForKey:@"sku"];
        suspendView.speValues=nil;
        suspendView.min_sale_quantity = [dict objectForKey:@"min_sale_quantity"];
        suspendView.max_sale_quantity = [dict objectForKey:@"max_sale_quantity"];
        suspendView.is_modulo = [dict objectForKey:@"is_modulo"];
        suspendView.img_original = [dict objectForKey:@"img_original"];
    }
    suspendView.minSaleNum=[dict objectForKey:@"min_sale_quantity"];
    suspendView.salePolicy=[dict objectForKey:@"sale_policy"];
    suspendView.delegate=self;
    suspendView.name=[dict objectForKey:@"goods_name"];
    suspendView.min_sale_quantity = [dict objectForKey:@"min_sale_quantity"];
    suspendView.max_sale_quantity = [dict objectForKey:@"max_sale_quantity"];
    suspendView.is_modulo = [dict objectForKey:@"is_modulo"];
    suspendView.img_original = [dict objectForKey:@"img_original"];
    [self.view addSubview:suspendView];
    
    [suspendView setFrame:CGRectMake(0, kDisHeight, kDisWidth, 300)];
    [UIView animateWithDuration:0.5 animations:^{
        [suspendView setFrame:CGRectMake(0, kDisHeight - 300, kDisWidth, 300)];
    }];
}

#pragma mark --suspendView 代理方法
-(void)suspendViewDidConfirmWithModel:(GoodsAddModel *)goodsAdd{
    [self makeHiddenCover];
    if ([_delegate respondsToSelector:@selector(GetGoodsActionWithModel:)]) {
        [_delegate GetGoodsActionWithModel:goodsAdd];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark--创建蒙板
-(void)makeShowCover{
    if (cover == nil) {
        cover = [[UIView alloc] init];
        cover.backgroundColor = [UIColor blackColor];
        cover.frame = table.frame;
        cover.autoresizingMask = table.autoresizingMask;
        cover.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeHiddenCover)];
        [cover addGestureRecognizer:tap];
    }
    [self.view addSubview:cover];
    cover.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        cover.alpha = 0.5;
    }];
}

#pragma mark --隐藏蒙板
-(void)makeHiddenCover{
    [UIView animateWithDuration:0.2 animations:^{
        [suspendView setFrame:CGRectMake(0, kDisHeight, kDisWidth, 300)];
    } completion:^(BOOL finished) {
        cover.alpha = 0.0;
        [cover removeFromSuperview];
        [suspendView removeFromSuperview];
    }];
}


@end
