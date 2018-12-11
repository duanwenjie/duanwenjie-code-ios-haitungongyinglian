//
//  PayFailure_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "PayFailure_VC.h"
#import "PayFailureHintView.h"
#import "PayCell.h"
#import "PayMoreCell.h"
#import "PayFootView.h"
#import "AppDelegate.h"

#import "C_TabBarController.h"
#import "HTTabbleView.h"


@interface PayFailure_VC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *arrName;

@property (nonatomic, strong) NSArray *arrNeiRon;

@property (nonatomic, strong) NSArray *arrImage;

@property (nonatomic, strong) NSMutableArray *arrSelect;

@property (nonatomic, strong) HTTabbleView *tbMain;

@property (nonatomic, strong) PayFootView *vFoot;

@property (nonatomic, strong) UIView *vHead;

@property (nonatomic, strong) PayFailureHintView *vFailureHint;

@property (nonatomic, assign) BOOL bShowWeiXinPay;

@property (nonatomic, assign) OrderType orderType;

@end

@implementation PayFailure_VC

- (instancetype)initWithIsZhiFiBaoOrWeiXin:(NSString *)sZhifuboaOrWeixin
                                 OrderType:(OrderType)orderType
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
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
        if ([sZhifuboaOrWeixin isEqualToString:@"zhifubao"]) {
            self.arrSelect = [NSMutableArray arrayWithObjects:@"1", @"0", nil];
            self.bShowWeiXinPay = NO;
        }
        else
        {
            self.arrSelect = [NSMutableArray arrayWithObjects:@"0", @"1", nil];
            self.bShowWeiXinPay = YES;
        }
    }
    return self;
}

- (void)tapLeft
{
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
        
        if ([YKSUserDefaults isUserIndividual]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"GoToTabBarThree" object:nil];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"GoToTabBarTwo" object:nil];
        }
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tbMain];
    [self.view addSubview:self.vFailureHint];
    
    [self addNavigationType:YKSDefaults NavigationTitle:@"支付结果"];
    
    [self.vFailureHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.vNavigation.mas_bottom);
        make.height.mas_equalTo(190);
    }];
    
    
    [self.tbMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.vFailureHint.mas_bottom).offset(0);
    }];
    
    [self.vFailureHint loadViewOrderNumber:self.sOrderNumber MoneyNumber:self.sOrderMoney];
}



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


- (PayFootView *)vFoot
{
    if (!_vFoot) {
        WS(weakSelf);
        _vFoot = [[PayFootView alloc] initWithTap:^{
            if ([weakSelf.arrSelect[0] isEqualToString:@"1"]) { // 支付宝
                weakSelf.block(YES);
                [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
            else  // 微信
            {
                weakSelf.block(NO);
                [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
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

- (PayFailureHintView *)vFailureHint
{
    if (!_vFailureHint) {
        _vFailureHint = [[PayFailureHintView alloc] init];
        _vFailureHint.backgroundColor = [UIColor whiteColor];
    }
    return _vFailureHint;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
