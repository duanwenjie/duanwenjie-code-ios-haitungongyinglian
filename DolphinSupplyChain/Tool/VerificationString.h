//
//  VerificationString.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/1/13.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerificationString : NSObject

/**
 验证身份证号码
 
 @param sIDCard 身份证号码
 @return YES则是通过验证，NO则反之
 */
+ (BOOL)Verify_Identity:(NSString *)sIDCard;


/**
 验证手机号码

 @param sPhone 手机号码
 @return YES则是通过验证，NO则反之
 */
+ (BOOL)Verify_Phone:(NSString *)sPhone;



/**
 验证密码

 @param sPassword 密码
 @return YES则是通过验证，NO则反之
 */
+ (BOOL)Verify_Password:(NSString *)sPassword;

/**
 判断昵称不能含有特殊字符

 @param sNickname 昵称
 @return YES则是通过验证，NO则反之
 */
+ (BOOL)Verify_Nickname:(NSString *)sNickname;


/**
 判断邮箱是否正确
 
 @param sEmail 昵称
 @return YES则是通过验证，NO则反之
 */
+ (BOOL)Verify_Email:(NSString *)sEmail;


/**
 判断是否为纯汉字
 
 @param sChinese 字符串
 @return YES则是通过验证，NO则反之
 */
+ (BOOL)Verify_Chinese:(NSString *)sChinese;

@end
