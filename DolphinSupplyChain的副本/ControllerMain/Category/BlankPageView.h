//
//  AppDelegate.m
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BlankPageBlock)();

@interface BlankPageView : UIView

@property (nonatomic ,strong)UIImage *image;
@property (nonatomic , copy )NSString *title;

@property (nonatomic, strong) BlankPageBlock block;



/**
 切换到无网络状态显示风格
 */
- (void)switchToNoNetwork;


/**
 切换到无数据显示风格 并可以修改提示语
 
 @param sPrompt 默认可以传入nil 如果想要自定义文字内容，请传入对应的文字
 */
- (void)switchToNoDataPrompt:(NSString *)sPrompt;

@end
