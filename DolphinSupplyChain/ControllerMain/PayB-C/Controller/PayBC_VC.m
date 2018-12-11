//
//  PayBC_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/1.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "PayBC_VC.h"
#import "PayFootView.h"
#import "PayCell.h"
#import "PayMoreCell.h"
#import "PayFailure_VC.h"
#import "BaseNavigationViewController.h"
#import "PaySucceed_VC.h"
#import "MyAddressList_VC.h"
#import "ZhiFuBaoTool.h"
#import "WeiXinTool.h"
#import "AppDelegate.h"
#import "HTLoadingTool.h"
#import "ZXNTool.h"
#import "BuyProtocolView.h"

#import "HTTabbleView.h"
#import "OrderInfoView.h"

@interface PayBC_VC () <UITableViewDelegate, UITableViewDataSource, WeiXinZhiFuDelegate, ZhiFuBaoDelegate, BuyProtocolDelegate>

@property (nonatomic, strong) NSArray *arrName;

@property (nonatomic, strong) NSArray *arrNeiRon;

@property (nonatomic, strong) NSArray *arrImage;

@property (nonatomic, strong) NSMutableArray *arrSelect;

@property (nonatomic, strong) HTTabbleView *tbMain;

@property (nonatomic, strong) PayFootView *vFoot;

@property (nonatomic, strong) BuyProtocolView *vBuyProtocol;

@property (nonatomic, assign) BuyType buyTeyp;

@property (nonatomic, assign) OrderType orderType;

@property (nonatomic, strong) OrderInfoView *vOrderInfo;

@property (nonatomic, strong) UIView *vHead;

@property (nonatomic, copy) NSString *sPayNumber;

@property (nonatomic, assign) BOOL bSelectBuyProcotol;

@end

@implementation PayBC_VC

- (instancetype)initWithIsBuyType:(BuyType)buyType
                            Order:(OrderType)orderType
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.bSelectBuyProcotol = YES;
        self.orderType = orderType;
        if (self.orderType == GuoNei_Order) {
            self.arrName = @[@"支付宝", @"微信支付"];
        }
        else
        {
            self.arrName = @[@"支付宝"];
        }
        self.arrNeiRon = @[@"数亿用户都在用，安全可托付", @"亿万用户的选择，更快更安全"];
        self.arrImage = @[@"alipay", @"wei_xin_pay"];
        self.arrSelect = [NSMutableArray arrayWithObjects:@"1", @"0", nil];
        self.buyTeyp = buyType;
        self.sPayNumber = @"";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ZhiFuBaoPayIsTrue:) name:@"AlipaySDKPay" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GoToTabBarZero) name:@"GoToTabBarZero" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GoToTabBarTwo) name:@"GoToTabBarTwo" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GoToTabBarThree) name:@"GoToTabBarThree" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GoToTabBarFour) name:@"GoToTabBarFour" object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.vOrderInfo];
    
    if (self.buyTeyp == C_Pay) {
        [self.view addSubview:self.vBuyProtocol];
        
        CGSize size = [ZXNTool gainTextSize:kFont13 text:@"本人承诺本次购买商品为本人自用合理数量，愿承担相应法律责任。" Width:kDisWidth - 30];
        
        [self.vBuyProtocol mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.vOrderInfo.mas_bottom);
            make.height.mas_equalTo(60 + size.height);
        }];
    }
    [self.view addSubview:self.tbMain];
    
    [self addNavigationType:YKSDefaults NavigationTitle:@"订单支付"];
    
    [self.vOrderInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.vNavigation.mas_bottom);
        make.height.mas_equalTo(65);
    }];
    
    [self.tbMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        
        if (self.buyTeyp == C_Pay) {
            make.top.equalTo(self.vBuyProtocol.mas_bottom);
        }
        else
        {
            make.top.equalTo(self.vOrderInfo.mas_bottom);
        }
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

// 返回首页 TabBar下标为0 的控制器
- (void)GoToTabBarZero
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 返回首页
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate cutSomeController:0];
}


// 返回TabBar下标为2 的控制器
- (void)GoToTabBarTwo
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate cutSomeController:2];
}


// 返回TabBar下标为3 的控制器
- (void)GoToTabBarThree
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate cutSomeController:3];
}

// 返回TabBar下标为4 的控制器
- (void)GoToTabBarFour
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 返回用户个人中心
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate cutSomeController:4];
}


#pragma mark - 为每个订单附上身份证及姓名
- (void)LoadDataSetPayer
{
    [HTLoadingTool showLoadingForView:self.view Hint:@"努力支付中..."];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sName = [user objectForKey:@"YKS_Payer_Name"];
    NSString *sNumber = [user objectForKey:@"YKS_Payer_Number"];
    
    NSDictionary *dic = @{@"c_order_id":self.sOrderId,
                          @"payer_name":sName,
                          @"payer_id_card_no":sNumber};
    
    [AFHTTPClient POSTNODismiss:@"/COrder/setPayer" params:dic successInfo:^(ResponseModel *response) {
        
        [self Payment:YES];
        
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


// bPayType YES 为支付宝  NO 为微信
- (void)Payment:(BOOL)bPayType
{
    if (!self.bSelectBuyProcotol) {
        [self.view makeToast:@"您的没同意购买协议，不能进行付款购买" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    
    if (!bPayType) {
        if (![[WeiXinTool shareInstance] isWXAppMake]) {
            [self.view makeToast:@"您的手机还未安装微信" duration:1.0 position:CSToastPositionCenter];
            return;
        }
    }
    
    NSString *sType = bPayType ? @"InternalAlipayApp" : @"Weixin";
    NSDictionary *dic = @{@"pay_code":sType,
                          @"order_sn":self.sOrderNumber};
    
    [HTLoadingTool showLoadingForView:self.view Hint:@"努力支付中..."];
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
        
        self.sPayNumber = response.dataResponse[@"info"][@"send_order_sn"];
        
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
    if (bType) {
        
        PaySucceed_VC *succeedVC = [[PaySucceed_VC alloc] initWithBuyType:self.buyTeyp PayType:@"微信" PayNumber:self.sPayNumber];
        
        succeedVC.sOrderNumber = self.sOrderNumber;
        succeedVC.sOrderMoney = self.sOrderMoney;
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:succeedVC];
        [self.navigationController presentViewController:nav animated:YES completion:^{
            
        }];
    }
    else
    {
        PayFailure_VC *failureVC = [[PayFailure_VC alloc] initWithIsZhiFiBaoOrWeiXin:@"weixin" OrderType:self.orderType];
        
        failureVC.sOrderNumber = self.sOrderNumber;
        failureVC.sOrderMoney = self.sOrderMoney;
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:failureVC];
        
        WS(weakSelf);
        failureVC.block = ^(BOOL isZhiFuBao){
            [weakSelf Payment:isZhiFuBao];
        };
        
        [self.navigationController presentViewController:nav animated:YES completion:^{
            
        }];
    }
}

- (void)ZhiFuBaoPayIsTrue:(NSNotification *)notifiCation
{
    NSDictionary *dicData = nil;
    if (notifiCation.userInfo[@"userInfo"] != nil) {
        dicData = notifiCation.userInfo[@"userInfo"];
        
        if ([dicData[@"resultStatus"] isEqualToString:@"9000"]) {

            PaySucceed_VC *succeedVC = [[PaySucceed_VC alloc] initWithBuyType:self.buyTeyp PayType:@"支付宝" PayNumber:self.sPayNumber];
            
            succeedVC.sOrderNumber = self.sOrderNumber;
            succeedVC.sOrderMoney = self.sOrderMoney;
            BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:succeedVC];
            [self.navigationController presentViewController:nav animated:YES completion:^{
                
            }];
        }
        else
        {
            
            PayFailure_VC *failureVC = [[PayFailure_VC alloc] initWithIsZhiFiBaoOrWeiXin:@"zhifubao" OrderType:self.orderType];
            failureVC.sOrderNumber = self.sOrderNumber;
            failureVC.sOrderMoney = self.sOrderMoney;
            BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:failureVC];
            
            WS(weakSelf);
            failureVC.block = ^(BOOL isZhiFuBao){
                [weakSelf Payment:isZhiFuBao];
            };
            
            [self.navigationController presentViewController:nav animated:YES completion:^{
                
            }];
        }
    }
    else
    {
        PayFailure_VC *failureVC = [[PayFailure_VC alloc] initWithIsZhiFiBaoOrWeiXin:@"zhifubao" OrderType:self.orderType];
        
        failureVC.sOrderNumber = self.sOrderNumber;
        failureVC.sOrderMoney = self.sOrderMoney;
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:failureVC];
        
        WS(weakSelf);
        failureVC.block = ^(BOOL isZhiFuBao){
            [weakSelf Payment:isZhiFuBao];
        };
        
        [self.navigationController presentViewController:nav animated:YES completion:^{
            
        }];
    }
}

- (void)ZhiFuBaoIsTrue:(BOOL)isTrue
{
    if (isTrue) {
        
        PaySucceed_VC *succeedVC = [[PaySucceed_VC alloc] initWithBuyType:self.buyTeyp PayType:@"支付宝" PayNumber:self.sPayNumber];
        
        succeedVC.sOrderNumber = self.sOrderNumber;
        succeedVC.sOrderMoney = self.sOrderMoney;
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:succeedVC];
        [self.navigationController presentViewController:nav animated:YES completion:^{
            
        }];
    }
    else
    {
        PayFailure_VC *failureVC = [[PayFailure_VC alloc] initWithIsZhiFiBaoOrWeiXin:@"zhifubao" OrderType:self.orderType];
        failureVC.sOrderNumber = self.sOrderNumber;
        failureVC.sOrderMoney = self.sOrderMoney;
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:failureVC];
        
        WS(weakSelf);
        failureVC.block = ^(BOOL isZhiFuBao){
            [weakSelf Payment:isZhiFuBao];
        };
        
        [self.navigationController presentViewController:nav animated:YES completion:^{
            
        }];
    }
    
}


#pragma mark - BuyProtocolDelegate
- (void)buyProtocolIsSelect:(BOOL)bSelect
{
    self.bSelectBuyProcotol = bSelect;
}


#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrName.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayCell"];
    if (cell == nil) {
        cell = [[PayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PayCell"];
    }
    [cell loadViewIcon:self.arrImage[indexPath.row] PayName:self.arrName[indexPath.row] PayNeiRon:self.arrNeiRon[indexPath.row] Select:self.arrSelect[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.arrSelect[indexPath.row] isEqualToString:@"0"]) {
        
        for (int i = 0; i < 2; i ++) {
            self.arrSelect[i] = @"0";
        }
        
        self.arrSelect[indexPath.row] = @"1";
        
        [tableView reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.vFoot;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.vHead;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 34;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 90;
}


#pragma mark - 懒加载
- (HTTabbleView *)tbMain
{
    if (!_tbMain) {
        _tbMain = [[HTTabbleView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tbMain.scrollEnabled = NO;
        _tbMain.showsVerticalScrollIndicator = NO;
        _tbMain.delegate = self;
        _tbMain.dataSource = self;
        _tbMain.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbMain.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    }
    return _tbMain;
}

- (UIView *)vOrderInfo
{
    if (!_vOrderInfo) {
        _vOrderInfo = [[OrderInfoView alloc] initWithOrderNumber:self.sOrderNumber OrderMoney:self.sOrderMoney];
        _vOrderInfo.backgroundColor = [UIColor whiteColor];
    }
    return _vOrderInfo;
}



- (PayFootView *)vFoot
{
    if (!_vFoot) {
        
        __weak PayBC_VC *WeakSelf = self;
        _vFoot = [[PayFootView alloc] initWithTap:^{
            if ([WeakSelf.arrSelect[0] isEqualToString:@"1"]) { // 支付宝
                
                if (WeakSelf.buyTeyp == C_Pay && WeakSelf.orderType == JingWai_Order) {
                    [self LoadDataSetPayer];
                }
                else
                {
                    [self Payment:YES];
                }
                
            }
            else  // 微信
            {
                [self Payment:NO];
            }
        }];
        _vFoot.frame = CGRectMake(0, 0, kDisWidth, 90);
    }
    return _vFoot;
}

- (UIView *)vHead
{
    if (!_vHead) {
        _vHead = [[UIView alloc] init];
        
        UILabel *lblPayName = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 34)];
        lblPayName.text = @"选择支付方式";
        lblPayName.textColor = [UIColor colorWithHexString:@"666666"];
        lblPayName.font = kFont13;
        
        [_vHead addSubview:lblPayName];
    }
    return _vHead;
}

- (BuyProtocolView *)vBuyProtocol
{
    if (!_vBuyProtocol) {
        _vBuyProtocol = [[BuyProtocolView alloc] init];
        _vBuyProtocol.delegate = self;
    }
    return _vBuyProtocol;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
