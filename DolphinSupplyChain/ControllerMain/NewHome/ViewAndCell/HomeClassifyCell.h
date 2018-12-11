//
//  HomeClassifyCell.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/22.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeClassifyDelegate <NSObject>

- (void)didHomeClassifySelectItemAtIndex:(NSInteger)index;

@end

@interface HomeClassifyCell : UICollectionViewCell

@property (nonatomic, weak) id<HomeClassifyDelegate> delegate;

- (void)loadView:(NSArray *)arrData;

@end
