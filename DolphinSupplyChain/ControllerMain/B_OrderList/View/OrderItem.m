//
//  OrderItem.m
//  Distribution
//
//  Created by fei on 14-12-23.
//  Copyright (c) 2014年 ___YKSKJ.COM___. All rights reserved.
//

#import "OrderItem.h"

static CGFloat  const kItemScale = 0.2;

@implementation OrderItem
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment=NSTextAlignmentCenter;

    }
    return self;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat y=contentRect.size.height*(1-kItemScale)-5.0;
    CGFloat w=contentRect.size.width;
    CGFloat h=contentRect.size.height*kItemScale;
    return CGRectMake(0, y, w, h);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat w=contentRect.size.height*(1-kItemScale)-5.0;
    CGFloat h=contentRect.size.height*(1-kItemScale)-5.0;
    CGFloat x=(contentRect.size.width-w)/2;
    return CGRectMake(x, 0, w, h);
}

@end
