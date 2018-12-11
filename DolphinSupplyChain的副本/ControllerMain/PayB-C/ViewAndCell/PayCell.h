//
//  PayCell.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayCell : UITableViewCell

- (void)loadViewIcon:(NSString *)sIcon
             PayName:(NSString *)sPayName
           PayNeiRon:(NSString *)sPayNeiRon
              Select:(NSString *)sSelect;

@end
