//
//  YKSUserDefaults.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/6.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "YKSUserDefaults.h"



@implementation YKSUserDefaults

/**
 构造单例方法
 
 @return 实例对象
 */
+ (instancetype)shareInstance
{
    static YKSUserDefaults *UserDefaults;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UserDefaults = [[YKSUserDefaults alloc] init];
    });
    return UserDefaults;
}

+ (BOOL)isLogin
{
    return [[YKSUserDefaults shareInstance] isLoginSelf];
}

- (BOOL)isLoginSelf
{
    return self.bLogin;
}

+ (BOOL)isUserIndividual
{
    return [[YKSUserDefaults shareInstance] isUserIndividualSelf];
}

- (BOOL)isUserIndividualSelf
{
    return self.bUserType;
}

+ (BOOL)isHavePayPower
{
    return [[YKSUserDefaults shareInstance] isHavePayPowerSelf];
}

- (BOOL)isHavePayPowerSelf
{
    return self.bCanPay;
}


/**
 储存用户登录信息

 @param dicInfo 登录返回的NSDictionary
 */
+ (void)storeUserInfo:(NSDictionary *)dicInfo
{
    [[YKSUserDefaults shareInstance] caseStoreUserInfo:dicInfo];
}

- (void)caseStoreUserInfo:(NSDictionary *)dicInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.sUser_Birthday    = dicInfo[@"data"][@"birthday"];
    self.sUser_Email       = dicInfo[@"data"][@"email"];
    self.sUser_ImageURL    = dicInfo[@"data"][@"image_url"];
    self.sUser_Mobile      = dicInfo[@"data"][@"mobile_phone"];
    self.sUser_Name        = dicInfo[@"data"][@"name"];
    self.sUser_Nick        = dicInfo[@"data"][@"nick"];
    self.sUser_PasswordKey = dicInfo[@"data"][@"password_key"];
    self.sUser_QQ          = dicInfo[@"data"][@"qq"];
    self.sUser_Sex         = dicInfo[@"data"][@"sex"];
    self.sUser_ID          = dicInfo[@"data"][@"user_id"];
    self.sUser_Account     = dicInfo[@"data"][@"user_name"];
    self.sUser_Type        = dicInfo[@"data"][@"user_type"];
    self.sUser_Wechat      = dicInfo[@"data"][@"wechat"];
    self.sUser_Ticket      = dicInfo[@"ticket"];
    
    
    [userDefaults setValue:self.sUser_Birthday forKey:@"YKSBirthday"];
    [userDefaults setValue:self.sUser_Email forKey:@"YKSEmail"];
    [userDefaults setValue:self.sUser_ImageURL forKey:@"YKSImageURL"];
    [userDefaults setValue:self.sUser_Mobile forKey:@"YKSMobile"];
    [userDefaults setValue:self.sUser_Name forKey:@"YKSName"];
    [userDefaults setValue:self.sUser_Nick forKey:@"YKSNick"];
    [userDefaults setValue:self.sUser_PasswordKey forKey:@"YKSPasswordKey"];
    [userDefaults setValue:self.sUser_QQ forKey:@"YKSQQ"];
    [userDefaults setValue:self.sUser_Sex forKey:@"YKSSex"];
    [userDefaults setValue:self.sUser_ID forKey:@"YKSUserID"];
    [userDefaults setValue:self.sUser_Account forKey:@"YKSUserName"];
    [userDefaults setValue:self.sUser_Type forKey:@"YKSUserType"];
    [userDefaults setValue:self.sUser_Wechat forKey:@"YKSWechat"];
    [userDefaults setValue:self.sUser_Ticket forKey:@"YKSTicket"];
    
    [userDefaults setBool:YES forKey:@"YKS_Login"];
    
    [userDefaults synchronize];
    
    self.bLogin = YES;
    
    if ([self.sUser_Type isEqualToString:@"-1"]) {
        self.bUserType = YES;
    }
    else
    {
        self.bUserType = NO;
    }
    
    if ([self.sUser_Type isEqualToString:@"-1"] || [self.sUser_Type isEqualToString:@"0"]) {
        self.bCanPay = YES;
    }
    else
    {
        self.bCanPay = NO;
    }
}


/**
 获取所有用户数据
 */
+ (void)readUserInfo
{
    [[YKSUserDefaults shareInstance] caseReadUserInfo];
}

- (void)caseReadUserInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sUser_Birthday    = [userDefaults objectForKey:@"YKSBirthday"];
    self.sUser_Email       = [userDefaults objectForKey:@"YKSEmail"];
    self.sUser_ImageURL    = [userDefaults objectForKey:@"YKSImageURL"];
    self.sUser_Mobile      = [userDefaults objectForKey:@"YKSMobile"];
    self.sUser_Name        = [userDefaults objectForKey:@"YKSName"];
    self.sUser_Nick        = [userDefaults objectForKey:@"YKSNick"];
    self.sUser_PasswordKey = [userDefaults objectForKey:@"YKSPasswordKey"];
    self.sUser_QQ          = [userDefaults objectForKey:@"YKSQQ"];
    self.sUser_Sex         = [userDefaults objectForKey:@"YKSSex"];
    self.sUser_ID          = [userDefaults objectForKey:@"YKSUserID"];
    self.sUser_Account     = [userDefaults objectForKey:@"YKSUserName"];
    self.sUser_Type        = [userDefaults objectForKey:@"YKSUserType"];
    self.sUser_Wechat      = [userDefaults objectForKey:@"YKSWechat"];
    self.sUser_Ticket      = [userDefaults objectForKey:@"YKSTicket"];
    self.bLogin            = [userDefaults boolForKey:@"YKS_Login"];
    
    
    if (self.sUser_Birthday == nil) {
        self.sUser_Birthday = @"";
    }
    if (self.sUser_Email == nil) {
        self.sUser_Email = @"";
    }
    if (self.sUser_ImageURL == nil) {
        self.sUser_ImageURL = @"";
    }
    if (self.sUser_Mobile == nil) {
        self.sUser_Mobile = @"";
    }
    if (self.sUser_Name == nil) {
        self.sUser_Name = @"";
    }
    if (self.sUser_Nick == nil) {
        self.sUser_Nick = @"";
    }
    if (self.sUser_PasswordKey == nil) {
        self.sUser_PasswordKey = @"";
    }
    if (self.sUser_QQ == nil) {
        self.sUser_QQ = @"";
    }
    if (self.sUser_Sex == nil) {
        self.sUser_Sex = @"";
    }
    if (self.sUser_ID == nil) {
        self.sUser_ID = @"";
    }
    if (self.sUser_Account == nil) {
        self.sUser_Account = @"";
    }
    if (self.sUser_Type == nil) {
        self.sUser_Type = @"";
    }
    if (self.sUser_Wechat == nil) {
        self.sUser_Wechat = @"";
    }
    if (self.sUser_Ticket == nil) {
        self.sUser_Ticket = @"";
    }
    
    
    if ([self.sUser_Type isEqualToString:@"-1"] || self.sUser_Type.length == 0) {
        self.bUserType = YES;
    }
    else
    {
        self.bUserType = NO;
    }
    
    if ([self.sUser_Type isEqualToString:@"-1"] || [self.sUser_Type isEqualToString:@"0"]) {
        self.bCanPay = YES;
    }
    else
    {
        self.bCanPay = NO;
    }
}



/**
 储存用户明文密码

 @param sPassword 明文密码
 */
+ (void)storeUserPassword:(NSString *)sPassword
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:sPassword forKey:@"YKSPassword"];
    [userDefaults synchronize];
}


/**
 获取用户明文密码

 @return 明文密码
 */
+ (NSString *)readUserPassword
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"YKSPassword"];
}

/**
 清除用户明文密码
 */
+ (void)deleteUserPassword
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:@"" forKey:@"YKSPassword"];
    [userDefaults synchronize];
}


/**
 清除用户信息
 */
+ (void)deleteAllUserInfo
{
    [[YKSUserDefaults shareInstance] caseDeleteAllUserInfo];
}

- (void)caseDeleteAllUserInfo
{
    // 不清除电话号码
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.sUser_Birthday    = @"";
    self.sUser_Email       = @"";
    self.sUser_ImageURL    = @"";
    self.sUser_Name        = @"";
    self.sUser_Nick        = @"";
    self.sUser_PasswordKey = @"";
    self.sUser_QQ          = @"";
    self.sUser_Sex         = @"";
    self.sUser_ID          = @"";
    self.sUser_Account     = @"";
    self.sUser_Type        = @"";
    self.sUser_Wechat      = @"";
    self.sUser_Ticket      = @"";
    self.sNumberCart       = @"";
    
    [userDefaults setValue:self.sUser_Birthday forKey:@"YKSBirthday"];
    [userDefaults setValue:self.sUser_Email forKey:@"YKSEmail"];
    [userDefaults setValue:self.sUser_ImageURL forKey:@"YKSImageURL"];
    [userDefaults setValue:self.sUser_Name forKey:@"YKSName"];
    [userDefaults setValue:self.sUser_Nick forKey:@"YKSNick"];
    [userDefaults setValue:self.sUser_PasswordKey forKey:@"YKSPasswordKey"];
    [userDefaults setValue:self.sUser_QQ forKey:@"YKSQQ"];
    [userDefaults setValue:self.sUser_Sex forKey:@"YKSSex"];
    [userDefaults setValue:self.sUser_ID forKey:@"YKSUserID"];
    [userDefaults setValue:self.sUser_Account forKey:@"YKSUserName"];
    [userDefaults setValue:self.sUser_Type forKey:@"YKSUserType"];
    [userDefaults setValue:self.sUser_Wechat forKey:@"YKSWechat"];
    [userDefaults setValue:self.sUser_Ticket forKey:@"YKSTicket"];
    
    [userDefaults setValue:self.sUser_Ticket forKey:@"YKSCartNumber"];
    
    [userDefaults setBool:NO forKey:@"YKS_Login"];
    
    // 清除支付人姓名
    [userDefaults setValue:@"" forKey:@"YKS_Payer_Name"];
    // 清除支付人身份证
    [userDefaults setValue:@"" forKey:@"YKS_Payer_Number"];
    
    [userDefaults synchronize];
    
    self.bLogin = NO;
    self.bUserType = YES;
    self.bCanPay = NO;
    
}


/**
 获取用户标签

 @return 用户标签
 */
+ (NSString *)gainTicKet
{
    return [[YKSUserDefaults shareInstance] gainTicKetSelf];
}

- (NSString *)gainTicKetSelf
{
    return self.sUser_Ticket;
}

/**
 更新Ticket

 @param sTicket 新的Ticket
 */
+ (void)upDateUser_Ticket:(NSString *)sTicket
{
    [[YKSUserDefaults shareInstance] caseUpDateUser_TIcket:sTicket];
}

- (void)caseUpDateUser_TIcket:(NSString *)sTicket
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sUser_Ticket = sTicket;
    [userDefaults setValue:self.sUser_Ticket forKey:@"YKSTicket"];
    [userDefaults synchronize];
}


/**
 储存用户购物车数量
 
 @param sNumber 明文密码
 */
+ (void)storeCartNumber:(NSString *)sNumber
{
    [[YKSUserDefaults shareInstance] storeCartNumberSelf:sNumber];
}

- (void)storeCartNumberSelf:(NSString *)sNumber
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:sNumber forKey:@"YKSCartNumber"];
    [userDefaults synchronize];
}

/**
 更新用户购物车数量
 
 @param sNumber 新的Ticket
 */
+ (void)upDateCartNumber:(NSString *)sNumber
{
    [[YKSUserDefaults shareInstance] upDateCartNumberSelf:sNumber];
}

- (void)upDateCartNumberSelf:(NSString *)sNumber
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sNumberCart = sNumber;
    [userDefaults setValue:self.sNumberCart forKey:@"YKSCartNumber"];
    [userDefaults synchronize];
}


/**
 获取用户购物车数量
 
 @return 用户购物车数量
 */
+ (NSString *)gainCartNumber
{
    return [[YKSUserDefaults shareInstance] gainCartNumberSelf];
}

- (NSString *)gainCartNumberSelf
{
    return self.sNumberCart;
}



/**
 更新生日
 
 @param sBirthday 新的生日
 */
- (void)upDateUser_Birthday:(NSString *)sBirthday
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sUser_Birthday = sBirthday;
    [userDefaults setValue:self.sUser_Birthday forKey:@"YKSBirthday"];
    [userDefaults synchronize];
}

/**
 更新邮箱
 
 @param sEmail 新的邮箱
 */
- (void)upDateUser_Email:(NSString *)sEmail
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sUser_Email = sEmail;
    [userDefaults setValue:self.sUser_Email forKey:@"YKSEmail"];
    [userDefaults synchronize];
}

/**
 更新头像链接
 
 @param sImageURL 新的头像链接
 */
- (void)upDateUser_ImageURL:(NSString *)sImageURL
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sUser_ImageURL = sImageURL;
    [userDefaults setValue:self.sUser_ImageURL forKey:@"YKSImageURL"];
    [userDefaults synchronize];
}

/**
 更新移动电话号码
 
 @param sMobile 新的移动电话号码
 */
- (void)upDateUser_Mobile:(NSString *)sMobile
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sUser_Mobile = sMobile;
    [userDefaults setValue:self.sUser_Mobile forKey:@"YKSMobile"];
    [userDefaults synchronize];
}


/**
 更新用户名
 
 @param sName 新的用户名
 */
- (void)upDateUser_Name:(NSString *)sName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sUser_Name = sName;
    [userDefaults setValue:self.sUser_Name forKey:@"YKSName"];
    [userDefaults synchronize];
}


/**
 更新昵称
 
 @param sNick 新的昵称
 */
- (void)upDateUser_Nick:(NSString *)sNick
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sUser_Nick = sNick;
    [userDefaults setValue:self.sUser_Nick forKey:@"YKSNick"];
    [userDefaults synchronize];
}


/**
 更新PasswordKey
 
 @param sPasswordKey 新的Key
 */
- (void)upDateUser_PasswordKey:(NSString *)sPasswordKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sUser_PasswordKey = sPasswordKey;
    [userDefaults setValue:self.sUser_PasswordKey forKey:@"YKSPasswordKey"];
    [userDefaults synchronize];
}


/**
 更新QQ号码
 
 @param sQQ 新的QQ
 */
- (void)upDateUser_QQ:(NSString *)sQQ
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sUser_QQ = sQQ;
    [userDefaults setValue:self.sUser_QQ forKey:@"YKSQQ"];
    [userDefaults synchronize];
}


/**
 更新性别
 
 @param sSex 新的性别
 */
- (void)upDateUser_Sex:(NSString *)sSex
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sUser_Sex = sSex;
    [userDefaults setValue:self.sUser_Sex forKey:@"YKSSex"];
    [userDefaults synchronize];
}


/**
 更新用户ID
 
 @param sID 新的ID
 */
- (void)upDateUser_ID:(NSString *)sID
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sUser_ID = sID;
    [userDefaults setValue:self.sUser_ID forKey:@"YKSUserID"];
    [userDefaults synchronize];
}


/**
 更新用户账号名
 
 @param sAccount 新的用户账号名
 */
- (void)upDateUser_Account:(NSString *)sAccount
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sUser_Account = sAccount;
    [userDefaults setValue:self.sUser_Account forKey:@"YKSUserName"];
    [userDefaults synchronize];
}


/**
 更新用户类型
 
 @param sType 新的类型
 */
- (void)upDateUser_Type:(NSString *)sType
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sUser_Type = sType;
    [userDefaults setValue:self.sUser_Type forKey:@"YKSUserType"];
    [userDefaults synchronize];
}


/**
 更新微信号
 
 @param sWechat 新的微信号
 */
- (void)upDateUser_Wechat:(NSString *)sWechat
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sUser_Wechat = sWechat;
    [userDefaults setValue:self.sUser_Wechat forKey:@"YKSWechat"];
    [userDefaults synchronize];
}

/**
 获取环境所在的HTTPURL
 
 @return HTTPURL
 */
- (NSString *)gainHTTPURL
{
    if (self.sHTTPURL.length == 0) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString *sType = [userDefaults objectForKey:@"YKS_HTTP_URL_TYPE"];
        if (sType == nil) {
            [userDefaults setValue:@"Official" forKey:@"YKS_HTTP_URL_TYPE"];
            self.sHTTPURL = @"";
            [userDefaults synchronize];
        }
        else
        {
            if ([sType isEqualToString:@"Official"]) {
                self.sHTTPURL = @"https://api.dolphinsc.com%@";
            }
            else if ([sType isEqualToString:@"Test"]) {
                self.sHTTPURL = @"https://dev.app.haitun.hk/api_dev.php%@";
                // http://192.168.91.87:8888/haitun_new/api_local.php
                // https://api.prod.haitun.kokoerp.com
                //https://dev.haitun.kokoerp.com 
            }
            else
            {
                self.sHTTPURL = @"http://192.168.8.239:8282/huxiangyang/api_dev.php%@";
            }
        }
        return self.sHTTPURL;
    }
    return self.sHTTPURL;
}

/**
 更新环境所在的HTTPURL

 @param sType HTTPURLType
 */
- (void)upDateHTTPURLType:(NSString *)sType
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:sType forKey:@"YKS_HTTP_URL_TYPE"];
    [userDefaults synchronize];
    
    if ([sType isEqualToString:@"Official"]) {
        self.sHTTPURL = @"https://api.dolphinsc.com%@";
    }
    else if ([sType isEqualToString:@"Test"]) {
        self.sHTTPURL = @"https://dev.haitun.kokoerp.com/api_test.php%@";
        // http://192.168.91.87:8888/haitun_new/api_local.php
        // https://api.prod.haitun.kokoerp.com
    }
    else
    {
        self.sHTTPURL = @"https://dev.haitun.kokoerp.com/api_test.php%@";
    }
}

@end


