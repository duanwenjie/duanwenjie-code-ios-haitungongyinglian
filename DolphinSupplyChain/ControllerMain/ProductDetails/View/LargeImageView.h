//
//  LargeImageView.h
//  Weekens
//
//  Created by fei on 15/4/15.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@protocol LargeImageViewDelegate <NSObject>

-(void)imageTextViewReloadActionLargeImageView;


@end
@interface LargeImageView : UIView

@property (nonatomic ,copy) NSString *images;
@property (nonatomic ,assign)id<LargeImageViewDelegate>delegate;
@property (nonatomic, strong) WKWebView *wbView;

@end
