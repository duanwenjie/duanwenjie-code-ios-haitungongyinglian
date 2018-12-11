//
//  HotBrandCell.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/22.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HotBrandDelegate <NSObject>

- (void)didHotBrandSelectItemAtIndex:(NSInteger)index;

@end

@interface HotBrandCell : UICollectionViewCell

@property (nonatomic, weak) id<HotBrandDelegate> delegate;

- (void)loadView:(NSArray *)arrData isRefresh:(BOOL)bRefresh;

@end
