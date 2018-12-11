//
//  LogisticsTableViewCell.h
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/3/3.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransEventArrayModel.h"


@interface LogisticsTableViewCell : UITableViewCell

-(void)updateTrantsEvent:(NSDictionary * )dict model:(TransEventArrayModel *)trantsModel;
-(void)updateTrantsEvent:(NSDictionary * )dict;

@end
