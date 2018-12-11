//
//  ParaView.m
//  Distribution
//
//  Created by yksmacmini2 on 15-1-6.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import "ParaView.h"



@implementation ParaView

-(instancetype)initWithFrame:(CGRect)frame WithTitle:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
        if (titles.count==0) {
            UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake((self.width-150.0)/2,20,150, 40)];
            lab.text=@"暂无商品参数";
            lab.textAlignment=NSTextAlignmentCenter;
            lab.textColor=[UIColor blackColor];
            [self addSubview:lab];
        }else{
            for (int i=0; i<[titles count]; i++) {
                CGFloat oldHeight = 0;
                UILabel *value_lab=[[UILabel alloc] initWithFrame:CGRectZero];
                value_lab.font=[UIFont systemFontOfSize:14.0];
                [UIFont fontNamesForFamilyName:@""];

                value_lab.textColor=[UIColor blackColor];
                value_lab.numberOfLines=0;
                CGFloat labY=[value_lab.text boundingRectWithSize:CGSizeMake(kDisWidth-20,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:value_lab.font,NSFontAttributeName,nil] context:nil].size.height;
                
                [value_lab setFrame:CGRectMake(10.0, oldHeight + 10,kDisWidth-40,labY)];
//                oldHeight = value_lab.bottom;
                [self addSubview:value_lab];
                
            }
        }
        UILabel *label = (UILabel *)self.subviews.lastObject;
        CGRect f= self.frame;
        f.size.height = label.bottom;
        self.frame = f;
    }
    return self;
}

@end
