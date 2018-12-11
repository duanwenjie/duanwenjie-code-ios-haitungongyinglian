//
//  BCOrderDetailsFootView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/15.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BCOrderDetailsFootViewDelegate <NSObject>

- (void)tapTel;

- (void)tapQQ;

@end

@interface BCOrderDetailsFootView : UIView

@property (nonatomic, weak) id<BCOrderDetailsFootViewDelegate> delegate;

@end
