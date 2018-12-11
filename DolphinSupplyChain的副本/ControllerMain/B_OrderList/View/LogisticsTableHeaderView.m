//
//  LogisticsTableHeaderView.m
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/3/3.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "LogisticsTableHeaderView.h"
#import "ErpOrderProductModel.h"



@interface LogisticsTableHeaderView()

@property (nonatomic ,strong)ZXNImageView * vImgView;

@property (nonatomic ,strong)UILabel * lbName;

@property (nonatomic ,strong)UILabel * lbNumber;

@property (nonatomic ,strong)UILabel * lbOrdersn;

@property (nonatomic ,strong)UIView * vLineViewH;

@property (nonatomic ,strong)UILabel * lbCompany;

@property (nonatomic ,strong)UILabel * lbLogistic;

@property (nonatomic ,strong)NSMutableArray * arrModel;


@end


@implementation LogisticsTableHeaderView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
    
}



-(void)updateData:(NSMutableArray *)erpArrM{
    
    for (ErpOrderProductModel * model in erpArrM) {
        [self.arrModel addObject:model];
    }
    
    for (int i = 0 ; i < self.arrModel.count; i++) {
        
        [self updataErpOrderModel:self.arrModel[i] frame:CGRectMake(0, i * 94, kDisWidth, 94)];
        
    }
    
    
    
}


-(void)updataErpOrderModel:(ErpOrderProductModel *)erpOrderModel frame:(CGRect )frame{

    
    UIView * vHeaderView = [[UIView alloc]init];
    vHeaderView.frame = frame;
    [self addSubview:vHeaderView];
    
    
    ZXNImageView * vImagView = [[ZXNImageView alloc]init];
    vImagView.frame = CGRectMake(15, 15, 65, 65);
    vImagView.layer.borderColor = kLineColer.CGColor;
    vImagView.layer.borderWidth = 0.5;
    vImagView.layer.masksToBounds = YES;
    [vHeaderView addSubview:vImagView];
    
    UILabel * lbName = [[UILabel alloc]init];
    lbName.font = [UIFont systemFontOfSize:12];
    lbName.numberOfLines = 0;
    lbName.textColor = [UIColor colorWithHexString:@"#333333"];
    lbName.frame = CGRectMake(vImagView.right+10, 15, kDisWidth-104, 30);
    [vHeaderView addSubview:lbName];

    UILabel * lbNumber = [[UILabel alloc]init];
    lbNumber.font = [UIFont systemFontOfSize:12];
    lbNumber.numberOfLines = 0;
    lbNumber.textColor = [UIColor colorWithHexString:@"#666666"];
    lbNumber.frame = CGRectMake(vImagView.right+10, 50, 100, 20);
    [vHeaderView addSubview:lbNumber];
    
    UILabel * lbOrdersn = [[UILabel alloc]init];
    lbOrdersn.font = [UIFont systemFontOfSize:12];
    lbOrdersn.numberOfLines = 0;
    lbOrdersn.textAlignment = NSTextAlignmentRight;
    lbOrdersn.textColor = [UIColor colorWithHexString:@"#666666"];
    lbOrdersn.frame = CGRectMake(kDisWidth-15-150, 50, 150, 20);
    [vHeaderView addSubview:lbOrdersn];
    
    UIView * vLineViewH = [[UIView alloc]init];
    vLineViewH.backgroundColor = [UIColor colorWithHexString:@"#e2e2e2"];
    vLineViewH.frame = CGRectMake(15, vImagView.bottom+15, kDisWidth-15, 0.5);
    [vHeaderView addSubview:vLineViewH];
    
    
    if (erpOrderModel != nil) {
        [vImagView downloadImage:erpOrderModel.img_thumb backgroundImage:ZXNImageDefaul];
        lbName.text = erpOrderModel.sku_name;
        lbNumber.text = [NSString stringWithFormat:@"数量: %@",erpOrderModel.item_count];
        lbOrdersn.text = [NSString stringWithFormat:@"商品编号: %@",erpOrderModel.orders_sku];
        
    }else{
        
        lbName.text = @"暂无数据";
        lbNumber.text = [NSString stringWithFormat:@"数量: %@",@"暂无数据"];
        lbOrdersn.text = [NSString stringWithFormat:@"商品编号: %@",@"暂无数据"];
        
    }

}

#pragma mark --懒加载
-(ZXNImageView *)vImgView{
    
    if (!_vImgView) {
        _vImgView = [[ZXNImageView alloc]init];
        _vImgView.layer.borderColor = kLineColer.CGColor;
        _vImgView.layer.borderWidth = 0.5;
        _vImgView.layer.masksToBounds = YES;
    }
    return _vImgView;
    
}

-(UILabel *)lbName{
    
    if (!_lbName) {
        _lbName = [[UILabel alloc]init];
        _lbName.font = [UIFont systemFontOfSize:12];
        _lbName.numberOfLines = 0;
        _lbName.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _lbName;
}

-(UILabel *)lbNumber{
    
    if (!_lbNumber) {
        _lbNumber = [[UILabel alloc]init];
        _lbNumber.font = [UIFont systemFontOfSize:12];
        _lbNumber.numberOfLines = 0;
        _lbNumber.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _lbNumber;
}

-(UILabel *)lbOrdersn{
    
    if (!_lbOrdersn) {
        _lbOrdersn = [[UILabel alloc]init];
        _lbOrdersn.font = [UIFont systemFontOfSize:12];
        _lbOrdersn.numberOfLines = 0;
        _lbOrdersn.textAlignment = NSTextAlignmentRight;
        _lbOrdersn.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _lbOrdersn;
}

-(UIView *)vLineViewH{
    
    if (!_vLineViewH) {
        
        _vLineViewH = [[UIView alloc]init];
        _vLineViewH.backgroundColor = [UIColor colorWithHexString:@"#e2e2e2"];
    }
    return _vLineViewH;
}

-(UILabel *)lbCompany{
    
    if (!_lbCompany) {
        _lbCompany = [[UILabel alloc]init];
        _lbCompany.font = [UIFont systemFontOfSize:12];
        _lbCompany.numberOfLines = 0;
        _lbCompany.textAlignment = NSTextAlignmentLeft;
        _lbCompany.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _lbCompany;
}

-(UILabel *)lbLogistic{
    
    if (!_lbLogistic) {
        _lbLogistic = [[UILabel alloc]init];
        _lbLogistic.font = [UIFont systemFontOfSize:12];
        _lbLogistic.numberOfLines = 0;
        _lbLogistic.textAlignment = NSTextAlignmentLeft;
        _lbLogistic.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _lbLogistic;
}

-(NSMutableArray *)arrModel{
    
    if (!_arrModel) {
        _arrModel = [[NSMutableArray alloc]init];
    }
    return _arrModel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
