//
//  ShortcutView.h
//  Distribution
//
//  Created by DIOS on 15/5/12.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShortcutViewDelegate <NSObject>

- (void) shortcutTouchToPush:(NSInteger)tag;

@end

@interface ShortcutView : UIView

- (id)initWithFrame:(CGRect)frame titleArr:(NSArray *)arr withImageArr:(NSArray *)imgArr;

@property(weak)id<ShortcutViewDelegate>delegate;

@end
