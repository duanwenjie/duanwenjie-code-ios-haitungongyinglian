//
//  NewProductRecommendCell.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/22.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewProductRecommendDelegate <NSObject>

- (void)didNewProductRecommendSelectItemAtIndex:(NSInteger)index;

@end


@interface NewProductRecommendCell : UICollectionViewCell

@property (nonatomic, weak) id<NewProductRecommendDelegate> delegate;

- (void)loadViewOne:(NSString *)sTitleOne
                   :(NSString *)sMoneyOne
                   :(NSString *)sImageURLOne
                Two:(NSString *)sTitleTwo
                   :(NSString *)sMoneyTwo
                   :(NSString *)sImageURLTwo
              Three:(NSString *)sTitleThree
                   :(NSString *)sMoneyThree
                   :(NSString *)sImageURLThree;

@end
