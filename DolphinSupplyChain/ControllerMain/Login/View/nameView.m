//
//  ViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//


#import "nameView.h"

@interface nameView()<UITextFieldDelegate>{
    UILabel *lab;
    UIImageView * imgView;
}

@end

@implementation nameView
@synthesize pwdTxt;

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 70, 44)];
        lab.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:lab];
        
        pwdTxt = [[UITextField alloc] initWithFrame:CGRectMake(lab.right, 0,kDisWidth-20 - 200, 44)];
        [pwdTxt setClearButtonMode:UITextFieldViewModeWhileEditing];
        pwdTxt.keyboardType = UIKeyboardTypeDefault;
        pwdTxt.font = [UIFont systemFontOfSize:14.0f];
        pwdTxt.delegate=self;
        [self addSubview:pwdTxt];
        
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 80, 0, 80, 44)];
        imgView.backgroundColor = [UIColor grayColor];
        [self addSubview:imgView];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(imgView.left, 0, 80, 44);
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}
-(void)btn:(UIButton *)btn{

    if ([self.delegate respondsToSelector:@selector(imgViewBtn)]) {
        [self.delegate imgViewBtn];
    }
}
-(void)setLabText:(NSString *)labText{
    _labText=labText;
    lab.text=labText;
}

-(void)setPlaceText:(NSString *)placeText{
    _placeText=placeText;
    pwdTxt.placeholder=placeText;
}
-(void)setImgURLData:(NSString *)imgURLData{

    _imgURLData = imgURLData;
    NSData *_decodedImageData   = [[NSData alloc] initWithBase64Encoding:imgURLData];
    UIImage * Image  = [UIImage imageWithData:_decodedImageData];
    imgView.image = Image;
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
