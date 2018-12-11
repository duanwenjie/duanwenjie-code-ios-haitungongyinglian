//
//  HandleCell.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/5/16.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HandleCell : UITableViewCell

- (void)loadDataGoodsName:(NSString *)sGoodsName
                  Address:(NSString *)sAddress
                    Money:(NSString *)sMonye;

@end
