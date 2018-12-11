//
//  PickNumView.h
//  Distribution
//
//  Created by fei on 15/1/9.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickNumView;
@protocol PickNumViewDelegate <NSObject>

-(void)makeSureGetNumActionWithNum:(NSString *)num;

@end

@interface PickNumView : UIView

@property (nonatomic ,strong)UIPickerView *pickView;

@property(nonatomic,assign)id<PickNumViewDelegate>delegate;

@end
