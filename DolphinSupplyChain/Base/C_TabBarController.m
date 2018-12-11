//
//  C_TabBarController.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/1.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "C_TabBarController.h"

#import "NewHome_VC.h"
#import "ClassifViewController.h"
#import "ShopingCart_VC.h"
#import "PersonalCenterViewController.h"


@interface C_TabBarController ()

@property (nonatomic, strong) NSMutableArray    *arrayControllTabBarItem;


@end

@implementation C_TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NewHome_VC *homeVC = [[NewHome_VC alloc] init];
    ClassifViewController *classVC = [[ClassifViewController alloc]init];
    PersonalCenterViewController *personalVC = [[PersonalCenterViewController alloc] init];
    ShopingCart_VC *cartVC = [[ShopingCart_VC alloc] init];
    
    
    UINavigationController *navOne = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UINavigationController *navTwo = [[UINavigationController alloc] initWithRootViewController:classVC];
    UINavigationController *navThree = [[UINavigationController alloc] initWithRootViewController:cartVC];
    UINavigationController *navFour = [[UINavigationController alloc] initWithRootViewController:personalVC];
    
    
    NSArray *arrVC = @[navOne, navTwo, navThree, navFour];
    
    
    NSArray *arrTitle = @[@"商城",
                          @"分类",
                          @"购物车",
                          @"我的"];
    
    NSArray *arrImage = @[@"Bar_Home_Gray",
                          @"Bar_Classify_Gray",
                          @"Bar_Cart_Gray",
                          @"Bar_My_Gray"];
    
    NSArray *arrSelectImage = @[@"Bar_Home_Select",
                                @"Bar_Classify_Select",
                                @"Bar_Cart_Select",
                                @"Bar_My_Select"];
    
    
    [arrVC enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
        
        UITabBarItem *item = nil;
        
        item = [[UITabBarItem alloc] initWithTitle:arrTitle[idx] image:nil tag:idx];
        
        item.image = [[UIImage imageNamed:arrImage[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        item.selectedImage = [[UIImage imageNamed:arrSelectImage[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
        
        // 改变tabBar中items上字体大小
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithHexString:@"5f646e"], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
        
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithHexString:@"12a0ea"], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
        
        viewController.tabBarItem = item;
        
        [self.arrayControllTabBarItem addObject:viewController];
    }];
    
    // 设置tabBar的背景图片
    /*
    UIImage* tabBarBackground = [UIImage imageNamed:@"背景图"];
    [self.tabBar setBackgroundImage:[tabBarBackground resizableImageWithCapInsets:UIEdgeInsetsMake(24.5, 0, 24.5, 0) resizingMode:UIImageResizingModeStretch]];
     */
    self.viewControllers = self.arrayControllTabBarItem;
    
}



- (void)addRedDot:(NSInteger)iControllerType dotNumber:(NSInteger)iNumber
{
    NSArray *arrayControllerType = self.viewControllers;
    
    if (iControllerType < arrayControllerType.count) {
        
        if (iNumber > 99) {
            ((UIViewController *)arrayControllerType[iControllerType]).tabBarItem.badgeValue = @"99+";
        }
        else if (iNumber <= 0)
        {
            if (iNumber == 0) {
                [self removeRedDot:iControllerType];
            }
            else
            {
#ifndef DEBUG
                NSAssert(iNumber == 0, @"传入的 iNumber 不能小于0");
#else
                [self removeRedDot:iControllerType];
#endif
            }
        }
        else
        {
            ((UIViewController *)arrayControllerType[iControllerType]).tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)iNumber];
        }
    }
    else
    {
#ifndef DEBUG
        NSAssert(iControllerType < arrayControllerType.count, @"传入的 iControllerType 大于实际数组的下标");
#endif
    }
}

- (void)removeRedDot:(NSInteger)iControllerType
{
    NSArray *arrayControllerType = self.viewControllers;
    
    if (iControllerType < arrayControllerType.count) {
        
        ((UIViewController *)arrayControllerType[iControllerType]).tabBarItem.badgeValue = nil;
    }
    else
    {
#ifndef DEBUG
        NSAssert(iControllerType < arrayControllerType.count, @"传入的 iControllerType 大于实际数组的下标");
#endif
    }
}

- (void)removeAllRedDot
{
    for (UIViewController *controller in self.viewControllers) {
        controller.tabBarItem.badgeValue = nil;
    }
}



#pragma mark - set And Get
- (NSMutableArray *)arrayControllTabBarItem
{
    if (!_arrayControllTabBarItem) {
        _arrayControllTabBarItem = [[NSMutableArray alloc] init];
    }
    return _arrayControllTabBarItem;
}


- (void)setIPage:(NSInteger)iPage
{
    _iPage = iPage;
    self.selectedIndex = _iPage;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
