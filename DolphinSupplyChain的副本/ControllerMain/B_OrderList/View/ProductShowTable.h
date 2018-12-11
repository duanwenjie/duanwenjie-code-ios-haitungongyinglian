//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"


@interface ProductShowTable : HTTabbleView<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong)NSArray *productList;

@property (nonatomic, strong)NSNumber *status;

@property (nonatomic ,strong)OrderModel * model;


@end
