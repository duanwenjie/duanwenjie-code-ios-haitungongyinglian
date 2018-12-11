//
//  GoodsExtentionViewController.h
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/2/27.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "HTBase_VC.h"
#import "GoodsAddModel.h"
#import "GoodsExtentionModel.h"
@protocol GoodsExtentionViewControllerDelegate <NSObject>

-(void)updateDataTitle:(NSString *)title GoodsSn:(NSString *)goodsSn number:(NSString *)number imgStr:(NSString *)imgStr;

@end
@interface GoodsExtentionViewController : HTBase_VC

@property (nonatomic ,assign)id<GoodsExtentionViewControllerDelegate>delegate;

-(void)loadSuitViewData:(NSString *)sku goodsModl:(GoodsAddModel *)model;

@end
