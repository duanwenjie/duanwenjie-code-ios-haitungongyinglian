//
//  ViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//


#import "PhoneMsgView.h"

@interface PhoneMsgView()<UITextFieldDelegate>{
    UILabel    *lab;
    UIButton   *verifyBtn;
    int        time;
    NSTimer    *timer;
    UILabel    *time_lab;
}
@property NSTimer *countDownTimer;
@property(nonatomic,strong) UIButton *GetTheVerificationNumButton;
@end

@implementation PhoneMsgView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 85, 44)];
        lab.text = @"手机验证码";
        lab.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:lab];
        
        _phoneTxt=[[UITextField alloc] initWithFrame:CGRectMake(lab.right, 0,kDisWidth-20 - 200, 44)];
        [_phoneTxt setClearButtonMode:UITextFieldViewModeWhileEditing];
        _phoneTxt.keyboardType=UIKeyboardTypeNumberPad;
        _phoneTxt.delegate=self;
        _phoneTxt.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:_phoneTxt];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 40)];
        view.backgroundColor = [UIColor lightGrayColor];
        _phoneTxt.inputAccessoryView = view;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kDisWidth - 60, 0, 50, 40)];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(confirmEdit) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
        verifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        verifyBtn.frame = CGRectMake(self.width - 80, 9, 80, 28);
        [verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [verifyBtn setTitleColor:ColorAPPTheme forState:UIControlStateNormal];
        verifyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:10];
        verifyBtn.layer.borderWidth = 1;
        verifyBtn.layer.cornerRadius = 3;
        verifyBtn.layer.borderColor = ColorAPPTheme.CGColor;
        verifyBtn.layer.masksToBounds = YES;
        [verifyBtn addTarget:self action:@selector(btnn:) forControlEvents:UIControlEventTouchUpInside];
        verifyBtn.selected = NO;
        [verifyBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateSelected];
        [self addSubview:verifyBtn];

    }
    return self;
}

#pragma mark - 获取手机验证码
-(void)btnn:(UIButton *)btn
{
    if (!btn.selected) {
        if ([self.delegate respondsToSelector:@selector(PhoneMsgViewBtn)]) {
            [self.delegate PhoneMsgViewBtn];
        }
    }
}


-(void)confirmEdit
{
    [_phoneTxt resignFirstResponder];
}

#pragma mark -- textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_phoneTxt resignFirstResponder];
    return YES;
}

#pragma mark -- textfield delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (1 == range.length) {//按下回格键
        return YES;
    }
    if (_phoneTxt == textField) {
        if ([textField.text length] < 11) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 开始定时器
-(void)getAgainVerifyMessage
{
    verifyBtn.userInteractionEnabled = NO;
    time = 60;
    verifyBtn.selected = YES;
    verifyBtn.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
    [verifyBtn setTitle:@"60(s)" forState:UIControlStateSelected];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(function)userInfo:nil repeats:YES];
}

#pragma mark - 定时任务
-(void)function
{
    time--;
    [verifyBtn setTitle:[NSString stringWithFormat:@"%d(s)", time] forState:UIControlStateSelected];
    if (time <= 0) {
        [timer invalidate];
        timer = nil;
        
        verifyBtn.userInteractionEnabled = YES;
        time = 60;
        verifyBtn.selected = NO;
        [verifyBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        verifyBtn.layer.borderColor = ColorAPPTheme.CGColor;
    }
}

#pragma mark - 停止定时器
- (void)stopTiem
{
    [timer invalidate];
    timer = nil;
}

@end
