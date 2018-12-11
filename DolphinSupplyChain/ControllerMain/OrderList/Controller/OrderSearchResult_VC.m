//
//  OrderSearchResult_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/23.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "OrderSearchResult_VC.h"
#import "BlankPageView.h"
#import "OrderListCell.h"
#import "OrderListHeadView.h"
#import "OrderListFootView.h"
#import "OrderListBll.h"
#import "OrderListModel.h"
#import "OrderListGoodsModel.h"
#import "PayBC_VC.h"
#import "CommodityDetails_VC.h"
#import "LogisticsNewViewController.h"
#import "BCOrderDetails_VC.h"
#import "OrderSearch_VC.h"
#import "BaseNavigationViewController.h"
#import "HTTabbleView.h"

@interface OrderSearchResult_VC () <UITableViewDelegate, UITableViewDataSource, OrderListFootDelegate, OrderListHeadDelegate>

@property (nonatomic, strong) BlankPageView *vBlankView;

@property (nonatomic, strong) UIView *vSearch;

@property (nonatomic, strong) UIImageView *imgSearch;

@property (nonatomic, strong) UILabel *lblSearch;

@property (nonatomic, strong) HTTabbleView *tbMain;

@property (nonatomic, strong) NSMutableArray *arrOrderData;

@property (nonatomic, assign) NSInteger iType;

@property (nonatomic, copy) NSString *sType;

@property (nonatomic, assign) NSInteger iPage;

@property (nonatomic, copy) NSString *sKeyWorld;

@end

@implementation OrderSearchResult_VC


- (instancetype)initWithOrderType:(NSInteger)iType KeyWorld:(NSString *)sKeyWorld
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.iType = iType;
        self.arrOrderData = [NSMutableArray array];
        self.iPage = 2;
        self.sType = @"self_all";
        self.sKeyWorld = sKeyWorld;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tbMain];
    [self.vSearch addSubview:self.imgSearch];
    [self.vSearch addSubview:self.lblSearch];
    [self.view addSubview:self.vBlankView];
    
    [self addNavigationType:YKSOnlyLeft NavigationTitle:@""];
    [self.vNavigation addSubview:self.vSearch];
    
    
    
    [self.imgSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vSearch.mas_left).offset(10);
        make.top.bottom.equalTo(self.vSearch);
        make.width.mas_equalTo(15);
    }];
    
    [self.lblSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.vSearch);
        make.left.equalTo(self.imgSearch.mas_right).offset(8);
        make.right.equalTo(self.vSearch.mas_right).offset(0);
    }];
    
    [self.tbMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.vNavigation.mas_bottom);
    }];
    
    WS(weakSelf);
    [self.tbMain addHeaderRefresh:^{
        [weakSelf loadDataFirst];
    }];
    
    [self.tbMain addFooterRefresh:^{
        [weakSelf loadDataMore];
    }];
    
    
    self.lblSearch.text = self.sKeyWorld;
    
    [self.tbMain beginRefreshing];
}


- (void)tapSearch
{
    WS(weakSelf);
    OrderSearch_VC *vcSearch = [[OrderSearch_VC alloc] initWithBlock:^(NSString *sKeyWorld) {
        
        self.vBlankView.hidden = YES;
        [weakSelf.tbMain beginRefreshing];
        weakSelf.sKeyWorld = sKeyWorld;
        weakSelf.lblSearch.text = sKeyWorld;
    }];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:vcSearch];
    [self.navigationController presentViewController:nav animated:NO completion:nil];
}


#pragma mark - 网络请求
- (void)loadDataFirst
{
    self.iPage = 2;
    NSDictionary *dic = @{@"page":@"1",
                          @"page_size":@"10",
                          @"type":self.sType,
                          @"keyword":self.sKeyWorld};
    
    [AFHTTPClient POST:@"/COrder/getList" params:dic successInfo:^(ResponseModel *response) {
        
        [self.tbMain endHeaderRefreshing];
        
        [self.arrOrderData removeAllObjects];
        
        self.arrOrderData = [OrderListBll gainOrderList:response.dataResponse];
        
        if (self.arrOrderData.count == 0) {
            self.vBlankView.hidden = NO;
        }
        else
        {
            self.vBlankView.hidden = YES;
            [self.tbMain reloadData];
        }
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        [self.tbMain endHeaderRefreshing];
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
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
                          @"type":self.sType,
                          @"keyword":self.sKeyWorld};
    
    [AFHTTPClient POST:@"/COrder/getList" params:dic successInfo:^(ResponseModel *response) {
        
        [self.tbMain endFooterRefreshing];
        
        NSMutableArray* arrayCollect = [OrderListBll gainOrderList:response.dataResponse];
        
        if (arrayCollect.count != 0) {
            self.iPage += 1;
            
            
            NSRange Range = NSMakeRange(self.arrOrderData.count, arrayCollect.count);
            
            NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:Range];
            [self.arrOrderData addObjectsFromArray:arrayCollect];
            
            [self.tbMain insertSections:set withRowAnimation:UITableViewRowAnimationNone];
        }
        else
        {
            
            [self.tbMain showNoMoreData];
        }
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        [self.tbMain endFooterRefreshing];
        
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}

#pragma mark - OrderListFootDelegate
// 删除订单
- (void)DeleteOrder:(NSInteger)index
{
    OrderListModel *model = self.arrOrderData[index][@"OrderListModel"];
    NSDictionary *dic = @{@"order_id":model.c_order_id};
    [HTLoadingTool showLoadingStringDontOperation:@"删除订单中"];
    
    [AFHTTPClient POST:@"/COrder/deleteOrder" params:dic successInfo:^(ResponseModel *response) {
        [self.view makeToast:@"删除订单成功" duration:1.0 position:CSToastPositionCenter];
        
        [self.tbMain beginRefreshing];
        
        self.iPage = 2;
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
    
    
}
// 取消订单
- (void)CancelOrder:(NSInteger)index
{
    OrderListModel *model = self.arrOrderData[index][@"OrderListModel"];
    
    NSDictionary *dic = @{@"order_id":model.c_order_id};
    
    [HTLoadingTool showLoadingStringDontOperation:@"取消订单中"];
    
    [AFHTTPClient POST:@"/COrder/cancelOrder" params:dic successInfo:^(ResponseModel *response) {
        [self.view makeToast:@"删除订单成功" duration:1.0 position:CSToastPositionCenter];
        
        [self.tbMain beginRefreshing];
        
        self.iPage = 2;
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}

// 付款
- (void)PayOrder:(NSInteger)index
{    
    OrderListModel *model = self.arrOrderData[index][@"OrderListModel"];
    
    OrderType type;
    if ([model.business_type isEqualToString:@"1"]) {
        type = GuoNei_Order;
    }
    else
    {
        type = JingWai_Order;
    }
    
    PayBC_VC *pay_VC = [[PayBC_VC alloc] initWithIsBuyType:C_Pay Order:type];
    pay_VC.bNeedPay = YES;
    pay_VC.sOrderId = model.c_order_id;
    pay_VC.sOrderNumber = model.c_order_sn;
    [self.navigationController pushViewController:pay_VC animated:YES];
}

// 查看物流
- (void)CheckLogisticsOrder:(NSInteger)index
{
    OrderListModel *model = self.arrOrderData[index][@"OrderListModel"];
    LogisticsNewViewController *logistic_VC = [[LogisticsNewViewController alloc] init];
    logistic_VC.orderID = model.c_order_id;
    logistic_VC.type = @"C_ORDER";
    [self.navigationController pushViewController:logistic_VC animated:YES];
}

// 确认收货
- (void)ReceiptOrder:(NSInteger)index
{
    UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否确认收货" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        OrderListModel *model = self.arrOrderData[index][@"OrderListModel"];
        [self receiptOrderID:model.c_order_id];
    }];
    
    [alerController addAction:cancelAction];
    [alerController addAction:okAction];
    
    [self.navigationController presentViewController:alerController animated:YES completion:nil];
}

- (void)receiptOrderID:(NSString *)sOrderId
{
    NSDictionary *dic = @{@"order_id":sOrderId};
    [HTLoadingTool showLoadingStringDontOperation:@"确认收货中"];
    
    [AFHTTPClient POST:@"/COrder/closeOrder" params:dic successInfo:^(ResponseModel *response) {
        [self.view makeToast:@"确认收货成功" duration:1.0 position:CSToastPositionCenter];
        
        [self.tbMain beginRefreshing];
        
        self.iPage = 2;
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}

#pragma mark - OrderListHeadDelegate 进入订单详情
- (void)ComeInOederInfoVC:(NSInteger)iIndex
{
    OrderListModel *model = self.arrOrderData[iIndex][@"OrderListModel"];
    
    BOOL bNoPay = NO;
    if ([model.order_status_type isEqualToString:@"self_need_pay"] || [model.order_status_type isEqualToString:@"self_need_delivery"] || [model.order_status_type isEqualToString:@"cancel"]) {
        bNoPay = YES;
    }
    
    BCOrderDetails_VC *BCDetails_VC = [[BCOrderDetails_VC alloc] initWithOrderID:model.c_order_id B_COrder:YES isNoPay:bNoPay];
    [self.navigationController pushViewController:BCDetails_VC animated:YES];
}


#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrOrderData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *array = self.arrOrderData[section][@"OrderListGoodsModel"];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListCell"];
    if (cell == nil) {
        cell = [[OrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    OrderListGoodsModel *model = self.arrOrderData[indexPath.section][@"OrderListGoodsModel"][indexPath.row];
    
    [cell loadView:model.img_thumb BuyName:model.goods_name Quantity:model.quantity SKU:model.sku MoneyOne:model.price MoneyTwo:model.pretax_price];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListGoodsModel *model = self.arrOrderData[indexPath.section][@"OrderListGoodsModel"][indexPath.row];
    
    CommodityDetails_VC *detail_VC = [[CommodityDetails_VC alloc]initWithSKU:model.sku];
//    detail_VC.sku = model.sku;
    [self.navigationController pushViewController:detail_VC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 73;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.arrOrderData.count == 0) {
        return nil;
    }
    
    OrderListHeadView *vHead = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OrderListHeadView"];
    
    OrderListModel *model = self.arrOrderData[section][@"OrderListModel"];
    
    [vHead loadViewOrderNumber:model.add_time Time:model.order_status_info Order:model.c_order_sn Index:section];

    vHead.delegate = self;
    
    return vHead;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.arrOrderData.count == 0) {
        return nil;
    }
    OrderListFootView *vFoot = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OrderListFootView"];
    vFoot.delegate = self;
    NSArray *arrStatus = @[@"cancel",      // 取消订单
                           @"succeed",     // 完成订单
                           @"No_Pay",      // 未支付订单
                           @"shipments",   // 未发货订单
                           @"delivery"];   // 已发货订单
    
    OrderListModel *model = self.arrOrderData[section][@"OrderListModel"];
    NSString *sType = @"";
    if ([model.order_status_type isEqualToString:@"self_need_pay"]) {
        sType = arrStatus[2];
    }
    else if ([model.order_status_type isEqualToString:@"self_need_delivery"])
    {
        sType = arrStatus[3];
    }
    else if ([model.order_status_type isEqualToString:@"shipped"])
    {
        sType = arrStatus[4];
    }
    else if ([model.order_status_type isEqualToString:@"cancel"])
    {
        sType = arrStatus[0];
    }
    else
    {
        sType = arrStatus[1];
    }
    NSString *sAddress = [NSString stringWithFormat:@"%@%@%@%@ %@(收)",model.province,model.city,model.district,model.address,model.consignee];
    
    [vFoot loadViewAddress:sAddress Status:model.order_status_info Money:model.order_amount Type:sType Index:section];
    return vFoot;
}


#pragma mark - 懒加载
- (HTTabbleView *)tbMain
{
    if (!_tbMain) {
        _tbMain = [[HTTabbleView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tbMain.delegate = self;
        _tbMain.dataSource = self;
        _tbMain.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbMain.showsVerticalScrollIndicator = NO;
        _tbMain.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        
        [_tbMain registerClass:[OrderListHeadView class] forHeaderFooterViewReuseIdentifier:@"OrderListHeadView"];
        [_tbMain registerClass:[OrderListFootView class] forHeaderFooterViewReuseIdentifier:@"OrderListFootView"];
    }
    return _tbMain;
}


- (BlankPageView *)vBlankView
{
    if (!_vBlankView) {
        _vBlankView = [[BlankPageView alloc] initWithFrame:CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight - kDisNavgation)];
        _vBlankView.title = @"暂无订单信息";
        _vBlankView.image = [UIImage imageNamed:@"Order_List_NO_Data"];
        _vBlankView.hidden = YES;
    }
    return _vBlankView;
}

- (UIView *)vSearch
{
    if (!_vSearch) {
        _vSearch = [[UIView alloc] initWithFrame:CGRectMake(45, 27+KTop, kDisWidth - 60, 30)];
        _vSearch.backgroundColor = [UIColor colorWithHexString:@"#0073af"];
        _vSearch.layer.cornerRadius = 5;
        _vSearch.layer.masksToBounds = YES;
        
        UITapGestureRecognizer *tapSearch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSearch)];
        [_vSearch addGestureRecognizer:tapSearch];
    }
    return _vSearch;
}

- (UIImageView *)imgSearch
{
    if (!_imgSearch) {
        _imgSearch = [[UIImageView alloc] init];
        _imgSearch.image = [UIImage drawImageWithName:@"icon-search" size:CGSizeMake(15, 15)];
        _imgSearch.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgSearch;
}

- (UILabel *)lblSearch
{
    if (!_lblSearch) {
        _lblSearch = [[UILabel alloc] init];
        _lblSearch.text = @"请输入商品名称或关键字";
        _lblSearch.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _lblSearch.textAlignment = NSTextAlignmentLeft;
        _lblSearch.font = [UIFont systemFontOfSize:12];
    }
    return _lblSearch;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
