//
//  ViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//


#import "SignViewController.h"
#import "LoginButton.h"
#import "PhoneView.h"
#import "PwdView.h"
#import "nameView.h"
#import "CodeView.h"
#import "PhoneMsgView.h"
#import "AppDelegate.h"


//获取验证码图片

static NSString * const kGetimgURL = @"/user/captchaBase64";

static NSString * const kGetMsgURL = @"/user/sms";

static NSString * const kGetRegistURL = @"/user/register";

static NSString * const kLoginInURL = @"/user/login";


@interface SignViewController ()<PhoneMsgViewDelegate,nameViewDelegate>{
    nameView  *imgText;
    PhoneView  *phoneText;
    PhoneMsgView  *phoneMsgText;
    PwdView  *passwordtext;
    PwdView  *passwordConfirmText;
    
    NSString * body;
}

@end

@implementation SignViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIView *vBack = [[UIView alloc] initWithFrame:CGRectMake(0, 13 + kDisNavgation, kDisWidth, 222)];
    vBack.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vBack];
    
    UIView *vLineOne = [[UIView alloc] init];
    vLineOne.frame = CGRectMake(20, 44, kDisWidth - 20, 0.5);
    vLineOne.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
    [vBack addSubview:vLineOne];
    
    UIView *vLineTwo = [[UIView alloc] init];
    vLineTwo.frame = CGRectMake(20, 88.5, kDisWidth - 20, 0.5);
    vLineTwo.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
    [vBack addSubview:vLineTwo];
    
    UIView *vLineThree = [[UIView alloc] init];
    vLineThree.frame = CGRectMake(20, 133, kDisWidth - 20, 0.5);
    vLineThree.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
    [vBack addSubview:vLineThree];
    
    UIView *vLineFour = [[UIView alloc] init];
    vLineFour.frame = CGRectMake(20, 177.5, kDisWidth - 20, 0.5);
    vLineFour.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
    [vBack addSubview:vLineFour];

    phoneText = [[PhoneView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth-20, 44.0)];
    phoneText.lblName.text = @"手机号";
    phoneText.phoneTxt.placeholder=@"输入您的手机号";
    [vBack addSubview:phoneText];
    
    imgText = [[nameView alloc] initWithFrame:CGRectMake(0, 44.5, kDisWidth-20, 44.0)];
    imgText.labText = @"验证码";
    imgText.placeText = @"验证码";
    imgText.delegate = self;
    [vBack addSubview:imgText];
    
    phoneMsgText = [[PhoneMsgView alloc] initWithFrame:CGRectMake(0, 88.5, kDisWidth-20, 44)];
    phoneMsgText.phoneTxt.placeholder = @"短信验证码";
    phoneMsgText.delegate = self;
    [vBack addSubview:phoneMsgText];
    
    passwordtext=[[PwdView alloc] initWithFrame:CGRectMake(0, 133, kDisWidth-20, 44)];
    passwordtext.labText=@"设置密码";
    passwordtext.placeText=@"建议至少使用两种字符组合";
    [vBack addSubview:passwordtext];
    
    passwordConfirmText = [[PwdView alloc] initWithFrame:CGRectMake(0, 177.5, kDisWidth-20, 44.0)];
    passwordConfirmText.labText = @"确认密码";
    passwordConfirmText.placeText = @"请再次输入密码";
    [vBack addSubview:passwordConfirmText];
        
    LoginButton *loginBtn=[[LoginButton alloc] initWithFrame:CGRectMake(0, vBack.bottom + 20, vBack.width - 30, 36)];
    loginBtn.center = CGPointMake(kDisWidth/2, vBack.bottom + 40);
    [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [loginBtn addTarget:self  action:@selector(login1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    [self addNavigationType:YKSDefaults NavigationTitle:@"注册"];
    
    // 获取图片验证码
    [self setImg];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [phoneMsgText stopTiem];
}

-(void)setImg{
    
    [HTLoadingTool showLoadingForView:self.view];
    NSDictionary *dic = nil;
    
    [AFHTTPClient POST:kGetimgURL params:dic successInfo:^(ResponseModel *response) {
        
        
        //解析数据
        id json = @{@"data":response.dataResponse};
        NSDictionary * dict = [json objectForKey:@"data"];
        NSString * strData =[dict objectForKey:@"base64"];
        imgText.imgURLData = strData;
        
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

-(void)login1{
    if(phoneText.phoneTxt.text.length == 0)
    {
        [self.view makeToast:@"手机号码不能为空" duration:1.0 position:CSToastPositionCenter];
        return;
        
    }
    
    if(phoneText.phoneTxt.text.length!=11)
    {
        [self.view makeToast:@"手机号码输入有误" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    NSString *sNewPassWord = passwordtext.pwdTxt.text;
    NSString *sOldPassWord = passwordConfirmText.pwdTxt.text;
    if (![sNewPassWord isEqualToString:sOldPassWord]) {
        [self.view makeToast:@"两个密码不一致" duration:1.0 position:CSToastPositionCenter];
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
    
    [HTLoadingTool showLoadingStringDontOperation:@"注册中..."];
    NSDictionary *dic = @{
                          @"password":passwordtext.pwdTxt.text,
                          @"mobile_phone":phoneText.phoneTxt.text,
                          @"code":phoneMsgText.phoneTxt.text,
                          @"type":@"ios"
                          };
    
    [AFHTTPClient POST:kGetRegistURL params:dic successInfo:^(ResponseModel *response) {
        //解析数据
        id json = @{@"data":response.dataResponse};
        [self loginRefresh:json];
        
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


-(void)loginRefresh:(id)json{
    
    NSString *member=[json objectForKey:@"user_id"];
    NSNumber *memberID = [NSNumber numberWithFloat:[member floatValue]];
    if (memberID) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [HTLoadingTool showLoadingDontOperation];
    NSDictionary *dic = @{
                          @"user_name":phoneText.phoneTxt.text,
                          @"password":passwordtext.pwdTxt.text,
                          @"type":@"ios"
                          };
    
    [AFHTTPClient POST:kGetRegistURL params:dic successInfo:^(ResponseModel *response) {
        
        
        //解析数据
        id json = @{@"data":response.dataResponse};
        [self alertViewDataRefresh:json];
        
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

-(void)alertViewDataRefresh:(id)json{
    [self.view makeToast:@"账号注册成功" duration:1.0 position:CSToastPositionCenter];
    
    [HTLoadingTool showLoadingDontOperation];
    NSDictionary *dic = @{
                          @"user_name":phoneText.phoneTxt.text,
                          @"password":passwordtext.pwdTxt.text,
                          @"type":@"ios"
                          };
    
    [AFHTTPClient POST:kLoginInURL params:dic successInfo:^(ResponseModel *response) {
        [YKSUserDefaults storeUserInfo:json];
        [YKSUserDefaults storeUserPassword:passwordtext.pwdTxt.text];
        
        
        if ([YKSUserDefaults isUserIndividual]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            // 返回经销商个人中心
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate changeRootView:NO cutSomeController:4];
        }
        
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


//点击空白收回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


#pragma mark --PhoneMsgViewDelegate

-(void)PhoneMsgViewBtn{
    if ([phoneText.phoneTxt.text isEqualToString:@""] || [imgText.pwdTxt.text isEqualToString:@""] )
    {
        [self.view makeToast:@"手机号或验证码不能为空" duration:1.0 position:CSToastPositionCenter];
    }
    else
    {
        
        [HTLoadingTool showLoadingStringDontOperation:@"获取验证码"];
        NSDictionary *dic = @{
                              @"mobile_phone":phoneText.phoneTxt.text,
                              @"type":@"register",
                              @"captcha":imgText.pwdTxt.text
                              };
        
        [AFHTTPClient POST:kGetMsgURL params:dic successInfo:^(ResponseModel *response) {
            [phoneMsgText getAgainVerifyMessage];
            
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
    

}
-(void)imgViewBtn{
    
    [self setImg];
}
@end
