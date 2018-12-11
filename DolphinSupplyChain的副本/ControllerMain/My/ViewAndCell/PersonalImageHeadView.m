//
//  PersonalImageHeadView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/29.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "PersonalImageHeadView.h"

@interface PersonalImageHeadView ()

@property (nonatomic, strong) PersonalImageBlock personalBlock;

@property (nonatomic, strong) UIImageView *imgBack;

@property (nonatomic, strong) UIImageView *imgArrows;

@property (nonatomic, strong) UIImageView *imgUser;

@property (nonatomic, strong) UIButton *btnLogin;

//@property (nonatomic, strong) UILabel *lblAccountSign;
//
//@property (nonatomic, strong) UILabel *lblUserNameSign;

@property (nonatomic, strong) UILabel *lblAccount;

@property (nonatomic, strong) UILabel *lblUserName;

@property (nonatomic, assign) BOOL bLogin;

@end

@implementation PersonalImageHeadView

- (id)initWithTapSelfViewIsLogin:(BOOL)bLogin TapBlock:(PersonalImageBlock)block
{
    self = [super init];
    if (self) {
        self.personalBlock = block;
        
        self.bLogin = bLogin;
        
        [self initView];
    }
    return self;
}

- (void)initView
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(amendUserInformation)];
    [self addGestureRecognizer:tapGesture];
    
    [self addSubview:self.imgBack];
    [self.imgBack addSubview:self.imgUser];
    [self.imgBack addSubview:self.btnLogin];
    [self.imgBack addSubview:self.lblAccount];
    [self.imgBack addSubview:self.lblUserName];
    [self.imgBack addSubview:self.imgArrows];
    
    [self.imgBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    [self.imgArrows mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(8, 20));
        make.right.equalTo(self.imgBack.mas_right).offset(-15);
        make.centerY.equalTo(self.imgUser.mas_centerY).offset(0);
    }];
    
    [self.imgUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imgBack.mas_bottom).offset(-20);
        make.left.equalTo(self.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    
    [self.btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 30));
        make.left.equalTo(self.imgUser.mas_right).offset(20);
        make.centerY.equalTo(self.imgUser.mas_centerY).offset(0);
    }];
    
//    [self.lblAccountSign mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.imgUser.mas_top).offset(5);
//        make.size.mas_equalTo(CGSizeMake(50, 20));
//        make.left.equalTo(self.imgUser.mas_right).offset(10);
//    }];
    
    [self.lblAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgUser.mas_top).offset(5);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(25);
        make.left.equalTo(self.imgUser.mas_right).offset(10);
    }];
    
//    [self.lblUserNameSign mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.imgUser.mas_bottom).offset(-5);
//        make.size.mas_equalTo(CGSizeMake(50, 20));
//        make.left.equalTo(self.imgUser.mas_right).offset(10);
//    }];
    
    [self.lblUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imgUser.mas_bottom).offset(-7);
        make.height.mas_equalTo(20);
        make.left.equalTo(self.imgUser.mas_right).offset(10);
    }];
    
    
    if (self.bLogin) {
        self.btnLogin.hidden = YES;
        self.lblAccount.hidden = NO;
        self.lblUserName.hidden = NO;
        self.imgArrows.hidden = NO;
    }
    else
    {
        self.btnLogin.hidden = NO;
        self.lblAccount.hidden = YES;
        self.lblUserName.hidden = YES;
        self.imgArrows.hidden = YES;
    }
}



#pragma mark - 数据赋值
- (void)isShowLogin:(BOOL)bShow
{
    self.bLogin = bShow;
    if (self.bLogin) {
        self.btnLogin.hidden = YES;
        self.lblAccount.hidden = NO;
        self.lblUserName.hidden = NO;
        self.imgArrows.hidden = NO;
        
        NSString *sAccount = [YKSUserDefaults shareInstance].sUser_Nick;
        NSString *sPhone = [YKSUserDefaults shareInstance].sUser_Mobile;
        if (sAccount.length == 0) {
            self.lblAccount.text = sPhone;
            self.lblUserName.text = [NSString stringWithFormat:@"%@   ",sPhone];
        }
        else
        {
            self.lblAccount.text = sAccount;
            self.lblUserName.text = [NSString stringWithFormat:@"%@   ",sPhone];
        }
        self.imgUser.image = [UIImage imageNamed:@"Head_Portrait_Longin"];
    }
    else
    {
        self.lblAccount.text = @"";
        self.lblUserName.text = @"";
        self.btnLogin.hidden = NO;
        self.lblAccount.hidden = YES;
        self.lblUserName.hidden = YES;
        self.imgArrows.hidden = YES;
        self.imgUser.image = [UIImage imageNamed:@"Head_Portrait_Not_Longin"];
    }
}


//- (void)dataAssignment:(NSString *)sAccount UserName:(NSString *)sUserName
//{
//    if (self.bLogin) {
//        self.lblAccount.text = sAccount;
//        self.lblUserName.text = sUserName;
//    }
//    else
//    {
//        self.lblAccount.text = @"";
//        self.lblUserName.text = @"";
//    }
//}

#pragma mark - 点击事件
- (void)login
{
    self.personalBlock();
}

- (void)amendUserInformation
{
    self.personalBlock();
}

#pragma mark - 懒加载控件
- (UIImageView *)imgBack
{
    if (!_imgBack) {
        _imgBack = [[UIImageView alloc] init];
        _imgBack.image = [UIImage imageNamed:@"Personal_Center_Back_Image"];
        _imgBack.contentMode = UIViewContentModeScaleAspectFill;
        _imgBack.userInteractionEnabled = YES;
    }
    return _imgBack;
}

- (UIImageView *)imgArrows
{
    if (!_imgArrows) {
        _imgArrows = [[UIImageView alloc] init];
        _imgArrows.contentMode = UIViewContentModeScaleAspectFit;
        _imgArrows.image = [UIImage imageNamed:@"icon_expanding_white"];
        _imgArrows.hidden = YES;
    }
    return _imgArrows;
}

- (UIImageView *)imgUser
{
    if (!_imgUser) {
        _imgUser = [[UIImageView alloc] init];
        _imgUser.layer.cornerRadius = 30;
        _imgUser.layer.masksToBounds = YES;
        _imgUser.layer.borderColor = ([UIColor colorWithHexString:@"3082df"].CGColor);
        _imgUser.layer.borderWidth = 4;
        _imgUser.contentMode = UIViewContentModeScaleAspectFit;
        _imgUser.backgroundColor = [UIColor grayColor];
        _imgUser.image = [UIImage imageNamed:@"Head_Portrait_Not_Longin"];
    }
    return _imgUser;
}

- (UIButton *)btnLogin
{
    if (!_btnLogin) {
        _btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnLogin setTitle:@"登录/注册" forState:UIControlStateNormal];
        [_btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnLogin.titleLabel.font=[UIFont systemFontOfSize:13];
        [_btnLogin addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        _btnLogin.layer.borderWidth = 1;
        _btnLogin.layer.cornerRadius = 2;
        _btnLogin.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _btnLogin;
}

//- (UILabel *)lblAccountSign
//{
//    if (!_lblAccountSign) {
//        _lblAccountSign = [[UILabel alloc] init];
//        _lblAccountSign.text = @"账   号:";
//        _lblAccountSign.font = [UIFont systemFontOfSize:12.0f];
//    }
//    return _lblAccountSign;
//}
//
//- (UILabel *)lblUserNameSign
//{
//    if (!_lblUserNameSign) {
//        _lblUserNameSign = [[UILabel alloc] init];
//        _lblUserNameSign.text = @"用户名:";
//        _lblUserNameSign.font = [UIFont systemFontOfSize:12.0f];
//    }
//    return _lblUserNameSign;
//}

- (UILabel *)lblAccount
{
    if (!_lblAccount) {
        _lblAccount = [[UILabel alloc] init];
        _lblAccount.font = [UIFont systemFontOfSize:15.0f];
        _lblAccount.textColor = [UIColor whiteColor];
    }
    return _lblAccount;
}

- (UILabel *)lblUserName
{
    if (!_lblUserName) {
        _lblUserName = [[UILabel alloc] init];
        _lblUserName.font = [UIFont systemFontOfSize:12.0f];
        _lblUserName.backgroundColor = [UIColor colorWithHexString:@"014aaa"];
        _lblUserName.layer.cornerRadius = 5;
        _lblUserName.textColor = [UIColor whiteColor];
        _lblUserName.layer.masksToBounds = YES;
        _lblUserName.textAlignment = NSTextAlignmentCenter;
    }
    return _lblUserName;
}



@end
