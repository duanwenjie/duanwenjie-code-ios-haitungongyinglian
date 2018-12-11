//
//  AppDelegate.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/28.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "AppDelegate.h"
#import <UMSocialCore/UMSocialCore.h>
#import "WeiXinTool.h"
#import "ZhiFuBaoTool.h"
#import "UMMobClick/MobClick.h"
#import "C_TabBarController.h"
#import "B_TabBarController.h"
#import "LoginViewController.h"

#define PGY_APPKEY @"78978d7dd0adfcc727b829cc7f5c4c8f"


@interface AppDelegate ()

@property (nonatomic, strong) C_TabBarController *User_VC;

@property (nonatomic, strong) B_TabBarController *Dealers_VC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 获取所有用户信息
    [YKSUserDefaults readUserInfo];
    
    // 监听网络状态
    [[AFHTTPClient shareInstance] AFNetworkStatus];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 用来判断是否是个人 还是 经销商
    if ([YKSUserDefaults isLogin]) {
        if (![YKSUserDefaults isUserIndividual]) {
            // 经销商
            self.window.rootViewController = self.Dealers_VC;
        }
        else
        {
            // 个人用户
            self.window.rootViewController = self.User_VC;
            LoginViewController * lg_VC = [[LoginViewController alloc]init];
            [lg_VC logout];
        }
    }
    else
    {
        // 个人用户
        self.window.rootViewController = self.User_VC;
    }
    
    // 自动登录
    [self AutomaticLogin];
    
    //向微信注册
    [WXApi registerApp:@"wx4bca32308537afe4" withDescription:@"DolphinSupplyChain_WX"];
    
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:NO];
    
    UMConfigInstance.appKey = @"55d7dc2fe0f55ac97c006a2c";
    UMConfigInstance.channelId = @"App Store";
    UMConfigInstance.ePolicy = BATCH; // 发送策略：启动发送
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    [MobClick setCrashReportEnabled:YES];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"55d7dc2fe0f55ac97c006a2c"];
    
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx4bca32308537afe4" appSecret:@"8c8089964cef095c3472619eda44d1e5" redirectURL:@"http://mobile.umeng.com/social"];
    
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1104723128"  appSecret:@"cJGP5HyEy8KKXCB2" redirectURL:@"http://mobile.umeng.com/social"];
    
    
    return YES;
}


/**
 切换TabBar
 @param bRootC 传入YES则切换到个人TabBar NO为切换为经销商
 */
- (void)changeRootView:(BOOL)bRootC
{
    for (UIView *view in [self.window subviews]) {
        [view removeFromSuperview];
    }
    self.User_VC = nil;
    self.Dealers_VC = nil;
    
    if (bRootC) { // 切换到个人用户TabBar
        self.window.rootViewController = self.User_VC;
    }
    else
    {
        self.window.rootViewController = self.Dealers_VC;
    }
}

/**
 切换TabBar 并跳转到指定的根控制器
 @param bRootC 入YES则切换到个人TabBar NO为切换为经销商
 @param iNumber 指定根控制器的下标
 */
- (void)changeRootView:(BOOL)bRootC cutSomeController:(NSInteger)iNumber
{
    for (UIView *view in [self.window subviews]) {
        [view removeFromSuperview];
    }
    self.User_VC = nil;
    self.Dealers_VC = nil;
    
    if (bRootC) { // 切换到个人用户TabBar
        self.User_VC.selectedIndex = iNumber;
        self.window.rootViewController = self.User_VC;
    }
    else
    {
        self.Dealers_VC.selectedIndex = iNumber;
        self.window.rootViewController = self.Dealers_VC;
    }
}

- (void)cutSomeController:(NSInteger)iNumber
{
    if ([YKSUserDefaults isUserIndividual]) {
        self.User_VC.selectedIndex = iNumber;
    }
    else
    {
        self.Dealers_VC.selectedIndex = iNumber;
    }
}



/**
 自动登录
 */
- (void)AutomaticLogin
{
    if ([YKSUserDefaults shareInstance].sUser_Mobile.length == 0 || [YKSUserDefaults readUserPassword].length == 0 || [YKSUserDefaults shareInstance].sUser_PasswordKey.length == 0) {
        return;
    }
    
    NSDictionary *dic = @{@"user_name":[YKSUserDefaults shareInstance].sUser_Mobile,
                          @"password":[YKSUserDefaults readUserPassword],
                          @"password_key":[YKSUserDefaults shareInstance].sUser_PasswordKey
                          };
    
    [AFHTTPClient POSTNODismiss:@"/user/login" params:dic successInfo:^(ResponseModel *response) {
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == NO_NETWORK)
        {
            if ([YKSUserDefaults isLogin]) {
                [YKSUserDefaults deleteAllUserInfo];
                [YKSUserDefaults deleteUserPassword];
                
                // 返回经销商个人中心
                [self changeRootView:YES cutSomeController:0];
            }
        }
    }];
}

#pragma mark - Delegate
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:[WeiXinTool shareInstance]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AlipaySDKPay" object:resultDic[@"userInfo"]];
        }];
        return YES;
    }
    else
    {
        return [WXApi handleOpenURL:url delegate:[WeiXinTool shareInstance]];
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AlipaySDKPay" object:resultDic[@"userInfo"]];
        }];
        return YES;
    }
    else
    {
        return [WXApi handleOpenURL:url delegate:[WeiXinTool shareInstance]];
    }

}

- (void)applicationWillResignActive:(UIApplication *)application {}


- (void)applicationDidEnterBackground:(UIApplication *)application {}


- (void)applicationWillEnterForeground:(UIApplication *)application {}


- (void)applicationDidBecomeActive:(UIApplication *)application {}


- (void)applicationWillTerminate:(UIApplication *)application {}


#pragma mark - 懒加载
- (C_TabBarController *)User_VC
{
    if (!_User_VC) {
        _User_VC = [[C_TabBarController alloc] init];
    }
    return _User_VC;
}

- (B_TabBarController *)Dealers_VC
{
    if (!_Dealers_VC) {
        _Dealers_VC = [[B_TabBarController alloc] init];
    }
    return _Dealers_VC;
}

@end
