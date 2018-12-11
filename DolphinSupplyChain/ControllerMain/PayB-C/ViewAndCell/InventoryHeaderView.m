//
//  InventoryHeaderView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/5/13.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "InventoryHeaderView.h"

@interface InventoryHeaderView ()

@property (nonatomic, strong) UILabel *lblInventory;

@property (nonatomic, strong) UIView *vLine;

@end

@implementation InventoryHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self.contentView addSubview:self.lblInventory];
    [self.contentView addSubview:self.vLine];
    
    [self.lblInventory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.top.bottom.equalTo(self.contentView);
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)loadViewInventory:(NSString *)sInventory
{
    self.lblInventory.text = [NSString stringWithFormat:@"发货地：%@", sInventory];
}


#pragma mark - 懒加载
- (UILabel *)lblInventory
{
    if (!_lblInventory) {
        _lblInventory = [[UILabel alloc] init];
        _lblInventory.font = kFont13;
    }
    return _lblInventory;
}


- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = ColorLine;
    }
    return _vLine;
}


@end
