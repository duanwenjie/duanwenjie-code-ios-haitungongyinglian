//
//  LogisticsTableViewCell.m
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/3/3.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "LogisticsTableViewCell.h"
@interface LogisticsTableViewCell(){
    
    
}
@property (nonatomic ,strong)UILabel * labCompany;

@property (nonatomic ,strong)UILabel * labLogistic;

@end


@implementation LogisticsTableViewCell
-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
    
}

-(void)updateTrantsEvent:(NSDictionary * )dict model:(TransEventArrayModel *)trantsModel{

    //赋值
    UIView * vHeaderView = [[UIView alloc]init];
    vHeaderView.frame = CGRectMake(0, 0, kDisWidth, 60);
    [self addSubview:vHeaderView];
    
    UILabel * labCompany = [[UILabel alloc]init];
    labCompany.text = [NSString stringWithFormat:@"物流公司: %@",trantsModel.express];
    labCompany.font = [UIFont systemFontOfSize:12];
    labCompany.numberOfLines = 0;
    labCompany.textAlignment = NSTextAlignmentLeft;
    labCompany.textColor = [UIColor colorWithHexString:@"#333333"];
    labCompany.frame = CGRectMake(15, 10, kDisWidth-30, 20);
    [vHeaderView addSubview:labCompany];
    
    UILabel * labLogistic = [[UILabel alloc]init];
    labLogistic.frame = CGRectMake(15, labCompany.bottom, kDisWidth-30, 20);
    labLogistic.text = [NSString stringWithFormat:@"物流单号: %@",trantsModel.transportion_sn];
    labLogistic.font = [UIFont systemFontOfSize:12];
    labLogistic.numberOfLines = 0;
    labLogistic.textAlignment = NSTextAlignmentLeft;
    labLogistic.textColor = [UIColor colorWithHexString:@"#333333"];
    [vHeaderView addSubview:labLogistic];
    
    UIView * vline3 = [[UIView alloc]init];
    vline3.frame = CGRectMake(0, vHeaderView.bottom, kDisWidth, 10);
    vline3.backgroundColor = [UIColor colorWithHexString:@"#efeff2"];
    [vHeaderView addSubview:vline3];
    
    
    [self updateTrants:dict frame:CGRectMake(0,  70, kDisWidth, 70) isFirst:YES];

}

-(void)updateTrantsEvent:(NSDictionary * )dict{

    [self updateTrants:dict frame:CGRectMake(0,  0, kDisWidth, 70) isFirst:NO];
    
}

-(void)updateTrants:(NSDictionary *)dict frame:(CGRect )frame isFirst:(BOOL )isFirst{
    
    
    if (isFirst == YES) {
        UIView * vLogisticsView = [[UIView alloc]init];
        vLogisticsView.frame = frame;
        [self addSubview:vLogisticsView];
        
        UIImageView * vimgNomal = [[UIImageView alloc]init];
        vimgNomal.frame = CGRectMake(15, 10, 12.5, 12.5);
        vimgNomal.image = [UIImage imageNamed:@"icon-logistici1"];
        [vLogisticsView addSubview:vimgNomal];
        
        UIView * vLine = [[UIView alloc]init];
        vLine.frame = CGRectMake(15 + (vimgNomal.width)/2, vimgNomal.bottom , 0.5, 47.5);
        vLine.backgroundColor = kLineColer;
        [vLogisticsView addSubview:vLine];
        
        UILabel * labTitle = [[UILabel alloc]init];
        labTitle.frame = CGRectMake(37.5, 10, kDisWidth-52.5, 30);
        labTitle.text = [NSString stringWithFormat:@"%@", [dict objectForKey:@"event"] ];
        labTitle.font = [UIFont systemFontOfSize:12];
        labTitle.numberOfLines = 0;
        labTitle.textAlignment = NSTextAlignmentLeft;
        labTitle.textColor = [UIColor colorWithHexString:@"#14991e"];
        [vLogisticsView addSubview:labTitle];
        
        UILabel * labTime = [[UILabel alloc]init];
        labTime.frame = CGRectMake(37.5, 40, kDisWidth-52.5, 20);
        labTime.text = [NSString stringWithFormat:@"%@", [dict objectForKey:@"update_time"]];
        labTime.font = [UIFont systemFontOfSize:10];
        labTime.numberOfLines = 0;
        labTime.textAlignment = NSTextAlignmentLeft;
        labTime.textColor = [UIColor colorWithHexString:@"#14991e"];
        [vLogisticsView addSubview:labTime];
        
        UIView * vline2 = [[UIView alloc]init];
        vline2.frame = CGRectMake(37.5, labTime.bottom+10, kDisWidth-52.5, 0.5);
        vline2.backgroundColor = [UIColor colorWithHexString:@"#e2e2e2"];
//        [vLogisticsView addSubview:vline2];
    }else{
    
        UIView * vLogisticsView = [[UIView alloc]init];
        vLogisticsView.frame = frame;
        [self addSubview:vLogisticsView];
        
        UIView * vLine1 = [[UIView alloc]init];
        vLine1.frame = CGRectMake(15 + 12.5/2, 0, 0.5, 10);
        vLine1.backgroundColor = kLineColer;
        [vLogisticsView addSubview:vLine1];
        
        UIImageView * vimgNomal = [[UIImageView alloc]init];
        vimgNomal.frame = CGRectMake(15, 10, 12.5, 12.5);
        vimgNomal.image = [UIImage imageNamed:@"icon-logistici2"];
        [vLogisticsView addSubview:vimgNomal];
        
        UIView * vLine = [[UIView alloc]init];
        vLine.frame = CGRectMake(15 + (vimgNomal.width)/2, vimgNomal.bottom , 0.5, 47.5);
        vLine.backgroundColor = kLineColer;
        [vLogisticsView addSubview:vLine];
        
        UILabel * labTitle = [[UILabel alloc]init];
        labTitle.frame = CGRectMake(37.5, 10, kDisWidth-52.5, 30);
        labTitle.text = [NSString stringWithFormat:@"%@", [dict objectForKey:@"event"] ];
        labTitle.font = [UIFont systemFontOfSize:12];
        labTitle.numberOfLines = 0;
        labTitle.textAlignment = NSTextAlignmentLeft;
        labTitle.textColor = [UIColor colorWithHexString:@"#666666"];
        [vLogisticsView addSubview:labTitle];
        
        UILabel * labTime = [[UILabel alloc]init];
        labTime.frame = CGRectMake(37.5, 40, kDisWidth-52.5, 20);
        labTime.text = [NSString stringWithFormat:@"%@", [dict objectForKey:@"update_time"]];
        labTime.font = [UIFont systemFontOfSize:10];
        labTime.numberOfLines = 0;
        labTime.textAlignment = NSTextAlignmentLeft;
        labTime.textColor = [UIColor colorWithHexString:@"#999999"];
        [vLogisticsView addSubview:labTime];
        
        UIView * vline2 = [[UIView alloc]init];
        vline2.frame = CGRectMake(37.5, labTime.bottom+10, kDisWidth-52.5, 0.5);
        vline2.backgroundColor = kLineColer;
//        [vLogisticsView addSubview:vline2];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
