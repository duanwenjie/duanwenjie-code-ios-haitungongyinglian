//
//  AddressListCell.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/4.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddressListDelegate <NSObject>

/**
 点击了设为默认
 
 @param index Cell对应的数组下标
 */
- (void)tapDefault:(NSIndexPath *)index;


/**
 点击了编辑

 @param index Cell对应的数组下标
 */
- (void)tapCompile:(NSIndexPath *)index;


/**
 点击了删除
 
 @param index Cell对应的数组下标
 */
- (void)tapDelete:(NSIndexPath *)index;

@end

@interface AddressListCell : UITableViewCell

@property (nonatomic, weak) id<AddressListDelegate> delegate;

/**
 传入数据渲染视图

 @param sName 收货人名
 @param sPhoneNumber 收货人电话号码☎️
 @param sIdentityNumber 收货人身份证
 @param sAddress 收货人详细地址
 @param index Cell对应的NSIndexPath
 @param bDefault 是否是默认地址
 */
- (void)loadViewName:(NSString *)sName
         PhoneNumber:(NSString *)sPhoneNumber
      IdentityNumber:(NSString *)sIdentityNumber
             Address:(NSString *)sAddress
          IndextPath:(NSIndexPath *)index
           isDefault:(BOOL      )bDefault;


@end
