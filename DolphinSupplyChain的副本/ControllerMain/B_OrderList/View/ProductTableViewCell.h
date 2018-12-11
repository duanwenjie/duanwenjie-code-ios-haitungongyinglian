//
//  ProductTableViewCell.h
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/2/28.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaleGoodsModel.h"


@interface ProductTableViewCell : UITableViewCell

-(void)updateData:(SaleGoodsModel *)goods status:(NSString *)status;

@end
