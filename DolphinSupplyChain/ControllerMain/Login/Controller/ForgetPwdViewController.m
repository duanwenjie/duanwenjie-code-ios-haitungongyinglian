//
//  ViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//


#import "ForgetPwdViewController.h"
#import "PhoneView.h"
#import "LoginButton.h"
#import "nameView.h"
#import "NewpwdViewController.h"

static NSString * const kGetimgURL = @"/user/captchaBase64";

static NSString * const kGetMsgURL = @"/user/sms";


@interface ForgetPwdViewController () <UITextFieldDelegate,nameViewDelegate>
{
    PhoneView *phoneText;
    nameView * imgText;
    UITextField *verifyText;
    LoginButton *verifyBtn;
    int      time;
    UILabel     *time_lab;
    NSTimer     *timer;
    NSString    *message;
    BOOL        isTaking;
}

@property (nonatomic, strong) UITextField *tfPhoneCode;

@property (nonatomic, strong) UIButton *btnVerify;

@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *vBack = [[UIView alloc] initWithFrame:CGRectMake(0, 13 + kDisNavgation, kDisWidth, 133)];
    vBack.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vBack];
    
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(20, 44, kDisWidth - 20, 0.5)];
    vLine.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
    [vBack addSubview:vLine];
    
    UIView *vLineTwo = [[UIView alloc] initWithFrame:CGRectMake(20, 88.5, kDisWidth - 20, 0.5)];
    vLineTwo.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
    [vBack addSubview:vLineTwo];
    
    phoneText=[[PhoneView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth-20, 44)];
    phoneText.phoneTxt.placeholder = @"请输入手机号/用户名";
    [vBack addSubview:phoneText];
    
    
    imgText = [[nameView alloc] initWithFrame:CGRectMake(0, 44.5, kDisWidth-20, 44)];
    imgText.labText = @"验证码";
    imgText.delegate = self;
    imgText.pwdTxt.placeholder = @"请输入图片验证码";
    [vBack addSubview:imgText];
    
    
    UILabel *lblPhoneCode = [[UILabel alloc] initWithFrame:CGRectMake(20, 89, 85, 44)];
    lblPhoneCode.font = [UIFont systemFontOfSize:14.0f];
    lblPhoneCode.text = @"短信验证码";
    [vBack addSubview:lblPhoneCode];
    
    self.tfPhoneCode = [[UITextField alloc] initWithFrame:CGRectMake(lblPhoneCode.right, 89, kDisWidth - 200, 44)];
    [self.tfPhoneCode setClearButtonMode:UITextFieldViewModeWhileEditing];
    self.tfPhoneCode.keyboardType=UIKeyboardTypeNumberPad;
    self.tfPhoneCode.delegate = self;
    self.tfPhoneCode.font = [UIFont systemFontOfSize:14.0f];
    self.tfPhoneCode.placeholder = @"请输入短信验证码";
    [vBack addSubview:self.tfPhoneCode];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 40)];
    view.backgroundColor = [UIColor lightGrayColor];
    self.tfPhoneCode.inputAccessoryView = view;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kDisWidth - 60, 0, 50, 40)];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(confirmEdit) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    self.btnVerify = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnVerify.frame = CGRectMake(vBack.width - 100, 98, 80, 28);
    [self.btnVerify setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.btnVerify setTitleColor:ColorAPPTheme forState:UIControlStateNormal];
    self.btnVerify.titleLabel.font = [UIFont boldSystemFontOfSize:10];
    self.btnVerify.layer.borderWidth = 1;
    self.btnVerify.layer.cornerRadius = 3;
    self.btnVerify.layer.borderColor = ColorAPPTheme.CGColor;
    self.btnVerify.layer.masksToBounds = YES;
    [self.btnVerify addTarget:self action:@selector(btnn:) forControlEvents:UIControlEventTouchUpInside];
    self.btnVerify.selected = NO;
    [self.btnVerify setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateSelected];
    [vBack addSubview:self.btnVerify];
    
    LoginButton *loginBtn=[[LoginButton alloc] initWithFrame:CGRectMake(20, vBack.bottom + 15, vBack.width - 40, 36)];
    loginBtn.center = CGPointMake(kDisWidth/2, vBack.bottom + 40);
    [loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [loginBtn addTarget:self  action:@selector(toNewpwd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    [self addNavigationType:YKSDefaults NavigationTitle:@"忘记密码"];
    
    [self setImg];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self stopTiem];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (timer != nil) {
        //开启定时器
        [timer setFireDate:[NSDate distantPast]];
    }
}

#pragma mark - 获取手机验证码
-(void)btnn:(UIButton *)btn
{
    if (!btn.selected) {
        // 获取短信验证码
        [self gainSMS];
    }
}


-(void)confirmEdit
{
    [self.tfPhoneCode resignFirstResponder];
}

#pragma mark -- textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.tfPhoneCode resignFirstResponder];
    return YES;
}

#pragma mark -- textfield delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (1 == range.length)//按下回格键
    {
        return YES;
    }
    if (self.tfPhoneCode == textField)
    {
        if ([textField.text length] < 11)
        {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 开始定时器
-(void)getAgainVerifyMessage
{
    self.btnVerify.userInteractionEnabled = NO;
    time = 60;
    self.btnVerify.selected = YES;
    self.btnVerify.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
    [self.btnVerify setTitle:@"60(s)" forState:UIControlStateSelected];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(function)userInfo:nil repeats:YES];
}

#pragma mark - 定时任务
-(void)function
{
    time--;
    [self.btnVerify setTitle:[NSString stringWithFormat:@"%d(s)", time] forState:UIControlStateSelected];
    if (time <= 0) {
        [timer invalidate];
        timer = nil;
        
        self.btnVerify.userInteractionEnabled = YES;
        time = 60;
        self.btnVerify.selected = NO;
        [self.btnVerify setTitle:@"重新获取" forState:UIControlStateNormal];
        self.btnVerify.layer.borderColor = ColorAPPTheme.CGColor;
    }
}

#pragma mark - 停止定时器
- (void)stopTiem
{
    [timer invalidate];
}
-(void)setImg{
    
    [HTLoadingTool showLoadingStringDontOperation:@"获取中..."];
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


- (void)imgViewBtn
{
    [self setImg];
}


/// 获取短信验证码

-(void)gainSMS{
    
    
    if (phoneText.phoneTxt.text.length == 0)
    {
        [self.view makeToast:@"手机号码不能为空" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (phoneText.phoneTxt.text.length != 11)
    {
        [self.view makeToast:@"手机号码输入有误" duration:1.0 position:CSToastPositionCenter];
        return;
    }

    [HTLoadingTool showLoadingStringDontOperation:@"获取中..."];
    NSDictionary *dic = @{
                          @"mobile_phone":phoneText.phoneTxt.text,
                          @"type":@"forget_password",
                          @"captcha":imgText.pwdTxt.text
                          };
    
    [AFHTTPClient POST:kGetMsgURL params:dic successInfo:^(ResponseModel *response) {
        
        
        //            //解析数据
        //            id json = @{@"data":response.dataResponse};
        [self getAgainVerifyMessage];
        
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







-(void)toNewpwd
{
    if (phoneText.phoneTxt.text.length == 0)
    {
        [self.view makeToast:@"手机号码不能为空" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (phoneText.phoneTxt.text.length != 11)
    {
        [self.view makeToast:@"手机号码输入有误" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (imgText.pwdTxt.text.length == 0) {
        [self.view makeToast:@"图片验证码不能为空" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (self.tfPhoneCode.text.length == 0) {
        [self.view makeToast:@"短信验证码不能为空" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (self.tfPhoneCode.text.length != 6) {
        [self.view makeToast:@"短信验证码有误" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    
    [HTLoadingTool showLoadingStringDontOperation:@"修改中..."];
    NSDictionary *dic = @{@"code":self.tfPhoneCode.text};
    
    [AFHTTPClient POST:@"/user/forgetPasswordValid" params:dic successInfo:^(ResponseModel *response) {
        NewpwdViewController *newVC=[[NewpwdViewController alloc] init];
        newVC.code = self.tfPhoneCode.text;
        [self.navigationController pushViewController:newVC animated:YES];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        
    }];
    
}

//点击空白收回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

@end
