//
//  ViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//


#import "BaseNavigationViewController.h"
#import "UIImage+MJ.h"
@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//设置导航栏背景
    [self.navigationBar setBackgroundImage:[UIImage resizedImage:@"beijing" xPos:5 yPos:5] forBarMetrics:UIBarMetricsDefault];

    self.navigationBar.tintColor = [UIColor whiteColor];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
