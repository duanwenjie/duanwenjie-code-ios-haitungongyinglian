//
//  PaySucceed_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "PaySucceed_VC.h"
#import "PaySucceedHintView.h"
#import "PaySucceedFootImageView.h"
#import "AppDelegate.h"
#import "C_PaySucceedOrderView.h"
#import "ZXNTool.h"
#import "ConfirmOrderBll.h"
#import "OrderPayModel.h"
#import "BCOrderDetails_VC.h"

@interface PaySucceed_VC () <C_PaySucceedDelegate>

@property (nonatomic, strong) PaySucceedHintView *vPaySucceedHint;

@property (nonatomic, strong) PaySucceedFootImageView *imgSucceedFoot;

@property (nonatomic, assign) BuyType buyType;

/// 支付方式
@property (nonatomic, copy) NSString *sPayType;

/// 商户单号（支付宝的订单号，或微信的订单号）
@property (nonatomic, copy) NSString *sPayNumber;

@property (nonatomic, strong) UILabel *lblHint;

@end

@implementation PaySucceed_VC

- (instancetype)initWithBuyType:(BuyType)buyType
                        PayType:(NSString *)sPayType
                      PayNumber:(NSString *)sPayNumber
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        self.buyType = buyType;
        
        self.sPayType = sPayType;
        self.sPayNumber = sPayNumber;
    }
    return self;
}


- (void)tapLeft
{
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
        
        if (self.buyType == C_Pay) { // C端订单
            if ([YKSUserDefaults isUserIndividual]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GoToTabBarThree" object:nil];
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GoToTabBarFour" object:nil];
            }
        }
        else  // B端订单
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"GoToTabBarTwo" object:nil];
        }
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavigationType:YKSDefaults NavigationTitle:@"支付结果"];
    
    if (self.buyType == C_Pay) { // C端订单
        
        [HTLoadingTool showLoadingStringDontOperation:@"查询订单状态中..."];
        [self performSelector:@selector(loadOrderInfoData) withObject:nil afterDelay:5];
        return;
    }
    //*****  B端订单  *****//
    [self.view addSubview:self.vPaySucceedHint];
    [self.view addSubview:self.lblHint];
    
    [self.vPaySucceedHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.vNavigation.mas_bottom);
        make.height.mas_equalTo(235);
    }];
    
    [self.view addSubview:self.imgSucceedFoot];
    
    [self.imgSucceedFoot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(73);
        make.top.equalTo(self.vPaySucceedHint.mas_bottom).offset(0);
    }];
    
    [self.lblHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.top.equalTo(self.imgSucceedFoot.mas_bottom).offset(10);
    }];
    
    [self.vPaySucceedHint loadViewOrderNumber:self.sOrderNumber PayType:self.sPayType MoneyNumber:self.sOrderMoney PayNumber:self.sPayNumber];
}

- (void)showView
{
    [self.view addSubview:self.vPaySucceedHint];
    [self.view addSubview:self.lblHint];
    
    [self.vPaySucceedHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.vNavigation.mas_bottom);
        make.height.mas_equalTo(235);
    }];
    
    [self.vPaySucceedHint loadViewOrderNumber:self.sOrderNumber PayType:self.sPayType MoneyNumber:self.sOrderMoney PayNumber:self.sPayNumber];
}

#pragma mark - 异步加载订单信息，并由加载出来的信息渲染界面
- (void)loadOrderInfoData
{
    NSDictionary *dic1 = @{@"order_sn":self.sOrderNumber};
    [AFHTTPClient POST:@"/Payment/getOrderSoonInfo" params:dic1 successInfo:^(ResponseModel *response) {
        
        OrderPayModel *model = [ConfirmOrderBll gainOrderPay:response.dataResponse];
        
        [self showView];
        
        if (model.flag) // 支付完成
        {
            C_PaySucceedOrderView *vCPaySucceed = [[C_PaySucceedOrderView alloc] initWithNODisperseOrder:!model.hasSoon OrderNumberList:model.arrList];
            vCPaySucceed.delegate = self;
            [self.view addSubview:vCPaySucceed];
            
            if (model.hasSoon)  // 有子订单
            {
                NSString *sT = @"尊敬的客户，由于您商品不在同一库房，您的订单被系统拆分为多个子订单分开配送，所产生的额外运费由海豚供应链承担，给您带来的不便请谅解。";
                CGSize size = [ZXNTool gainTextSize:kFont12 text:sT Width:kDisWidth - 30];
                
                [vCPaySucceed mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self.view);
                    make.height.mas_equalTo((size.height + 10 + 40) + (((model.arrList.count - 1)/3 + 1) * (40)));
                    make.top.equalTo(self.vPaySucceedHint.mas_bottom).offset(0);
                }];
            }
            else  // 没有子订单
            {
                [vCPaySucceed mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self.view);
                    make.height.mas_equalTo(90);
                    make.top.equalTo(self.vPaySucceedHint.mas_bottom).offset(0);
                }];
            }
            
            [self.lblHint mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view.mas_left).offset(15);
                make.right.equalTo(self.view.mas_right).offset(-15);
                make.top.equalTo(vCPaySucceed.mas_bottom).offset(10);
            }];
        }
        else  // 支付失败
        {
            C_PaySucceedOrderView *vCPay = [[C_PaySucceedOrderView alloc] initWithServePayQueryFails];
            vCPay.delegate = self;
            [self.view addSubview:vCPay];
            
            [vCPay mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.height.mas_equalTo(90);
                make.top.equalTo(self.vPaySucceedHint.mas_bottom).offset(0);
            }];
            
            [self.lblHint mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view.mas_left).offset(15);
                make.right.equalTo(self.view.mas_right).offset(-15);
                make.top.equalTo(vCPay.mas_bottom).offset(10);
            }];
        }
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        if (type != NEED_LOGIN) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        [self showView];
        
        C_PaySucceedOrderView *vCPay = [[C_PaySucceedOrderView alloc] initWithServePayQueryFails];
        vCPay.delegate = self;
        [self.view addSubview:vCPay];
        
        [vCPay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(90);
            make.top.equalTo(self.vPaySucceedHint.mas_bottom).offset(0);
        }];
        
        [self.lblHint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(15);
            make.right.equalTo(self.view.mas_right).offset(-15);
            make.top.equalTo(vCPay.mas_bottom).offset(10);
        }];
        
    }];
}

#pragma mark - C_PaySucceedDelegate
- (void)C_PayGoHome
{
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GoToTabBarZero" object:nil];
    }];
}

- (void)C_PayGoToOrderInfo:(NSString *)sOrderNumber
{
    if ([sOrderNumber isEqualToString:@"总订单"]) // 跳转回首页
    {
        BCOrderDetails_VC *orderDetails_VC = [[BCOrderDetails_VC alloc] initWithOrderID:self.sOrderNumber B_COrder:self.buyType == C_Pay ? YES : NO isNoPay:NO];
        [self.navigationController pushViewController:orderDetails_VC animated:YES];
    }
    else // 跳转回进入订单详情
    {
        BCOrderDetails_VC *orderDetails_VC = [[BCOrderDetails_VC alloc] initWithOrderID:sOrderNumber B_COrder:self.buyType == C_Pay ? YES : NO isNoPay:NO];
        [self.navigationController pushViewController:orderDetails_VC animated:YES];
    }
}

#pragma mark - 懒加载
- (PaySucceedHintView *)vPaySucceedHint
{
    if (!_vPaySucceedHint) {
        _vPaySucceedHint = [[PaySucceedHintView alloc] init];
        _vPaySucceedHint.backgroundColor = [UIColor whiteColor];
    }
    return _vPaySucceedHint;
}

- (PaySucceedFootImageView *)imgSucceedFoot
{
    if (!_imgSucceedFoot) {
        _imgSucceedFoot = [[PaySucceedFootImageView alloc] initWithShipmentsOrHomeNameBlock:^(NSString *sType) {
            
            if ([sType isEqualToString:@"Go_Home"]) {
                [self.navigationController dismissViewControllerAnimated:NO completion:^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"GoToTabBarZero" object:nil];
                }];
            }
            
            if ([sType isEqualToString:@"Go_Order"]) {
                [self.navigationController dismissViewControllerAnimated:NO completion:^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"GoToTabBarThree" object:nil];
                }];
            }
            
        }];
    }
    return _imgSucceedFoot;
}

- (UILabel *)lblHint
{
    if (!_lblHint) {
        _lblHint = [[UILabel alloc] init];
        _lblHint.text = @"安全提醒：海通供应链不会以订单异常、系统升级为由，要求您点击任何链接进行退款操作。";
        _lblHint.numberOfLines = 0;
        _lblHint.textColor = [UIColor colorWithHexString:@"666666"];
        _lblHint.font = kFont12;
    }
    return _lblHint;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
