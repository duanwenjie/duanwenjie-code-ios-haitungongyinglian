//
//  ChangeSomethingController.m
//  Distribution
//
//  Created by 张翔 on 14-11-22.
//  Copyright (c) 2014年 ___YKSKJ.COM___. All rights reserved.
//

#import "ChangeSomethingController.h"

@interface ChangeSomethingController () <UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITextField *putInTextfield;

@property (nonatomic, strong) ChangeSomethingBlock changeSomeBlock;

@end

@implementation ChangeSomethingController


- (instancetype)initWithChangeSomething:(ChangeSomethingBlock)block
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.changeSomeBlock = block;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 15 + kDisNavgation, kDisWidth, 44)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60.0, 44)];
    lab1.textColor = kCustomBlack;
    lab1.font = [UIFont systemFontOfSize:13.0f];
    [view1 addSubview:lab1];
    
    _putInTextfield = [[UITextField alloc] initWithFrame:CGRectMake(65, 0, view1.width - 70, 44)];
    _putInTextfield.font = [UIFont systemFontOfSize:13.0f];
    _putInTextfield.delegate = self;
    _putInTextfield.returnKeyType = UIReturnKeyDone;
    [_putInTextfield setClearButtonMode:UITextFieldViewModeWhileEditing];
    [view1 addSubview:_putInTextfield];
    
    UILabel *example = [[UILabel alloc] initWithFrame:CGRectMake(view1.left + 10, view1.bottom + 5, view1.width - 20, 50)];
    example.numberOfLines = 0;
    example.textColor = [UIColor lightGrayColor];
    example.font = [UIFont systemFontOfSize:15.0f];
    
    UIButton *makeSureBtn = [[UIButton alloc] init];
    [makeSureBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    makeSureBtn.backgroundColor = ColorAPPTheme;
    [makeSureBtn.layer setBorderColor:[ColorAPPTheme CGColor]];
    [makeSureBtn.layer setBorderWidth:0.5];
    [makeSureBtn.layer setMasksToBounds:YES];
    [makeSureBtn.layer setCornerRadius:3.0f];
    makeSureBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    makeSureBtn.tag = 999;
    
    if(_numOfRow == 0){
        lab1.text = @"用户名称:";
        [self addNavigationType:YKSDefaults NavigationTitle:@"修改用户名"];
        
        _putInTextfield.placeholder = self.nickName;
        example.text = @"\t限制4-16个字符，不能有特殊符号";
        [self.view addSubview:example];
        
        makeSureBtn.frame = CGRectMake(view1.left + 10, example.bottom + 5, view1.width - 20, 40);
        [makeSureBtn addTarget:self action:@selector(changeNickname:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    if(_numOfRow == 2){
        [self addNavigationType:YKSDefaults NavigationTitle:@"修改邮箱"];
        lab1.text = @" 邮箱 :";
        _putInTextfield.placeholder = @"请输入修改的邮箱";
        makeSureBtn.frame = CGRectMake(view1.left + 10, view1.bottom + 10, view1.width - 20, 40);
        [makeSureBtn addTarget:self action:@selector(changeEmail:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:makeSureBtn];
}


- (void)changeNickname:(UIButton *)btn
{
    [_putInTextfield resignFirstResponder];
    if(btn.selected == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名只能修改一次，一旦生成不能再次修改，确认修改吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 1;
        [alert show];
    }
}


#pragma mark --修改邮箱
- (void)changeEmail:(UIButton *)btn
{
    [_putInTextfield resignFirstResponder];
    
    if(btn.selected == NO){
        btn.selected = YES;
        BOOL isTure = [self isValidateEmail:_putInTextfield.text];
        if (!isTure) {
            [self.view makeToast:@"请输入正确的邮箱" duration:1.0 position:CSToastPositionCenter];
        }
        else
        {
            self.changeSomeBlock(_putInTextfield.text, @"Email");
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
    {
        if(buttonIndex == 1)
        {
            BOOL isRight = [self isRightNickname:_putInTextfield.text];
            
            if (!isRight) {
                [self.view makeToast:@"昵称不规范，请参考提示" duration:1.0 position:CSToastPositionCenter];
                return;
            }
            
            int i = [self convertToInt:_putInTextfield.text];
            if (i > 16 || i < 4) {
                [self.view makeToast:@"请输入4—16个字符" duration:1.0 position:CSToastPositionCenter];
                return;
            }
            
            self.changeSomeBlock(_putInTextfield.text, @"Name");
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        if (buttonIndex == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


//利用正则表达式验证邮箱
-(BOOL)isValidateEmail:(NSString *)email
{
    
    NSString *emailRegex = @"[A-Z0-9a-z_%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
}


//判断昵称不能含有特殊字符
- (BOOL)isRightNickname:(NSString *)nickname{
    NSString *regex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:nickname];
}

//textfield代理收回键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//点击空白收回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

//含有汉字的字符串长度计算
- (int)convertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
        
    }
    return strlength;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.numOfRow == 2) {
        if (textField == _putInTextfield) {
            if (string.length == 0) return YES;
            
            NSInteger existedLength = textField.text.length;
            NSInteger selectedLength = range.length;
            NSInteger replaceLength = string.length;
            if (existedLength - selectedLength + replaceLength > 26) {
                return NO;
            }
        }
    }else{
        if (textField == _putInTextfield) {
            if (string.length == 0) return YES;
            
            NSInteger existedLength = textField.text.length;
            NSInteger selectedLength = range.length;
            NSInteger replaceLength = string.length;
            if (existedLength - selectedLength + replaceLength > 16) {
                return NO;
            }
        }
    }
    return YES;
}



@end
