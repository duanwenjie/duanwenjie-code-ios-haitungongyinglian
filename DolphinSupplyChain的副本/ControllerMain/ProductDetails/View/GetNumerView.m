//
//  GetNumerView.m
//  Distribution
//
//  Created by fei on 15/5/16.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import "GetNumerView.h"

@interface GetNumerView(){
    UILabel *quatity_text;
}

@end


@implementation GetNumerView


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor clearColor];
        self.layer.borderColor=kLineColer.CGColor;
        self.layer.borderWidth=0.5;
        self.layer.masksToBounds=YES;
        
        UIButton *reduceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0, 35, 35)];
        [reduceBtn addTarget:self action:@selector(reduceQuatityAction:) forControlEvents:UIControlEventTouchUpInside];
        reduceBtn.tag = 100;
        [reduceBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [reduceBtn setTitle:@"-" forState:UIControlStateNormal];
//        [reduceBtn setBackgroundColor:KSystemColor];
        [self addSubview:reduceBtn];
        
        quatity_text = [[UILabel alloc]init];
        quatity_text.frame = CGRectMake(reduceBtn.right, 0, 50, 35);
        quatity_text.textColor = [UIColor blackColor];
        quatity_text.textAlignment=NSTextAlignmentCenter;
        quatity_text.layer.borderColor = kLineColer.CGColor;
        quatity_text.layer.borderWidth = 0.5;
        quatity_text.layer.masksToBounds = YES;
        [self addSubview:quatity_text];
        
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(quatity_text.right,0, 35, 35)];
        [addBtn addTarget:self action:@selector(addQuatityAction:) forControlEvents:UIControlEventTouchUpInside];
        addBtn.tag = 101;
        [addBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [addBtn setTitle:@"+" forState:UIControlStateNormal];
//        [addBtn setBackgroundColor:KSystemColor];
        [self addSubview:addBtn];
        
    }
    return self;
}

-(void)setCountText:(NSString *)countText{
    _countText=countText;
    quatity_text.text=countText;
}

- (void)addQuatityAction:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(getNumberForAddAction)]) {
        [_delegate getNumberForAddAction];
    }
}

- (void)reduceQuatityAction:(UIButton *)btn{

    if ([_delegate respondsToSelector:@selector(getNumberForReduceAction)]) {
        [_delegate getNumberForReduceAction];
    }

}

@end
