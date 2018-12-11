//
//  InfoTableViewCell.m
//  Distribution
//
//  Created by fei on 15/5/14.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import "InfoTableViewCell.h"

@interface InfoTableViewCell ()

@property (nonatomic, strong) UILabel *lblTime;

@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UILabel *lblNeiRon;

@end

@implementation InfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        
        self.lblTime = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, kDisWidth - 30, 27)];
        self.lblTime.font = [UIFont systemFontOfSize:12];
        self.lblTime.textColor = [UIColor colorWithHexString:@"a0a0a0"];
        self.lblTime.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.lblTime];
        
        UIView *vBack = [[UIView alloc] initWithFrame:CGRectMake(15, 35, kDisWidth-30, 125)];
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
        
        UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(12, self.lblNeiRon.bottom + 2, vBack.width - 24, 0.5)];
        vLine.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
        [vBack addSubview:vLine];
        
        UILabel *lblLook = [[UILabel alloc] initWithFrame:CGRectMake(12, vLine.bottom, vBack.width - 44, 27)];
        lblLook.textAlignment = NSTextAlignmentRight;
        lblLook.textColor = [UIColor colorWithHexString:@"a0a0a0"];
        lblLook.font = [UIFont systemFontOfSize:14];
        lblLook.text = @"查看详情";
        [vBack addSubview:lblLook];
        
        UIImageView *imageArr = [[UIImageView alloc] init];
        imageArr.image = [UIImage imageNamed:@"accessory"];
        imageArr.contentMode = UIViewContentModeScaleAspectFit;
        imageArr.frame = CGRectMake(lblLook.right + 4, vLine.bottom, 15, 27);
        [vBack addSubview:imageArr];
        
    }
    return self;
}

-(void)cellDisplayWithModel:(MessageFourModel *)info
{
    self.lblTitle.text = info.title;
    self.lblTime.text = info.add_time;
//    self.lblNeiRon.text = info.content;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];}

@end
