//
//  AppDelegate.m
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "FrameView.h"

@implementation FrameView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.borderColor=[UIColor lightGrayColor].CGColor;
        self.layer.borderWidth=0.5;
        self.layer.cornerRadius=5.0;
        self.layer.masksToBounds=YES;
        self.backgroundColor=[UIColor whiteColor];
       
    }
    return self;
}

-(void)setIndex:(NSUInteger)index{
    
    for (int i=0; i<index; i++) {
        UILabel *line=[[UILabel alloc] initWithFrame:CGRectMake(0.0,50.0*(i+1),self.frame.size.width,0.5)];
        line.text=@"";
        line.backgroundColor=kLineColer;
        [self addSubview:line];
    }
}

@end
