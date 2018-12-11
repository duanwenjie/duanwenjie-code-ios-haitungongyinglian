//
//  OrderListCell.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/5.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListCell : UITableViewCell


- (void)loadView:(NSString *)sImageURL
         BuyName:(NSString *)sName
        Quantity:(NSString *)sQuantity
             SKU:(NSString *)sSKU
        MoneyOne:(NSString *)sMoneyOne
        MoneyTwo:(NSString *)sMoneyTwo;



@end
