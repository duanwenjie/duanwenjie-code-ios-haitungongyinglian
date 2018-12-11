//
//  GetNumerView.h
//  Distribution
//
//  Created by fei on 15/5/16.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GetNumerViewDelegate <NSObject>

- (void)getNumberForAddAction;

- (void)getNumberForReduceAction;




@end


@interface GetNumerView : UIView

@property (nonatomic ,assign)id<GetNumerViewDelegate>delegate;

@property (nonatomic , copy )NSString *countText;
@property (nonatomic ,strong)NSNumber *minPurNum;
@property (nonatomic ,strong)NSNumber *minSaleNum;
@property (nonatomic ,strong)NSNumber *salePolicy;

@property (nonatomic , assign)BOOL    isdidClick;
@end
