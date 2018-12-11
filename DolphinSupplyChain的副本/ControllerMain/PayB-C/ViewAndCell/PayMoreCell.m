//
//  PayMoreCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "PayMoreCell.h"

@interface PayMoreCell ()

@property (nonatomic, strong) UILabel *lblMore;


@end

@implementation PayMoreCell

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
    [self.contentView addSubview:self.lblMore];
    
    [self.lblMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.contentView);
    }];
    
}

- (void)loadViewMore:(NSString *)sMore
{
    self.lblMore.text = sMore;
}


- (UILabel *)lblMore
{
    if (!_lblMore) {
        _lblMore = [[UILabel alloc] init];
        _lblMore.text = @"更多";
        _lblMore.font = [UIFont systemFontOfSize:12];
        _lblMore.textColor = [UIColor colorWithHexString:@"666666"];
        _lblMore.textAlignment = NSTextAlignmentCenter;
    }
    return _lblMore;
}



- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
