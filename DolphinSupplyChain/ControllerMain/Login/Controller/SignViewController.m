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
#import "WeiXinViewController.h"


//获取验证码图片

static NSString * const kGetimgURL = @"/user/captchaBase64";

static NSString * const kGetMsgURL = @"/user/sms";

static NSString * const kGetRegistURL = @"/user/register";

static NSString * const kLoginInURL = @"/user/login";


@interface SignViewController ()<PhoneMsgViewDelegate,nameViewDelegate>{
    nameView  *imgText;
    PhoneView  *phoneText;
    PhoneView  *companyText;
    PhoneView  *nameText;
    PhoneMsgView  *phoneMsgText;
    PwdView  *passwordtext;
    PwdView  *passwordConfirmText;
    
    NSString * body;
}

@property (nonatomic, strong) UIButton *btnIndividual;

@property (nonatomic, strong) UIButton *btnFenxiao;

@property (nonatomic, assign) NSString *type ;

@property (nonatomic, assign) BOOL btnClick1;

@property (nonatomic, assign) BOOL btnClick2;


@end

@implementation SignViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIView *vBack = [[UIView alloc] initWithFrame:CGRectMake(0, 13 + kDisNavgation, kDisWidth, 310)];
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
    vLineThree.frame = CGRectMake(20, 131.5, kDisWidth - 20, 0.5);
    vLineThree.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
    [vBack addSubview:vLineThree];
    
    UIView *vLineFour = [[UIView alloc] init];
    vLineFour.frame = CGRectMake(20, 177.5, kDisWidth - 20, 0.5);
    vLineFour.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
    [vBack addSubview:vLineFour];
    
    UIView *vLineFive = [[UIView alloc] init];
    vLineFive.frame = CGRectMake(20, 221.5, kDisWidth - 20, 0.5);
    vLineFive.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
    [vBack addSubview:vLineFive];
    
    UIView *vLineSix = [[UIView alloc] init];
    vLineSix.frame = CGRectMake(20, 265.5, kDisWidth - 20, 0.5);
    vLineSix.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
    [vBack addSubview:vLineSix];
    
//    UIView *vLineSeven = [[UIView alloc] init];
//    vLineSeven.frame = CGRectMake(20, 309.5, kDisWidth - 20, 0.5);
//    vLineSeven.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
//    [vBack addSubview:vLineSeven];

    companyText = [[PhoneView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth-20, 44.0)];
    companyText.lblName.text = @"公司名";
    companyText.phoneTxt.placeholder=@"输入您的公司名";
    [vBack addSubview:companyText];
    
    nameText = [[PhoneView alloc] initWithFrame:CGRectMake(0, 44.5, kDisWidth-20, 44.0)];
    nameText.lblName.text = @"联系人";
    nameText.phoneTxt.placeholder=@"输入您的联系人名称";
    [vBack addSubview:nameText];
    
    phoneText = [[PhoneView alloc] initWithFrame:CGRectMake(0, 88.5, kDisWidth-20, 44.0)];
    phoneText.lblName.text = @"手机号";
    phoneText.phoneTxt.placeholder=@"输入您的手机号";
    [vBack addSubview:phoneText];
    
    imgText = [[nameView alloc] initWithFrame:CGRectMake(0, 132.5, kDisWidth-20, 44.0)];
    imgText.labText = @"验证码";
    imgText.placeText = @"验证码";
    imgText.delegate = self;
    [vBack addSubview:imgText];
    
    phoneMsgText = [[PhoneMsgView alloc] initWithFrame:CGRectMake(0, 176.5, kDisWidth-20, 44)];
    phoneMsgText.phoneTxt.placeholder = @"短信验证码";
    phoneMsgText.delegate = self;
    [vBack addSubview:phoneMsgText];
    
    passwordtext=[[PwdView alloc] initWithFrame:CGRectMake(0, 221.5, kDisWidth-20, 44)];
    passwordtext.labText=@"设置密码";
    passwordtext.placeText=@"建议至少使用两种字符组合";
    [vBack addSubview:passwordtext];
    
    passwordConfirmText = [[PwdView alloc] initWithFrame:CGRectMake(0, 265.5, kDisWidth-20, 44.0)];
    passwordConfirmText.labText = @"确认密码";
    passwordConfirmText.placeText = @"请再次输入密码";
    [vBack addSubview:passwordConfirmText];
    
//    UIView * vType = [[UIView alloc]initWithFrame:CGRectMake(0, 310, kDisWidth, 44.0)];
//
//    UILabel * labType = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 44.0)];
//    labType.text = @"请选择注册类型";
//    labType.font = [UIFont systemFontOfSize:14];
//    [vType addSubview:labType];
//
//    [self.btnIndividual setFrame:CGRectMake(125, 0, 100, 44)];
//    [vType addSubview:self.btnIndividual];
//
//    [self.btnFenxiao setFrame:CGRectMake(225, 0, 100, 44)];
//    [vType addSubview:self.btnFenxiao];
//    [vBack addSubview:vType];

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

- (void)login1{
    
    if(companyText.phoneTxt.text.length == 0)
    {
        [self.view makeToast:@"公司名不能为空" duration:1.0 position:CSToastPositionCenter];
        return;
        
    }
    
    if(nameText.phoneTxt.text.length == 0)
    {
        [self.view makeToast:@"联系人名称不能为空" duration:1.0 position:CSToastPositionCenter];
        return;
        
    }
    
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
    
//    if (self.btnClick1) {
//        self.type = @"1";
//    }else if(self.btnClick2){
//        self.type = @"2";
//    }else{
//        [self.view makeToast:@"注册类型不能为空" duration:1.0 position:CSToastPositionCenter];
//        return;
//    }
    
    [HTLoadingTool showLoadingStringDontOperation:@"注册中..."];
    NSDictionary *dic = @{
                          @"company":companyText.phoneTxt.text,
                          @"nick":nameText.phoneTxt.text,
                          @"password":passwordtext.pwdTxt.text,
                          @"mobile_phone":phoneText.phoneTxt.text,
                          @"code":phoneMsgText.phoneTxt.text,
                          @"type":@"ios",
                          @"apply_user_type":@"2" //默认为分销商客户 （1：个人 2:分销商）
                          };
    
    [AFHTTPClient POST:kGetRegistURL params:dic successInfo:^(ResponseModel *response) {
        //解析数据
        [self weiXin];
//        id json = @{@"data":response.dataResponse};
//        [self loginRefresh:json];
        
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

//跳转扫扫微信界面
- (void)weiXin{
    
    WeiXinViewController * weixin_VC = [[WeiXinViewController alloc]init];
//    if(self.btnClick1){
//        weixin_VC.isIndividual = YES;
//    }else if(self.btnClick2){
//        weixin_VC.isIndividual = NO;
//    }else{
//        [self.view makeToast:@"注册类型不能为空" duration:1.0 position:CSToastPositionCenter];
//        return;
//    };
    
    [self YKSRootPushViewController:weixin_VC];
    
}

#pragma mark - 按钮事件
- (void)selectorDefault
{
    self.btnClick1 = !self.btnClick1;
    
    if (self.btnClick1) {
        self.btnIndividual.selected = YES;
    }else{
        self.btnIndividual.selected = NO;
    }
    self.btnClick2 = NO;
    self.btnFenxiao.selected = NO;
}

- (void)selectorDefault2
{
    self.btnClick2 = !self.btnClick2;
    if (self.btnClick2) {
        self.btnFenxiao.selected = YES;
    }else{
        self.btnFenxiao.selected = NO;
    }
     self.btnClick1 = NO;
     self.btnIndividual.selected = NO;
}
- (UIButton *)btnIndividual
{
    if (!_btnIndividual) {
        _btnIndividual = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnIndividual setTitle:@" 个 人" forState:UIControlStateNormal];
        [_btnIndividual setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [_btnIndividual setImage:[UIImage drawImageWithName:@"choose_default" size:CGSizeMake(15, 15)] forState:UIControlStateNormal];
        
        [_btnIndividual setTitle:@" 个 人" forState:UIControlStateSelected];
        [_btnIndividual setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateSelected];
        [_btnIndividual setImage:[UIImage drawImageWithName:@"choose_selected" size:CGSizeMake(15, 15)] forState:UIControlStateSelected];
        
        [_btnIndividual addTarget:self action:@selector(selectorDefault) forControlEvents:UIControlEventTouchUpInside];
        
        _btnIndividual.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnIndividual setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    }
    return _btnIndividual;
}

- (UIButton *)btnFenxiao
{
    if (!_btnFenxiao) {
        _btnFenxiao = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnFenxiao setTitle:@" 企 业" forState:UIControlStateNormal];
        [_btnFenxiao setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [_btnFenxiao setImage:[UIImage drawImageWithName:@"choose_default" size:CGSizeMake(15, 15)] forState:UIControlStateNormal];

        [_btnFenxiao setTitle:@" 企 业" forState:UIControlStateSelected];
        [_btnFenxiao setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateSelected];
        [_btnFenxiao setImage:[UIImage drawImageWithName:@"choose_selected" size:CGSizeMake(15, 15)] forState:UIControlStateSelected];
        
        [_btnFenxiao addTarget:self action:@selector(selectorDefault2) forControlEvents:UIControlEventTouchUpInside];
        
        _btnFenxiao.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnFenxiao setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    }
    return _btnFenxiao;
}

@end
