//
//  OrderRiskTips_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/5/13.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "OrderRiskTips_VC.h"

@interface OrderRiskTips_VC ()

@property (nonatomic, strong) UILabel *lblTitleName;

@property (nonatomic, strong) UILabel *lblNeiRon;

@end

@implementation OrderRiskTips_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.lblTitleName];
    [self.view addSubview:self.lblNeiRon];
    
    [self addNavigationType:YKSDefaults NavigationTitle:@"申报委托"];
    
    [self.lblTitleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavigation.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(16);
    }];
    
    [self.lblNeiRon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblTitleName.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
    }];
    
    [self addNavigationType:YKSDefaults NavigationTitle:@"申报委托"];
}


#pragma mark - 懒加载
- (UILabel *)lblTitleName
{
    if (!_lblTitleName) {
        _lblTitleName = [[UILabel alloc] init];
        _lblTitleName.font = kFont14;
        _lblTitleName.textAlignment = NSTextAlignmentCenter;
        _lblTitleName.text = @"《跨境电子商务零售进口商品申报委托》";
    }
    return _lblTitleName;
}

- (UILabel *)lblNeiRon
{
    if (!_lblNeiRon) {
        _lblNeiRon = [[UILabel alloc] init];
        _lblNeiRon.numberOfLines = 0;
        _lblNeiRon.font = kFont12;
        _lblNeiRon.text = @"本人承诺所购买商品系个人合理自用，针对保税区发货的各种商品，现委托商家代理申报、代缴税款等通关事宜，本人保证遵守《海关法》和国家相关法律法规，保证所提供的身份信息和收货信息真实完整，无侵犯他人权益的行为，以上委托关系系如实填写，本人愿意接受海关、检验检疫机构及其他监管部门的监管，并承担相应法律责任。";
    }
    return _lblNeiRon;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
