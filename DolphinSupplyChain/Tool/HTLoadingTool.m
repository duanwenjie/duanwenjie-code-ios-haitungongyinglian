//
//  HTLoadingTool.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/15.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "HTLoadingTool.h"
#import "WSProgressHUD.h"

@interface HTLoadingTool ()

@property (nonatomic, strong) WSProgressHUD *hud;

@end

@implementation HTLoadingTool


/**
 构造单例方法
 
 @return 实例对象
 */
+ (instancetype)shareInstance
{
    static HTLoadingTool *HTLoading;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HTLoading = [[HTLoadingTool alloc] init];
    });
    return HTLoading;
}


+ (void)showLoading
{
    [[HTLoadingTool shareInstance] showLoadingForWindow:@"" isOperation:YES];
}

+ (void)showLoadingDontOperation
{
    [[HTLoadingTool shareInstance] showLoadingForWindow:@"" isOperation:NO];
}

+ (void)showLoadingString:(NSString *)sHint
{
    [[HTLoadingTool shareInstance] showLoadingForWindow:sHint isOperation:YES];
}

+ (void)showLoadingStringDontOperation:(NSString *)sHint
{
    [[HTLoadingTool shareInstance] showLoadingForWindow:sHint isOperation:NO];
}


- (void)showLoadingForWindow:(NSString *)sHint isOperation:(BOOL)bOperation
{
    if (sHint.length == 0 || sHint == nil) {
        sHint = @"加载中...";
    }
    if (bOperation) {
        [WSProgressHUD showWithStatus:sHint maskType:WSProgressHUDMaskTypeDefault maskWithout:WSProgressHUDMaskWithoutDefault];
    }
    else
    {
        [WSProgressHUD showWithStatus:sHint maskType:WSProgressHUDMaskTypeClear maskWithout:WSProgressHUDMaskWithoutDefault];
    }
}



+ (void)showLoadingForView:(UIView *)view
{
    [[HTLoadingTool shareInstance] showLoadingForView:@"" View:view isOperation:YES];
}

+ (void)showLoadingForView:(UIView *)view Hint:(NSString *)sHint
{
    [[HTLoadingTool shareInstance] showLoadingForView:sHint View:view isOperation:YES];
}

+ (void)showLoadingDontOperationForView:(UIView *)view
{
    [[HTLoadingTool shareInstance] showLoadingForView:@"" View:view isOperation:NO];
}

+ (void)showLoadingDontOperationForView:(UIView *)view Hint:(NSString *)sHint
{
    [[HTLoadingTool shareInstance] showLoadingForView:sHint View:view isOperation:NO];
}


- (void)showLoadingForView:(NSString *)sHint View:(UIView *)view isOperation:(BOOL)bOperation
{
    if (sHint.length == 0 || sHint == nil) {
        sHint = @"加载中...";
    }
    __block BOOL bHave = NO;
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[WSProgressHUD class]]) {
            bHave = YES;
            *stop = YES;
        }
    }];
    
    if (!bHave) {
        self.hud = [[WSProgressHUD alloc] initWithView:view];
        [view addSubview:self.hud];
    }
    
    
    if (bOperation) {
        [self.hud showWithString:sHint maskType:WSProgressHUDMaskTypeDefault];
    }
    else
    {
        [self.hud showWithString:sHint maskType:WSProgressHUDMaskTypeClear];
    }
}


+ (void)disMissForView
{
    [[HTLoadingTool shareInstance].hud dismiss];
}



+ (void)disMissForWindow
{
    [WSProgressHUD dismiss];
}






@end
