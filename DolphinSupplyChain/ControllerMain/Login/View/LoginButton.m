//
//  ViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//


#import "LoginButton.h"

@implementation LoginButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.cornerRadius=5.0;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundColor:color(76, 175, 255, 1)];
        self.titleLabel.font=[UIFont boldSystemFontOfSize:16.0];
    }
    return self;
}

@end
