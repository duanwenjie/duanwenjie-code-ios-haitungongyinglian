//
//  DetailGoodsScroView.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/25.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailGoodsScroModel.h"
#import "GoodsInfoModel.h"
#import "CateGoodsButton.h"

@protocol DetailGoodsScroViewDelegate <NSObject>

-(void)cellGoodsButtonActionWithID:(NSString *)goodsID :(NSString *)sku :(NSString *)cat_id;
//-(void)cellTapActionWithTitle:(NSString *)titleText categoryID:(NSString *)category_id;

@end

@interface DetailGoodsScroView : UIView

@property (nonatomic ,assign)id<DetailGoodsScroViewDelegate>delegate;

-(void)detailGoodsScroViewDisplayWithMode:(DetailGoodsScroModel *)categoryModel;
-(void)detailGoodsScroViewDisplayWithMode2:(DetailGoodsScroModel *)categoryModel;

@property (nonatomic ,strong)NSArray * detailGoodsScroArr;

@end
