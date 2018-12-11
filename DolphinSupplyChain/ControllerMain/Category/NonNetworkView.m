//
//  AppDelegate.m
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "NonNetworkView.h"
#import "UIImage+MJ.h"

@implementation NonNetworkView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self switchToNoNetwork];
    }
    return self;
}


@end
