//
//  ButtonGroup.m
//  Weekens
//
//  Created by fei on 15/4/15.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import "ButtonGroup.h"


@interface ButtonGroup(){
//    UIButton  *selectBtn;
    UILabel   *line_lab;
    
    CGFloat   btnWidth;
}

@end

@implementation ButtonGroup

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles index:(NSInteger )index{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
        NSUInteger num=titles.count;
        btnWidth=kDisWidth/num;
        for (int i=0; i<num; i++) {
            self.btn = [[UIButton alloc] initWithFrame:CGRectMake(i*btnWidth, 0, btnWidth, 40.0)];
            [self.btn setTitle:titles[i] forState:UIControlStateNormal];
            [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.btn setTitleColor:ColorAPPTheme forState:UIControlStateSelected];
            self.btn.tag=100+i;
            self.btn.titleLabel.font=[UIFont systemFontOfSize:14];
            [self.btn addTarget:self action:@selector(changeViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:self.btn];
            
            if (index == nil) {
                if (i==0) {
                    self.selectBtn=self.btn;
                    self.selectBtn.selected=YES;
                }

            }
            else{
            if (i == index) {
                self.selectBtn=self.btn;
                self.selectBtn.selected=YES;
            }
            }
        }
        
        line_lab=[[UILabel alloc] initWithFrame:CGRectMake(5.0, 39, btnWidth-10.0, 1.0)];
        line_lab.backgroundColor= ColorAPPTheme;
        [self addSubview:line_lab];
    }
    return self;
}

-(void)changeViewWithButton:(UIButton *)btn{
    
    
    NSUInteger index=btn.tag-100;
    [UIView animateWithDuration:0.2 animations:^{
        self.selectBtn.selected = NO;
        btn.selected = YES;
        self.selectBtn = btn;
        line_lab.frame = CGRectMake(index*btnWidth+5.0, 39, btnWidth-10.0, 1.0);
    }];
    
    if ([_delegate respondsToSelector:@selector(buttonGroupActionWithIndex:)]) {
        [_delegate buttonGroupActionWithIndex:index];
    }
}


-(void)changeViewWithButton2:(NSInteger )indexx{
    
    
    NSUInteger index = indexx;
//    self.btn.selected = YES;
    line_lab.frame=CGRectMake(index*btnWidth+5.0, 39, btnWidth-10.0, 1.0);

    
    if ([_delegate respondsToSelector:@selector(buttonGroupActionWithIndex:)]) {
        [_delegate buttonGroupActionWithIndex:index];
    }
}

@end
