//
//  B_PuchaseTableView_VC.m
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/3/10.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "B_PuchaseTableView_VC.h"
#import "PurchaseOrderView.h"
#import "HTTabbleView.h"
#import "PayBC_VC.h"
#import "ShopingCart_VC.h"
#import "ZXNTool.h"

static NSString * const kMyPurchaseURL = @"/PurchaseOrder/getPurchaseOrderList";

static NSString * const kCancelPurchaseOrderURL = @"/PurchaseOrder/cancel";

static NSString * const kAddToAddCartURL = @"/cart/batchAdd";

static NSString * const KAddquickBuy = @"/cart/batchAdd";


@interface B_PuchaseTableView_VC ()<PurchaseOrderViewDelegate>

@property (nonatomic ,strong)PurchaseOrderView * table;

@property (nonatomic ,assign)NSInteger  page;

@property (nonatomic ,assign)NSInteger  selectIndex;

@property (nonatomic ,strong)BlankPageView * blankPageView;

@property (nonatomic ,strong)NSMutableArray * purchaseList;

@property (nonatomic ,copy)NSString * order_id;


@end

@implementation B_PuchaseTableView_VC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self addRefresh];
    [self.table beginRefreshing];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);

    }];
  
    [self.table addSubview:self.blankPageView];
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

-(void)loadNewData{
    self.page = 0;
    [self loadRequestData];
}

-(void)loadMoreData{
    self.page ++;
    [self loadRequestData];
    
}

#pragma mark - 加载数据
-(void)loadRequestData{
    
    NSDictionary * dic = nil;
    if (self.selectIndex == 0) {
        dic = @{
                @"order_status":@"PURCHASE_ORDER_STATUS_CREATE",
                @"goods":@"1",
                @"offset":[NSString stringWithFormat:@"%ld",(long)self.page],
                @"order_by_dir":@"DESC",
                @"order_by":@"add_time"
                };
    }else{
        dic = @{
                @"order_status":@"PURCHASE_ORDER_STATUS_PAID",
                @"goods":@"1",
                @"offset":[NSString stringWithFormat:@"%ld",(long)self.page],
                @"order_by_dir":@"DESC",
                @"order_by":@"add_time"
                };
        
    }
    
    [AFHTTPClient POST:kMyPurchaseURL params:dic successInfo:^(ResponseModel *response) {
        
        //解析数据
        id json = @{@"data":response.dataResponse};
        [self loadRequestDataRefresh:json];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        [self.table endHeaderRefreshing];
        [self.table endFooterRefreshing];
        
        if (type == NEED_HINT)
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
            [self loadRequestData];
        }
    }];
}

-(void)loadRequestDataRefresh:(id)json{
    NSDictionary * dict = [json objectForKey:@"data"];
    NSArray *list = [dict objectForKey:@"list"];
    if (list.count != 0) {
        self.purchaseList=[[NSMutableArray alloc] init];
        for (NSDictionary *dict in list) {
            PurchaseOrderModel *purchase = [[PurchaseOrderModel alloc] init];
            [purchase setValues:dict];
            [self.purchaseList addObject:purchase];
        }
        if (self.page == 0) {
            if (self.purchaseList.count == 0) {
                self.blankPageView.hidden = NO;
            }else{
                self.blankPageView.hidden = YES;
            }
            self.table.purchaseOrderList = self.purchaseList;
            if (self.purchaseList.count >= 10) {
                self.table.mj_footer.hidden = NO;
            }

        }else if (self.page != 0){
            if ([self.purchaseList count] == 0)
            {
                [self.view makeToast:@"亲，没有更多订单了~~" duration:1.0 position:CSToastPositionCenter];
                self.table.mj_footer.hidden = YES;
            }else{
                [self.table.purchaseOrderList addObjectsFromArray:self.purchaseList];
            }
        }
        
    }else{
        self.purchaseList = nil;
        if (self.page == 0) {
            if (self.purchaseList.count == 0) {
                self.blankPageView.hidden = NO;
            }else{
                self.blankPageView.hidden = YES;
            }
            self.table.purchaseOrderList = self.purchaseList;

        }
        if ( self.blankPageView.hidden == NO) {
            
        }else {
            [self.view makeToast:@"亲，没有更多订单了~~" duration:1.0 position:CSToastPositionCenter];
        }
        self.table.mj_footer.hidden = YES;
        
    }
    [self.table reloadData];
    [self.table endHeaderRefreshing];
    [self.table endFooterRefreshing];

}

#pragma mark - PurchaseOrderViewDelegate


#pragma mark --取消订单
-(void)cancelActionWithOrder:(PurchaseOrderModel *)order{
    UIAlertView *cancelAlert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要取消该订单吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [cancelAlert show];
    self.order_id = order.purchase_order_id;
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1)
    {
        [HTLoadingTool showLoadingStringDontOperation:@"取消订单中"];
        NSDictionary *dic = @{
                              @"purchase_order_id":self.order_id
                              };
        
        [AFHTTPClient POST:kCancelPurchaseOrderURL params:dic successInfo:^(ResponseModel *response) {
            
            
            //解析数据
            id json = @{@"data":response.dataResponse};
            [self alertViewRefresh:json];
            
        } flaseInfo:^(ResponseModel *response, HTTPType type) {
            if (type == NEED_HINT)
            {
                [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
                self.blankPageView.hidden = NO;
                return ;
            }
            
            if (type == NO_NETWORK) {
                [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
                self.blankPageView.hidden = NO;
                [self.blankPageView switchToNoNetwork];
                return;
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

-(void)alertViewRefresh:(id)json{
    [self.view makeToast:@"订单取消成功" duration:1.0 position:CSToastPositionCenter];
    [self loadRequestData];
}

#pragma mark - 去支付
-(void)payActionWithOrder:(PurchaseOrderModel *)order
{
    
    //判断用户是否有支付权限
    BOOL isPay = [YKSUserDefaults isHavePayPower];
    if (isPay == YES) {
        
        OrderType type;
        if ([order.is_normal_trade isEqualToString:@"1"]) {
            type = GuoNei_Order;
        }
        else
        {
            type = JingWai_Order;
        }
        
        PayBC_VC * VC =[[PayBC_VC alloc] initWithIsBuyType:B_Pay Order:type];
        VC.sOrderNumber = order.purchase_order_sn;
        VC.sOrderMoney = order.order_amount;
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        [self.view makeToast:@"等待后台付款，请联系客服" duration:1.0 position:CSToastPositionCenter];
    }
}


#pragma mark - 再次购买
- (void)rePayActionWithOrder:(PurchaseOrderModel *)order
{
    NSMutableArray *params = [[NSMutableArray alloc] init];
    for (int i = 0; i < order.goods.count; i++) {
        NSDictionary * arrDict = order.goods[i];
        NSString * ID = [arrDict objectForKey:@"goods_id"];
        NSString * quantity =[arrDict objectForKey:@"quantity"];
        NSDictionary *tempDict=[[NSDictionary alloc] initWithObjects:@[ID,quantity] forKeys:@[@"goods_id",@"quantity"]];
        [params addObject:tempDict];
        
    }
    
    NSString *value = [ZXNTool getJSONString:params];
    
    //添加到购物车
    [HTLoadingTool showLoadingDontOperation];
    NSDictionary *dic = @{@"goods_list":value};
    
    [AFHTTPClient POST:KAddquickBuy params:dic successInfo:^(ResponseModel *response) {
        
        
        //解析数据
        id json = @{@"data":response.dataResponse};
        [self rePayActionWithOrderRefresh:json];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT)
        {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            return ;
        }
        
        if (type == NO_NETWORK) {
            self.blankPageView.hidden = NO;
            [self.blankPageView switchToNoNetwork];
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            return;
        }
        
        if (type == SERVICE_ERROR) {
            return ;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}

- (void)rePayActionWithOrderRefresh:(id)json
{
    ShopingCart_VC *shopCartVC = [[ShopingCart_VC alloc] init];
    shopCartVC.hidesBottomBarWhenPushed = YES;
     shopCartVC.bBottom = YES;
    [self.navigationController pushViewController:shopCartVC animated:YES];
}


- (NSString *)getProductDescriptionWithList:(PurchaseOrderModel *)purOrder
{
    NSMutableArray *bodyList=[[NSMutableArray alloc] init];
    NSArray *list=purOrder.goods;
    for (NSDictionary *dict in list){
        NSString *goodsName=[dict objectForKey:@"goods_name"];
        goodsName=[goodsName stringByReplacingOccurrencesOfString:@"'" withString:@"’"];
        goodsName=[goodsName stringByReplacingOccurrencesOfString:@"%" withString:@""];
        [bodyList addObject:goodsName];
    }
    NSString *body=[bodyList componentsJoinedByString:@"  "];
    return body;
}


#pragma mark - 加载数据
- (void)loadviewCategoryId:(NSInteger )selected{

    self.selectIndex = selected;
    [self.table beginRefreshing];
}


-(PurchaseOrderView *)table{

    if (!_table) {
        _table = [[PurchaseOrderView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.purDelegate=self;
        _table.backgroundColor=[UIColor colorWithHexString:@"#efeff2"];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _table;
}

-(BlankPageView *)blankPageView{

    if (!_blankPageView) {
        _blankPageView = [[BlankPageView alloc]init];
        _blankPageView.title = @"亲，没有更多订单了~~";
        _blankPageView.frame = CGRectMake(0, 0, kDisWidth, kDisHeight-101-50);
        _blankPageView.hidden = YES;
    }
    return _blankPageView;
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
