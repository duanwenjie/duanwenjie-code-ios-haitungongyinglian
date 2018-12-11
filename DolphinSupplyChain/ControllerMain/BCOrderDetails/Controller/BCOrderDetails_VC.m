//
//  BCOrderDetails_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/15.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "BCOrderDetails_VC.h"
#import "BCOrderDetailsCell.h"
#import "BCOrderDetailsFootView.h"
#import "BCOrderDetailsHeadView.h"
#import "BCOrderDetailCellHead.h"
#import "BCOrderDetailCellFoot.h"
#import "HTLoadingTool.h"
#import "BCOrderDetailsModel.h"
#import "BCOrderDetailsBuyModel.h"
#import "BCOrderDetailsBll.h"
#import "BlankPageView.h"
#import "BCorderSellDetailBuyModel.h"
#import "LogisticsBuyModel.h"
#import "LogisticsNewViewController.h"
#import "CommodityDetails_VC.h"
#import "HTTabbleView.h"
#import "ChangeOrderViewController.h"
@interface BCOrderDetails_VC () <UITableViewDelegate, UITableViewDataSource, BCOrderDetailCellHeadDelegate, BCOrderDetailsFootViewDelegate, UIWebViewDelegate>

@property (nonatomic, strong) BCOrderDetailsFootView *vFoot;

@property (nonatomic, strong) BCOrderDetailsHeadView *vHead;

@property (nonatomic, strong) BlankPageView *vBlankPage;

@property (nonatomic, strong) NSMutableArray *arrData;


@property (nonatomic, strong) BCOrderDetailsModel *model;

@property (nonatomic, strong) BCOrderSellDetail *sellModel;

@property (nonatomic, strong) HTTabbleView *tbMain;

@property (nonatomic, strong) NSString *sOrderID;

@property (nonatomic, strong) NSMutableArray *arrLogistics;

@property (nonatomic, assign) BOOL bB_COrder;

@property (nonatomic, assign) BOOL bHaveLogistics;

@property (nonatomic, assign) BOOL bNoPay;



@end

@implementation BCOrderDetails_VC

- (instancetype)initWithOrderID:(NSString *)sOrderID B_COrder:(BOOL)bB_COrder isNoPay:(BOOL)bNOPay
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.arrData = [NSMutableArray array];
        self.arrLogistics = [NSMutableArray array];
        self.sOrderID = sOrderID;
        self.bB_COrder = bB_COrder;
        self.bHaveLogistics = NO;
        self.bNoPay = bNOPay;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    if (self.bB_COrder) {
        [self loadDataOrderDetailC];
    }
    else
    {
        [self loadDataOrderDetailB];
    }
    
}

- (void)initView
{
    [self.view addSubview:self.vHead];
    [self.view addSubview:self.tbMain];
    [self.view addSubview:self.vFoot];
    [self.view addSubview:self.vBlankPage];
    
    WS(weakSelf);
    
    if (self.bB_COrder) {
        [self addNavigationType:YKSDefaults NavigationTitle:@"订单详情"];
    }
    else
    {
        if (self.bNoRevise) {
            [self addNavigationType:YKS_Left_Title_RightTwo NavigationTitle:@"订单详情"];
            [self.btnRigthTwo setTitle:@"修改" forState:UIControlStateNormal];
            [self.btnRigthTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.btnRigthTwo.titleLabel.font = kFont15;
        }
        else
        {
            [self addNavigationType:YKSDefaults NavigationTitle:@"订单详情"];
        }
        
    }
    
    
    
    [self.vHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.vNavigation.mas_bottom);
        make.height.mas_equalTo(114.5);
        
//        self.bB_COrder ? make.height.mas_equalTo(114.5) : make.height.mas_equalTo(30.5);
    }];
    
    [self.tbMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vHead.mas_bottom).offset(6);
        make.bottom.equalTo(self.vFoot.mas_top).offset(0);
        make.left.right.equalTo(self.view);
    }];
    
    [self.vFoot mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.left.bottom.equalTo(self.view);
//        make.top.equalTo(self.tbMain.mas_bottom).offset(0);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(kDisWidth);
        make.top.mas_equalTo(kDisHeight-44-KBottomSuit);
    }];
    
    [self.vBlankPage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.vNavigation.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom).offset(-44);
    }];
    
    
    self.vBlankPage.block = ^(){
        [weakSelf loadDataLogisticsInfo];
    };
}

- (void)selectLogistics:(NSInteger)isection
{
    if (!self.bHaveLogistics) {
        
        if (!self.bNoPay) {
            [self.view makeToast:@"该订单暂时没有物流详细哦~！" duration:1.0 position:CSToastPositionCenter];
        }
        return;
    }
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:self.arrLogistics[isection]];
    
    LogisticsNewViewController * VC = [[LogisticsNewViewController alloc]init];
    
    VC.type = self.bB_COrder ? @"C_ORDER" : @"SALES_ORDER";
    VC.orderID = self.sOrderID;
    VC.arrList = array;
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)tapRightTwo
{
    if (self.sellModel == nil) {
        return;
    }
    ChangeOrderViewController * VC = [[ChangeOrderViewController alloc]init];
    [VC setChangeViewControllerData:self.sellModel];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 加载网络数据
// 获取C端订单详情
- (void)loadDataOrderDetailC
{
    self.vBlankPage.hidden = YES;
    [HTLoadingTool showLoadingForView:self.view];
    
    NSDictionary *dic = @{@"order_id":self.sOrderID,
                          @"logistics":@"0"};        // 不带物流信息
    [AFHTTPClient POSTNODismiss:@"/COrder/getOneOrder" params:dic successInfo:^(ResponseModel *response) {
        
        self.model = [BCOrderDetailsBll gainOrderDetailList:response.dataResponse];
        
        [self.vHead loadViewStateTitle:self.model.order_status_info Name:[NSString stringWithFormat:@"%@  %@", self.model.consignee, self.model.mobile] identity:self.model.id_card_number address:[NSString stringWithFormat:@"%@%@%@", self.model.city, self.model.district, self.model.address]];
        
        if (!self.bNoPay) {
            [self loadDataLogisticsInfo];
        }
        else
        {
            [HTLoadingTool disMissForView];
            [HTLoadingTool disMissForWindow];
            self.bHaveLogistics = NO;
            [self.arrData addObject:self.model.arrGoods];
            [self.tbMain reloadData];
        }
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        if (type == NO_NETWORK) {
            self.vBlankPage.hidden = NO;
            [self.vBlankPage switchToNoNetwork];
            return ;
        }
        [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        [HTLoadingTool disMissForView];
        [HTLoadingTool disMissForWindow];
    }];
}

// 获取B端订单详情
- (void)loadDataOrderDetailB
{
    self.vBlankPage.hidden = YES;
    [HTLoadingTool showLoadingForView:self.view];
    
    NSDictionary *dic = @{@"sales_order_id":self.sOrderID,
                          @"logistics":@"0",         // 不带物流信息
                          @"goods":@"1"};
    [AFHTTPClient POSTNODismiss:@"/SalesOrder/getSalesOrder" params:dic successInfo:^(ResponseModel *response) {
                
        self.sellModel = [BCOrderDetailsBll gainOrderSellDetailList:response.dataResponse];
        
        BOOL isLoadData = NO;
        NSString *sStatus = @"";
        if ([self.sellModel.order_status isEqualToString:@"1"]) {
            sStatus = @"缺货采购";
        }
        else if ([self.sellModel.order_status isEqualToString:@"2"])
        {
            sStatus = @"待通知发货";
        }
        else if ([self.sellModel.order_status isEqualToString:@"3"])
        {
            sStatus = @"待收货";
            isLoadData = YES;
        }
        else if ([self.sellModel.order_status isEqualToString:@"SALES_ORDER_STATUS_RECEIVED"])
        {
            sStatus = @"已收货";
            isLoadData = YES;
        }
        else if ([self.sellModel.order_status isEqualToString:@"SALES_ORDER_STATUS_CANCELLED"])
        {
            sStatus = @"已取消";
        }
        else if ([self.sellModel.order_status isEqualToString:@"SALES_ORDER_STATUS_DELETED"])
        {
            sStatus = @"已删除";
        }
        else if ([self.sellModel.order_status isEqualToString:@"SALES_ORDER_STATUS_NOTIFY"])
        {
            sStatus = @"通知发货处理中";
            isLoadData = YES;
        }
        else if ([self.sellModel.order_status isEqualToString:@"SALES_ORDER_STATUS_NOTIFY_SUCCESS"])
        {
            sStatus = @"已通知发货";
            isLoadData = YES;
        }
        
        else if ([self.sellModel.order_status isEqualToString:@"SALES_ORDER_STATUS_SYNC_ERP"])
        {
            sStatus = @"发货处理中";
            isLoadData = YES;
        }
        
        [self.vHead loadViewStateTitle:sStatus Name:[NSString stringWithFormat:@"%@  %@", self.sellModel.consignee, self.sellModel.mobile] identity:self.sellModel.id_card_number address:[NSString stringWithFormat:@"%@%@%@", self.sellModel.city, self.sellModel.district, self.sellModel.address]];
        
        if (isLoadData) {
            [self loadDataLogisticsInfo];
        }
        else
        {
            [HTLoadingTool disMissForWindow];
            [HTLoadingTool disMissForView];
            self.bHaveLogistics = NO;
            [self.arrData addObject:self.sellModel.arrGoods];
            [self.tbMain reloadData];
        }
        
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        if (type == NO_NETWORK) {
            self.vBlankPage.hidden = NO;
            [self.vBlankPage switchToNoNetwork];
            return ;
        }
        [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        [HTLoadingTool disMissForWindow];
        [HTLoadingTool disMissForView];
    }];
}

- (void)loadDataLogisticsInfo
{
    [HTLoadingTool showLoadingForView:self.view Hint:@"努力加载物流信息中..."];
    
    NSDictionary *dic = @{@"order_id":self.sOrderID,
                          @"type":self.bB_COrder ? @"C_ORDER" : @"SALES_ORDER"};
    
    [AFHTTPClient POST:@"/Logistics/info" params:dic successInfo:^(ResponseModel *response) {
        
        self.bHaveLogistics = NO;
        [self.arrData removeAllObjects];
        if ([response.dataResponse isKindOfClass:[NSDictionary class]])
        {
            if (self.bB_COrder) {
                [self.arrData addObject:self.model.arrGoods];
            }
            else
            {
                [self.arrData addObject:self.sellModel.arrGoods];
            }
            [self.tbMain reloadData];
        }
        else if ([response.dataResponse isKindOfClass:[NSArray class]])
        {
            if (((NSArray *)response.dataResponse).count == 0) {
                if (self.bB_COrder) {
                    [self.arrData addObject:self.model.arrGoods];
                }
                else
                {
                    [self.arrData addObject:self.sellModel.arrGoods];
                }
                [self.tbMain reloadData];
            }
            else
            {
                self.arrData = [BCOrderDetailsBll gainLogistics:response.dataResponse];
                self.arrLogistics = (NSMutableArray *)response.dataResponse;
                self.bHaveLogistics = YES;
                [self.tbMain reloadData];
            }
        }
        
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        if ([response.sCode isEqualToString:@"0X0010"]) {
            if (self.bB_COrder) {
                [self.arrData addObject:self.model.arrGoods];
            }
            else
            {
                [self.arrData addObject:self.sellModel.arrGoods];
            }
            [self.tbMain reloadData];
            return ;
        }
        
        [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
    }];
}


#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.bHaveLogistics) {
        NSMutableArray *array = self.arrData[section][@"Goods"];
        return array.count;
    }
    else
    {
        NSMutableArray *array = self.arrData[section];
        return array.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BCOrderDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BCOrderDetailsCell"];
    if (cell == nil) {
        cell = [[BCOrderDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BCOrderDetailsCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.bHaveLogistics) {
        LogisticsBuyModel *model = self.arrData[indexPath.section][@"Goods"][indexPath.row];
        [cell loadView:model.img_thumb BuyName:model.sku_name MoneyOne:model.item_count MoneyTwo:model.orders_sku];
    }
    else
    {
        if (self.bB_COrder) {
            BCOrderDetailsBuyModel *model = self.arrData[indexPath.section][indexPath.row];
            
            [cell loadView:model.img_thumb BuyName:model.goods_name MoneyOne:model.quantity MoneyTwo:model.sku];
        }
        else
        {
            BCorderSellDetailBuyModel *model = self.arrData[indexPath.section][indexPath.row];
            
            [cell loadView:model.img_thumb BuyName:model.goods_name MoneyOne:model.quantity MoneyTwo:model.sku];
        }
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (self.bHaveLogistics) {
        LogisticsBuyModel *model = self.arrData[indexPath.section][@"Goods"][indexPath.row];
        CommodityDetails_VC *detail_VC = [[CommodityDetails_VC alloc]initWithSKU:model.sku_name];
//        detail_VC.sku = model.sku_name;
        [self.navigationController pushViewController:detail_VC animated:YES];
    }
    else
    {
        if (self.bB_COrder) {
            BCOrderDetailsBuyModel *model = self.arrData[indexPath.section][indexPath.row];
            
             CommodityDetails_VC *detail_VC = [[CommodityDetails_VC alloc]initWithSKU:model.sku];
//            detail_VC.sku = model.sku;
            [self.navigationController pushViewController:detail_VC animated:YES];
        }
        else
        {
            BCorderSellDetailBuyModel *model = self.arrData[indexPath.section][indexPath.row];
            
            CommodityDetails_VC *detail_VC = [[CommodityDetails_VC alloc]initWithSKU:model.sku];
//            detail_VC.sku = model.sku;
            [self.navigationController pushViewController:detail_VC animated:YES];
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.arrData.count - 1 == section) {
        return 78;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BCOrderDetailCellHead *vHeadCell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BCOrderDetailCellHead"];
    
    vHeadCell.delegate = self;
    if (!self.bHaveLogistics)  // 没有物流信息时
    {
        if (self.bNoPay) {
            [vHeadCell loadView:@"订单物品列表信息" LogisticsTime:self.model.add_time section:section];
            
            return vHeadCell;
        }
        else
        {
            if (self.bB_COrder) {
                
                [vHeadCell loadView:@"订单暂无物流信息" LogisticsTime:self.model.add_time section:section];
                
                return vHeadCell;
            }
            else
            {
                [vHeadCell loadView:@"订单暂无物流信息" LogisticsTime:self.sellModel.add_time section:section];
                
                return vHeadCell;
            }
        }
    }
    else   // 有物流信息时
    {
       [vHeadCell loadView:self.arrData[section][@"HeadErp"][@"event"] LogisticsTime:self.arrData[section][@"HeadErp"][@"update_time"] section:section];
        return vHeadCell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.arrData.count - 1 == section) {
        BCOrderDetailCellFoot *vFootCell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BCOrderDetailCellFoot"];
        
        if (self.bB_COrder) {
            [vFootCell loadViewNumber:self.model.c_order_sn Time:self.model.add_time];
        }
        else
        {
            [vFootCell loadViewNumber:self.sellModel.sales_order_sn Time:self.sellModel.add_time];
        }
        
        
        return vFootCell;
    }
    else
    {
        return nil;
    }
}


#pragma mark - BCOrderDetailsFootViewDelegate
- (void)tapTel
{
    NSString *phoneNumber = @"4008522086";
    NSString *cleanedString =[[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSString *escapedPhoneNumber = [cleanedString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", escapedPhoneNumber]];
    UIWebView *mCallWebview = [[UIWebView alloc] init] ;
    [self.view addSubview:mCallWebview];
    [mCallWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
}

- (void)tapQQ
{
    //qqNumber就是你要打开的QQ号码， 也就是你的客服号码。
    NSString  *qqNumber=@"2880942711";
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qqNumber]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        webView.delegate = self;
        [webView loadRequest:request];
        [self.view addSubview:webView];
    }
    else
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"对不起，您还没安装QQ" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}



#pragma mark - 懒加载
- (HTTabbleView *)tbMain
{
    if (!_tbMain) {
        _tbMain = [[HTTabbleView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tbMain.showsVerticalScrollIndicator = NO;
        _tbMain.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbMain.delegate = self;
        _tbMain.dataSource = self;
        _tbMain.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        
        [_tbMain registerClass:[BCOrderDetailCellHead class] forHeaderFooterViewReuseIdentifier:@"BCOrderDetailCellHead"];
        
        [_tbMain registerClass:[BCOrderDetailCellFoot class] forHeaderFooterViewReuseIdentifier:@"BCOrderDetailCellFoot"];
    }
    return _tbMain;
}



- (BCOrderDetailsHeadView *)vHead
{
    if (!_vHead) {
        _vHead = [[BCOrderDetailsHeadView alloc] initWithBOrderOrCOrder:self.bB_COrder];
        _vHead.backgroundColor = [UIColor whiteColor];
    }
    return _vHead;
}

- (BCOrderDetailsFootView *)vFoot
{
    if (!_vFoot) {
        _vFoot = [[BCOrderDetailsFootView alloc] init];
        _vFoot.delegate = self;
        _vFoot.backgroundColor = [UIColor whiteColor];
    }
    return _vFoot;
}

- (BlankPageView *)vBlankPage
{
    if (!_vBlankPage) {
        _vBlankPage = [[BlankPageView alloc] init];
        _vBlankPage.hidden = YES;
    }
    return _vBlankPage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
