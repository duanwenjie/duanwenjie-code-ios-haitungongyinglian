//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "PurchaseGoodsCell.h"

@implementation PurchaseGoodsCell
@synthesize imgView;
@synthesize price_lab;
@synthesize name_lab;
@synthesize amount_lab;
@synthesize sn_lab;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat margin = 10;
        CGFloat marginX = 10;
        imgView=[[ZXNImageView alloc] initWithFrame:CGRectMake(margin+5, margin, 70.0, 70.0)];
        imgView.contentMode=UIViewContentModeScaleAspectFit;
        imgView.layer.borderColor = [UIColor colorWithHexString:@"#dcdcdc"].CGColor;
        imgView.layer.borderWidth = 0.5;
        imgView.layer.masksToBounds = YES;
        [self.contentView addSubview:imgView];
        
        //    商品名称
        name_lab=[[UILabel alloc] initWithFrame:CGRectZero];
        name_lab.font=[UIFont systemFontOfSize:12];
        name_lab.numberOfLines=0;
        [name_lab setFrame:CGRectMake(imgView.right+marginX,marginX-2, kDisWidth-imgView.width-2*marginX-margin-5,35.0)];
        name_lab.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.contentView addSubview:name_lab];
        
        //    数量
        amount_lab=[[UILabel alloc] initWithFrame:CGRectMake(imgView.right+marginX, name_lab.bottom,80.0, 20.0)];
        amount_lab.font=[UIFont systemFontOfSize:11.0];
        amount_lab.backgroundColor=[UIColor clearColor];
        amount_lab.textColor=[UIColor colorWithHexString:@"#666666"];
        [self.contentView addSubview:amount_lab];
        
        //    金额
        price_lab=[[UILabel alloc] initWithFrame:CGRectMake(imgView.right+marginX,amount_lab.bottom, 150.0, 20)];
        price_lab.font=[UIFont systemFontOfSize:12.0f];
        price_lab.backgroundColor=[UIColor clearColor];
        price_lab.textColor=[UIColor colorWithHexString:@"#666666"];
        [self.contentView addSubview:price_lab];
        
        sn_lab=[[UILabel alloc] initWithFrame:CGRectMake(kDisWidth-140-margin-5,name_lab.bottom, 140.0, 20)];
        sn_lab.font=[UIFont systemFontOfSize:12.0f];
        sn_lab.textAlignment = NSTextAlignmentRight;
        sn_lab.backgroundColor=[UIColor clearColor];
        sn_lab.textColor= kCustomWordColor;
        [self.contentView addSubview:sn_lab];
        
    }
    return self;
}

-(void)purchaseGoodsCellDisplayWithModel:(PurchaseGoodsModel *)goods{
    NSString *imgUrl=[NSString stringWithFormat:@"%@", goods.img_thumb];

    [imgView downloadImage:imgUrl backgroundImage:ZXNImageDefaul];
    name_lab.text=goods.goods_name;
    float price=[goods.price floatValue];
    price_lab.text=[NSString stringWithFormat:@"¥%.2f",price];
    sn_lab.text=[NSString stringWithFormat:@"商品编号：%@",goods.sku];
    amount_lab.text=[NSString stringWithFormat:@"数量：%@",goods.quantity];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
