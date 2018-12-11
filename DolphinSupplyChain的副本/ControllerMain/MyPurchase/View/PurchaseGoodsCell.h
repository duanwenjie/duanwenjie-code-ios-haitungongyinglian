//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseGoodsModel.h"

@interface PurchaseGoodsCell : UITableViewCell

@property (nonatomic ,strong)ZXNImageView *imgView;
@property (nonatomic ,strong)UILabel *name_lab;
@property (nonatomic ,strong)UILabel *amount_lab;
@property (nonatomic ,strong)UILabel *sn_lab;
@property (nonatomic ,strong)UILabel *price_lab;



-(void)purchaseGoodsCellDisplayWithModel:(PurchaseGoodsModel *)goods;

@end
