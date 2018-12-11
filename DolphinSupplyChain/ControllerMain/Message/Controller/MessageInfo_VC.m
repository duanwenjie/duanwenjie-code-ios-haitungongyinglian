//
//  MessageInfo_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/3.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "MessageInfo_VC.h"
#import <WebKit/WebKit.h>

@interface MessageInfo_VC ()

@property (nonatomic, strong) UILabel *lblNavName;

@property (nonatomic, strong) UILabel *lblTime;

@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, copy) NSString *sNavName;

@property (nonatomic, copy) NSString *sTime;

@property (nonatomic, copy) NSString *sNeiRon;

@property (nonatomic, strong) WKWebView *wkView;

@property (nonatomic, copy) NSString *sMessageID;


@end

@implementation MessageInfo_VC

- (instancetype)initWithNavName:(NSString *)sNavName Time:(NSString *)sTime NeiRon:(NSString *)sNeiRon Keyid:(NSString *)MessageID
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.sNavName = sNavName;
        self.sTime = sTime;
        self.sNeiRon = sNeiRon;
        self.sMessageID = MessageID;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.lblNavName];
    [self.view addSubview:self.lblTime];
    [self.view addSubview:self.vLine];
    
    [self.view addSubview:self.wkView];

    [self addNavigationType:YKSDefaults NavigationTitle:@"消息内容"];
    
    [self.lblNavName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavigation.mas_bottom).offset(14);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(40);
    }];
    
    [self.lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lblNavName);
        make.top.equalTo(self.lblNavName.mas_bottom).offset(2);
        make.height.mas_equalTo(20);
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lblNavName);
        make.top.equalTo(self.lblTime.mas_bottom).offset(8);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.wkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lblNavName);
        make.top.equalTo(self.vLine.mas_bottom).offset(15);
        make.bottom.equalTo(self.view).offset(-15);
    }];
    
    
    self.lblNavName.text = self.sNavName;
    self.lblTime.text = self.sTime;
    
    
    [self.wkView loadHTMLString:self.sNeiRon baseURL:nil];
}

- (UILabel *)lblNavName
{
    if (!_lblNavName) {
        _lblNavName = [[UILabel alloc] init];
        _lblNavName.font = [UIFont systemFontOfSize:16];
    }
    return _lblNavName;
}

- (UILabel *)lblTime
{
    if (!_lblTime) {
        _lblTime = [[UILabel alloc] init];
        _lblTime.font = [UIFont systemFontOfSize:12];
        _lblTime.textColor = [UIColor colorWithHexString:@"999999"];
    }
    return _lblTime;
}

- (WKWebView *)wkView
{
    if (!_wkView) {
        
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.userContentController = wkUController;
        
        
        _wkView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:wkWebConfig];
        
    }
    return _wkView;
}

- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _vLine;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
