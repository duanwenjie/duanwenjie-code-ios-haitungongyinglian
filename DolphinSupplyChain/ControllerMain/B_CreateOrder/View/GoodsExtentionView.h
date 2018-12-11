//
//  GoodsExtentionView.h
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/2/18.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsAddModel.h"
#import "GoodsExtentionModel.h"
@protocol GoodsExtentionViewDelegate <NSObject>

-(void)updateDataTitle:(NSString *)title GoodsSn:(NSString *)goodsSn number:(NSString *)number;

@end
@interface GoodsExtentionView : UIView
@property (nonatomic ,assign)id<GoodsExtentionViewDelegate>delegate;

@property (nonatomic ,strong)NSMutableArray * arrMData;

@property (nonatomic ,strong)GoodsAddModel * model;


@end
