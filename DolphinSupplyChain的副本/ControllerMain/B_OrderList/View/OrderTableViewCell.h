//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "ProductShowTable.h"

@interface OrderTableViewCell : UITableViewCell

@property (nonatomic ,strong)UILabel *num_lab;
@property (nonatomic ,strong)UILabel *time_lab;
@property (nonatomic ,strong)UIImageView *accessoryImage;
@property (nonatomic ,strong)UILabel *remindlbl;

@property (nonatomic ,strong)UIButton *paybtn;
@property (nonatomic ,strong)UIButton *deliverbtn;
@property (nonatomic ,strong)UIButton *logisticBtn;
@property (nonatomic ,strong)UIButton *logisticBtn1;
@property (nonatomic ,strong)UIButton *modifyBtn;
@property (nonatomic ,strong)UIButton *cancelbtn;
@property (nonatomic ,strong)UIButton *cancelNotiBtn;

-(void)orderTableViewDisplayCellWithModel:(OrderModel *)order status:(NSNumber *)status;


@end
