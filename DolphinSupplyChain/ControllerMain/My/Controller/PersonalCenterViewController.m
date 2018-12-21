//
//  PersonalCenterViewController.m
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "PersonalCenterViewController.h"

#import "LoginViewController.h"
#import "SetupViewController.h"
#import "CollectBuy_VC.h"
#import "Message_VC.h"
#import "UserInformationController.h"
#import "ShopingCart_VC.h"
#import "MyAddressList_VC.h"
#import "OrderList_VC.h"

#import "PersonalImageHeadView.h"
#import "PersonalOrderCell.h"

#import "ShareTool.h"
#import "StorageViewController.h"

#import "HaiTunVIP_VC.h"

@interface PersonalCenterViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) HTTabbleView *tbMain;

@property (nonatomic, assign) BOOL bPersonalUser;

@property (nonatomic, strong) PersonalImageHeadView *headView;

@property (nonatomic, strong) NSArray *arrCellNameData;

@property (nonatomic, strong) NSArray *arrCellImageData;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, copy) NSString *sNeedPay;

@property (nonatomic, copy) NSString *sNeedDelivery;

@property (nonatomic, copy) NSString *sShipped;

@end

@implementation PersonalCenterViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.sNeedPay = @"";
        self.sNeedDelivery = @"";
        self.sShipped = @"";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GoShoppingCart) name:@"GOShoppingCart" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GoOrderList) name:@"GOOrderList" object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //主界面
    [self drawMainView];
}



#pragma mark - 设置列表数据
- (void)settingUserList
{
    self.arrCellNameData = @[@[@"我的收藏", @"我的地址"],
                             @[@"联系客服", @"推荐给好友"]];
    self.arrCellImageData = @[@[@"Personal_Center_Collect", @"Personal_Center_ Address"],
                              @[@"Personal_Center_Service", @"Personal_Center_Recommend"]];
    /*
    self.arrCellNameData = @[@[@"我的收藏", @"我的地址"],
                             @[@"海豚会员", @"联系客服", @"推荐给好友"]];
    self.arrCellImageData = @[@[@"Personal_Center_Collect", @"Personal_Center_ Address"],
                              @[@"Personal_Center_Member", @"Personal_Center_Service", @"Personal_Center_Recommend"]];
    */
}

- (void)settingDealersList
{
    /*
    self.arrCellNameData = @[@[@"购物车", @"我的微仓", @"我的收藏", @"我的地址"],
                             @[@"海豚会员", @"联系客服", @"推荐给好友"]];
    self.arrCellImageData = @[@[@"Personal_Center_Cart", @"Personal_Center_Warehouse", @"Personal_Center_Collect", @"Personal_Center_ Address"],
                              @[@"Personal_Center_Member", @"Personal_Center_Service", @"Personal_Center_Recommend"]];
    */
//    self.arrCellNameData = @[@[@"购物车", @"我的微仓", @"我的收藏", @"我的地址"],
//                             @[@"联系客服", @"推荐给好友"]];
//    self.arrCellImageData = @[@[@"Personal_Center_Cart", @"Personal_Center_Warehouse", @"Personal_Center_Collect", @"Personal_Center_ Address"],
//                              @[@"Personal_Center_Service", @"Personal_Center_Recommend"]];
    
    self.arrCellNameData = @[@[@"购物车", @"我的微仓", @"我的收藏"],
                             @[@"联系客服", @"推荐给好友"]];
    self.arrCellImageData = @[@[@"Personal_Center_Cart", @"Personal_Center_Warehouse", @"Personal_Center_Collect"],
                              @[@"Personal_Center_Service", @"Personal_Center_Recommend"]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 用来判断是否是个人 还是 经销商
    if (![YKSUserDefaults isUserIndividual]) {
        // 经销商
        self.bPersonalUser = NO;
        [self settingDealersList];
    }
    else
    {
        // 个人
        self.bPersonalUser = YES;
        [self settingUserList];
    }
    [self.tbMain reloadData];
    
    [self.headView isShowLogin:[YKSUserDefaults isLogin]];
    if ([YKSUserDefaults isLogin]) {
        [self messageGet];
    }
    
    // 禁用 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.activityView stopAnimating];
    
    // 开启
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}


- (void)drawMainView
{
    self.tbMain = [[HTTabbleView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tbMain.dataSource = self;
    self.tbMain.delegate = self;
    self.tbMain.backgroundColor = [UIColor clearColor];
    self.tbMain.contentInset = UIEdgeInsetsMake(145, 0, 0, 0);
    self.tbMain.showsVerticalScrollIndicator = NO;
    
//    self.tbMain.estimatedRowHeight = 0;
//    self.tbMain.estimatedSectionHeaderHeight = 0;
//    self.tbMain.estimatedSectionFooterHeight = 0;
    
    [self.view addSubview:self.tbMain];
    
    
    
    WS(weakSelf);
    self.headView = [[PersonalImageHeadView alloc] initWithTapSelfViewIsLogin:[YKSUserDefaults isLogin] TapBlock:^{
        
        if (![YKSUserDefaults isLogin]) {  // 不在登录态
            LoginViewController *VC = [[LoginViewController alloc] init];
            [weakSelf YKSRootPushViewController:VC];
        }
        else {  // 在登录态，进入个人信息中心
            
            UserInformationController *userInfo_VC = [[UserInformationController alloc] init];
            [weakSelf YKSRootPushViewController:userInfo_VC];
        }
    }];
    self.headView.frame = CGRectMake(0, -145, kDisWidth, 200);
    [self.tbMain insertSubview:self.headView atIndex:0];
    
    [self.view addSubview:self.activityView];
    
    [self.tbMain setContentOffset:CGPointMake(0, -145) animated:NO];
    
    [self addNavigationType:YKS_Title_RightOne_RightTwo NavigationTitle:@""];
    self.fNavigationBackViewAlpha = 0;
    [self.btnRigthTwo setImage:[UIImage drawImageWithName:@"Personal_Center_Setting_Message" size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    [self.btnRigthOne setImage:[UIImage drawImageWithName:@"Personal_Center_Setting" size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    
    
    [self.tbMain mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
}

#pragma mark - 进入购物车
- (void)GoShoppingCart
{
    ShopingCart_VC *cart_VC = [[ShopingCart_VC alloc] init];
    cart_VC.bBottom = YES;
    [self YKSRootPushViewController:cart_VC];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GOShoppingCart" object:nil];
}

- (void)GoOrderList
{
    OrderList_VC *orderList_VC = [[OrderList_VC alloc] initWithOrderType:3];
    [self YKSRootPushViewController:orderList_VC];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GOOrderList" object:nil];
}


#pragma mark -
#pragma mark 跳转至设置中心
- (void)tapRightOne
{
    SetupViewController *Setup_VC = [[SetupViewController alloc] init];
    [self YKSRootPushViewController:Setup_VC];
}

- (void)tapRightTwo
{
    Message_VC *message_VC = [[Message_VC alloc] init];
    [self YKSRootPushViewController:message_VC];
}



#pragma mark－加载用户信息
- (void)messageGet
{
    [self.activityView startAnimating];
    NSDictionary *dic = @{@"type":@"self_all"};
    
    [AFHTTPClient POST:@"/COrder/getTotal" params:dic successInfo:^(ResponseModel *response) {
        [self.activityView stopAnimating];
        self.sNeedPay = response.dataResponse[@"self_need_pay"];
        self.sNeedDelivery = response.dataResponse[@"self_need_delivery"];
        self.sShipped = response.dataResponse[@"shipped"];
        [self.tbMain reloadData];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        [self.activityView stopAnimating];
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
    
}

#pragma mark tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 30;
    }
    return 5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 0.01;
    }
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }
    else
    {
        NSArray *array = self.arrCellNameData[section - 1];
        return array.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
//        PersonalOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
//        if (cell == nil) {
//
//            cell = [[PersonalOrderCell alloc] initWithReuseIdentifier:@"OrderCell" tapSomeButton:^(PersonalOrderType type) {
//
//                NSInteger i = 0;
//                switch (type) {
//                    case AllOrder: // 全部订单回调
//                        i = 0;
//                        break;
//                    case Payment:  // 待付款回调
//                        i = 1;
//                        break;
//                    case Shipments:// 待发货回调
//                        i = 2;
//                        break;
//                    case GatherGoods: // 待收货回调
//                        i = 3;
//                        break;
//                }
//
//                if (![YKSUserDefaults isLogin]) {  // 不在登录态
//                    LoginViewController *VC = [[LoginViewController alloc] init];
//                    [self YKSRootPushViewController:VC];
//                }
//                else {  // 在登录态
//
//                    OrderList_VC *orderList_VC = [[OrderList_VC alloc] initWithOrderType:i];
//                    [self YKSRootPushViewController:orderList_VC];
//                }
//
//            }];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        if (![YKSUserDefaults isLogin]) {  // 不在登录态
//            [cell loadView:@"" Shipment:@"" GatherGoods:@""];
//        }
//        else {  // 在登录态
//            [cell loadView:self.sNeedPay Shipment:self.sNeedDelivery GatherGoods:self.sShipped];
//        }
//
//        return cell;
        
        UITableViewCell * cell = [[UITableViewCell alloc]initWithFrame:CGRectZero];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellIdentifier"];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *array1 = self.arrCellNameData[indexPath.section - 1];
        NSArray *array2 = self.arrCellImageData[indexPath.section - 1];
        cell.textLabel.text = array1[indexPath.row];
        
        cell.imageView.image = [self drawImageWithName:array2[indexPath.row]];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.section) {
        case 1:
        {
            if (self.bPersonalUser)
            {
                if (![YKSUserDefaults isLogin]) {  // 不在登录态
                    LoginViewController *VC = [[LoginViewController alloc] init];
                    [self YKSRootPushViewController:VC];
                    break;
                }
                
                if (indexPath.row == 0) {
                    
                    CollectBuy_VC *vc = [[CollectBuy_VC alloc] init];
                    [self YKSRootPushViewController:vc];
                }
                else
                {
                    MyAddressList_VC *address_VC = [[MyAddressList_VC alloc] initWithIsSeletReceivingComeIn:NO DefaultAddressID:nil SelectReceivingAddress:nil];
                    [self YKSRootPushViewController:address_VC];
                }
            }
            else
            {
                if (![YKSUserDefaults isLogin]) {  // 不在登录态
                    LoginViewController *VC = [[LoginViewController alloc] init];
                    [self YKSRootPushViewController:VC];
                    break;
                }
                
                if (indexPath.row == 0) {
                    ShopingCart_VC *cart_VC = [[ShopingCart_VC alloc] init];
                    cart_VC.bBottom = YES;
                    [self YKSRootPushViewController:cart_VC];
                    
                }
                else if (indexPath.row == 1)
                {
                    StorageViewController *vc = [[StorageViewController alloc] init];
                    [self YKSRootPushViewController:vc];
                }
                else if (indexPath.row == 2)
                {
                    CollectBuy_VC *vc = [[CollectBuy_VC alloc] init];
                    [self YKSRootPushViewController:vc];
                }
                else
                {
                    MyAddressList_VC *address_VC = [[MyAddressList_VC alloc] initWithIsSeletReceivingComeIn:NO DefaultAddressID:nil SelectReceivingAddress:nil];
                    [self YKSRootPushViewController:address_VC];
                }
            }
            
        }
            break;
        case 2:
        {
            /*
            if (indexPath.row == 0) {       // 海豚会员
                HaiTunVIP_VC *haitun_VIP = [[HaiTunVIP_VC alloc] init];
                [self YKSRootPushViewController:haitun_VIP];
            }
            else if (indexPath.row == 1)    // 联系客服
            {
                ContactServiceViewController *contactVC = [[ContactServiceViewController alloc] init];
                [self YKSRootPushViewController:contactVC];
            }
            else if (indexPath.row == 2)    // 推荐给好友
            {
                [ShareTool shareHaiTunAPP];
            }
            */

            if (indexPath.row == 0)    // 联系客服
            {
                ContactServiceViewController *contactVC = [[ContactServiceViewController alloc] init];
                [self YKSRootPushViewController:contactVC];
            }
            else if (indexPath.row == 1)    // 推荐给好友
            {
                [ShareTool shareHaiTunAPP];
            }
            
        }
            break;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat down = scrollView.contentOffset.y;
    // 如果down大于 -145 那么意味着视图往上滚动 故该Image的Y坐标不变，高度不变
    if (down > -145) {
        if (down >= -65) {
            if (self.lblTitle.text.length == 0)
            {
                [UIView animateWithDuration:0.4 animations:^{
                    self.fNavigationBackViewAlpha = 1;
                }];
                self.lblTitle.text = @"个人中心";
            }
        }
        else
        {
            if (self.lblTitle.text.length != 0)
            {
                [UIView animateWithDuration:0.4 animations:^{
                    self.fNavigationBackViewAlpha = 0;
                }];
                self.lblTitle.text = @"";
            }
        }
        down = 0;
    }
    else
    {
        // 如果down小于 -145 那么意味着视图往下滚动 故该Image的Y坐标变小，高度变高 ImageView的Y坐标随ScrollView的Y坐标的变小而变小，高度随ScrollView的Y坐标变小而变大
        down -= -145;
        
        // 获取ImageView的坐标信息
        CGRect frame = self.headView.frame;
        frame.size.height = -down + 145;
        frame.origin.y = -145 + down;
        self.headView.frame = frame;
    }
}


#pragma mark 绘制图片
- (UIImage *)drawImageWithName:(NSString *)sender
{
    UIImage *icon = [UIImage imageNamed:sender];
    CGSize itemSize = CGSizeMake(32, 32);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    
    icon = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return icon;
}

- (UIActivityIndicatorView *)activityView
{
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.frame = CGRectMake(kDisWidth/2 - 10, kDisHeight/2 - 10, 20, 20);
        //当旋转结束时隐藏
        [_activityView setHidesWhenStopped:YES];
    }
    return _activityView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
