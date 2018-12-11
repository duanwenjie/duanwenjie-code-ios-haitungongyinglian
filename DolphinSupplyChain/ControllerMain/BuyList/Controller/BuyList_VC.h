//
//  BuyList_VC.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/29.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "HTBase_VC.h"

@interface BuyList_VC : HTBase_VC


/**
 该类初始化方法

 @param sSuperListId 商品父类分类ID
 @param sSubListID 商品子类分类ID
 @param sName 导航栏名称
 @return 自己本身
 */
- (instancetype)initWithBuySuperListID:(NSString *)sSuperListId
                             subListID:(NSString *)sSubListID
                            NavBarName:(NSString *)sName
                          ClassifyName:(NSString *)sClassify;


@end
