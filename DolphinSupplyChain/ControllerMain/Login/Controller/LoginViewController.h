//
//  ViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//


#import "HTBase_VC.h"


@interface LoginViewController : HTBase_VC

- (instancetype)initWithIsChangePassword:(NSString *)sChangePassword;

- (instancetype)logout;

- (instancetype)initWithLogin:(BOOL)isLogin;


@end
