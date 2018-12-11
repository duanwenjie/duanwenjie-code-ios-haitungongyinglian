//
//  OrderListFootView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/5.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "OrderListFootView.h"

@interface OrderListFootView ()

@property (nonatomic, strong) UILabel *lblAddress;

@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UILabel *lblStatusName;

@property (nonatomic, strong) UILabel *lblStatus;

@property (nonatomic, strong) UIButton *btnLeft;

@property (nonatomic, strong) UIButton *btnRight;

@property (nonatomic, copy) NSString *sType;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSArray *arrStatus;

@end


@implementation OrderListFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.sType = @"";
        self.index = 0;
        
        self.arrStatus = @[@"cancel",      // 取消订单
                           @"succeed",     // 完成订单
                           @"No_Pay",      // 未支付订单
                           @"shipments",   // 未发货订单
                           @"delivery"];   // 已发货订单
        
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self.contentView addSubview:self.lblAddress];
    [self.contentView addSubview:self.vLine];
    
    [self.contentView addSubview:self.lblStatusName];
    [self.contentView addSubview:self.lblStatus];
    
    [self.contentView addSubview:self.btnLeft];
    [self.contentView addSubview:self.btnRight];
    
    
    [self.lblAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.height.mas_equalTo(35);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblAddress.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.lblStatusName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLine.mas_bottom).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.lblStatus.mas_left);
    }];
    
    [self.lblStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLine.mas_bottom).offset(0);
        make.left.equalTo(self.lblStatusName.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        
    }];
    
    [self.btnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLine.mas_bottom).offset(6);
        make.right.equalTo(self.contentView.mas_right).offset(-93);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-6);
        make.width.mas_equalTo(63);
    }];
    
    [self.btnRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLine.mas_bottom).offset(6);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-6);
        make.width.mas_equalTo(63);
    }];
}

#pragma mark - 按钮点击事件
- (void)tapLeft
{
    if (self.sType.length == 0) {
        return;
    }
    
    if ([self.sType isEqualToString:self.arrStatus[2]]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(CancelOrder:)]) {
            [self.delegate CancelOrder:self.index];
        }
    }
    
    if ([self.sType isEqualToString:self.arrStatus[4]]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(CheckLogisticsOrder:)]) {
            [self.delegate CheckLogisticsOrder:self.index];
        }
    }
    
}

- (void)tapRight
{
    if (self.sType.length == 0) {
        return;
    }
    
    if ([self.sType isEqualToString:self.arrStatus[0]] || [self.sType isEqualToString:self.arrStatus[1]]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(DeleteOrder:)]) {
            [self.delegate DeleteOrder:self.index];
        }
    }
    
    if ([self.sType isEqualToString:self.arrStatus[3]]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(CancelOrder:)]) {
            [self.delegate CancelOrder:self.index];
        }
    }
    
    
    if ([self.sType isEqualToString:self.arrStatus[2]]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(PayOrder:)]) {
            [self.delegate PayOrder:self.index];
        }
    }
    
    
    if ([self.sType isEqualToString:self.arrStatus[4]]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(ReceiptOrder:)]) {
            [self.delegate ReceiptOrder:self.index];
        }
    }
}


#pragma mark - 渲染数据
- (void)loadViewAddress:(NSString *)sAddress
                 Status:(NSString *)sStatus
                  Money:(NSString *)sMoney
                   Type:(NSString *)sType
                  Index:(NSInteger )index
{
    self.sType = sType;
    self.index = index;
    
    if (sAddress.length == 0) {
        self.lblAddress.text = @"寄往：暂无收货地址";
    }
    else
    {
        self.lblAddress.text = [NSString stringWithFormat:@"寄往：%@",sAddress];
    }
    
    if ([sType isEqualToString:self.arrStatus[0]]) {
        
        // 已取消 订单状态
        self.btnLeft.hidden = YES;
        
        [self.btnRight setBackgroundColor:[UIColor whiteColor]];
        [self.btnRight setTitle:@"删除订单" forState:UIControlStateNormal];
        [self.btnRight setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        
        self.lblStatusName.text = @"";
        self.lblStatus.text = @"";
    }
    else if ([sType isEqualToString:self.arrStatus[1]])
    {
        // 已完成 订单状态
        self.btnLeft.hidden = YES;
        
        [self.btnRight setBackgroundColor:[UIColor whiteColor]];
        [self.btnRight setTitle:@"删除订单" forState:UIControlStateNormal];
        [self.btnRight setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        
        self.lblStatusName.text = @"";
        self.lblStatus.text = @"";
    }
    else if ([sType isEqualToString:self.arrStatus[2]])
    {
        // 待付款 订单状态
        self.btnLeft.hidden = NO;
        [self.btnLeft setTitle:@"取消订单" forState:UIControlStateNormal];
        
        [self.btnRight setBackgroundColor:[UIColor colorWithHexString:@"12a0ea"]];
        [self.btnRight setTitle:@"付款" forState:UIControlStateNormal];
        [self.btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.lblStatusName.text = @"应付款：";
        self.lblStatus.text = [NSString stringWithFormat:@"¥ %@",sMoney];
        
    }
    else if ([sType isEqualToString:self.arrStatus[3]])
    {
        // 待发货 订单状态
        self.btnLeft.hidden = YES;
        self.btnRight.hidden = YES;
        
        self.lblStatusName.text = @"";
        self.lblStatus.text = @"";
        
    }
    else if ([sType isEqualToString:self.arrStatus[4]])
    {
        // 待收货 订单状态
        self.btnLeft.hidden = NO;
        [self.btnLeft setTitle:@"查看物流" forState:UIControlStateNormal];
        
        [self.btnRight setBackgroundColor:[UIColor colorWithHexString:@"12a0ea"]];
        [self.btnRight setTitle:@"确认收货" forState:UIControlStateNormal];
        [self.btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.lblStatusName.text = @"";
        self.lblStatus.text = @"";
    }
}




#pragma mark - 懒加载
- (UILabel *)lblAddress
{
    if (!_lblAddress) {
        _lblAddress = [[UILabel alloc] init];
        _lblAddress.textColor = [UIColor colorWithHexString:@"666666"];
        _lblAddress.font = [UIFont systemFontOfSize:12];
    }
    return _lblAddress;
}

- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    }
    return _vLine;
}

- (UILabel *)lblStatusName
{
    if (!_lblStatusName) {
        _lblStatusName = [[UILabel alloc] init];
        _lblStatusName.textColor = [UIColor colorWithHexString:@"666666"];
        _lblStatusName.font = [UIFont systemFontOfSize:13];
    }
    return _lblStatusName;
}

- (UILabel *)lblStatus
{
    if (!_lblStatus) {
        _lblStatus = [[UILabel alloc] init];
        _lblStatus.textColor = [UIColor redColor];
        _lblStatus.font = [UIFont boldSystemFontOfSize:13];
    }
    return _lblStatus;
}

- (UIButton *)btnLeft
{
    if (!_btnLeft) {
        _btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLeft.backgroundColor = [UIColor whiteColor];
        [_btnLeft setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        _btnLeft.layer.borderColor = [UIColor colorWithHexString:@"c1c1c1"].CGColor;
        _btnLeft.layer.borderWidth = 0.5;
        _btnLeft.layer.cornerRadius = 2;
        _btnLeft.clipsToBounds = YES;
        _btnLeft.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_btnLeft addTarget:self action:@selector(tapLeft) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLeft;
}

- (UIButton *)btnRight
{
    if (!_btnRight) {
        
        _btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.backgroundColor = [UIColor colorWithHexString:@"12a0ea"];
        [_btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnRight.layer.borderColor = [UIColor colorWithHexString:@"c1c1c1"].CGColor;
        _btnRight.layer.borderWidth = 0.5;
        _btnRight.layer.cornerRadius = 2;
        _btnRight.clipsToBounds = YES;
        _btnRight.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_btnRight addTarget:self action:@selector(tapRight) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRight;
}




@end
