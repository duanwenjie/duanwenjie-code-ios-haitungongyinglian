//
//  ViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//


#import "PhoneView.h"

@interface PhoneView()<UITextFieldDelegate>
@end

@implementation PhoneView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.lblName = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 70, 44)];
        self.lblName.text=@"账号";
        self.lblName.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.lblName];
        
        _phoneTxt=[[UITextField alloc] initWithFrame:CGRectMake(self.lblName.right, 0, kDisWidth-20 - 100, 44)];
        [_phoneTxt setClearButtonMode:UITextFieldViewModeWhileEditing];
        _phoneTxt.keyboardType=UIKeyboardTypeDefault;
        _phoneTxt.delegate=self;
        _phoneTxt.font = [UIFont systemFontOfSize:14];
        [self addSubview:_phoneTxt];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 44)];
        view.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
        _phoneTxt.inputAccessoryView = view;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kDisWidth * 0.8, 0, kDisWidth * 0.2, 44)];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(confirmEdit) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    return self;
}

-(void)confirmEdit{
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
    if (_phoneTxt==textField) {
        if ([textField.text length]<30) {
            return YES;
        }
    }
    return NO;
}


@end
