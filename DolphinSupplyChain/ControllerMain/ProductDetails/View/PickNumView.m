//
//  PickNumView.m
//  Distribution
//
//  Created by fei on 15/1/9.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import "PickNumView.h"

static NSString *num;
@interface PickNumView()<UIPickerViewDataSource,UIPickerViewDelegate> {
    NSMutableArray *goodsNumArray;
}

@end

@implementation PickNumView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.layer.borderWidth=1.0;
        self.layer.borderColor=[UIColor lightGrayColor].CGColor;
        
        UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn setBackgroundColor:[UIColor redColor]];
        [cancleBtn addTarget:self action:@selector(pickerHiden) forControlEvents:UIControlEventTouchUpInside];
        [cancleBtn setExclusiveTouch:YES];
        [self addSubview:cancleBtn];
        
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(kDisWidth-100, 0, 100, 40)];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setBackgroundColor:[UIColor redColor]];
        [sureBtn addTarget:self action:@selector(makeSureNum) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn setExclusiveTouch:YES];
        [self addSubview:sureBtn];
        
        
        _pickView=[[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 40.0, kDisWidth, 260)];
        _pickView.delegate=self;
        _pickView.dataSource=self;
        [self addSubview:_pickView];
        
        num=@"1";
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    frame.size = CGSizeMake(kDisWidth, 300.0);
    [super setFrame:frame];
}

#pragma mark pickerView呆梨
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 200;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%zd",row+1];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    num=[NSString stringWithFormat:@"%zd",row+1];
}


-(void)pickerHiden{
    [UIView animateWithDuration:0.5 animations:^{
        self.frame=CGRectMake(0.0, kDisHeight, kDisWidth, 260);
    }];
}

-(void)makeSureNum{
    if ([_delegate respondsToSelector:@selector(makeSureGetNumActionWithNum:)]) {
        [_delegate makeSureGetNumActionWithNum:num];
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.frame=CGRectMake(0.0, kDisHeight, kDisWidth, 260.0);
    }];
}


@end
