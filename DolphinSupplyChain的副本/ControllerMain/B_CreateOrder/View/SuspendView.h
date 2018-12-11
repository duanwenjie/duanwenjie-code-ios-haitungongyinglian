//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsAddModel.h"

@protocol SuspendViewDelegate <NSObject>

-(void)suspendViewDidConfirmWithModel:(GoodsAddModel *)goodsAdd;

@end

@interface SuspendView : UIView

@property (nonatomic ,assign)NSInteger status;

@property (nonatomic ,strong)UIImage  *goodsImge;
@property (nonatomic ,strong)NSString *goods_sn;
@property (nonatomic , copy )NSString *name;
@property (nonatomic , copy )NSString *speName;
@property (nonatomic , copy )NSArray  *speValues;
@property (nonatomic ,strong)UILabel  *quatity_text;
@property (nonatomic ,strong)NSNumber *minSaleNum;
@property (nonatomic ,strong)NSString *salePolicy;
@property (nonatomic, strong)ZXNImageView *imgView;
@property (nonatomic ,copy)NSString * min_sale_quantity;
@property (nonatomic ,copy)NSString * max_sale_quantity;

@property(nonatomic ,assign)BOOL is_modulo;
@property (nonatomic ,copy)NSString * img_original;

@property (nonatomic ,assign)id<SuspendViewDelegate>delegate;


@end
