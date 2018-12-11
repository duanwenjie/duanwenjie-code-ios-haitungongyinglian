//
//  UnLoginView.m
//  Distribution
//
//  Created by DIOS on 15/5/8.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import "UnLoginView.h"

@implementation UnLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    CGFloat width = frame.size.width;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 80)];
    imageView.center = CGPointMake(width/2, 120);
    imageView.image = [UIImage imageNamed:@"avatar"];
    [self addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom + 5, width, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14.0f];
    label.text  = @"您还没有登录，请先登录";
    [self addSubview:label];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 35)];
    btn.center = CGPointMake(width/2, label.bottom + 20);
    [btn setTitle:@"去登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor colorWithWhite:0.7 alpha:1.0] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 4.0;
    btn.layer.borderWidth = 0.8;
    btn.layer.borderColor = [UIColor colorWithWhite:0.7 alpha:1.0].CGColor;
    [self addSubview:btn];
    
    
    
    return self;
}

- (void)login:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(turnToLoginVC)]) {
        [_delegate turnToLoginVC];
    }
    
}

@end
