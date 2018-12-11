//
//  ContactServiceViewController.m
//  Distribution
//
//  Created by 张翔 on 14-11-19.
//  Copyright (c) 2014年 ___YKSKJ.COM___. All rights reserved.
//

#import "ContactServiceViewController.h"
#import "ContactQQButton.h"


@interface ContactServiceViewController () <UIWebViewDelegate>
{
    NSArray *qqlist;
}

@end

@implementation ContactServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawView];
    
    [self addNavigationType:YKSDefaults NavigationTitle:@"联系客服"];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)drawView
{
    UIImageView *imgTop = [[UIImageView alloc] init];
    imgTop.frame = CGRectMake(0, kDisNavgation, kDisWidth, kDisWidth * 0.46);
    imgTop.contentMode = UIViewContentModeScaleAspectFit;
    imgTop.image = [UIImage imageNamed:@"Service_Head"];
    [self.view addSubview:imgTop];
    
    UILabel *lblOne = [[UILabel alloc] initWithFrame:CGRectMake(kDisWidth/2, imgTop.height/2 - 20, 100, 25)];
    lblOne.text = @"服务时间";
    lblOne.font = [UIFont systemFontOfSize:14];
    [imgTop addSubview:lblOne];
    
    UILabel *lblTwo = [[UILabel alloc] initWithFrame:CGRectMake(lblOne.left, lblOne.bottom + 2, 160, 40)];
    lblTwo.text = @"周一至周六 08:30-12:30\n                    14:00-18:00";
    lblTwo.numberOfLines = 0;
    lblTwo.font = [UIFont systemFontOfSize:14];
    lblTwo.textAlignment = NSTextAlignmentLeft;
    lblTwo.textColor = [UIColor colorWithHexString:@"666666"];
    [imgTop addSubview:lblTwo];
    
    
    UIView *vBack = [[UIView alloc] initWithFrame:CGRectMake(0, imgTop.bottom + 13, kDisWidth, 90.5)];
    vBack.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vBack];
    
    UIView *vOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 45)];
    [vBack addSubview:vOne];
    
    
    UIImageView *imgQQ = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 26, 45)];
    imgQQ.contentMode = UIViewContentModeScaleAspectFit;
    imgQQ.image = [UIImage imageNamed:@"Service_QQ"];
    [vOne addSubview:imgQQ];
    
    UILabel *lblQQ = [[UILabel alloc] initWithFrame:CGRectMake(imgQQ.right + 10, 0, kDisWidth - 205, 45)];
    lblQQ.text = @"客服QQ";
    lblQQ.font = [UIFont systemFontOfSize:14];
    [vOne addSubview:lblQQ];
    
    UILabel *lblQQNumber = [[UILabel alloc] initWithFrame:CGRectMake(kDisWidth - 135, 0, 135 - 27, 45)];
    lblQQNumber.text = @"2880942711";
    lblQQNumber.font = [UIFont systemFontOfSize:14];
    lblQQNumber.textAlignment = NSTextAlignmentRight;
    lblQQNumber.textColor = [UIColor colorWithHexString:@"666666"];
    [vOne addSubview:lblQQNumber];
    
    UIImageView *imgQQArr = [[UIImageView alloc] initWithFrame:CGRectMake(lblQQNumber.right, 0, 20, 45)];
    imgQQArr.contentMode = UIViewContentModeScaleAspectFit;
    imgQQArr.image = [UIImage imageNamed:@"accessory"];
    [vOne addSubview:imgQQArr];
    
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(15, vOne.bottom, kDisWidth - 15, 1)];
    vLine.backgroundColor = [UIColor colorWithHexString:@"efeff2"];
    [vBack addSubview:vLine];
    
    UIView *vTwo = [[UIView alloc] initWithFrame:CGRectMake(0, vLine.bottom, kDisWidth, 45)];
    [vBack addSubview:vTwo];
    
    
    UIImageView *imgPhone = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 26, 45)];
    imgPhone.contentMode = UIViewContentModeScaleAspectFit;
    imgPhone.image = [UIImage imageNamed:@"Service_Phone"];
    [vTwo addSubview:imgPhone];
    
    UILabel *lblPhone = [[UILabel alloc] initWithFrame:CGRectMake(imgPhone.right + 10, 0, kDisWidth - 205, 45)];
    lblPhone.text = @"客服热线";
    lblPhone.font = [UIFont systemFontOfSize:14];
    [vTwo addSubview:lblPhone];
    
    UILabel *lblPhoneNumber = [[UILabel alloc] initWithFrame:CGRectMake(kDisWidth - 135, 0, 135 - 27, 45)];
    lblPhoneNumber.text = @"400-852-2086";
    lblPhoneNumber.font = [UIFont systemFontOfSize:14];
    lblPhoneNumber.textAlignment = NSTextAlignmentRight;
    lblPhoneNumber.textColor = [UIColor colorWithHexString:@"666666"];
    [vTwo addSubview:lblPhoneNumber];
    
    UIImageView *imgPhoneArr = [[UIImageView alloc] initWithFrame:CGRectMake(lblPhoneNumber.right, 0, 20, 45)];
    imgPhoneArr.contentMode = UIViewContentModeScaleAspectFit;
    imgPhoneArr.image = [UIImage imageNamed:@"accessory"];
    [vTwo addSubview:imgPhoneArr];
    
    UITapGestureRecognizer *tapQQ = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapQQ)];
    [vOne addGestureRecognizer:tapQQ];
    
    UITapGestureRecognizer *tapTel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTel)];
    [vTwo addGestureRecognizer:tapTel];
    
}

- (void)tapQQ
{
    //qqNumber就是你要打开的QQ号码， 也就是你的客服号码。
    NSString  *qqNumber=@"2880942711";
    
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

- (void)tapTel
{
    NSString *phoneNumber = @"4008522086";
    NSString *cleanedString =[[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSString *escapedPhoneNumber = [cleanedString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", escapedPhoneNumber]];
    UIWebView *mCallWebview = [[UIWebView alloc] init] ;
    [self.view addSubview:mCallWebview];
    [mCallWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
}



@end
