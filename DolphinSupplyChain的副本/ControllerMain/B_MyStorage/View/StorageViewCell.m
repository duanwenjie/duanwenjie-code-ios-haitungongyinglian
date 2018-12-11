//
//  StorageViewCell.m
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/3/14.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "StorageViewCell.h"
@interface StorageViewCell()

@property (nonatomic ,strong)ZXNImageView * vImagView;

@property (nonatomic ,strong)UILabel * labTitle;

@property (nonatomic ,strong)UILabel * labPrice;

@property (nonatomic ,strong)UILabel * labStock;

@property (nonatomic ,strong)UILabel * labSalas;

@property (nonatomic ,strong)UILabel * labSalas_title;



@end


@implementation StorageViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:self.vImagView];
        
        [self addSubview:self.labTitle];
        
        [self addSubview:self.labPrice];
        
        [self addSubview:self.labStock];
        
        [self addSubview:self.labSalas];
        
        [self addSubview:self.labSalas_title];
        
    }
    return self;
}

-(void)setData:(StorageModel *)storageModel{
    
    [self.vImagView downloadImage:storageModel.img_url backgroundImage:ZXNImageDefaul];
    
    self.labTitle.text = storageModel.goods_name;
    
    self.labPrice.text = [NSString stringWithFormat:@"￥%@",storageModel.price];
    
    self.labStock.text = [NSString stringWithFormat:@"库存: %@",storageModel.available];
    
    self.labSalas_title.text = [NSString stringWithFormat:@"%@",storageModel.purchase_count];
}

#pragma mark - 懒加载
-(ZXNImageView *)vImagView{

    if (!_vImagView) {
        _vImagView = [[ZXNImageView alloc]initWithFrame:CGRectMake(15, 15, 65, 65)];
        _vImagView.backgroundColor = [UIColor whiteColor];
        _vImagView.layer.borderColor = kLineColer.CGColor;
        _vImagView.layer.borderWidth = 0.5;
        _vImagView.layer.masksToBounds = YES;

    }
    return _vImagView;
}

-(UILabel *)labTitle{

    if (!_labTitle) {
        _labTitle = [[UILabel alloc]initWithFrame:CGRectMake(_vImagView.right+10, 10, kDisWidth-104, 35)];
        _labTitle.textColor = [UIColor colorWithHexString:@"#333333"];
        _labTitle.textAlignment = NSTextAlignmentLeft;
        _labTitle.numberOfLines = 0;
        _labTitle.font = [UIFont systemFontOfSize:12];
    }
    return _labTitle;
}

-(UILabel *)labPrice{

    if (!_labPrice) {
        _labPrice = [[UILabel alloc]initWithFrame:CGRectMake(_vImagView.right+10, 45, 200, 20)];
        _labPrice.textAlignment = NSTextAlignmentLeft;
        _labPrice.textColor = [UIColor redColor];
        _labPrice.font = [UIFont systemFontOfSize:14];

    }
    return _labPrice;
}

-(UILabel *)labStock{

    if (!_labStock) {
        _labStock = [[UILabel alloc]initWithFrame:CGRectMake(_vImagView.right+10, 65, 60, 20)];
        _labStock.textAlignment = NSTextAlignmentLeft;
        _labStock.textColor = [UIColor colorWithHexString:@"#666666"];
        _labStock.font = [UIFont systemFontOfSize:12];
    }
    return _labStock;
}

-(UILabel *)labSalas{

    if (!_labSalas) {
        _labSalas = [[UILabel alloc]initWithFrame:CGRectMake(self.right-125, 65, 30, 20)];
        _labSalas.textAlignment = NSTextAlignmentLeft;
        _labSalas.textColor = [UIColor colorWithHexString:@"#666666"];
        _labSalas.font = [UIFont systemFontOfSize:12];
        _labSalas.text = @"销量: ";
    }
    return _labSalas;
}

-(UILabel *)labSalas_title{

    if (!_labSalas_title) {
        _labSalas_title = [[UILabel alloc]initWithFrame:CGRectMake(_labSalas.right, 65, 80, 20)];
        _labSalas_title.textAlignment = NSTextAlignmentLeft;
        _labSalas_title.textColor = [UIColor colorWithHexString:@"#666666"];
        _labSalas_title.font = [UIFont systemFontOfSize:12];
    }
    return _labSalas_title;
}















@end
