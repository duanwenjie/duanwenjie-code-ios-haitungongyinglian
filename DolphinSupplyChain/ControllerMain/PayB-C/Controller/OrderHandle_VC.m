//
//  OrderHandle_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/5/16.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "OrderHandle_VC.h"
#import "OrderHandleHeadView.h"
#import "HTTabbleView.h"
#import "OrderHandleFootView.h"
#import "HandleCell.h"
#import "HandleView.h"
#import "FooterView.h"
#import "OrderHandleModel.h"
#import "ConfirmOrderGoodsModel.h"
#import "AppDelegate.h"
#import "WeiXinTool.h"
#import "ZhiFuBaoTool.h"
#import "OrderHandleHintView.h"
#import "OrderHandleModel.h"

@interface OrderHandle_VC () <UITableViewDelegate, UITableViewDataSource, HandleFooterDelegate, OrderHandleFootDelegate, WeiXinZhiFuDelegate, ZhiFuBaoDelegate, OrderHandleHintViewDelegate>

@property (nonatomic, strong) OrderHandleHeadView *vHead;

@property (nonatomic, strong) HTTabbleView *tbMain;

@property (nonatomic, strong) OrderHandleFootView *vFoot;

@property (nonatomic, strong) UIWindow *HTWindow;

@property (nonatomic, strong) OrderHandleHintView *vHint;

@property (nonatomic, copy) NSMutableArray *arrData;

@property (nonatomic, assign) NSInteger iSection;

@property (nonatomic, assign) BuyType buyTeyp;

@property (nonatomic, assign) OrderType orderType;

@end

@implementation OrderHandle_VC

- (instancetype)initWithArrayList:(NSMutableArray *)array
                          BuyType:(BuyType)buyType
                        OrderType:(OrderType)orderType
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        self.buyTeyp = buyType;
        self.orderType = orderType;
        
        self.iSection = 0;
        self.arrData = array;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ZhiFuBaoPayIsTrue:) name:@"AlipaySDKPay" object:nil];
    
    [self addNavigationType:YKSDefaults NavigationTitle:@"订单处理"];
    [self initView];
    [self addViewLayout];
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
    // 开启 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}


- (void)initView
{
    [self.view addSubview:self.vHead];
    [self.view addSubview:self.tbMain];
    [self.view addSubview:self.vFoot];
    [self.HTWindow addSubview:self.vHint];
}

- (void)addViewLayout
{
    [self.vHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavigation.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    [self.tbMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vHead.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.vFoot.mas_top);
    }];
    
    [self.vFoot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(80);
    }];
    
    [self.vHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.HTWindow);
    }];
}

#pragma mark - 重写返回按钮
- (void)tapLeft
{
    if ([YKSUserDefaults isUserIndividual]) {
        [self GoToTabBarThree];
    }
    else
    {
        if (self.buyTeyp == C_Pay) {
            [self GoToTabBarFour];
        }
        else
        {
            [self GoToTabBarTwo];
        }
    }
}


// 返回首页 TabBar下标为0 的控制器
- (void)GoToTabBarZero
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    // 返回首页
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate cutSomeController:0];
}


// 返回TabBar下标为2 的控制器
- (void)GoToTabBarTwo
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate cutSomeController:2];
}


// 返回TabBar下标为3 的控制器
- (void)GoToTabBarThree
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate cutSomeController:3];
}

// 返回TabBar下标为4 的控制器 进入购物车
- (void)GoToTabBarFour
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    // 返回用户个人中心
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate cutSomeController:4];
}

// 返回TabBar下标为4 的控制器 进入购物车
- (void)GoToTabBarFourShopingCart
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    // 返回用户个人中心
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate cutSomeController:4];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GOShoppingCart" object:nil];
}

// 返回TabBar下标为4 的控制器 进入订单列表
- (void)GoToTabBarFourOrderList
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    // 返回用户个人中心
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate cutSomeController:4];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GOOrderList" object:nil];
}

#pragma mark - 显示FootView
- (void)showFootView
{
    [self.vFoot mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).offset(-80);
    }];
}

#pragma mark - HandleFooterDelegate
- (void)tapGoPay:(NSInteger)iSection
{
    self.iSection = iSection;
    if (self.orderType == JingWai_Order) { // 境外商品订单
        
        OrderHandleModel *model = self.arrData[iSection];
        [self LoadDataOrderID:model.c_order_id OrderNumber:model.c_order_sn];
    }
    else // 国内商品订单
    {
        if (self.vHint.hidden) {
            self.vHint.hidden = NO;
        }
    }
}

#pragma mark - OrderHandleFootDelegate
- (void)tapGoOrderList
{
    if ([YKSUserDefaults isUserIndividual]) {
        [self GoToTabBarThree];
    }
    else
    {
        if (self.buyTeyp == C_Pay) {
            [self GoToTabBarFourOrderList];
        }
        else
        {
            [self GoToTabBarTwo];
        }
    }
}

- (void)tapGoShopingCart
{
    if ([YKSUserDefaults isUserIndividual]) {
        [self GoToTabBarTwo];
    }
    else
    {
        if (self.buyTeyp == C_Pay) {
            [self GoToTabBarFourShopingCart];
        }
        else
        {
            [self GoToTabBarTwo];
        }
    }
}


#pragma mark - OrderHandleHintViewDelegate
- (void)cancel
{
    self.vHint.hidden = YES;
}

- (void)selectorGoPay:(OrderHandleHintENUM)type
{
    OrderHandleModel *model = self.arrData[self.iSection];
    if (type == HT_ZhiFuBao) {
        [self Payment:YES OrderNumber:model.c_order_sn];
    }
    else
    {
        [self Payment:NO OrderNumber:model.c_order_sn];
    }
}

#pragma mark - 为每个订单附上身份证及姓名
- (void)LoadDataOrderID:(NSString *)SorderID OrderNumber:(NSString *)sOrderNumber
{
    [HTLoadingTool showLoadingForView:self.view Hint:@"努力支付中..."];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sName = [user objectForKey:@"YKS_Payer_Name"];
    NSString *sNumber = [user objectForKey:@"YKS_Payer_Number"];
    
    NSDictionary *dic = @{@"c_order_id":SorderID,
                          @"payer_name":sName,
                          @"payer_id_card_no":sNumber};
    
    [AFHTTPClient POSTNODismiss:@"/COrder/setPayer" params:dic successInfo:^(ResponseModel *response) {
        
        [self Payment:YES OrderNumber:sOrderNumber];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
        
        [HTLoadingTool disMissForWindow];
        [HTLoadingTool disMissForView];
    }];
}



#pragma mark - bPayType YES 为支付宝  NO 为微信
- (void)Payment:(BOOL)bPayType OrderNumber:(NSString *)sOrderNumber
{
    self.vHint.hidden = YES;
    if (!bPayType) {
        if (![[WeiXinTool shareInstance] isWXAppMake]) {
            [self.view makeToast:@"您的手机还未安装微信" duration:1.0 position:CSToastPositionCenter];
            return;
        }
    }
    
    NSString *sType = bPayType ? @"InternalAlipayApp" : @"Weixin";
    NSDictionary *dic = @{@"pay_code":sType,
                          @"order_sn":sOrderNumber};
    
    if (self.orderType == GuoNei_Order) { // 国内商品订单
        [HTLoadingTool showLoadingForView:self.view Hint:@"努力支付中..."];
    }
    
    [AFHTTPClient POST:@"/Payment/toPay" params:dic successInfo:^(ResponseModel *response) {
        
        if (bPayType) {
            [[ZhiFuBaoTool shareInstance] startZhiFuBaoPay:response.dataResponse[@"info"][@"info"][@"result"]];
            [ZhiFuBaoTool shareInstance].delegate = self;
        }
        else
        {
            [[WeiXinTool shareInstance] startWeiXinPay:response.dataResponse[@"info"][@"info"]];
            [WeiXinTool shareInstance].delegate = self;
        }
        
//        NSString *sPayNumber = response.dataResponse[@"info"][@"send_order_sn"];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}



#pragma mark - WeiXinZhiFuDelegate
- (void)isZhiFuTureOrFalse:(BOOL)bType
{
    if (bType) { // 微信支付成功
        
        OrderHandleModel *model = self.arrData[self.iSection];
        model.bIsPay = YES;
        __block BOOL bIsAllPay = YES;
        [self.arrData enumerateObjectsUsingBlock:^(OrderHandleModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (!obj.bIsPay) {
                bIsAllPay = NO;
            }
        }];
        
        if (bIsAllPay) {
            [self showFootView];
        }
        
        NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:self.iSection];
        [self.tbMain reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else // 微信支付失败
    {
        [self.view makeToast:@"微信支付失败" duration:2.0 position:CSToastPositionCenter];
    }
}


#pragma mark - ZhiFuBaoDelegate
- (void)ZhiFuBaoIsTrue:(BOOL)isTrue
{
    if (isTrue) { // 支付宝支付成功
        OrderHandleModel *model = self.arrData[self.iSection];
        model.bIsPay = YES;
        __block BOOL bIsAllPay = YES;
        [self.arrData enumerateObjectsUsingBlock:^(OrderHandleModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (!obj.bIsPay) {
                bIsAllPay = NO;
            }
        }];
        
        if (bIsAllPay) {
            [self showFootView];
        }
        
        NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:self.iSection];
        [self.tbMain reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else // 支付宝支付失败
    {
        [self.view makeToast:@"支付宝支付失败" duration:2.0 position:CSToastPositionCenter];
    }
    
}


#pragma mark - 支付宝通知调用
- (void)ZhiFuBaoPayIsTrue:(NSNotification *)notifiCation
{
    NSDictionary *dicData = nil;
    if (notifiCation.userInfo[@"userInfo"] != nil) {
        dicData = notifiCation.userInfo[@"userInfo"];
        
        if ([dicData[@"resultStatus"] isEqualToString:@"9000"])
        {
            // 支付宝支付成功
            OrderHandleModel *model = self.arrData[self.iSection];
            model.bIsPay = YES;
            __block BOOL bIsAllPay = YES;
            [self.arrData enumerateObjectsUsingBlock:^(OrderHandleModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (!obj.bIsPay) {
                    bIsAllPay = NO;
                }
            }];
            
            if (bIsAllPay) {
                [self showFootView];
            }
            
            NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:self.iSection];
            [self.tbMain reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else
        {
            // 支付宝支付失败
            [self.view makeToast:@"支付宝支付失败" duration:2.0 position:CSToastPositionCenter];
        }
    }
    else
    {
        // 支付宝支付失败
        [self.view makeToast:@"支付宝支付失败" duration:2.0 position:CSToastPositionCenter];
    }
}





#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    OrderHandleModel *model = self.arrData[section];
    return model.arrList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HandleCell *handleCell = [tableView dequeueReusableCellWithIdentifier:@"handleCell"];
    if (handleCell == nil) {
        handleCell = [[HandleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"handleCell"];
        handleCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    OrderHandleModel *model = self.arrData[indexPath.section];
    ConfirmOrderGoodsModel *goodsModel = model.arrList[indexPath.row];
    [handleCell loadDataGoodsName:goodsModel.goods_name Address:model.warehouse_name Money:goodsModel.price];
    return handleCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HandleView *vHandle = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"vHandle"];
    if (vHandle == nil) {
        vHandle = [[HandleView alloc] initWithReuseIdentifier:@"vHandle"];
    }
    OrderHandleModel *model = self.arrData[section];
    [vHandle loadData:model.c_order_sn];
    return vHandle;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    FooterView *vFooter = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"vFooter"];
    if (vFooter == nil) {
        vFooter = [[FooterView alloc] initWithReuseIdentifier:@"vFooter"];
        vFooter.delegate = self;
    }
    OrderHandleModel *model = self.arrData[section];
    [vFooter loadData:model.order_amount Section:section isPay:model.bIsPay];
    return vFooter;
}



#pragma mark - 懒加载
- (OrderHandleHeadView *)vHead
{
    if (!_vHead) {
        _vHead = [[OrderHandleHeadView alloc] init];
    }
    return _vHead;
}

- (OrderHandleFootView *)vFoot
{
    if (!_vFoot) {
        _vFoot = [[OrderHandleFootView alloc] init];
        _vFoot.delegate = self;
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

- (UIWindow *)HTWindow
{
    if (!_HTWindow) {
        _HTWindow = [UIApplication sharedApplication].keyWindow;
    }
    return _HTWindow;
}

- (OrderHandleHintView *)vHint
{
    if (!_vHint) {
        _vHint = [[OrderHandleHintView alloc] init];
        _vHint.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _vHint.delegate = self;
        _vHint.hidden = YES;
    }
    return _vHint;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
