//
//  ViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//


#import "LoginViewController.h"
#import "LoginButton.h"
#import "SignViewController.h"
#import "ForgetPwdViewController.h"
#import "PhoneView.h"
#import "PwdView.h"
#import "LoginMessageModel.h"
#import "AppDelegate.h"
#import "YKSUserDefaults.h"
#import "HTFMDBTool.h"
#import "CartZXNModel.h"
#import "ZXNTool.h"


static NSString * const kLoginInURL = @"/user/login";


@interface LoginViewController (){
    PhoneView *phoneText;
    PwdView *passwordtext;
    LoginMessageModel * loginMessageModel;
}

@property (nonatomic, copy) NSString *sChangePassword;

@property (nonatomic, assign) BOOL isLogin;


@end

@implementation LoginViewController

- (instancetype)initWithIsChangePassword:(NSString *)sChangePassword
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.sChangePassword = sChangePassword;
    }
    return self;
}

- (instancetype)initWithLogin:(BOOL)isLogin
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.isLogin = isLogin;
    }
    return self;
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
    // 开启
    self.tabBarController.tabBar.hidden = NO;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.tabBarController.tabBar.hidden = YES;
    [self checkForAutoLogin];
}

-(void)checkForAutoLogin
{
    if ([YKSUserDefaults shareInstance].sUser_Mobile.length != 0) {
        phoneText.phoneTxt.text = [YKSUserDefaults shareInstance].sUser_Mobile;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *vBack = [[UIView alloc] initWithFrame:CGRectMake(0, 13 + kDisNavgation, kDisWidth, 88.5)];
    vBack.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vBack];
    
    UIView *vLine = [[UIView alloc] init];
    vLine.frame = CGRectMake(20, 44, kDisWidth - 20, 0.5);
    vLine.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
    [vBack addSubview:vLine];
    
    
    phoneText=[[PhoneView alloc] initWithFrame:CGRectMake(0.0, 0.0, kDisWidth-20, 44.0)];
    phoneText.phoneTxt.placeholder=@"手机号/用户名";
    [vBack addSubview:phoneText];
    
    passwordtext = [[PwdView alloc] initWithFrame:CGRectMake(0.0, phoneText.bottom, kDisWidth-20, 44.0)];
    passwordtext.labText=@"密码";
    passwordtext.placeText=@"请输入密码";
    [vBack addSubview:passwordtext];
    
    LoginButton *loginBtn = [[LoginButton alloc] initWithFrame:CGRectMake(20, vBack.bottom + 15, vBack.width - 40, 35)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self  action:@selector(loginn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kDisWidth - 85, loginBtn.bottom + 10, 73, 20)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor clearColor]];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    if(self.isLogin){
        [self addNavigationType:YKS_Title_RightTwo NavigationTitle:@"登录"];
    }else{
        [self addNavigationType:YKS_Left_Title_RightTwo NavigationTitle:@"登录"];
    }
    [self.btnRigthTwo setTitle:@"注册" forState:UIControlStateNormal];
    [self.btnRigthTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnRigthTwo.titleLabel.font = kFont16;
}

- (void)back
{
    if (self.sChangePassword.length == 0 || self.sChangePassword == nil) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        if ([self.sChangePassword isEqualToString:@"C_Password"]) {
            // 返回用户个人中心
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            // 返回用户个人中心
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate changeRootView:YES cutSomeController:3];
        }
    }
}



-(void)forgetPassword
{
    ForgetPwdViewController *forgetVC=[[ForgetPwdViewController alloc] init];
    [self YKSRootPushViewController:forgetVC];
}

#pragma mark --登录

- (void)loginn{
    
    NSString *sUserName = phoneText.phoneTxt.text;
    if (sUserName.length == 0) {
        [self.view makeToast:@"账号不能为空" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (sUserName.length < 4 || sUserName.length > 20) {
        [self.view makeToast:@"账号长度必须为4-20个字符" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    NSString *regex1 =@"^[\\w\\-\\_\\x{4e00}-\\x{9fa5}][\\w\\d\\-\\_\\x{4e00}-\\x{9fa5}]{3,19}$";
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex1];
    if (![pred1 evaluateWithObject:sUserName]) {
        [self.view makeToast:@"账号可以由 数字、字母、中文、-、_ 组成，不能包含其他字符" duration:2.0 position:CSToastPositionCenter];
        return;
    }
    
    NSString *sPassWord = passwordtext.pwdTxt.text;
    
    if (sPassWord.length == 0) {
        [self.view makeToast:@"密码不能为空" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    //    if (sPassWord.length < 6 || sPassWord.length > 20) {
    //        [self.view makeToast:@"密码长度必须为6-20个字符" duration:1.0 position:CSToastPositionCenter];
    //        return;
    //    }
    //
    //    NSString *regex2 = @"^(?![0-9]+$)(?![a-zA-Z]+$)(?!([^(0-9a-zA-Z)]|[\\(\\)])+$)([^(0-9a-zA-Z)]|[\\(\\)]|[a-zA-Z]|[0-9]){6,20}$";
    //
    //    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //    if (![pred2 evaluateWithObject:sPassWord]) {
    //        [self.view makeToast:@"密码必须是数字、字母、符号，任意两种组合以上" duration:2.0 position:CSToastPositionCenter];
    //        return;
    //    }

    
    
    [HTLoadingTool showLoadingStringDontOperation:@"登录中..."];
    NSDictionary *dic = @{
                          @"user_name":phoneText.phoneTxt.text,
                          @"password":passwordtext.pwdTxt.text,
                          @"type":@"ios"
                          };
    
    [AFHTTPClient POSTNODismiss:kLoginInURL params:dic successInfo:^(ResponseModel *response) {
        
        [HTLoadingTool disMissForWindow];
        //解析数据
        id json = @{@"data":response.dataResponse};
        [self batchAddCommodityCart:json sUserName:sUserName];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        [HTLoadingTool disMissForWindow];
        
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

/// 同步购物车数据
- (void)batchAddCommodityCart:(id)json sUserName:(NSString *)sUserName
{
    HTFMDBTool *db = [HTFMDBTool shareInstance];
    [db querySQL:@"select * from cart_tb" block:^(NSMutableArray *obj) {
        NSMutableArray *arrData = [NSMutableArray array];
        for (NSDictionary *dic in obj) {
            NSMutableDictionary *dicData = [NSMutableDictionary dictionary];
            [dicData setValue:dic[@"sCommodityID"] forKey:@"goods_id"];
            [dicData setValue:dic[@"sNumber"] forKey:@"quantity"];
            [arrData addObject:dicData];
        }
        
        if (arrData.count != 0) {
            NSString *sJson = [ZXNTool getJSONString:arrData];
            NSDictionary *dic = @{@"goods_list":sJson};
            [HTLoadingTool showLoadingStringDontOperation:@"购物车数据同步中..."];
            [AFHTTPClient POSTNODismiss:@"/cart/batchAdd" params:dic successInfo:^(ResponseModel *response) {
                
                [db execSQL:@"DELETE FROM cart_tb" withBlock:^(BOOL bRet) {
                    [self loginnRefresh:json sUserName:sUserName];
                }];
                
            } flaseInfo:^(ResponseModel *response, HTTPType type) {
                [db execSQL:@"DELETE FROM cart_tb" withBlock:^(BOOL bRet) {
                    [self loginnRefresh:json sUserName:sUserName];
                }];
            }];
        }
        else
        {
            [self loginnRefresh:json sUserName:sUserName];
        }
    }];
}



- (void)loginnRefresh:(id)json sUserName:(NSString *)sUserName
{
    // 储存用户信息
    [YKSUserDefaults storeUserInfo:json];
    [YKSUserDefaults storeUserPassword:passwordtext.pwdTxt.text];
    [HTLoadingTool disMissForWindow];
    
    //判断当前用户是否是C端用户，是则提示用户去官网链接升级账号
    if([YKSUserDefaults isUserIndividual]){
        [self alertMsg:sUserName];
        return ;
    }
    
    // 普通页面进入走以下逻辑
    if (self.sChangePassword.length == 0 || self.sChangePassword == nil) {
        if ([YKSUserDefaults isUserIndividual])
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            // 返回经销商个人中心
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate changeRootView:NO cutSomeController:4];
        }
    }
    else
    {
        // 从修改密码界面进入的登录页面走以下逻辑
        if ([self.sChangePassword isEqualToString:@"C_Password"]) {
            
            // C端修改密码界面进入后登录逻辑
            if ([YKSUserDefaults isUserIndividual])
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else
            {
                // 返回经销商个人中心
                AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [appDelegate changeRootView:NO cutSomeController:4];
            }
        }
        else
        {
            // B端修改密码界面进入后登录逻辑
            if ([YKSUserDefaults isUserIndividual])
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else
            {
                // 返回用户个人中心
                AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [appDelegate changeRootView:YES cutSomeController:3];
            }
        }
    }
    
}

- (void)logout{
    [self.view makeToast:@"注销中..." duration:1.0 position:CSToastPositionCenter];
   
    NSDictionary *dic = nil;
    
    [AFHTTPClient POST:@"/user/logout" params:dic successInfo:^(ResponseModel *response) {
        
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
    
    [YKSUserDefaults deleteAllUserInfo];
    [YKSUserDefaults deleteUserPassword];
    
    // 返回个人中心
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate changeRootView:YES cutSomeController:3];
}

- (void)alertMsg:(NSString *)sUserName{
   
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"C端账号升级告知书" message:@"尊敬的客户：\n\t您好！即日起海豚供应链将不再支持C端用户访问，如果您想继续购买海豚供应链的商品，请点击跳转访问官网链接，升级账号。给您带来的不便，敬请谅解，感谢您的支持！   \n\n\t\t\t\t\t海豚供应链" preferredStyle:UIAlertControllerStyleAlert];
    
    float floatString = [[[UIDevice currentDevice] systemVersion] floatValue];
    UIView *subView1 = alert.view.subviews[0];
    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
    UILabel *message = [[UILabel alloc]init];
    //适配iOS12
    if (floatString < 12){
        message = subView5.subviews[1];
    }else{
        message = subView5.subviews[2];
    }
    message.textAlignment = NSTextAlignmentLeft;
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"我清楚了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString * url = [NSString stringWithFormat:@"https://www.dolphinsc.com/Index/goGuideUpgrade.html?account=%@",sUserName];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        [self logout];
    }];
    
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)tapRightTwo
{
    SignViewController *signVC = [[SignViewController alloc] init];
    [self YKSRootPushViewController:signVC];
}

//点击空白收回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)enumrateSubviewsInView:(UIView *)view message:(NSString*)message msgAlignment:(NSTextAlignment)msgAlignment {
    NSArray *subViews = view.subviews;
    if (subViews.count == 0) {
        return;
    }
    for (NSInteger i = 0; i < subViews.count; i++) {
        UIView *subView = subViews[i];
        [self enumrateSubviewsInView:subView message:message msgAlignment:msgAlignment];
        
        if ([subView isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)subView;
            if ([label.text isEqualToString:message]) {
                label.textAlignment = msgAlignment;
            }
        }
    }
}

@end
