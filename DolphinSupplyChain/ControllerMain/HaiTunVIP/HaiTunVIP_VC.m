//
//  HaiTunVIP_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/8.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "HaiTunVIP_VC.h"

@interface HaiTunVIP_VC () <UIWebViewDelegate>

@property (nonatomic, strong) UILabel *lblNeiRon;

@property (nonatomic, strong) UIImageView *imgList;

@property (nonatomic, strong) UIView *vBack;

@property (nonatomic, strong) UIButton *btnApplyVIP;

@end

@implementation HaiTunVIP_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.lblNeiRon];
    [self.view addSubview:self.imgList];
    [self.view addSubview:self.vBack];
    [self.vBack addSubview:self.btnApplyVIP];
    
    [self addNavigationType:YKSDefaults NavigationTitle:@"海豚会员"];
    
    [self.lblNeiRon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavigation.mas_bottom).offset(12);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.bottom.equalTo(self.imgList.mas_top).offset(-12);
    }];
    
    [self.imgList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblNeiRon.mas_bottom).offset(12);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo((kDisWidth - 40) * 0.802);
    }];
    
    
    [self.vBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(65);
    }];
    
    [self.btnApplyVIP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBack.mas_left).offset(15);
        make.right.equalTo(self.vBack.mas_right).offset(-15);
        make.top.equalTo(self.vBack.mas_top).offset(10);
        make.bottom.equalTo(self.vBack.mas_bottom).offset(-15);
    }];
    
    self.lblNeiRon.text = @"    海豚会员为用户提供除普通用户所有权益外，另外提供了代发管理功能，不同等级的会员还可享受不同的优惠折扣。\n    海豚会员既可以像个人买家一样快速购买发货，也可以采取商家的角色，先采购，再根据销售情况分别发货。\n    代发管理功能介绍：海豚为用户提供代发服务，用户在自己的线上店铺（或线下）进行销售后，将订单导入海豚(亦可实现API自动对接)，海豚为您安排发货。您无需为仓储、物流、海关等操心。\n    海豚为您提供微仓服务，根据您的需要锁定库存，保证销售不会断货。旺季来临时，不再为商品库存操心。具体情况请联系客服QQ。";
}

- (void)tapApplyVIP
{
    //qqNumber就是你要打开的QQ号码， 也就是你的客服号码。
    NSString  *qqNumber=@"3472529929";
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qqNumber]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        webView.delegate = self;
        [webView loadRequest:request];
        [self.view addSubview:webView];
    }
    else
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"对不起，您还没安装QQ" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (UILabel *)lblNeiRon
{
    if (!_lblNeiRon) {
        _lblNeiRon = [[UILabel alloc] init];
        _lblNeiRon.font = [UIFont systemFontOfSize:12];
        _lblNeiRon.numberOfLines = 0;
        if (kDisWidth >= 375.0) {
            _lblNeiRon.font = [UIFont systemFontOfSize:14];
        }
        else
        {
            _btnApplyVIP.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        }
    }
    return _lblNeiRon;
}

- (UIImageView *)imgList
{
    if (!_imgList) {
        _imgList = [[UIImageView alloc] init];
        _imgList.contentMode = UIViewContentModeScaleAspectFit;
        _imgList.image = [UIImage imageNamed:@"VIP_List"];
    }
    return _imgList;
}

- (UIView *)vBack
{
    if (!_vBack) {
        _vBack = [[UIView alloc] init];
        _vBack.backgroundColor = [UIColor whiteColor];
    }
    return _vBack;
}

- (UIButton *)btnApplyVIP
{
    if (!_btnApplyVIP) {
        _btnApplyVIP = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnApplyVIP.backgroundColor = [UIColor colorWithHexString:@"12a0ea"];
        [_btnApplyVIP setTitle:@"申请会员" forState:UIControlStateNormal];
        [_btnApplyVIP setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnApplyVIP.layer.cornerRadius = 5;
        _btnApplyVIP.clipsToBounds = YES;
        if (kDisWidth >= 375.0) {
            _btnApplyVIP.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        }
        else
        {
            _btnApplyVIP.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        }
        
        [_btnApplyVIP addTarget:self action:@selector(tapApplyVIP) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnApplyVIP;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
