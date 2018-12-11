//
//  ButtonGroup.h
//  Weekens
//
//  Created by fei on 15/4/15.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButtonGroupDelegate <NSObject>

-(void)buttonGroupActionWithIndex:(NSUInteger)index;

@end

@interface ButtonGroup : UIView

@property (nonatomic ,assign) id<ButtonGroupDelegate>delegate;
-(void)changeViewWithButton:(UIButton *)btn;
//-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles index:(NSInteger )index;
-(void)changeViewWithButton2:(NSInteger )indexx;

@property (nonatomic ,assign)NSInteger  index;

@property (nonatomic ,strong)UIButton  *selectBtn;

@property (nonatomic ,strong)UIButton *btn;

@end
