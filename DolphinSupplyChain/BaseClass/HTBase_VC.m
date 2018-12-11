//
//  HTBase_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/12.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "HTBase_VC.h"

@interface HTBase_VC ()

/// 判断是否是竖屏还是横屏
@property (nonatomic, assign) BOOL bVertical;

@end

@implementation HTBase_VC


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
        
        self.bShowNavigation = YES;
        self.sLeftImage = @"Go_Back";
        self.sBackViewColor = @"efeff2";
        self.sNavigationTitleColor = @"ffffff";
        self.sNavigationBackViewColor = @"12a0ea";
        self.fNavigationBackViewAlpha = 1;
        self.bVertical = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    if (@available(iOS 11.0, *)) {
//        self.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        // Fallback on earlier versions
    }
    
    self.view.backgroundColor = [UIColor colorWithHexString:self.sBackViewColor];
}

- (void)viewWillLayoutSubviews
{
    [self _shouldRotateToOrientation:(UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation];
}

-(void)_shouldRotateToOrientation:(UIDeviceOrientation)orientation {
    if (orientation == UIDeviceOrientationPortrait ||orientation ==
        UIDeviceOrientationPortraitUpsideDown)
    {
        // 竖屏
        self.bVertical = YES;
        [self.vNavigation mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kDisNavgation);
        }];
    }
    else
    {
        // 横屏
        self.bVertical = NO;
        [self.vNavigation mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
        }];
    }
}

- (void)orientChange:(NSNotification *)notification
{
    UIInterfaceOrientation interfaceOritation = [[UIApplication sharedApplication] statusBarOrientation];
    
    switch (interfaceOritation) {
        case UIInterfaceOrientationUnknown:
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            if (_vNavigation != nil) {
                [self.vNavigation mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(kDisNavgation);
                }];
            }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            if (_vNavigation != nil) {
                [self.vNavigation mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(44);
                }];
            }
            break;
    }
}


#pragma mark - 按钮点击事件
// 要使用该方法请在子控制器中重写该方法
- (void)tapLeft { [self.navigationController popViewControllerAnimated:YES]; }

// 要使用该方法请在子控制器中重写该方法
- (void)tapRightTwo {}

// 要使用该方法请在子控制器中重写该方法
- (void)tapRightOne {}

#pragma mark - 公共API
/**
 根视图Push 时跳转调用

 @param vc viewController
 */
- (void)YKSRootPushViewController:(UIViewController *)vc
{
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


// 变导航栏的透明度
- (void)setFNavigationBackViewAlpha:(CGFloat)fNavigationBackViewAlpha
{
    _fNavigationBackViewAlpha = fNavigationBackViewAlpha;
    [self changeNavigationViewAlpha:fNavigationBackViewAlpha viewColor:self.sNavigationBackViewColor];
}


- (void)addNavigationType:(YKSNavigationEnum)eType
          NavigationTitle:(NSString *)sTitle
{
    if (!self.bShowNavigation) {
        return;
    }
    
    [self.view addSubview:self.vNavigation];
    [self.vNavigation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view).offset(0);        
        make.height.mas_equalTo(kDisNavgation);
    }];
    
    switch (eType) {
        case YKSDefaults:
        {
            [self.vNavigation addSubview:self.btnLeftOne];
            [self.vNavigation addSubview:self.lblTitle];
            self.lblTitle.text = sTitle;
            
            [self.btnLeftOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.vNavigation.mas_left).offset(5);
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
            }];
            
            [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.centerX.equalTo(self.vNavigation.mas_centerX);
                make.height.mas_equalTo(44);
            }];
        }
            break;
        case YKSOnlyTitle:
        {
            [self.vNavigation addSubview:self.lblTitle];
            self.lblTitle.text = sTitle;
            
            [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.centerX.equalTo(self.vNavigation.mas_centerX);
                make.height.mas_equalTo(44);
            }];
        }
            break;
        case YKSOnlyLeft:
        {
            [self.vNavigation addSubview:self.btnLeftOne];
            
            [self.btnLeftOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.vNavigation.mas_left).offset(5);
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
            }];
        }
            break;
        case YKSOnlyRightTwo:
        {
            [self.vNavigation addSubview:self.btnRigthTwo];
            
            [self.btnRigthTwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
                make.right.equalTo(self.vNavigation.mas_right).offset(-5);
            }];
        }
            break;
        case YKSOnlyRigthOneAndTwo:
        {
            [self.vNavigation addSubview:self.btnRigthTwo];
            [self.vNavigation addSubview:self.btnRigthOne];
            
            [self.btnRigthTwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
                make.right.equalTo(self.vNavigation.mas_right).offset(-5);
            }];
            
            [self.btnRigthOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
                make.right.equalTo(self.btnRigthTwo.mas_left).offset(-5);
            }];
        }
            break;
        case YKS_Title_RightTwo:
        {
            [self.vNavigation addSubview:self.lblTitle];
            [self.vNavigation addSubview:self.btnRigthTwo];
            self.lblTitle.text = sTitle;
            
            [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.centerX.equalTo(self.vNavigation.mas_centerX);
                make.height.mas_equalTo(44);
            }];
            
            [self.btnRigthTwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
                make.right.equalTo(self.vNavigation.mas_right).offset(-5);
            }];
        }
            break;
        case YKS_Title_RightOne_RightTwo:
        {
            [self.vNavigation addSubview:self.lblTitle];
            [self.vNavigation addSubview:self.btnRigthOne];
            [self.vNavigation addSubview:self.btnRigthTwo];
            self.lblTitle.text = sTitle;
            
            [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.centerX.equalTo(self.vNavigation.mas_centerX);
                make.height.mas_equalTo(44);
            }];
            
            [self.btnRigthOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
                make.right.equalTo(self.btnRigthTwo.mas_left).offset(-5);
            }];
            
            [self.btnRigthTwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
                make.right.equalTo(self.vNavigation.mas_right).offset(-5);
            }];
        }
            break;
        case YKS_Left_Title_RightTwo:
        {
            [self.vNavigation addSubview:self.btnLeftOne];
            [self.vNavigation addSubview:self.lblTitle];
            [self.vNavigation addSubview:self.btnRigthTwo];
            self.lblTitle.text = sTitle;
            
            [self.btnLeftOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.vNavigation.mas_left).offset(5);
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
            }];
            
            
            [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.centerX.equalTo(self.vNavigation.mas_centerX);
                make.height.mas_equalTo(44);
            }];
            
            [self.btnRigthTwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
                make.right.equalTo(self.vNavigation.mas_right).offset(-5);
            }];
        }
            break;
        case YKS_Left_Title_RightOne_RightTwo:
        {
            [self.vNavigation addSubview:self.btnLeftOne];
            [self.vNavigation addSubview:self.lblTitle];
            [self.vNavigation addSubview:self.btnRigthOne];
            [self.vNavigation addSubview:self.btnRigthTwo];
            self.lblTitle.text = sTitle;
            
            
            [self.btnLeftOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.vNavigation.mas_left).offset(5);
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
            }];
            
            [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.centerX.equalTo(self.vNavigation.mas_centerX);
                make.height.mas_equalTo(44);
            }];
            
            [self.btnRigthOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
                make.right.equalTo(self.btnRigthTwo.mas_left).offset(-5);
            }];
            
            [self.btnRigthTwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
                make.right.equalTo(self.vNavigation.mas_right).offset(-5);
            }];
        }
            break;
        case YKS_Left_RightTwo:
        {
            [self.vNavigation addSubview:self.btnLeftOne];
            [self.vNavigation addSubview:self.btnRigthTwo];
            
            [self.btnLeftOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.vNavigation.mas_left).offset(5);
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
            }];
            
            [self.btnRigthTwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
                make.right.equalTo(self.vNavigation.mas_right).offset(-5);
            }];
        }
            break;
        case YKS_Left_RightTwo_RightOne:
        {
            [self.vNavigation addSubview:self.btnLeftOne];
            
            [self.vNavigation addSubview:self.btnRigthOne];
            [self.vNavigation addSubview:self.btnRigthTwo];
            
            [self.btnLeftOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.vNavigation.mas_left).offset(5);
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
            }];
            
            [self.btnRigthOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
                make.right.equalTo(self.btnRigthTwo.mas_left).offset(-5);
            }];
            
            [self.btnRigthTwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.vNavigation.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
                make.right.equalTo(self.vNavigation.mas_right).offset(-5);
            }];
            
        }
            break;
        case YKSCustom:
        {
            
        }
            break;
    }
    
    
}


/**
 改变导航栏的透明度
 
 @param alpha 透明度系数 0 - 1
 @param sViewColor 背景默认颜色
 */
- (void)changeNavigationViewAlpha:(CGFloat)alpha viewColor:(NSString *)sViewColor
{
    if (_vNavigation != nil) {
        _vNavigation.backgroundColor = [UIColor colorWithHexString:sViewColor Alpha:alpha];
    }
    if (_vNavigationLine != nil) {
        self.vNavigationLine.backgroundColor = [UIColor colorWithHexString:@"cdcdcd" Alpha:alpha];
    }
}


#pragma mark - 控件懒加载
- (UIView *)vNavigation
{
    if (!_vNavigation) {
        _vNavigation = [[UIView alloc] init];
        _vNavigation.backgroundColor = [UIColor colorWithHexString:self.sNavigationBackViewColor Alpha:self.fNavigationBackViewAlpha];
    }
    return _vNavigation;
}

- (UIView *)vNavigationLine
{
    if (!_vNavigationLine) {
        _vNavigationLine = [[UIView alloc] init];
        _vNavigationLine.backgroundColor = [UIColor colorWithHexString:@"cdcdcd"];
    }
    return _vNavigationLine;
}

- (UILabel *)lblTitle
{
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.textColor = [UIColor colorWithHexString:self.sNavigationTitleColor];
        _lblTitle.font = [UIFont systemFontOfSize:17];
        _lblTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _lblTitle;
}

- (UIButton *)btnLeftOne
{
    if (!_btnLeftOne) {
        
        UIImage *imgLet = [UIImage drawImageWithName:self.sLeftImage size:CGSizeMake(12, 20)];
        _btnLeftOne = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnLeftOne addTarget:self action:@selector(tapLeft) forControlEvents:UIControlEventTouchUpInside];
        [_btnLeftOne setImage:imgLet forState:UIControlStateNormal];
        [_btnLeftOne setImageEdgeInsets:UIEdgeInsetsMake(0, -7, 0, 0)];

        [_btnLeftOne setImage:imgLet forState:UIControlStateNormal];
    }
    return _btnLeftOne;
}

- (UIButton *)btnRigthOne
{
    if (!_btnRigthOne) {
        _btnRigthOne = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnRigthOne addTarget:self action:@selector(tapRightOne) forControlEvents:UIControlEventTouchUpInside];
        _btnRigthOne.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _btnRigthOne;
}

- (UIButton *)btnRigthTwo
{
    if (!_btnRigthTwo) {
        _btnRigthTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnRigthTwo addTarget:self action:@selector(tapRightTwo) forControlEvents:UIControlEventTouchUpInside];
        _btnRigthTwo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _btnRigthTwo;
}

- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}
- (UIImage *)drawImageWithName:(NSString *)sender size:(CGSize)itemSize
{
    UIImage *icon = [UIImage imageNamed:sender];
    UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    
    icon = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return icon;
    
}

@end



