//
//  ProductTableViewCell.m
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/2/28.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "ProductTableViewCell.h"

@interface ProductTableViewCell()

@property (nonatomic ,strong)ZXNImageView * vImagView;

@property (nonatomic ,strong)UILabel * labTitle;

@property (nonatomic ,strong)UILabel * labCount;

@property (nonatomic ,strong)UILabel * labRemind;

@property (nonatomic ,strong)UILabel * labGoodsSn;




@end

@implementation ProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.vImagView = [[ZXNImageView alloc]init];
        self.vImagView.frame = CGRectMake(15, 10, 70, 70);
        self.vImagView.layer.borderWidth = 0.5;
        self.vImagView.layer.borderColor = [UIColor colorWithHexString:@"#dcdcdc"].CGColor;
        self.vImagView.layer.masksToBounds = YES;
        [self addSubview:self.vImagView];
        
        self.labTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.vImagView.right+10, 10, kDisWidth-110, 30)];
        self.labTitle.textColor = [UIColor colorWithHexString:@"#333333"];
        self.labTitle.textAlignment = NSTextAlignmentLeft;
        self.labTitle.font = [UIFont systemFontOfSize:12];
        self.labTitle.numberOfLines = 0;
        [self addSubview:self.labTitle];
        
        self.labCount = [[UILabel alloc]initWithFrame:CGRectMake(self.vImagView.right+10, 40, 100, 20)];
        self.labCount.textColor = [UIColor colorWithHexString:@"#666666"];
        self.labCount.textAlignment = NSTextAlignmentLeft;
        self.labCount.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.labCount];
        
        self.labRemind = [[UILabel alloc]initWithFrame:CGRectMake(kDisWidth-15-100, 40, 100, 20)];
        self.labRemind.text = @"微仓库存不足";
        self.labRemind.textColor = [UIColor redColor];
        self.labRemind.textAlignment = NSTextAlignmentRight;
        self.labRemind.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.labRemind];

        self.labGoodsSn = [[UILabel alloc]initWithFrame:CGRectMake(self.vImagView.right+10, 60, kDisWidth-110, 20)];
        self.labGoodsSn.textColor = [UIColor colorWithHexString:@"#666666"];
        self.labGoodsSn.textAlignment = NSTextAlignmentLeft;
        self.labGoodsSn.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.labGoodsSn];
        
        
    }
    return self;
    
}

-(void)updateData:(SaleGoodsModel *)goods status:(NSString *)status{

    [self.vImagView downloadImage:goods.img_thumb backgroundImage:ZXNImageDefaul];
    self.labTitle.text = goods.goods_name;
    self.labCount.text = [NSString stringWithFormat:@"数量: %@",goods.quantity];
    self.labGoodsSn.text = [NSString stringWithFormat:@"商品编号:  %@",goods.sku];
    
    int qua = [goods.quantity intValue];
    int stock = [goods.mw_stock intValue];
    NSInteger index=[status integerValue];
    
    if ((index == 0|| index == 3) && qua > stock) {
        self.labRemind.hidden = NO;
    }else{
        self.labRemind.hidden = YES;
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
