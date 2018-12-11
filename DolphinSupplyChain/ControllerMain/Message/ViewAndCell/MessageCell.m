//
//  MessageCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/9.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "MessageCell.h"

@interface MessageCell ()

@property (nonatomic, strong) UIImageView *imgIco;

@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UILabel *lblSubhead;

@property (nonatomic, strong) UILabel *lblTime;

@end

@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self.contentView addSubview:self.imgIco];
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.lblSubhead];
    
    [self.contentView addSubview:self.lblTime];
    
    [self.imgIco mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.width.equalTo(self.imgIco.mas_height);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(8);
        make.left.equalTo(self.imgIco.mas_right).offset(7);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(80);
    }];
    
    [self.lblSubhead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgIco.mas_right).offset(7);
        make.bottom.equalTo(self.imgIco.mas_bottom).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(25);
    }];
    
    [self.lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(8);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(160);
    }];
}

- (void)loadView:(NSString *)sURL
            Name:(NSString *)sName
         Subhead:(NSString *)sSubhead
            Time:(NSString *)sTime
{
    self.imgIco.image = [UIImage imageNamed:sURL];
    self.lblTitle.text = sName;
    self.lblSubhead.text = sSubhead;
    self.lblTime.text = sTime;
    
    [self setNeedsLayout];
}

- (UIImageView *)imgIco
{
    if (!_imgIco) {
        _imgIco = [[UIImageView alloc] init];
    }
    return _imgIco;
}

- (UILabel *)lblTitle
{
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.textColor = [UIColor colorWithHexString:@"333333"];
        _lblTitle.font = [UIFont systemFontOfSize:16];
    }
    return _lblTitle;
}

- (UILabel *)lblSubhead
{
    if (!_lblSubhead) {
        _lblSubhead = [[UILabel alloc] init];
        _lblSubhead.textColor = [UIColor colorWithHexString:@"999999"];
        _lblSubhead.font = [UIFont systemFontOfSize:14];
    }
    return _lblSubhead;
}

- (UILabel *)lblTime
{
    if (!_lblTime) {
        _lblTime = [[UILabel alloc] init];
        _lblTime.textColor = [UIColor colorWithHexString:@"999999"];
        _lblTime.font = [UIFont systemFontOfSize:12];
        _lblTime.textAlignment = NSTextAlignmentRight;
    }
    return _lblTime;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
