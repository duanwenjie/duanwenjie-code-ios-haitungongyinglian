//
//  ConsigneeInfoView.h
//  Distribution
//
//  Created by DIOS on 15/5/13.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OrderModel.h"

@protocol ConsigneeInfoViewDelegate <NSObject>

- (void)touchViewResponse;

@end

@interface ConsigneeInfoView : UIView

@property (weak)id<ConsigneeInfoViewDelegate>delegate;

@property (nonatomic, strong)OrderModel *orderModel;

- (id)initWithFrame:(CGRect)frame withInfo:(OrderModel *)model andIsModify:(NSString *)isModify;

//判断是在修改订单页面显示还是在订单详情页显示

@end
