//
//  GoodsAddsubView.h
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/2/18.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface GoodsAddsubView : UIView
//
//@end
@protocol GoodsAddsubViewDelegate <NSObject>

- (void)getNumberForAddAction;

- (void)getNumberForReduceAction;




@end


@interface GoodsAddsubView : UIView

@property (nonatomic ,assign)id<GoodsAddsubViewDelegate>delegate;

@property (nonatomic , copy )NSString *countText;
@property (nonatomic ,strong)NSNumber *minPurNum;
@property (nonatomic ,strong)NSNumber *minSaleNum;
@property (nonatomic ,strong)NSNumber *salePolicy;

@property (nonatomic , assign)BOOL    isdidClick;
@end
