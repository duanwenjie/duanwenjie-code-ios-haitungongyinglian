//
//  ShopView.h
//  Distribution
//
//  Created by fei on 15/1/24.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopViewDelegate <NSObject>

-(void)shopViewClickAction;

@end

@interface ShopView : UIView

@property (nonatomic ,assign)id<ShopViewDelegate>delegate;
@property (nonatomic ,strong)UILabel *shoplbl;
@property (nonatomic ,copy)NSString *orderNum;

@end
