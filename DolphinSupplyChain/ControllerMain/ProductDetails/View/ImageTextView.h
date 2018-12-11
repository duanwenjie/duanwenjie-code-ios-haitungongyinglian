//
//  ImageTextView.h
//  Weekens
//
//  Created by fei on 15/4/15.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
@protocol ImageTextViewDelegate <NSObject>

-(void)imageTextViewReloadAction;
-(void)recommendBtnDidclick:(DetailViewController *)VC;
@end

@interface ImageTextView : UIView

@property (nonatomic , assign )id<ImageTextViewDelegate>delegate;

-(void)buttonGroupActionWithIndex:(NSUInteger)index;

-(void)loadForDescriptionImagesWithImages:(NSString *)desImages;

-(void)loadForParameterViewWithParameters:(NSArray *)parameters;

@end
