//
//  ParamView.m
//  Distribution
//
//  Created by fei on 14-11-26.
//  Copyright (c) 2014年 ___YKSKJ.COM___. All rights reserved.
//

#import "ParamView.h"
#import "ProductParaModel.h"

static CGFloat  const kParaH = 30;

@implementation ParamView

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i=0; i<[titles count]; i++) {
            ProductParaModel *paraModel=titles[i];
            UILabel *name_lab=[[UILabel alloc] initWithFrame:CGRectZero];
            name_lab.font=[UIFont systemFontOfSize:16];
            name_lab.textAlignment=NSTextAlignmentCenter;
            name_lab.text=[NSString stringWithFormat:@"%@:",paraModel.name];
            name_lab.textColor=[UIColor lightGrayColor];
            CGFloat labHeight=kParaH;
            CGFloat labWidth=[name_lab.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, labHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:name_lab.font,NSFontAttributeName,nil] context:nil].size.width;
            name_lab.frame=CGRectMake(10.0, kParaH*i, labWidth+10.0, kParaH);
            [self addSubview:name_lab];
            
            UILabel *value_lab=[[UILabel alloc] initWithFrame:CGRectMake(name_lab.right+10.0,kParaH*i,kDisWidth-labWidth-20, kParaH)];
            value_lab.font=[UIFont systemFontOfSize:16];
            value_lab.text=paraModel.value;
            value_lab.textColor=[UIColor blackColor];
            [self addSubview:value_lab];
        }
    }
    return self;
}

@end
