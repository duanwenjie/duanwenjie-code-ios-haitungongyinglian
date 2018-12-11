//
//  LargeImageView.m
//  Weekens
//
//  Created by fei on 15/4/15.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import "LargeImageView.h"

@interface LargeImageView()
{
    UILabel *lab;
}

@end

@implementation LargeImageView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor blueColor];
    }
    return self;
}

-(void)setImages:(NSString *)images{
   
    _images=images;
    if (images == nil) {
        lab=[[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 40)];
        lab.text=@"暂无图文详情";
        lab.textColor = color(70, 70, 70, 1);
        [self addSubview:lab];
        
    }else{
        [self.wbView loadHTMLString:images baseURL:nil];

    }
}

- (WKWebView *)wbView
{
    if (!_wbView) {
        _wbView = [[WKWebView alloc]init];
        _wbView.frame = CGRectMake(0, 0, kDisWidth, kDisHeight - kDisNavgation - 40 - 50);
        _wbView.backgroundColor = [UIColor whiteColor];
         [self addSubview:self.wbView];
    }
    return _wbView;
}

@end
