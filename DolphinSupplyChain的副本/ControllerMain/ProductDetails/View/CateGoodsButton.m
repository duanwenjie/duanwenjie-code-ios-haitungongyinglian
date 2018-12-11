//
//  CateGoodsButton.m
//  Distribution
//
//  Created by fei on 15/5/6.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import "CateGoodsButton.h"


@interface CateGoodsButton (){
    ZXNImageView  *imgView;
    UILabel      *name_lab;
    UILabel      *price_lab;
    UILabel      *soldOutLab;
}

@end

@implementation CateGoodsButton

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        imgView=[[ZXNImageView alloc] initWithFrame:CGRectMake(0, 5, (kDisWidth-30)/3, (kDisWidth-30)/3)];
        [self addSubview:imgView];
        
        name_lab=[[UILabel alloc] initWithFrame:CGRectMake(0, imgView.bottom, (kDisWidth-30)/3, 38)];
        name_lab.textColor = [UIColor colorWithHexString:@"#333333"];
        name_lab.numberOfLines=0;
        name_lab.font=[UIFont systemFontOfSize:12];
        name_lab.textAlignment=NSTextAlignmentCenter;
        [self addSubview:name_lab];
        
        price_lab=[[UILabel alloc] initWithFrame:CGRectMake(0, name_lab.bottom, (kDisWidth-30)/3, 20)];
        price_lab.textAlignment=NSTextAlignmentCenter;
        price_lab.textColor=[UIColor colorWithHexString:@"#ff5e5e"];
        price_lab.font=[UIFont systemFontOfSize:12];
        [self addSubview:price_lab];
        
        soldOutLab=[[UILabel alloc] initWithFrame:CGRectMake(((kDisWidth-30)/3-30)/2.0-10, ((kDisWidth-30)/3-60)/2.0, 60.0, 60.0)];
        soldOutLab.layer.cornerRadius=30;
        soldOutLab.backgroundColor=[UIColor blackColor];
        soldOutLab.alpha=0.5;
        soldOutLab.text=@"暂无库存";
        soldOutLab.layer.masksToBounds=YES;
        soldOutLab.font=[UIFont systemFontOfSize:12];
        soldOutLab.textColor=[UIColor whiteColor];
        soldOutLab.textAlignment=NSTextAlignmentCenter;
//        [self addSubview:soldOutLab];
        soldOutLab.hidden=YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


-(void)setFrame:(CGRect)frame{
    frame.size=CGSizeMake((kDisWidth-30)/3, (kDisWidth-30)/3+60);
    [super setFrame:frame];
}

-(void)setGoodsInfo:(GoodsInfoModel *)goodsInfo{
    NSString *imgurl=[NSString stringWithFormat:@"%@", goodsInfo.img_original];
//    [imgView sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:[UIImage imageNamed:@"none"]];
    [imgView downloadImage:imgurl backgroundImage:ZXNImageDefaul];
    NSString * str = goodsInfo.goods_name;
    NSString * deleteStr = @"保税区直发";
    NSString * deleteStr2 = @" ";
    NSMutableString * strM = [NSMutableString stringWithString:str];
    NSRange range = [strM rangeOfString:deleteStr];
    NSRange range2 = [strM rangeOfString:deleteStr2];
    if (range.location != NSNotFound) {
        NSInteger loc = range.location;
        NSInteger len = range.length;
        [strM deleteCharactersInRange:NSMakeRange(loc, len+1)];
    }
    if (range2.location != NSNotFound) {
        NSInteger loc = range2.location;
        NSInteger len = range2.length;
        [strM deleteCharactersInRange:NSMakeRange(loc, len)];
    }

    NSString * deleteStr3 = @"【一般贸易】";
    NSString * deleteStr4 = @"香港直邮";
    NSString * deleteStr5 = @"德国直邮";
    NSString * deleteStr6 = @"英国直邮";
    NSString * deleteStr7 = @"日本直邮";
    NSString * strM3 = [self handleStr:strM :deleteStr3];
    NSString * strM4 = [self handleStr:strM3 :deleteStr4];
    NSString * strM5 = [self handleStr:strM4 :deleteStr5];
    NSString * strM6 = [self handleStr:strM5 :deleteStr6];
    NSString * strM7 = [self handleStr:strM6 :deleteStr7];
    name_lab.text = strM7;
    double price=[goodsInfo.price doubleValue];
    price_lab.text=[NSString stringWithFormat:@"¥%.2f", price];
    NSInteger stock = [goodsInfo.has_stock integerValue];
    soldOutLab.hidden= stock<=0?NO:YES;
}
-(NSString *)handleStr:(NSString *) str:(NSString *)deleteStr{
    NSMutableString * strM = [NSMutableString stringWithString:str];
    NSRange range = [strM rangeOfString:deleteStr];
    if (range.location != NSNotFound) {
        NSInteger loc = range.location;
        NSInteger len = range.length;
        [strM deleteCharactersInRange:NSMakeRange(loc, len)];
    }
    return strM;
}

@end
