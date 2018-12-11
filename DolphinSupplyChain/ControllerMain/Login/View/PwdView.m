//
//  ViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//


#import "PwdView.h"

@interface PwdView()<UITextFieldDelegate>{
    UILabel *lab;
}

@end

@implementation PwdView
@synthesize pwdTxt;

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 70, 44)];
        lab.font = [UIFont systemFontOfSize:14];
        [self addSubview:lab];
        
        pwdTxt=[[UITextField alloc] initWithFrame:CGRectMake(lab.right, 0, kDisWidth-20 - 100, 44)];
        [pwdTxt setClearButtonMode:UITextFieldViewModeWhileEditing];
        pwdTxt.keyboardType = UIKeyboardTypeDefault;
        pwdTxt.font = [UIFont systemFontOfSize:14];
        pwdTxt.delegate=self;
        pwdTxt.secureTextEntry=YES;
        [self addSubview:pwdTxt];
        
    }
    return self;
}

-(void)setLabText:(NSString *)labText{
    _labText=labText;
    lab.text=labText;
}

-(void)setPlaceText:(NSString *)placeText{
    _placeText=placeText;
    pwdTxt.placeholder=placeText;
}

#pragma mark -- textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [pwdTxt resignFirstResponder];
    return YES;
}

#pragma mark -- textfield delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (1 == range.length) {//按下回格键
        return YES;
    }
    if (pwdTxt==textField) {
        if ([textField.text length]<20) {
            return YES;
        }
    }
    return NO;
}


@end
