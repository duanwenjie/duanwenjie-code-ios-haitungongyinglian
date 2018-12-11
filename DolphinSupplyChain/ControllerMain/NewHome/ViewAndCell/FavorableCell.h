//
//  FavorableCell.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/22.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FavorableDelegate <NSObject>

- (void)didFavorableSelectItemAtIndex:(NSInteger)index;

@end


@interface FavorableCell : UICollectionViewCell

@property (nonatomic, weak) id<FavorableDelegate> delegate;

- (void)loadView:(NSString *)sUrlOne UrlTwo:(NSString *)sUrlTwo;

@end
