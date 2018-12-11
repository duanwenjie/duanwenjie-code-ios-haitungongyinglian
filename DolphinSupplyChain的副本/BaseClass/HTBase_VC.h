//
//  HTBase_VC.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/12.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    YKSDefaults,                       // 默认样式（一个返回按钮，一个标题）
    YKSOnlyTitle,                      // 只有一个标题
    YKSOnlyLeft,                       // 只有一个返回按钮
    YKSOnlyRightTwo,                   // 只有一个右边按钮
    YKSOnlyRigthOneAndTwo,             // 只有两个右边按钮
    YKS_Title_RightTwo,                // 一个标题，一个右边按钮
    YKS_Title_RightOne_RightTwo,       // 一个标题，两个右边按钮
    YKS_Left_Title_RightTwo,           // 有一个返回按钮，一个标题，一个右边按钮
    YKS_Left_Title_RightOne_RightTwo,  // 有一个返回按钮，一个标题，两个右边按钮
    YKS_Left_RightTwo,                 // 有一个返回按钮，一个右边按钮
    YKS_Left_RightTwo_RightOne,        // 有一个返回按钮，两个右边按钮
    YKSCustom,                         // 完全自定义样式
} YKSNavigationEnum;

@interface HTBase_VC : UIViewController

/**
 控制器背景颜色 默认为 efeff2
 */
@property (nonatomic, copy) NSString *sBackViewColor;

/**
 是否显示Navigation 默认为YES
 */
@property (nonatomic, assign) BOOL bShowNavigation;

/**
 系统默认导航栏颜色 默认值 12a0ea
 */
@property (nonatomic, copy) NSString *sNavigationBackViewColor;

/**
 系统导航栏透明度 默认值 1
 */
@property (nonatomic, assign) CGFloat fNavigationBackViewAlpha;

/**
 Navigation左边按钮图像 默认为 comeBack
 */
@property (nonatomic, copy) NSString *sLeftImage;

/**
 Navigation Title 字体颜色 默认为白色（ffffff）
 */
@property (nonatomic, copy) NSString *sNavigationTitleColor;

/**
 Navigation 底层View
 */
@property (nonatomic, strong) UIView *vNavigation;

/**
 Navigation 底部细线
 */
@property (nonatomic, strong) UIView *vNavigationLine;

/**
 Navigation Title文字控件
 */
@property (nonatomic, strong) UILabel *lblTitle;

/**
 Navigation 左边第一个按钮
 */
@property (nonatomic, strong) UIButton *btnLeftOne;

/**
 Navigation 右边第一个按钮
 */
@property (nonatomic, strong) UIButton *btnRigthOne;

/**
 Navigation 右边第二个按钮
 */
@property (nonatomic, strong) UIButton *btnRigthTwo;


#pragma mark - 按钮点击事件

/**
 根视图跳转

 @param vc 实例化后的控制器
 */
- (void)YKSRootPushViewController:(UIViewController *)vc;



/**
 添加导航栏

 @param eType 导航栏样式
 @param sTitle 导航栏标题 如果没有标题传入@""
 */
- (void)addNavigationType:(YKSNavigationEnum)eType
          NavigationTitle:(NSString *)sTitle;


/**
 要使用该方法请在子控制器中重写该方法
 */
- (void)tapLeft;

/**
 要使用该方法请在子控制器中重写该方法
 */
- (void)tapRightTwo;

/**
 要使用该方法请在子控制器中重写该方法
 */
- (void)tapRightOne;

@end

