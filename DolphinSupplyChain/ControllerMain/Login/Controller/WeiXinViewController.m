//
//  WeiXinViewController.m
//  DolphinSupplyChain
//
//  Created by Steffen.D on 2018/12/12.
//  Copyright © 2018 学宁. All rights reserved.
//

#import "WeiXinViewController.h"

@interface WeiXinViewController ()

@property(nonatomic, strong)UIImageView * vSuccessView;

@property(nonatomic, strong)UIImageView * vImgView;

@property(nonatomic, strong)UIImageView * vImgView2;

@property(nonatomic, strong)UILabel * labText;

@property(nonatomic, strong)UILabel * labText2;

@property(nonatomic, strong)UILabel * labText3;

@end

@implementation WeiXinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavigationType:YKSDefaults NavigationTitle:@"微信"];
    
    [self.view addSubview:self.vSuccessView];
    [self.view addSubview:self.labText];
    
    [self.vSuccessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(70);
    }];
    
    [self.labText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vSuccessView.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.left.right.equalTo(self.view);
    }];
    
    if (self.isIndividual) {
        [self.view addSubview:self.labText2];
        [self.view addSubview:self.vImgView];
        
        [self.labText2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labText.mas_bottom).offset(10);
            make.centerX.equalTo(self.view);
            make.left.right.equalTo(self.view);
        }];
        
        [self.vImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labText2.mas_bottom).offset(10);
            make.centerX.equalTo(self.view);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(200);
        }];
    }else{
        [self.view addSubview:self.labText3];
        [self.view addSubview:self.vImgView2];
        
        [self.labText3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labText.mas_bottom).offset(10);
            make.centerX.equalTo(self.view);
            make.left.right.equalTo(self.view);
        }];
        
        [self.vImgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labText3.mas_bottom).offset(10);
            make.centerX.equalTo(self.view);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(200);
        }];
    }
    
    // Do any additional setup after loading the view.
}



- (UIImageView *)vImgView{
    if (!_vImgView) {
        _vImgView = [[UIImageView alloc] init];
        [_vImgView setImage:[UIImage imageNamed:@"QR_code_individual"]];
    }
    return _vImgView;
}

- (UIImageView *)vImgView2{
    if (!_vImgView2) {
        _vImgView2 = [[UIImageView alloc] init];
        [_vImgView2 setImage:[UIImage imageNamed:@"QR_code_company"]];
    }
    return _vImgView2;
}


- (UIImageView *)vSuccessView{
    if (!_vSuccessView) {
        _vSuccessView = [[UIImageView alloc] init];
        [_vSuccessView setImage:[UIImage imageNamed:@"ic_success"]];
    }
    return _vSuccessView;
}


- (UILabel *)labText{
    if (!_labText) {
        _labText = [[UILabel alloc] init];
        _labText.font = [UIFont systemFontOfSize:20];
        _labText.text = @"注册申请提交成功";
        _labText.textAlignment = NSTextAlignmentCenter;
        _labText.textColor = [UIColor colorWithRed:51/255 green:51/255 blue:51/255 alpha:1];
    }
    return _labText;
}

- (UILabel *)labText2{
    if (!_labText2) {
        _labText2 = [[UILabel alloc] init];
        _labText2.font = [UIFont systemFontOfSize:16];
        _labText2.text = @"扫码关注微信公众号，优惠活动早知道";
        _labText2.textAlignment = NSTextAlignmentCenter;
        _labText2.textColor = [UIColor colorWithRed:102/255 green:102/255 blue:102/255 alpha:1];
    }
    return _labText2;
}

- (UILabel *)labText3{
    if (!_labText3) {
        _labText3 = [[UILabel alloc] init];
        _labText3.font = [UIFont systemFontOfSize:16];
        _labText3.text = @"扫码添加微信客服，审核进度早知道";
        _labText3.textAlignment = NSTextAlignmentCenter;
        _labText3.textColor = [UIColor colorWithRed:102/255 green:102/255 blue:102/255 alpha:1];
    }
    return _labText3;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
