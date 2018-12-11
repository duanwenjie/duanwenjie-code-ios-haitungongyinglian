//
//  SetupViewController.m
//  Distribution
//
//  Created by 张翔 on 14-11-19.
//  Copyright (c) 2014年 ___YKSKJ.COM___. All rights reserved.
//

#import "SetupViewController.h"
#import "SBJSON.h"
#import "AppDelegate.h"
#import "C_TabBarController.h"
#import "B_TabBarController.h"
#import "YKSUserDefaults.h"
#import "AppDelegate.h"

static NSString * const KLogOutURL = @"/user/logout";

@interface SetupViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    
    NSString *trackViewURL;
    UILabel *lab;
    
    UIButton *loginBtn;
    BOOL isButtonOn;
}

@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HTTabbleView *table = [[HTTabbleView alloc] initWithFrame:CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight - kDisNavgation) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.scrollEnabled = NO;
    table.backgroundColor = [UIColor clearColor];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 80)];
    //退出登录按键
    loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDisWidth - 40, 40)];
    [loginBtn setCenter:CGPointMake(kDisWidth/2, footerView.center.y)];
    loginBtn.backgroundColor = [UIColor colorWithHexString:@"ed6262"];
    [loginBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn.layer setCornerRadius:5.0f];
    [loginBtn addTarget:self action:@selector(quit:) forControlEvents:UIControlEventTouchDown];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [footerView addSubview:loginBtn];
    table.tableFooterView = footerView;
    
    
    if (![YKSUserDefaults isLogin]) {
        loginBtn.hidden = YES;
    }
    
    UILabel * labb = [[UILabel alloc]init];
    labb.frame = CGRectMake(0, kDisHeight - 50, kDisWidth, 40);
    [self.view addSubview:labb];
    NSString * currentversion = [NSString stringWithFormat:@"当前版本：V%@",[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]];
    labb.text = [NSString stringWithFormat:@"%@",currentversion];
    labb.textAlignment = NSTextAlignmentCenter;
    labb.font = [UIFont systemFontOfSize:13];
    labb.textColor = [UIColor colorWithHexString:@"666666"];
    
    [self addNavigationType:YKSDefaults NavigationTitle:@"设置中心"];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark loginBtn点击
- (void)quit:(UIButton *)btn{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要退出登录吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 100;
    [alert show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100)
    {
        if (buttonIndex == 1)
        {
            loginBtn.hidden=YES;
            
            {
                
                [HTLoadingTool showLoadingStringDontOperation:@"注销中..."];
                NSDictionary *dic = nil;
                
                [AFHTTPClient POST:KLogOutURL params:dic successInfo:^(ResponseModel *response) {
                    
                    
                } flaseInfo:^(ResponseModel *response, HTTPType type) {
                    if (type == NEED_HINT || type == NO_NETWORK)
                    {
                        [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
                        return ;
                    }
                    
                    if (type == SERVICE_ERROR) {
                        return ;
                    }
                    
                    if (type == NEED_LOGIN) {
                        ZXNLog(@"需要登录");
                    }
                }];
                
                [YKSUserDefaults deleteAllUserInfo];
                [YKSUserDefaults deleteUserPassword];
                
                // 返回个人中心
                AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [appDelegate changeRootView:YES cutSomeController:3];
                
            }
            

        }
    } else if(alertView.tag == 3){
        if(buttonIndex == 1)
        {
            [HTLoadingTool showLoadingStringDontOperation:@"清除缓存中..."];
            
            //清除内存图片
            [[SDImageCache sharedImageCache] cleanDisk];
            //清除物理缓存
            [[SDImageCache sharedImageCache] clearDisk];
            //清除过期物理缓存
            [[SDImageCache sharedImageCache] clearMemory];
            
            NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
            for (NSString *p in files) {
                NSError *error;
                NSString *path = [cachPath stringByAppendingPathComponent:p];
                if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                }
            }
            [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
        }
    }

}


- (void)longPressAbout
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"切换访问环境" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *alertTset = [UIAlertAction actionWithTitle:@"Test测试环境" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[YKSUserDefaults shareInstance] upDateHTTPURLType:@"Test"];
        [YKSUserDefaults deleteAllUserInfo];
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate changeRootView:YES];
    }];
    
    UIAlertAction *alertPre = [UIAlertAction actionWithTitle:@"Pre预发布环境" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[YKSUserDefaults shareInstance] upDateHTTPURLType:@"Pre"];
        [YKSUserDefaults deleteAllUserInfo];
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate changeRootView:YES];
    }];
    
    UIAlertAction *alertOfficial = [UIAlertAction actionWithTitle:@"正式生产环境" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[YKSUserDefaults shareInstance] upDateHTTPURLType:@"Official"];
        [YKSUserDefaults deleteAllUserInfo];
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate changeRootView:YES];
    }];
    
    UIAlertAction *alertCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:alertTset];
    [alert addAction:alertPre];
    [alert addAction:alertOfficial];
    [alert addAction:alertCancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark table代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger i = 0;
    switch (section) {
        case 0:
            i = 1;
            break;
        case 1:
            i = 1;
            break;
        case 2:
            i = 1;
            break;
    }
    return i;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
//    switch (section) {
//        case 0:
//            if (row == 0) {
//                cell.textLabel.text = @"常见问题";
//                cell.imageView.image = [self drawImageWithName:@"Setting_Problem"];
//                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            }
//            break;
//        case 1:
            cell.textLabel.text = @"清除缓存";
            cell.imageView.image = [self drawImageWithName:@"Setting_Clean"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            break;
//        case 2:
//            
//            cell.textLabel.text = @"关于我们";
//            cell.imageView.image = [self drawImageWithName:@"Setting_About_Us"];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
#ifdef DEBUG
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAbout)];
            [cell addGestureRecognizer:longPress];
#endif
            
//            break;
//    }
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    long section = [indexPath section];
//    long row = [indexPath row];
//    switch (section) {
//        case 0:
//            if (row == 0) {
//                CommonQusViewController *CommonVC = [[CommonQusViewController alloc] init];
//                [self.navigationController pushViewController:CommonVC animated:YES];
//            }
//            break;
//        case 1:
//            if (row == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认清除缓存吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 3;
                [alert show];
//            }
//            break;
//        case 2:
//        {
//            AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc] init];
//            [self.navigationController pushViewController:aboutUsVC animated:YES];
//        }
//            break;
//            
//        case 3:
//            
//            break;
//    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

#pragma mark 绘制图片

- (UIImage *)drawImageWithName:(NSString *)sender{
    UIImage *icon = [UIImage imageNamed:sender];
    CGSize itemSize = CGSizeMake(24, 24);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    
    icon = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return icon;
    
}

- (void)clearCacheSuccess
{
    [HTLoadingTool disMissForWindow];
    [self.view makeToast:@"清除缓存成功" duration:1.0 position:CSToastPositionCenter];
}


@end
