//
//  LoseEfficacyView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/17.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoseEfficacyDelegate <NSObject>


/**
 清除所有失效商品
 */
- (void)emptyAll;

@end

@interface LoseEfficacyView : UIView

@property (nonatomic, weak) id<LoseEfficacyDelegate> delegate;

@end
