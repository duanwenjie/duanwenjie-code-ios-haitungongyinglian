//
//  SearchScreenListView.h
//  DolphinSupplyChain
//
//  Created by zhengxuening on 2017/2/13.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchScreenListDelegate <NSObject>

- (void)selectBrand:(NSString *)sScreenID ScreenName:(NSString *)sScreenName ScreenData:(NSMutableArray *)arrScreen;

- (void)selectOnlyGoods:(BOOL)bHaveOnlyGoods;

@end


@interface SearchScreenListView : UIView

@property (nonatomic, strong) NSMutableArray *arrScree;

@property (nonatomic, weak) id<SearchScreenListDelegate> delegate;

- (void)amendSwitchState;

- (instancetype)initWithList;

@end





