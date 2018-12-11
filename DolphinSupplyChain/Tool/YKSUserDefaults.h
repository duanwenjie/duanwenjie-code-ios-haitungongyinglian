//
//  YKSUserDefaults.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/6.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>

// C类购买  B类采购
typedef NS_ENUM(NSInteger, BuyType) {
    C_Pay      = 0,     // C类购买
    B_Pay      = 1      // B类采购
};


// 境外商品订单  国内商品订单
typedef NS_ENUM(NSInteger, OrderType) {
    JingWai_Order      = 0,     // 境外商品订单
    GuoNei_Order       = 1      // 境外商品订单
};



@interface YKSUserDefaults : NSObject

/// 用户生日
@property (nonatomic, copy) NSString *sUser_Birthday;

/// 用户邮箱
@property (nonatomic, copy) NSString *sUser_Email;

/// 用户头像URL
@property (nonatomic, copy) NSString *sUser_ImageURL;

/// 用户手机号码
@property (nonatomic, copy) NSString *sUser_Mobile;

/// 用户名称
@property (nonatomic, copy) NSString *sUser_Name;

/// 用户昵称
@property (nonatomic, copy) NSString *sUser_Nick;

/// 用户二次登录Key
@property (nonatomic, copy) NSString *sUser_PasswordKey;

/// 用户QQ
@property (nonatomic, copy) NSString *sUser_QQ;

/// 用户性别
@property (nonatomic, copy) NSString *sUser_Sex;

/// 用户ID
@property (nonatomic, copy) NSString *sUser_ID;

/// 用户账号名称（只能修改一次，可以用于登录）
@property (nonatomic, copy) NSString *sUser_Account;

/// 用户类型 C端用户（-1） B端用户（0）
@property (nonatomic, copy) NSString *sUser_Type;

/// 用户微信号
@property (nonatomic, copy) NSString *sUser_Wechat;

/// 用户标签
@property (nonatomic, copy) NSString *sUser_Ticket;

/// 用户是否登录 YES表示已登录 NO表示未登录
@property (nonatomic, assign) BOOL bLogin;

/// 用户是个人用户还是经销商 YES表示个人 NO表示经销商
@property (nonatomic, assign) BOOL bUserType;

/// 使用者是否有调用支付的权限 YES表示有支付权限 NO表示无支付权限
@property (nonatomic, assign) BOOL bCanPay;

/// 环境所用的HTTPURL
@property (nonatomic, copy) NSString *sHTTPURL;

/// 账号拥有者购物车数量
@property (nonatomic, copy) NSString *sNumberCart;

/**
 构造单例方法
 
 @return 实例对象
 */
+ (instancetype)shareInstance;


/**
 储存用户登录信息
 
 @param dicInfo 登录返回的NSDictionary
 */
+ (void)storeUserInfo:(NSDictionary *)dicInfo;


/**
 获取所有用户数据
 */
+ (void)readUserInfo;


/**
 储存用户明文密码
 
 @param sPassword 明文密码
 */
+ (void)storeUserPassword:(NSString *)sPassword;


/**
 获取用户明文密码
 
 @return 明文密码
 */
+ (NSString *)readUserPassword;


/**
 清除用户明文密码
 */
+ (void)deleteUserPassword;


/**
 清除用户信息--不包括清除用户账号及用户明文密码
 */
+ (void)deleteAllUserInfo;


/**
 更新Ticket
 
 @param sTicket 新的Ticket
 */
+ (void)upDateUser_Ticket:(NSString *)sTicket;


/**
 获取用户标签
 
 @return 用户标签
 */
+ (NSString *)gainTicKet;


/**
 是否在登录态

 @return YES表示在登录态 NO表示无登录态
 */
+ (BOOL)isLogin;


/**
 是否是个人用户还是经销商用户

 @return YES表示是个人用户 NO表示经销商用户
 */
+ (BOOL)isUserIndividual;



/**
 是否有进入支付宝或微信支付权限

 @return YES表示有支付权限 NO表示无支付权限
 */
+ (BOOL)isHavePayPower;


/**
 储存用户购物车数量
 
 @param sNumber 明文密码
 */
+ (void)storeCartNumber:(NSString *)sNumber;

/**
 更新用户购物车数量
 
 @param sNumber 新的Ticket
 */
+ (void)upDateCartNumber:(NSString *)sNumber;


/**
 获取用户购物车数量
 
 @return 用户购物车数量
 */
+ (NSString *)gainCartNumber;

//**********************************不常用**********************************

/**
 更新生日
 
 @param sBirthday 新的生日
 */
- (void)upDateUser_Birthday:(NSString *)sBirthday;

/**
 更新邮箱
 
 @param sEmail 新的邮箱
 */
- (void)upDateUser_Email:(NSString *)sEmail;

/**
 更新头像链接
 
 @param sImageURL 新的头像链接
 */
- (void)upDateUser_ImageURL:(NSString *)sImageURL;

/**
 更新移动电话号码
 
 @param sMobile 新的移动电话号码
 */
- (void)upDateUser_Mobile:(NSString *)sMobile;

/**
 更新用户名
 
 @param sName 新的用户名
 */
- (void)upDateUser_Name:(NSString *)sName;


/**
 更新昵称
 
 @param sNick 新的昵称
 */
- (void)upDateUser_Nick:(NSString *)sNick;

/**
 更新PasswordKey
 
 @param sPasswordKey 新的Key
 */
- (void)upDateUser_PasswordKey:(NSString *)sPasswordKey;


/**
 更新QQ号码
 
 @param sQQ 新的QQ
 */
- (void)upDateUser_QQ:(NSString *)sQQ;


/**
 更新性别
 
 @param sSex 新的性别
 */
- (void)upDateUser_Sex:(NSString *)sSex;


/**
 更新用户ID
 
 @param sID 新的ID
 */
- (void)upDateUser_ID:(NSString *)sID;


/**
 更新用户账号名
 
 @param sAccount 新的用户账号名
 */
- (void)upDateUser_Account:(NSString *)sAccount;


/**
 更新用户类型
 
 @param sType 新的类型
 */
- (void)upDateUser_Type:(NSString *)sType;


/**
 更新微信号
 
 @param sWechat 新的微信号
 */
- (void)upDateUser_Wechat:(NSString *)sWechat;



/**
 获取环境所在的HTTPURL
 
 @return HTTPURL
 */
- (NSString *)gainHTTPURL;


/**
 更新环境所在的HTTPURL
 
 @param sType HTTPURLType
 */
- (void)upDateHTTPURLType:(NSString *)sType;


@end
