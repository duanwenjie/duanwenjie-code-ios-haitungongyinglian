//
//  BuyListScreenView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/30.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BuyListScreenDelegate <NSObject>

- (void)selectBrand:(NSString *)sScreenID ScreenName:(NSString *)sScreenName ScreenData:(NSMutableArray *)arrScreen;

- (void)selectOnlyGoods:(BOOL)bHaveOnlyGoods;

@end


@interface BuyListScreenView : UIView

@property (nonatomic, strong) NSMutableArray *arrScree;

@property (nonatomic, weak) id<BuyListScreenDelegate> delegate;

- (void)amendSwitchState;

- (instancetype)initWithList;


@end
