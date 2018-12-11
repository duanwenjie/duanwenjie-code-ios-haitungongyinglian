//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "HTBase_VC.h"
#import "GoodsAddModel.h"

@protocol  GetGoodsViewControllerDelegate<NSObject>

-(void)GetGoodsActionWithModel:(GoodsAddModel *)goods;

@end


@interface GetGoodsViewController : HTBase_VC

@property (nonatomic ,assign)id<GetGoodsViewControllerDelegate>delegate;
@property (nonatomic ,assign)NSInteger type;

@end
