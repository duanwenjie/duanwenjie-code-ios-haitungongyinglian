//
//  InfoTableViewTwoCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/9.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "InfoTableViewTwoCell.h"

@interface InfoTableViewTwoCell ()

@property (nonatomic, strong) UILabel *lblTime;

@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UILabel *lblNeiRon;

@end

@implementation InfoTableViewTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        
        self.lblTime = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, kDisWidth-30, 27)];
        self.lblTime.font = [UIFont systemFontOfSize:12];
        self.lblTime.textColor = [UIColor colorWithHexString:@"a0a0a0"];
        self.lblTime.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.lblTime];
        
        UIView *vBack = [[UIView alloc] initWithFrame:CGRectMake(15, 35, kDisWidth-30, 96)];
        vBack.backgroundColor = [UIColor whiteColor];
        vBack.layer.cornerRadius = 4;
        vBack.layer.borderColor = [UIColor colorWithHexString:@"dcdcdc"].CGColor;
        vBack.layer.borderWidth = 1;
        [self.contentView addSubview:vBack];
        
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, vBack.width - 24, 40)];
        self.lblTitle.font = [UIFont systemFontOfSize:16];
        [vBack addSubview:self.lblTitle];
        
        self.lblNeiRon = [[UILabel alloc] initWithFrame:CGRectMake(12, self.lblTitle.bottom, vBack.width - 24, 53)];
        self.lblNeiRon.textColor = [UIColor colorWithHexString:@"a0a0a0"];
        self.lblNeiRon.font = [UIFont systemFontOfSize:13];
        self.lblNeiRon.numberOfLines = 3;
        [vBack addSubview:self.lblNeiRon];
        
//        UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(12, self.lblNeiRon.bottom + 2, vBack.width - 24, 0.5)];
//        vLine.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
//        [vBack addSubview:vLine];
//        
//        UILabel *lblLook = [[UILabel alloc] initWithFrame:CGRectMake(12, vLine.bottom, vBack.width - 44, 27)];
//        lblLook.textAlignment = NSTextAlignmentRight;
//        lblLook.textColor = [UIColor colorWithHexString:@"a0a0a0"];
//        lblLook.font = [UIFont systemFontOfSize:14];
//        lblLook.text = @"查看详情";
//        [vBack addSubview:lblLook];
//        
//        UIImageView *imageArr = [[UIImageView alloc] init];
//        imageArr.image = [UIImage imageNamed:@"accessory"];
//        imageArr.contentMode = UIViewContentModeScaleAspectFit;
//        imageArr.frame = CGRectMake(lblLook.right + 4, vLine.bottom, 15, 27);
//        [vBack addSubview:imageArr];
        
    }
    return self;
}

-(void)cellDisplayWithModel:(MessageModel *)info
{
    if ([info.type isEqualToString:@"1"]) {
        self.lblTitle.text = @"发货提醒";
    }
    else if ([info.type isEqualToString:@"2"])
    {
        self.lblTitle.text = @"缺货通知";
    }
    else if ([info.type isEqualToString:@"3"])
    {
        self.lblTitle.text = @"库存提醒";
    }
    else
    {
        self.lblTitle.text = info.message;
    }
    self.lblTime.text = info.message;
    self.lblNeiRon.text = info.message;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];}
@end
