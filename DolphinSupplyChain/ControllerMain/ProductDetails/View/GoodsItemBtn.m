//
//  GoodsItemBtn.m
//  Distribution
//
//  Created by DIOS on 16/1/9.
//  Copyright (c) 2016年 ___YKSKJ.COM___. All rights reserved.
//

#import "GoodsItemBtn.h"

static CGFloat  const kSpeceLeft = 5;

//static CGFloat  const kTitleLabelHeight = 35;

static CGFloat  const kPricelabHeight = 20;

static NSString * const KHTTPURLTEST = @"http://www.haitun.hk/%@";

#define kLineColer color(220, 220, 220, 1)

@interface GoodsItemBtn ()
{
    ZXNImageView *imageView;
    UILabel *titleLab;
    UILabel *priceLab;
    UILabel *priceLab2;

}
@end

@implementation GoodsItemBtn

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor=[UIColor whiteColor];
    self.layer.borderColor=kLineColer.CGColor;
    self.layer.borderWidth=0.25;
    self.layer.masksToBounds=YES;
    CGFloat width = frame.size.width;
    
    imageView = [[ZXNImageView alloc] initWithFrame:CGRectMake(0, 0, width , width)];
//    self.backgroundColor = [UIColor grayColor];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
   
    [self addSubview:imageView];
    
    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(kSpeceLeft, imageView.bottom, width - 2 * kSpeceLeft, frame.size.height-width-kPricelabHeight)];
//    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(kSpeceLeft, imageView.bottom, width - 2 * kSpeceLeft, kTitleLabelHeight)];
    titleLab.font = [UIFont systemFontOfSize:12.0f];
    titleLab.textColor = [UIColor colorWithHexString:@"#333333"];
    titleLab.numberOfLines = 0;
    [self addSubview:titleLab];
    
    priceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLab.bottom-2, width, kPricelabHeight)];
    priceLab.font = [UIFont systemFontOfSize:14.0f];
    priceLab.textAlignment=NSTextAlignmentCenter;
    priceLab.textColor = [UIColor colorWithHexString:@"#ef2e23"];
    [self addSubview:priceLab];

//    priceLab = [[UILabel alloc] initWithFrame:CGRectMake(kSpeceLeft, titleLab.bottom-2, (width-2*kSpeceLeft)/2-5, kPricelabHeight)];
//    priceLab.font = [UIFont systemFontOfSize:14.0f];
//    priceLab.textAlignment=NSTextAlignmentRight;
//    priceLab.textColor = [UIColor colorWithHexString:@"#ef2e23"];
//    [self addSubview:priceLab];
    
//    priceLab2 = [[UILabel alloc] initWithFrame:CGRectMake(kSpeceLeft+(width-2*kSpeceLeft)/2-5, titleLab.bottom-2, (width-2*kSpeceLeft)/2-5, kPricelabHeight)];
//    priceLab2.font = [UIFont systemFontOfSize:14.0f];
//    priceLab2.textAlignment=NSTextAlignmentCenter;
////    priceLab2.textColor = [UIColor colorWithHexString:@"#ef2e23"];
//    priceLab2.textColor = [UIColor colorWithHexString:@"#999999"];
//
//    [self addSubview:priceLab2];
    
//    UIView * labgray = [[UIView alloc]init];
//    labgray.backgroundColor = [UIColor colorWithHexString:@"#999999"];
//    labgray.frame = CGRectMake(priceLab2.left+width/10, priceLab2.center.y, priceLab2.size.width*6/10, 10);
//    [self addSubview:labgray];
    return self;
}

- (void)setModel:(RecommendModel *)model{
    _model = model;
    
    NSString *urlStr = [NSString stringWithFormat:KHTTPURLTEST,model.goods_img];

//    [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"none"]];
    [imageView downloadImage:urlStr backgroundImage:ZXNImageDefaul];
    titleLab.text = model.goods_name;
    priceLab.text = [NSString stringWithFormat:@"¥%.2f",[model.shop_price floatValue]];
//    priceLab2.text = [NSString stringWithFormat:@"¥%.2f",[model.market_price floatValue]];
}


@end
