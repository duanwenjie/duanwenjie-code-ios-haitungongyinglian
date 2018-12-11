//
//  BCOrderDetailsCell.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/15.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCOrderDetailsCell : UITableViewCell


- (void)loadView:(NSString *)sImageURL
         BuyName:(NSString *)sName
        MoneyOne:(NSString *)sNumber
        MoneyTwo:(NSString *)sSKU;


@end
