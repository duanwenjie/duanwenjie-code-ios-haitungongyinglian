//
//  UnLoginView.h
//  Distribution
//
//  Created by DIOS on 15/5/8.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UnLoginViewDelegate <NSObject>

- (void)turnToLoginVC;

@end

@interface UnLoginView : UIView

@property (weak)id<UnLoginViewDelegate>delegate;

@end
