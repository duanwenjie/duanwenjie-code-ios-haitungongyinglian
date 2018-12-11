//
//  ViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//


#import "NewpwdViewController.h"
#import "PwdView.h"
#import "LoginButton.h"
#import "LoginViewController.h"


static NSString * const kForgetPwdURL = @"/user/forgetPassword";

@interface NewpwdViewController (){
    PwdView *pwd;
    PwdView *pwdConfirm;
    
}

@end

@implementation NewpwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *vBack = [[UIView alloc] initWithFrame:CGRectMake(0, 13 + kDisNavgation, kDisWidth, 88.5)];
    [self.view addSubview:vBack];
    
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(20, 44, kDisWidth - 20, 0.5)];
    vLine.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
    [vBack addSubview:vLine];
    
    pwd = [[PwdView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 44.0)];
    pwd.labText=@"设置密码";
    pwd.placeText=@"请输入您的密码";
    [vBack addSubview:pwd];
    
    pwdConfirm=[[PwdView alloc] initWithFrame:CGRectMake(0.0, pwd.bottom, kDisWidth-20, 44.0)];
    pwdConfirm.labText=@"确认密码";
    pwdConfirm.placeText=@"请再次输入您的密码";
    [vBack addSubview:pwdConfirm];
    
    LoginButton *loginBtn = [[LoginButton alloc] initWithFrame:CGRectMake(20, vBack.bottom + 15, kDisWidth - 40, 36)];
    [loginBtn setTitle:@"确认" forState:UIControlStateNormal];
    [loginBtn addTarget:self  action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    [self addNavigationType:YKSDefaults NavigationTitle:@"设置新密码"];
}


-(void)confirm
{
    NSString *sNewPassWord = pwd.pwdTxt.text;
    NSString *sOldPassWord = pwdConfirm.pwdTxt.text;
    if (![sNewPassWord isEqualToString:sOldPassWord]) {
        [self.view makeToast:@"两个密码输入不一致" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (sNewPassWord.length == 0) {
        [self.view makeToast:@"密码不能为空" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (sNewPassWord.length < 6 || sNewPassWord.length > 20) {
        [self.view makeToast:@"密码长度必须为6-20个字符" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    NSString *regex2 = @"^(?![0-9]+$)(?![a-zA-Z]+$)(?!([^(0-9a-zA-Z)]|[\\(\\)])+$)([^(0-9a-zA-Z)]|[\\(\\)]|[a-zA-Z]|[0-9]){6,20}$";
    
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if (![pred2 evaluateWithObject:sNewPassWord]) {
        [self.view makeToast:@"密码必须是数字、字母、符号，任意两种组合以上" duration:2.0 position:CSToastPositionCenter];
        return;
    }
    
    [HTLoadingTool showLoadingDontOperation];
    NSDictionary *dic = @{
                          @"password":pwd.pwdTxt.text,
                          @"code":_code
                          };
    
    [AFHTTPClient POST:kForgetPwdURL params:dic successInfo:^(ResponseModel *response) {
        
        
        //解析数据
        id json = @{@"data":response.dataResponse};
        [self confirmRefresh:json];
        
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

}


-(void)confirmRefresh:(id)json{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[LoginViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
//点击空白收回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


@end
