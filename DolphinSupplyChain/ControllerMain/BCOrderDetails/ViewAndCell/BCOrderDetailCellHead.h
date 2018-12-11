//
//  BCOrderDetailCellHead.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/15.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BCOrderDetailCellHeadDelegate <NSObject>

- (void)selectLogistics:(NSInteger)isection;

@end

@interface BCOrderDetailCellHead : UITableViewHeaderFooterView

@property (nonatomic, weak) id<BCOrderDetailCellHeadDelegate> delegate;

- (void)loadView:(NSString *)sLogisticsState
   LogisticsTime:(NSString *)sLogisticsTime
         section:(NSInteger)isection;

@end
