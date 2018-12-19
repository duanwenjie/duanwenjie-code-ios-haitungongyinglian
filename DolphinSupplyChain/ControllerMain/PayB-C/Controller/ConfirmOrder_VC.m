//
//  ConfirmOrder_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ConfirmOrder_VC.h"
#import "DefaultAddressHeadView.h"
#import "DefaultAddressFootView.h"
#import "ConfirmOrderCell.h"
#import "PayBC_VC.h"
#import "MyAddressList_VC.h"
#import "AddressListModel.h"
#import "ConfirmOrderBll.h"
#import "ConfirmOrderGoodsModel.h"
#import "PayModel.h"
#import "PurchaseModel.h"
#import "B_TabBarController.h"
#import "AppDelegate.h"
#import "HTLoadingTool.h"
#import "ZXNTool.h"
#import "OrderRiskTips_VC.h"
#import "HTTabbleView.h"
#import "InventoryHeaderView.h"
#import "PayerView.h"
#import "OrderHandle_VC.h"

@interface ConfirmOrder_VC () <UITableViewDelegate, UITableViewDataSource, DefaultAddressHeadDelegate>

@property (nonatomic, strong) NSArray *arrCartData;

@property (nonatomic, strong) NSArray *arrCartDataTwo;

@property (nonatomic, strong) NSMutableArray *arrInventoryData;

@property (nonatomic, strong) DefaultAddressHeadView *vHead;

@property (nonatomic, strong) DefaultAddressFootView *vFoot;

@property (nonatomic, strong) HTTabbleView *tbMain;

@property (nonatomic, strong) PayerView *vPayer;

@property (nonatomic, strong) AddressListModel *modelAddress;

@property (nonatomic, strong) NSMutableDictionary *dicData;

@property (nonatomic, assign) BuyType buyTeyp;

@property (nonatomic, assign) OrderType orderType;

@end

@implementation ConfirmOrder_VC


- (instancetype)initWithCartData:(NSArray *)array
                     twoCartData:(NSArray *)arrayTwo
                         BuyType:(BuyType)buyType
                       OrderType:(OrderType)orderType
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        self.buyTeyp = buyType;
        self.orderType = orderType;
        
        self.dicData = [NSMutableDictionary dictionary];
        self.arrInventoryData = [NSMutableArray array];
        self.arrCartData = array;
        self.arrCartDataTwo = arrayTwo;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self loadData];
}

- (void)initView
{
    if (self.buyTeyp == C_Pay) { // C端购买
        [self.view addSubview:self.vHead];
        
        if (self.orderType == JingWai_Order) { // 境外商品订单
            [self.view addSubview:self.vPayer];
        }
    }
    
    [self.view addSubview:self.tbMain];
    [self.view addSubview:self.vFoot];
    [self addNavigationType:YKSDefaults NavigationTitle:@"确认订单"];
    
    if (self.buyTeyp == C_Pay) { // C端购买
        [self.vHead mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.vNavigation.mas_bottom);
            make.height.mas_equalTo(87);
        }];
        
        if (self.orderType == JingWai_Order) { // 境外商品订单
            [self.vPayer mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.vHead.mas_bottom);
                make.left.right.equalTo(self.view);
                make.height.mas_equalTo(145.5);
            }];
        }
    }
    
    
    [self.tbMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        
        if (self.buyTeyp == C_Pay) { // C端购买
            
            if (self.orderType == JingWai_Order) { // 境外商品订单
                make.top.equalTo(self.vPayer.mas_bottom).offset(0);
            }
            else // 国内商品订单
            {
                make.top.equalTo(self.vHead.mas_bottom).offset(5);
            }
        }
        else // B端采购
        {
            make.top.equalTo(self.vNavigation.mas_bottom);
        }
        make.bottom.equalTo(self.view.mas_bottom).offset(-44);
    }];
    
    //如果是iPhone X KBottomSuit
    if (kDisHeight == 812.0) {
        [self.vFoot mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_offset(44);
            make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        }];
    }else{
        [self.vFoot mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_offset(44);
            make.bottom.equalTo(self.view.mas_bottom).offset(0);
        }];
    }
    
    
    // 跳转到订单风控界面
    WS(weakSelf);
    self.vFoot.TipsBlock = ^{
        OrderRiskTips_VC *tips_vc = [[OrderRiskTips_VC alloc] init];
        [weakSelf.navigationController pushViewController:tips_vc animated:YES];
    };
}

#pragma mark - 按钮点击事件
- (void)tapHead
{
    __weak ConfirmOrder_VC *WeakSelf = self;
    
    MyAddressList_VC *address_VC = [[MyAddressList_VC alloc] initWithIsSeletReceivingComeIn:YES DefaultAddressID:self.modelAddress.user_addr_id SelectReceivingAddress:^(AddressListModel *model) {
        WeakSelf.modelAddress = model;
        if (self.buyTeyp == C_Pay) { // C端购买
            if (WeakSelf.modelAddress == nil) {
                [WeakSelf.vHead loadViewName:@"" identity:@"" address:@"" isData:NO];
                [WeakSelf loadData];
            }
            else
            {
                [WeakSelf.vHead loadViewName:[NSString stringWithFormat:@"%@  %@", model.consignee, model.mobile] identity:model.id_card_number address:[NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.district,model.address] isData:YES];
                NSString *sJson = [ZXNTool getJSONString:WeakSelf.arrCartDataTwo];
                [WeakSelf loadDataInventorySeparation:sJson addressId:model.user_addr_id];
            }
        }
    }];
    [self.navigationController pushViewController:address_VC animated:YES];
}

#pragma mark - DefaultAddressHeadDelegate
- (void)tapAddAddress
{
    [self tapHead];
}


#pragma mark - 网络请求
- (void)loadData
{
    if (self.arrCartData.count == 0) {
        return;
    }
    
    NSMutableString *sGoodsID = [NSMutableString string];
    NSString *sJson = [ZXNTool getJSONString:self.arrCartDataTwo];
    
    [self.arrCartData enumerateObjectsUsingBlock:^(NSDictionary *dicGood, NSUInteger idx, BOOL * _Nonnull stop) {
        [sGoodsID appendString:[NSString stringWithFormat:@"%@,",dicGood[@"goods_id"]]];
    }];
    
    [sGoodsID deleteCharactersInRange:NSMakeRange([sGoodsID length]-1, 1)];
    
    // self.arrCartData[0][@"goods_id"]
    NSDictionary *dic = @{@"goods_id_in":sGoodsID,
                          @"default_addr":@"1"};
    [HTLoadingTool showLoadingForView:self.view];
    
    [AFHTTPClient POSTNODismiss:@"/goods/getGoodsInfoByIds" params:dic successInfo:^(ResponseModel *response) {
        self.dicData = [ConfirmOrderBll gainConfirmOrder:response.dataResponse arrIDOrQuantity:self.arrCartData];
        
        if (self.buyTeyp == C_Pay) { // C端购买
            if (self.dicData[@"Address"] != nil) {
                self.modelAddress = self.dicData[@"Address"];
                
                [self.vHead loadViewName:[NSString stringWithFormat:@"%@  %@", self.modelAddress.consignee, self.modelAddress.mobile] identity:self.modelAddress.id_card_number address:[NSString stringWithFormat:@"%@%@%@%@",self.modelAddress.province,self.modelAddress.city,self.modelAddress.district,self.modelAddress.address] isData:YES];
                
                [self loadDataInventorySeparation:sJson addressId:self.modelAddress.user_addr_id];
            }
            else
            {
                [self.vHead loadViewName:@"" identity:@"" address:@"" isData:NO];
                [self.arrInventoryData removeAllObjects];
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:@"0" forKey:@"warehouse_id"];
                [dic setValue:@"未分配" forKey:@"warehouse_name"];
                [dic setValue:self.dicData[@"List"] forKey:@"List"];
                [self.arrInventoryData addObject:dic];
                
                [self.tbMain reloadData];
                
                [HTLoadingTool disMissForView];
            }
        }
        else // B端采购
        {
            [self.tbMain reloadData];
            [HTLoadingTool disMissForView];
        }
        
        __block CGFloat fAll = 0.00;
        [self.dicData[@"List"] enumerateObjectsUsingBlock:^(ConfirmOrderGoodsModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            fAll = fAll + [model.price floatValue] * [model.sQuantity integerValue];
        }];
        
        [self.vFoot loadViewAllMoney:[NSString stringWithFormat:@"%0.2f", fAll]];
        
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        [HTLoadingTool disMissForView];
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}

// 请求库存分离接口
- (void)loadDataInventorySeparation:(NSString *)sJson addressId:(NSString *)sAddressId
{
    NSDictionary *dic = @{@"address_id":sAddressId,
                          @"goods_list":sJson};
    
    [AFHTTPClient POST:@"/COrder/splitGoodsListByConsigneeAddress" params:dic successInfo:^(ResponseModel *response) {
        
        [self.arrInventoryData removeAllObjects];
        self.arrInventoryData = [ConfirmOrderBll gainInventorySeparation:response.dataResponse];
        
        [self.tbMain reloadData];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}


// 生成用户订单
- (void)createUserOrder
{
    if (self.modelAddress.user_addr_id.length == 0) {
        [self.view makeToast:@"请选择收货地址" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (self.buyTeyp == B_Pay) {
        return;
    }
    
    if (self.orderType == JingWai_Order) {
        if (![self isPayerAndConditionSelection]) {
            return;
        }
    }
    
    [HTLoadingTool showLoadingDontOperation];
    
    NSString *sType = @"normal_buy";
    NSString *josn = [ZXNTool getJSONString:self.arrCartData];
    
    NSDictionary *dic = @{@"type":sType,
                          @"address_id":self.modelAddress.user_addr_id,
                          @"goods_list":josn};
    
    [AFHTTPClient POST:@"/COrder/createCOrder" params:dic successInfo:^(ResponseModel *response) {
        
        NSMutableArray *array = [ConfirmOrderBll gainOrderHandle:response.dataResponse];
        
        OrderHandle_VC *orderHandle_VC = [[OrderHandle_VC alloc] initWithArrayList:array BuyType:self.buyTeyp OrderType:self.orderType];
        [self.navigationController pushViewController:orderHandle_VC animated:YES];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}

/// 支付信息判断及是否同意委托判断
- (BOOL)isPayerAndConditionSelection
{
    BOOL a = [self.vPayer isPayerVerificationPassed];
    BOOL b = self.vFoot.btnCheck.selected;
    if (!a) {
        [self.view makeToast:@"支付人姓名必须为汉字，并身份证号码需真实有效" duration:2.0 position:CSToastPositionCenter];
    }
    else
    {
        [self.vPayer updatePayerInfo];
        if (!b) {
            [self.view makeToast:@"需要同意支付委托" duration:2.0 position:CSToastPositionCenter];
        }
    }
    
    if (a && b) {
        return YES;
    }
    else
    {
        return NO;
    }
}

// 创建采购订单
- (void)creatDealersOrder
{
    __block BOOL bShow = NO;
    [self.dicData[@"List"] enumerateObjectsUsingBlock:^(ConfirmOrderGoodsModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.bWarning == YES) {
            bShow = YES;
            *stop = YES;
        }
    }];
    
    if (bShow) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您采购的商品部分需要审核，请确定是否提交" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        
        UIAlertAction *cancelAction2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self DealersOrder];
        }];
        
        [alertController addAction:cancelAction1];
        [alertController addAction:cancelAction2];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        [self DealersOrder];
    }
}

- (void)DealersOrder
{
    NSString *josn = [ZXNTool getJSONString:self.arrCartData];
    
    [HTLoadingTool showLoadingDontOperation];
    NSDictionary *dic = @{@"create_from_platform":@"ios",
                          @"goodsList":josn};
    
    [AFHTTPClient POST:@"/PurchaseOrder/createPurchaseOrder" params:dic successInfo:^(ResponseModel *response) {
        
        PurchaseModel *model = [ConfirmOrderBll gainPurchaseOrder:response.dataResponse];
        
        if ([YKSUserDefaults isHavePayPower]) {
            PayBC_VC *pay_VC = [[PayBC_VC alloc] initWithIsBuyType:self.buyTeyp Order:self.orderType];
            pay_VC.sOrderId = model.purchase_order_id;
            pay_VC.sOrderNumber = model.purchase_order_sn;
            pay_VC.sOrderMoney = model.order_amount;
            [self.navigationController pushViewController:pay_VC animated:YES];
        }
        else
        {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            
            // 返回 采购发货
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            B_TabBarController *rootViewController = (B_TabBarController *)appDelegate.window.rootViewController;
            rootViewController.selectedIndex = 2;
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {

        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}


#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.buyTeyp == B_Pay) { // B端采购
        return 1;
    }
    else // C端购买
    {
        return self.arrInventoryData.count > 0 ? self.arrInventoryData.count : 1;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.buyTeyp == B_Pay) { // B端采购
        NSMutableArray *array = self.dicData[@"List"];
        return array.count;
    }
    else // C端购买
    {
        return self.arrInventoryData.count > 0 ? ((NSMutableArray *)self.arrInventoryData[section][@"List"]).count : 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConfirmOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderCell"];
    if (cell == nil) {
        cell = [[ConfirmOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ConfirmOrderCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    ConfirmOrderGoodsModel *model = nil;
    if (self.buyTeyp == B_Pay) {
        model = self.dicData[@"List"][indexPath.row];
    }
    else
    {
        model = self.arrInventoryData[indexPath.section][@"List"][indexPath.row];
    }
    
    [cell loadView:model.img_original BuyName:model.goods_name MoneyOne:model.sQuantity MoneyTwo:model.price Warning:model.bWarning isB_Or_C:self.buyTeyp == B_Pay ? NO : YES];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.buyTeyp == B_Pay) {
        return 0.01;
    }
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.buyTeyp == B_Pay || self.arrInventoryData.count == 0 || self.arrInventoryData.count == 1) {
        return 0.01;
    }
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.buyTeyp == B_Pay) {
        return nil;
    }
    
    InventoryHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"InventoryHeaderView"];
    if (headerView == nil) {
        headerView = [[InventoryHeaderView alloc] initWithReuseIdentifier:@"InventoryHeaderView"];
    }
    if (self.arrInventoryData.count > 0) {
        [headerView loadViewInventory:self.arrInventoryData[section][@"warehouse_name"]];
    }
    return headerView;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


#pragma mark - 懒加载
- (DefaultAddressHeadView *)vHead
{
    if (!_vHead) {
        _vHead = [[DefaultAddressHeadView alloc] init];
        _vHead.backgroundColor = [UIColor whiteColor];
        _vHead.delegate = self;
        UITapGestureRecognizer *tapHead = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHead)];
        [_vHead addGestureRecognizer:tapHead];
    }
    return _vHead;
}

- (DefaultAddressFootView *)vFoot
{
    if (!_vFoot) {
        
        __weak ConfirmOrder_VC *WeakSelf = self;
        _vFoot = [[DefaultAddressFootView alloc] initWithBuyTpye:self.buyTeyp OrderType:self.orderType goUserOrDealers:^(PayType type) {
            if (type == Go_C_Pay) { // 进入个人支付页面
                [WeakSelf createUserOrder];
            }
            else { // 进入经销商支付页面
                [WeakSelf creatDealersOrder];
            }
        }];
        
        _vFoot.backgroundColor = [UIColor whiteColor];
    }
    return _vFoot;
}

- (HTTabbleView *)tbMain
{
    if (!_tbMain) {
        _tbMain = [[HTTabbleView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tbMain.delegate = self;
        _tbMain.dataSource = self;
        _tbMain.showsVerticalScrollIndicator = NO;
        _tbMain.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbMain.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    }
    return _tbMain;
}

- (PayerView *)vPayer
{
    if (!_vPayer) {
        _vPayer = [[PayerView alloc] init];
    }
    return _vPayer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
