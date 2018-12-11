//
//  ParameterView.m
//  Weekens
//
//  Created by fei on 15/4/15.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import "ParameterView.h"
#import "ProductParaModel.h"
#import "UIColor+Hex.h"


@interface ParameterView(){
    UILabel     *blank_lab;
}

@end

@implementation ParameterView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
        blank_lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, kDisWidth-20, 30)];
        blank_lab.text=@"暂无商品参数";
        blank_lab.font=[UIFont systemFontOfSize:12];
        [self addSubview:blank_lab];
        blank_lab.hidden=YES;
        
    }
    return self;
}



-(void)setParameterList:(NSArray *)parameterList{
    _parameterList=parameterList;
    if (parameterList.count == 0) {
        blank_lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, kDisWidth-20, 30)];
        blank_lab.text=@"暂无商品参数";
        blank_lab.font=[UIFont systemFontOfSize:12];
//        [self addSubview:blank_lab];
    }else{
        blank_lab.hidden=YES;
        CGFloat startY=0.0;
        for (int i=0; i<parameterList.count; i++) {
            ProductParaModel *paraModel=parameterList[i];
            UILabel *name_lab=[[UILabel alloc] initWithFrame:CGRectMake(10.0,startY+5.0, 90.0, 30.0)];
            name_lab.font=[UIFont systemFontOfSize:12.0f];
            name_lab.textColor = [UIColor colorWithHexString:@"#555555"];
            name_lab.text=[NSString stringWithFormat:@"%@：",paraModel.name];
//            name_lab.textColor=color(163, 178, 179, 1);
            [self addSubview:name_lab];
            
            UILabel *value_lab=[[UILabel alloc] initWithFrame:CGRectZero];
            value_lab.font=[UIFont systemFontOfSize:12.0f];
            value_lab.text=paraModel.value;
            value_lab.textColor=[UIColor colorWithHexString:@"#444444"];
            value_lab.numberOfLines=0;
            CGFloat labHeight=[value_lab.text boundingRectWithSize:CGSizeMake(kDisWidth-75.0-30,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:value_lab.font,NSFontAttributeName,nil] context:nil].size.height;
            value_lab.frame=CGRectMake(name_lab.right,startY+13.0,kDisWidth-75.0-30, labHeight);
            [self addSubview:value_lab];
            
            startY+=labHeight+5.0;
        }
        [self setSize:CGSizeMake(kDisWidth, startY+50.0)];
    }
}



@end
