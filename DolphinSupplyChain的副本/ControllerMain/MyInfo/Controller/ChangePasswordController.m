//
//  AppDelegate.m
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2017年 郑学宁. All rights reserved.
//

#import "ChangePasswordController.h"
#import "LoginViewController.h"

@interface ChangePasswordController () <UITextFieldDelegate>

@property (strong, nonatomic) UIView *vBack;

@property (strong, nonatomic) UILabel *lblOldPassword;

@property (strong, nonatomic) UITextField *tfOldPassword;

@property (strong, nonatomic) UIView *vLineOne;

@property (strong, nonatomic) UILabel *lblNewPassword;

@property (strong, nonatomic) UITextField *tfNewPassword;

@property (strong, nonatomic) UIView *vLineTwo;

@property (strong, nonatomic) UILabel *lblConfirmPassword;

@property (strong, nonatomic) UITextField *tfConfirmPassword;

@property (strong, nonatomic) UIButton *btnConfirm;

@end

@implementation ChangePasswordController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addNavigationType:YKSDefaults NavigationTitle:@"修改密码"];
    [self initAddView];
    [self initLayoutView];
    
}


- (void)initAddView
{
    [self.view addSubview:self.vBack];
    
    [self.vBack addSubview:self.lblOldPassword];
    [self.vBack addSubview:self.tfOldPassword];
    [self.vBack addSubview:self.vLineOne];
    
    [self.vBack addSubview:self.lblNewPassword];
    [self.vBack addSubview:self.tfNewPassword];
    [self.vBack addSubview:self.vLineTwo];
    
    [self.vBack addSubview:self.lblConfirmPassword];
    [self.vBack addSubview:self.tfConfirmPassword];
    
    [self.view addSubview:self.btnConfirm];
}

- (void)initLayoutView
{
    [self.vBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.vNavigation.mas_bottom).offset(10);
        make.height.mas_equalTo(133);
    }];
    
    [self.lblOldPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vBack.mas_top).offset(0);
        make.left.equalTo(self.vBack.mas_left).offset(20);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(70);
    }];
    
    [self.tfOldPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vBack.mas_top).offset(0);
        make.right.equalTo(self.vBack.mas_right).offset(-20);
        make.height.mas_equalTo(44);
        make.left.equalTo(self.lblOldPassword.mas_right);
    }];
    
    [self.vLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBack.mas_left).offset(20);
        make.right.equalTo(self.vBack);
        make.top.equalTo(self.lblOldPassword.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.lblNewPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLineOne.mas_bottom).offset(0);
        make.left.equalTo(self.vBack.mas_left).offset(20);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(70);
    }];
    
    [self.tfNewPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLineOne.mas_bottom).offset(0);
        make.right.equalTo(self.vBack.mas_right).offset(-20);
        make.height.mas_equalTo(44);
        make.left.equalTo(self.lblNewPassword.mas_right);
    }];
    
    [self.vLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBack.mas_left).offset(20);
        make.right.equalTo(self.vBack);
        make.top.equalTo(self.lblNewPassword.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.lblConfirmPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLineTwo.mas_bottom).offset(0);
        make.left.equalTo(self.vBack.mas_left).offset(20);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(70);
    }];
    
    [self.tfConfirmPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLineTwo.mas_bottom).offset(0);
        make.right.equalTo(self.vBack.mas_right).offset(-20);
        make.height.mas_equalTo(44);
        make.left.equalTo(self.lblConfirmPassword.mas_right);
    }];
    
    [self.btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vBack.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark--确认修改
-(void)confirmChange
{
    NSString *sOldPassWord = self.tfOldPassword.text;
    NSString *sNewPassWord = self.tfNewPassword.text;
    NSString *sConfirmPassWord = self.tfConfirmPassword.text;
    
    
    if (sOldPassWord.length == 0) {
        [self.view makeToast:@"密码不能为空" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (![sNewPassWord isEqualToString:sConfirmPassWord]) {
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
    
    
    [HTLoadingTool showLoadingStringDontOperation:@"修改中..."];
    NSDictionary *dic = @{@"old_password":sOldPassWord,
                          @"new_password":sNewPassWord};
    
    [AFHTTPClient POST:@"/user/updatePassword" params:dic successInfo:^(ResponseModel *response) {
        
        
        //解析数据
        id json = @{@"data":response.dataResponse};
        [self confirmChangeRefresh:json];
        
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

- (void)confirmChangeRefresh:(id)json
{
    [self.view makeToast:@"修改密码成功" duration:1.0 position:CSToastPositionCenter];
    
    LoginViewController *logiv_VC = [[LoginViewController alloc] initWithIsChangePassword:[YKSUserDefaults isUserIndividual] ? @"C_Password" : @"B_Password"];
    
    [YKSUserDefaults deleteAllUserInfo];
    
    [self.navigationController pushViewController:logiv_VC animated:YES];
    
}

- (void)touchToLogin
{
    LoginViewController * VC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}


//点击空白收回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 1) {
        [self.tfNewPassword becomeFirstResponder];
    }
    else if (textField.tag == 2)
    {
        [self.tfConfirmPassword becomeFirstResponder];
    }
    else
    {
        [self.tfConfirmPassword resignFirstResponder];
        [self confirmChange];
    }
    return YES;
}

#pragma mark - 懒加载
- (UIView *)vBack
{
    if (!_vBack) {
        _vBack = [[UIView alloc] init];
        _vBack.backgroundColor = [UIColor whiteColor];
    }
    return _vBack;
}

- (UILabel *)lblOldPassword
{
    if (!_lblOldPassword) {
        _lblOldPassword = [[UILabel alloc] init];
        _lblOldPassword.text = @"旧密码";
        _lblOldPassword.font = kFont13;
    }
    return _lblOldPassword;
}

- (UITextField *)tfOldPassword
{
    if (!_tfOldPassword) {
        _tfOldPassword = [[UITextField alloc] init];
        _tfOldPassword.borderStyle = UITextBorderStyleNone;
        _tfOldPassword.backgroundColor = [UIColor whiteColor];
        _tfOldPassword.placeholder = @"输入您的旧密码";
        _tfOldPassword.font = [UIFont fontWithName:@"Arial" size:14.0f];
        _tfOldPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
        _tfOldPassword.secureTextEntry = YES;
        _tfOldPassword.keyboardType = UIKeyboardTypeASCIICapable;
        _tfOldPassword.returnKeyType = UIReturnKeyNext;
        _tfOldPassword.delegate = self;
        _tfOldPassword.tag = 1;
    }
    return _tfOldPassword;
}

- (UIView *)vLineOne
{
    if (!_vLineOne) {
        _vLineOne = [[UIView alloc] init];
        _vLineOne.backgroundColor = ColorLine;
    }
    return _vLineOne;
}

- (UILabel *)lblNewPassword
{
    if (!_lblNewPassword) {
        _lblNewPassword = [[UILabel alloc] init];
        _lblNewPassword.text = @"新密码";
        _lblNewPassword.font = kFont13;
    }
    return _lblNewPassword;
}

- (UITextField *)tfNewPassword
{
    if (!_tfNewPassword) {
        _tfNewPassword = [[UITextField alloc] init];
        _tfNewPassword.borderStyle = UITextBorderStyleNone;
        _tfNewPassword.backgroundColor = [UIColor whiteColor];
        _tfNewPassword.placeholder = @"输入您的新密码";
        _tfNewPassword.font = [UIFont fontWithName:@"Arial" size:14.0f];
        _tfNewPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
        _tfNewPassword.secureTextEntry = YES;
        _tfNewPassword.keyboardType = UIKeyboardTypeASCIICapable;
        _tfNewPassword.returnKeyType = UIReturnKeyNext;
        _tfNewPassword.delegate = self;
        _tfNewPassword.tag = 2;
    }
    return _tfNewPassword;
}

- (UIView *)vLineTwo
{
    if (!_vLineTwo) {
        _vLineTwo = [[UIView alloc] init];
        _vLineTwo.backgroundColor = ColorLine;
    }
    return _vLineTwo;
}

- (UILabel *)lblConfirmPassword
{
    if (!_lblConfirmPassword) {
        _lblConfirmPassword = [[UILabel alloc] init];
        _lblConfirmPassword.text = @"确认密码";
        _lblConfirmPassword.font = kFont13;
    }
    return _lblConfirmPassword;
}

- (UITextField *)tfConfirmPassword
{
    if (!_tfConfirmPassword) {
        _tfConfirmPassword = [[UITextField alloc] init];
        _tfConfirmPassword.borderStyle = UITextBorderStyleNone;
        _tfConfirmPassword.backgroundColor = [UIColor whiteColor];
        _tfConfirmPassword.placeholder = @"再次输入您的新密码";
        _tfConfirmPassword.font = [UIFont fontWithName:@"Arial" size:14.0f];
        _tfConfirmPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
        _tfConfirmPassword.secureTextEntry = YES;
        _tfConfirmPassword.keyboardType = UIKeyboardTypeASCIICapable;
        _tfConfirmPassword.returnKeyType = UIReturnKeySend;
        _tfConfirmPassword.delegate = self;
        _tfConfirmPassword.tag = 3;
    }
    return _tfConfirmPassword;
}

- (UIButton *)btnConfirm
{
    if (!_btnConfirm) {
        _btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnConfirm.layer.cornerRadius=5.0;
        [_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnConfirm setBackgroundColor:color(76, 175, 255, 1)];
        _btnConfirm.titleLabel.font = kFont16;
        [_btnConfirm setTitle:@"确认修改" forState:UIControlStateNormal];
        [_btnConfirm addTarget:self action:@selector(confirmChange) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnConfirm;
}


@end
