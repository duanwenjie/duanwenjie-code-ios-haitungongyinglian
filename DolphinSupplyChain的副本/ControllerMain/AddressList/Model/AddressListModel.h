//
//  AddressListModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/4.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ZXNModel.h"

@interface AddressListModel : ZXNModel

@property (nonatomic, copy) NSString *user_addr_id;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *user_addr_alias;

@property (nonatomic, copy) NSString *consignee;

@property (nonatomic, copy) NSString *country_id;

@property (nonatomic, copy) NSString *province_id;

@property (nonatomic, copy) NSString *city_id;

@property (nonatomic, copy) NSString *district_id;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *zipcode;

@property (nonatomic, copy) NSString *tel;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *status_working;

@property (nonatomic, copy) NSString *is_default;

@property (nonatomic, copy) NSString *use_number;

@property (nonatomic, copy) NSString *add_time;

@property (nonatomic, copy) NSString *update_time;

@property (nonatomic, copy) NSString *update_date;

@property (nonatomic, copy) NSString *district;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *country;

@property (nonatomic, copy) NSString *id_card_number;

@end
