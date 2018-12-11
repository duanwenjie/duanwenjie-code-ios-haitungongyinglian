//
//  B_OrderTableView_VC.m
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/3/13.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "B_OrderTableView_VC.h"
#import "OrderTableView.h"
#import "ProductShowTable.h"
#import "CreatNewOrderViewController.h"
#import "StorageViewController.h"
#import "ShopingCart_VC.h"
#import "BCOrderDetails_VC.h"
#import "ZXNTool.h"
#import "LogisticsNewViewController.h"


static NSString * const kSaleOrderURL = @"/SalesOrder/getSalesOrderList";

static NSString * const KAddquickBuy = @"/cart/batchAdd";

static NSString * const kNoticeDevURL = @"/SalesOrder/notify";

static NSString * const kCancelOrderURL = @"/SalesOrder/cancel";

static NSString * const kSurelOrderURL = @"/SalesOrder/receive";

@interface B_OrderTableView_VC()<OrderTableViewDelegate,UIAlertViewDelegate>

@property (nonatomic ,strong)OrderTableView * table;

@property (nonatomic ,assign)NSInteger  page;

@property (nonatomic ,assign)NSInteger  selectIndex;

@property (nonatomic ,strong)BlankPageView * blankPageView;

@property (nonatomic ,strong)NSMutableArray * purchaseList;

@property (nonatomic ,copy)NSString * order_id;

@property (nonatomic ,strong)NSMutableArray * orderNumList;

@property (nonatomic ,strong)UIAlertView * deliverAlert;

@property (nonatomic ,strong)UIAlertView * cancelAlert;

@property (nonatomic ,strong)UIAlertView * cancelNotifyAlert;

@property (nonatomic ,strong)UIAlertView * surePayAlert;

@property (nonatomic ,copy)NSString * cancelOrderID;

@property (nonatomic ,copy)NSString * cancelNotifyID;

@property (nonatomic ,copy)NSString * surePayID;

@property (nonatomic ,assign)NSInteger  order_status;

@property (nonatomic ,assign)BOOL  isFirst;

@end

@implementation B_OrderTableView_VC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.table];
    
    
    [self addRefresh];
    [self.table beginRefreshing];
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(KTopSuit);
        
    }];
   
    [self.table addSubview:self.blankPageView];
    
}


#pragma mark - 添加刷新
-(void)addRefresh
{
    WS(weakSelf);
    [self.table addHeaderRefresh:^{
        [weakSelf loadNewData];
    }];
    
    [self.table addFooterRefresh:^{
        [weakSelf loadMoreData];
    }];
}

- (void)loadNewData
{
    self.page = 0;
    [self loadOrderData];
}

- (void)loadMoreData
{
    self.page ++;
    [self loadOrderData];
    
}

#pragma mark - 刷新加载数据

- (void)loadviewCategoryId:(NSInteger )selected isHeader:(BOOL)isHeader
{

    if (isHeader) {
        self.order_status = selected;
        [self.table beginRefreshing];
    }else{
    
        self.order_status = selected;
        if (selected == 1) {
            return;
        }
        
        [self.table beginRefreshing];
    }
}

#pragma mark - 加载数据
- (void)loadOrderData
{
    
    NSDictionary *dic = nil;
    if (self.order_status == 0)
    {
        dic = @{@"order_status":@"1",
                @"goods":@"1",
                @"logistics":@"0",
                @"offset":[NSString stringWithFormat:@"%ld",(long)self.page],
                @"order_by_dir":@"DESC",
                @"order_by":@"add_time",};
        
    }
    else if (self.order_status == 1)
    {
        dic = @{@"order_status":@"2",
                @"goods":@"1",
                @"logistics":@"0",
                @"offset":[NSString stringWithFormat:@"%ld",(long)self.page],
                @"order_by_dir":@"DESC",
                @"order_by":@"add_time",};
        
    }
    else if (self.order_status == 2)
    {
        dic = @{@"order_status":@"3",
                @"goods":@"1",
                @"logistics":@"0",
                @"offset":[NSString stringWithFormat:@"%ld",(long)self.page],
                @"order_by_dir":@"DESC",
                @"order_by":@"add_time",};
        
    }
    else if (self.order_status == 3)
    {
        dic = @{@"order_status":@"SALES_ORDER_STATUS_ALL",
                @"goods":@"1",
                @"logistics":@"0",
                @"offset":[NSString stringWithFormat:@"%ld",(long)self.page],
                @"order_by_dir":@"DESC",
                @"order_by":@"add_time",};
        
    }
    
    [AFHTTPClient POST:kSaleOrderURL params:dic successInfo:^(ResponseModel *response) {
        
        
        //解析数据
        id json = @{@"data":response.dataResponse};
        [self loadOrderData:json];
        
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        [self endRefresh];
        if (type == NEED_HINT || type == NO_NETWORK)
        {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            self.blankPageView.hidden = NO;
            return ;
        }
        
        if (type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            return;
        }
        
        if (type == SERVICE_ERROR) {
            self.blankPageView.hidden = NO;
            return ;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
            [self loadOrderData];
        }
    }];
    
}


-(void)loadOrderData:(id)json{
    NSArray *result = [[json objectForKey:@"data"] objectForKey:@"list"];
    NSInteger count = result.count;
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in result) {
        OrderModel *order = [[OrderModel alloc] init];
        [order setValues:dict];
        [tempArray addObject:order];
    }
    if (self.page == 0) {
        if (tempArray.count == 0) {
            self.blankPageView.hidden = NO;
        }else{
            self.blankPageView.hidden = YES;
        }
        self.orderNumList = tempArray;
        if (count>15) {
            self.table.mj_footer.hidden = NO;
        }
    }else{
        if ([tempArray count] == 0)
        {
            [self.view makeToast:@"亲，没有更多订单了" duration:1.0 position:CSToastPositionCenter];
            self.table.mj_footer.hidden=YES;
        }else{
            [self.orderNumList addObjectsFromArray:tempArray];
        }
    }
    [self endRefresh];
    self.table.orderList = self.orderNumList;
    self.table.status = [NSNumber numberWithInteger:self.order_status];
    [self.table reloadData];
    
}


- (void)endRefresh
{
    [self.table endFooterRefreshing];
    [self.table endHeaderRefreshing];
}

#pragma mark - 禁用手势
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


#pragma mark - 去采购
-(void)orderListPayActionWithModel:(OrderModel *)order{
    NSMutableArray *params = [[NSMutableArray alloc] init];
    for (int i = 0; i <order.goods.count; i++) {
        NSDictionary * arrDict = order.goods[i];
        NSString * ID = [arrDict objectForKey:@"goods_id"];
        NSString * quantity = [arrDict objectForKey:@"quantity"];
        NSDictionary *tempDict = [[NSDictionary alloc] initWithObjects:@[ID,quantity] forKeys:@[@"goods_id",@"quantity"]];
        [params addObject:tempDict];
        
    }
    [HTLoadingTool showLoadingDontOperation];
    NSString *value = [ZXNTool getJSONString:params];
    //添加到购物车
    NSDictionary * dic = @{@"goods_list":value};
    
    
    [AFHTTPClient POST:KAddquickBuy params:dic successInfo:^(ResponseModel *response) {
        
        
        //解析数据
        ShopingCart_VC *shopCartVC = [[ShopingCart_VC alloc] init];
        shopCartVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shopCartVC animated:YES];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        if (type == NEED_HINT || type == NO_NETWORK)
        {
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


#pragma mark - 查看物流
- (void)orderlistLogisticActionWithModel:(OrderModel *)order
{
    LogisticsNewViewController * logicticVC = [[LogisticsNewViewController alloc] init];
    logicticVC.orderID = order.sales_order_id;
    logicticVC.hidesBottomBarWhenPushed = YES;
    logicticVC.type = @"SALES_ORDER";
    [self.navigationController pushViewController:logicticVC animated:YES];
}

#pragma mark - 通知发货
- (void)orderListDeliverActionWithModel:(OrderModel *)order
{
    NSDictionary *dic = @{@"sales_order_id":order.sales_order_id};
    [HTLoadingTool showLoadingDontOperation];
    [AFHTTPClient POST:kNoticeDevURL params:dic successInfo:^(ResponseModel *response) {
        
        
        //解析数据
        id json = @{@"data":response.dataResponse};
        [self orderListDeliverRefresh:json];
        
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        if (type == NEED_HINT || type == NO_NETWORK)
        {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            self.blankPageView.hidden = NO;
            return ;
        }
        
        if (type == SERVICE_ERROR) {
            self.blankPageView.hidden = NO;
            return ;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
    
}

-(void)orderListDeliverRefresh:(id)json{
    self.deliverAlert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的发货信息已提交" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [self.deliverAlert show];
}


#pragma mark - 确认收货
-(void)orderlistSureActionWithModel:(OrderModel *)order{
    self.surePayAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认收货?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [self.surePayAlert show];
    self.surePayID = order.sales_order_id;
}

#pragma mark - 取消订单
- (void)orderListCancelActionWithModel:(OrderModel *)order
{
    self.cancelAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要取消订单吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [self.cancelAlert show];
    self.cancelOrderID = order.sales_order_id;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.deliverAlert) {
        [self.table.mj_header beginRefreshing];
    }else if (alertView == self.cancelAlert){
        if (buttonIndex == 1) {
            NSDictionary * dic = @{
                                   @"sales_order_id":self.cancelOrderID
                                   };
            
            [HTLoadingTool showLoadingStringDontOperation:@"取消中..."];
            
            [AFHTTPClient POST:kCancelOrderURL params:dic successInfo:^(ResponseModel *response) {
                [self.table.mj_header beginRefreshing];
                [self.view makeToast:@"已取消订单" duration:1.0 position:CSToastPositionCenter];
                
                
                
            } flaseInfo:^(ResponseModel *response, HTTPType type) {
                if (type == NEED_HINT || type == NO_NETWORK)
                {
                    [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
                    self.blankPageView.hidden = NO;
                    return ;
                }
                
                if (type == SERVICE_ERROR) {
                    self.blankPageView.hidden = NO;
                    return ;
                }
                
                if (type == NEED_LOGIN) {
                    ZXNLog(@"需要登录");
                }
            }];
            
            
        }
    }else if (alertView == self.surePayAlert){
        if (buttonIndex == 1) {
            {
                
                [HTLoadingTool showLoadingDontOperation];
                NSDictionary *dic = @{@"sales_order_id":self.surePayID};
                
                [AFHTTPClient POST:kSurelOrderURL params:dic successInfo:^(ResponseModel *response) {
                    
                    [self.table.mj_header beginRefreshing];
                    
                    
                    
                } flaseInfo:^(ResponseModel *response, HTTPType type) {
                    if (type == NEED_HINT || type == NO_NETWORK)
                    {
                        [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
                        self.blankPageView.hidden = NO;
                        return ;
                    }
                    
                    if (type == SERVICE_ERROR) {
                        self.blankPageView.hidden = NO;
                        return ;
                    }
                    
                    if (type == NEED_LOGIN) {
                        ZXNLog(@"需要登录");
                    }
                }];
                
            }
            
        }
    }
}
//

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
}



#pragma mark - 懒加载
- (OrderTableView *)table
{
    if (!_table) {
        _table = [[OrderTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.orderDelegate=self;
        _table.backgroundColor=[UIColor colorWithHexString:@"#efeff2"];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _table;
}

- (BlankPageView *)blankPageView
{
    
    if (!_blankPageView) {
        _blankPageView = [[BlankPageView alloc] init];
        _blankPageView.title = @"亲，没有更多订单了~~";
        _blankPageView.frame = CGRectMake(0, 0, kDisWidth, kDisHeight-101);
        _blankPageView.hidden = YES;
    }
    return _blankPageView;
}

-(NSMutableArray *)orderNumList{
    
    if (!_orderNumList) {
        _orderNumList = [[NSMutableArray alloc]init];
    }
    return _orderNumList;
}

@end




