//
//  ConfirmOrderCell.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmOrderCell : UITableViewCell

- (void)loadView:(NSString *)sImageURL
         BuyName:(NSString *)sName
        MoneyOne:(NSString *)sNumber
        MoneyTwo:(NSString *)sMoney
         Warning:(BOOL)bWarning
        isB_Or_C:(BOOL)bC_Or_B;

@end
					
