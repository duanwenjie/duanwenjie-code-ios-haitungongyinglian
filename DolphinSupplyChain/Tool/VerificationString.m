//
//  VerificationString.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/1/13.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "VerificationString.h"

@implementation VerificationString


/**
 验证身份证号码

 @param sIDCard 身份证号码
 @return YES则是通过验证，NO则反之
 */
+ (BOOL)Verify_Identity:(NSString *)sIDCard {
    
    if (sIDCard.length <= 0) {
        return NO;
    }
    NSString *Regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [pre evaluateWithObject:sIDCard];
}

// 验证手机号码
+ (BOOL)Verify_Phone:(NSString *)sPhone {
    NSString *Regex =@"^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|17[0|1|2|3|4|5|6|7|8|9]|18[0|1|2|3|4|5|6|7|8|9])\\d{8}$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [pre evaluateWithObject:sPhone];
}

// 验证密码 密码必须是数字、字母、符号，任意两种组合以上 6-20位
+ (BOOL)Verify_Password:(NSString *)sPassword {
    NSString *Regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)(?!([^(0-9a-zA-Z)]|[\\(\\)])+$)([^(0-9a-zA-Z)]|[\\(\\)]|[a-zA-Z]|[0-9]){6,20}$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [pre evaluateWithObject:sPassword];
}

// 判断昵称不能含有特殊字符
+ (BOOL)Verify_Nickname:(NSString *)sNickname
{
    NSString *Regex = @"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [pre evaluateWithObject:sNickname];
}


/**
 判断邮箱是否正确
 
 @param sEmail 昵称
 @return YES则是通过验证，NO则反之
 */
+ (BOOL)Verify_Email:(NSString *)sEmail
{
    NSString *Regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [pre evaluateWithObject:sEmail];
}


/**
 判断是否为纯汉字

 @param sChinese 字符串
 @return YES则是通过验证，NO则反之
 */
+ (BOOL)Verify_Chinese:(NSString *)sChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:sChinese];
}

@end
