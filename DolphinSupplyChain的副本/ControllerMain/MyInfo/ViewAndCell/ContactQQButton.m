//
//  ContactQQButton.m
//  Distribution
//
//  Created by fei on 15/1/24.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import "ContactQQButton.h"

static CGFloat  const kContactButtonW = 120;

static CGFloat  const kContactButtonH = 40;

static CGFloat  const kImageW = 30;

@interface ContactQQButton(){
    UILabel *title_lab;
    UILabel *subtitle_lab;
    
}

@end

@implementation ContactQQButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.layer.cornerRadius=5.0;
        self.layer.borderColor=[UIColor lightGrayColor].CGColor;
        self.layer.borderWidth=0.5;
        
        CGSize itemSize=CGSizeMake(kImageW,kImageW);
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(55, 20,kImageW,kImageW)];
        imgView.image=[UIImage drawImageWithName:@"qqblue" size:itemSize];
        imgView.contentMode=UIViewContentModeScaleAspectFit;
        [self addSubview:imgView];
        
        title_lab=[[UILabel alloc] initWithFrame:CGRectMake(imgView.right+25.0, imgView.top - 10, kContactButtonW-kImageW, kContactButtonH/2)];
        title_lab.textColor=[UIColor darkGrayColor];
        title_lab.font=[UIFont boldSystemFontOfSize:15.0f];
        [self addSubview:title_lab];
        
        subtitle_lab=[[UILabel alloc] initWithFrame:CGRectMake(imgView.right + 5, title_lab.bottom + 10, kContactButtonW-kImageW, kContactButtonH/2)];
        subtitle_lab.font=[UIFont systemFontOfSize:14];
        subtitle_lab.textColor=[UIColor darkGrayColor];
        subtitle_lab.textAlignment=NSTextAlignmentCenter;
        [self addSubview:subtitle_lab];
        
        
        
    }
    return self;
}

-(void)setName:(NSString *)name{
    _name=name;
    title_lab.text=name;
}

-(void)setQqStr:(NSString *)qqStr{
    _qqStr=qqStr;
    subtitle_lab.text=qqStr;
}


@end
