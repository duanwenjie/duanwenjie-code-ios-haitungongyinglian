//
//  HotWordView.h
//  Weekens
//
//  Created by DIOS on 15/12/17.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotWordView : UIView

@property (nonatomic, strong)NSArray *hotArr;

@property (nonatomic, strong) void (^viewHeightRecalc) (CGFloat height);

@property (nonatomic, strong) void (^hotSearchClick) (NSString *title);

@end
