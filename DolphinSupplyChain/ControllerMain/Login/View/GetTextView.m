//
//  ViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//


#import "GetTextView.h"

static CGFloat  const kLoginTextH = 20.0;

@interface GetTextView()<UITextFieldDelegate>{
    UILabel *lab;
}

@end

@implementation GetTextView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        lab=[[UILabel alloc] initWithFrame:CGRectMake(5.0, 0, 90.0, kLoginTextH)];
        [self addSubview:lab];
        
        _textfield=[[UITextField alloc] initWithFrame:CGRectMake(lab.right, 0.0,kDisWidth-20-90.0, kLoginTextH)];
        [_textfield setClearButtonMode:UITextFieldViewModeWhileEditing];
        _textfield.delegate=self;
        [self addSubview:_textfield];
        
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _title=title;
    lab.text=title;
}

#pragma mark -- textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textfield resignFirstResponder];
    return YES;
}

@end
