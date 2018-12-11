//
//  HotCommodityCell.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/22.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotCommodityCell : UICollectionViewCell

- (void)loadView:(NSString *)sImageURL
         BuyName:(NSString *)sName
        MoneyOne:(NSString *)sMoneyOne
        MoneyTwo:(NSString *)sMoneyTwo
       Inventory:(NSString *)sInventory;

@end
