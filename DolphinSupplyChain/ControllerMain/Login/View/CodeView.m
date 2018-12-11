//
//  ViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//


#import "CodeView.h"
#import "LoginButton.h"
@interface CodeView ()<UITextFieldDelegate>{
    LoginButton *verifyBtn;
    int      time;
    int      secondsCountDown;
    NSTimer     *timer;
    BOOL        isTaking;
    
    UILabel    *labelText;
    UILabel    *time_lab;
    
    
    
}
@property int secondsCountDown; //倒计时总时长
@property NSTimer *countDownTimer;
@property(nonatomic,strong) UIButton *GetTheVerificationNumButton;
@end

@implementation CodeView
@synthesize verifyText;
@synthesize verifyText2;

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        verifyText=[[UITextField alloc] initWithFrame:CGRectMake(0.0,10.0, 120.0, 30.0)];
        verifyText.layer.cornerRadius=5.0;
        verifyText.layer.borderColor=[UIColor lightGrayColor].CGColor;
        verifyText.layer.borderWidth=0.5;
        verifyText.placeholder=@"请输入验证码";
        verifyText.keyboardType=UIKeyboardTypeDefault;
        verifyText.font=[UIFont systemFontOfSize:12];
        verifyText.delegate=self;
        [self addSubview:verifyText];
        
        UIButton *imgViewBtn = [[UIButton alloc]init];
        imgViewBtn.frame = CGRectMake(verifyText.right+20.0,10.0,kDisWidth/2-40.0,30.0);
        imgViewBtn.layer.cornerRadius=5.0;
        imgViewBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [imgViewBtn addTarget:self action:@selector(imageViewDidClick:) forControlEvents:UIControlEventTouchUpInside];
        imgViewBtn.layer.borderWidth=0.5;
        ZXNImageView * imgView = [[ZXNImageView alloc]init];
        imgView.frame = CGRectMake(verifyText.right+20.0,10.0,kDisWidth/2-40.0,30.0);
//        [imgView sd_setImageWithURL:[NSURL URLWithString:_imgUrlStr] placeholderImage:[UIImage imageNamed:@"none"]];
        [imgView downloadImage:_imgUrlStr backgroundImage:ZXNImageDefaul];
        [self addSubview:imgViewBtn];
        
        verifyText2=[[UITextField alloc] initWithFrame:CGRectMake(0.0,45, 120.0, 30.0)];
        verifyText2.layer.cornerRadius=5.0;
        verifyText2.layer.borderColor=[UIColor lightGrayColor].CGColor;
        verifyText2.layer.borderWidth=0.5;
        verifyText2.placeholder=@"请输入短信验证码";
        verifyText2.keyboardType=UIKeyboardTypeNumberPad;
        verifyText2.font=[UIFont systemFontOfSize:12];
        verifyText2.delegate=self;
        [self addSubview:verifyText2];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 50)];
        view.backgroundColor = [UIColor lightGrayColor];
        verifyText.inputAccessoryView = view;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kDisWidth * 0.8, 5, 40, 40)];
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(confirmEdit) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
        //**************************************************************
        verifyBtn=[[LoginButton alloc] initWithFrame:CGRectMake(verifyText2.right+20.0,45.0,kDisWidth/2-40.0,30.0)];
        verifyBtn.layer.borderWidth=0.5;
        verifyBtn.backgroundColor=[UIColor whiteColor];
        [verifyBtn setTitle:@"获取短信验证码" forState:UIControlStateNormal];
        [verifyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        verifyBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        
        [verifyBtn addTarget:self action:@selector(getAgainVerifyMessage) forControlEvents:UIControlEventTouchUpInside];
        verifyBtn.titleEdgeInsets=UIEdgeInsetsMake(5.0, 5.0, 5.0, 20.0);
        [self addSubview:verifyBtn];
        [verifyText becomeFirstResponder];
        
        time=60;
        
        time_lab=[[UILabel alloc] initWithFrame:CGRectMake(verifyBtn.size.width*2/3, 1.5, 30.0, 27.0)];
        time_lab.text=[NSString stringWithFormat:@"(%d)",time];
        time_lab.textAlignment=NSTextAlignmentRight;
        time_lab.textColor=[UIColor lightGrayColor];
        time_lab.font = [UIFont systemFontOfSize:12];
        time_lab.backgroundColor=[UIColor clearColor];
        [verifyBtn addSubview:time_lab];
        
        time_lab.hidden=YES;
        isTaking = NO;
        //**************************************************************
    }
    return self;
}
-(void)confirmEdit{
    [verifyText resignFirstResponder];
}
-(void)imageViewDidClick:(UIButton *)imgBtn{

    ZXNLog(@"图片按钮被点击了");
}
-(void)getAgainVerifyMessage{
    isTaking=!isTaking;
    if (isTaking) {
        time_lab.hidden=NO;
        verifyBtn.enabled=NO;
        [verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        isTaking=NO;
        time=60;
    }else{
        time_lab.hidden=YES;
        verifyBtn.enabled=YES;
        [verifyBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        
        isTaking=YES;
    }
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(function00)userInfo:nil repeats:YES];
    
    if ([_delegate respondsToSelector:@selector(getCodeAction)]) {
        [_delegate getCodeAction];
    }
}
-(void)function00{
    time--;
    time_lab.text=[NSString stringWithFormat:@"(%d)",time];
    if (time==0) {
        [timer invalidate];
        time_lab.hidden=YES;
        verifyBtn.enabled=YES;
        [verifyBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        time=60;
    }
}

#pragma mark -- textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [verifyText resignFirstResponder];
    return YES;
}

#pragma mark -- textfield delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (1 == range.length) {//按下回格键
        return YES;
    }
    if (verifyText==textField) {
        if ([textField.text length]<6) {
            return YES;
        }
    }
    return NO;
}



@end
