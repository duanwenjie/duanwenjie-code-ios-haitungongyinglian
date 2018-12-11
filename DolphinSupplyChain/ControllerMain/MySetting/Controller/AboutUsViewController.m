//
//  AboutUsViewController.m
//  Distribution
//
//  Created by 张翔 on 14-11-21.
//  Copyright (c) 2014年 ___YKSKJ.COM___. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()<UIScrollViewDelegate>

@property (nonatomic ,strong)UIScrollView * scroView;

@property (nonatomic ,strong)UILabel * labTitle;

@property (nonatomic ,strong)UILabel * labComapany;

@property (nonatomic ,strong)UILabel * labEnd;

@property (nonatomic ,strong)UIImageView * vImgView;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, kDisHeight - kDisWidth/1.5 , kDisWidth, kDisWidth/1.5)];
    [image setImage:[UIImage imageNamed:@"emptyBack"]];
    [self.view addSubview:image];
    
    [self.view addSubview:self.scroView];
    [self.scroView addSubview:self.labTitle];
    [self.view addSubview:self.labComapany];
    [self.view addSubview:self.labEnd];
    

    
    [self.scroView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(kDisNavgation);
        make.bottom.mas_equalTo(-70);
    }];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.scroView).offset(15);
        make.width.mas_equalTo(kDisWidth-30);
    }];
    
    [self.scroView mas_updateConstraints:^(MASConstraintMaker *make) {
    
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(kDisNavgation);
        make.bottom.equalTo(self.labTitle.mas_bottom).offset(0);
    }];
    
    [self.labComapany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-30);
        make.height.mas_equalTo(30);
    }];
    

    [self.labEnd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.labComapany.mas_bottom);
        make.height.mas_equalTo(30);
    }];

    [self addNavigationType:YKSDefaults NavigationTitle:@"关于我们"];
    
}

-(UIScrollView *)scroView{

    if (!_scroView) {
        _scroView = [[UIScrollView alloc]init];
        _scroView.showsVerticalScrollIndicator = NO;
        _scroView.showsHorizontalScrollIndicator = NO;
        _scroView.delegate = self;
        _scroView.backgroundColor = [UIColor clearColor];
    }
    return _scroView;
}

-(UILabel *)labTitle{

    if (!_labTitle) {
        _labTitle = [[UILabel alloc]init];
        _labTitle.text = @"    深圳海豚跨境科技有限公司自2014年创建 “海豚供应链” 品牌以来，以B2B和B2B2C模式为海淘企业提供正品货源，提供海外仓储、集运、保税"
        "仓储等全程服务，积极开拓上游品牌授权，与品牌厂商深度合作，产品覆盖母婴产品、保健品等超过1000个正品热销SKU，面向京东、唯品会、"
        "蜜芽、小红书等3千多家B端客户批发销售。目前海豚已成为跨境进口B端最大、最知名的跨境供应链品牌之一。\n"
        "\n"
        "    公司深耕海外供应链体系，在美国、英国、德国、日本、荷兰、波兰、香港等地建立多个海外仓库，其中日本、德国仓库面积上万平米，境内"
        "外累计仓库面积逾10万平米，建立 “中心仓 + 集货仓” 的仓库标准配置体系，有效辐射欧洲、北美洲、大洋洲、亚洲等地区。海豚供应链目前在"
        "香港自建跨境电商进口仓库，有效实现进口货物的分拨和中转甚至直邮；在深圳、广州、杭州、重庆等跨境电商试点城市建立跨境电商进口保"
        "税仓库，同各大保税区管委会、国检、海关等机构建立起良好的政企关系及数据系统无缝对接，为全球购商家提供从货物落地到消费者签收整"
        "个过程的全套供应链服务。公司为客户提供进口供应链全程服务，旗下海豚供应链正演变成为集货源、国际物流、跨境电商通关、仓配服务于"
        "一体的综合服务商。\n\n";
        _labTitle.font = [UIFont systemFontOfSize:12.0f];
        _labTitle.textColor = [UIColor colorWithHexString:@"#333333"];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_labTitle.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10.0];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _labTitle.text.length)];
        _labTitle.attributedText = attributedString;
        _labTitle.numberOfLines = 0;

    }
    return _labTitle;
}

-(UILabel *)labComapany{

    if (!_labComapany) {
        _labComapany = [[UILabel alloc]init];
        _labComapany.text = @"深圳市海豚跨境科技有限公司";
        _labComapany.textAlignment = NSTextAlignmentCenter;
        _labComapany.textColor = [UIColor blackColor];
        _labComapany.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:14.0f];
    }
    return _labComapany;
}


-(UILabel *)labEnd{

    if (!_labEnd) {
        _labEnd = [[UILabel alloc]init];
        _labEnd.text = @"ALL RIGHTS RESERVED";
        _labEnd.textAlignment = NSTextAlignmentCenter;
        _labEnd.textColor = [UIColor lightGrayColor];
        _labEnd.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:13.0f];
    }
    return _labEnd;
}
@end
