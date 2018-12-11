//
//  CarouselCell.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/22.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarouselDelegate <NSObject>

- (void)didSelectItemAtIndex:(NSInteger)index;

@end

@interface CarouselCell : UICollectionViewCell

@property (nonatomic, weak) id<CarouselDelegate> delegate;

- (void)loadView:(NSArray *)arrImageUrl isRefresh:(BOOL)bRefresh;


@end
