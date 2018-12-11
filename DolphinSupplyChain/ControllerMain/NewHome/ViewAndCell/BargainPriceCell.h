//
//  BargainPriceCell.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/22.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BargainPriceDelegate <NSObject>

- (void)didBargainPriceSelectItemAtIndex:(NSInteger)index;

- (void)didBargainPriceLastMore;

@end

@interface BargainPriceCell : UICollectionViewCell

@property (nonatomic, weak) id<BargainPriceDelegate> delegate;

- (void)loadView:(NSArray *)array;

@end



@interface BargainCell : UICollectionViewCell

- (void)loadView:(NSDictionary *)dic;

@end
