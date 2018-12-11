//
//  MyAddressList_VC.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/3.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "HTBase_VC.h"
#import "AddressListModel.h"

@interface MyAddressList_VC : HTBase_VC

typedef void (^SelectReceivingAddressBlock)(AddressListModel *model);


/**
 初始化构造器

 @param bReceivingComeIn 是否是从选择收货地址进入 是传YES 不是传NO
 @param sDefaultAddressID 从选择收货地址进入可传入默认收货地址ID 如果没有可传nil
 @param block 从选择收货地址进入一定要传，不是从选择收货地址进入可传nil
 @return 本身
 */
- (instancetype)initWithIsSeletReceivingComeIn:(BOOL)bReceivingComeIn
                              DefaultAddressID:(NSString *)sDefaultAddressID
                        SelectReceivingAddress:(SelectReceivingAddressBlock)block;

@end
