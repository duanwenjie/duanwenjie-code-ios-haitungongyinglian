//
//  MessageModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/3.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ZXNModel.h"

@interface MessageModel : ZXNModel

@property (nonatomic, copy) NSString *message_id;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *read_num;

@property (nonatomic, copy) NSString *is_datele;

@property (nonatomic, copy) NSString *add_time;

@property (nonatomic, copy) NSString *message_user_id;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *u_is_dalete;

@property (nonatomic, copy) NSString *user_read_num;

@property (nonatomic, copy) NSString *u_add_time;

@end
