//
//  FoundOrEditView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/4.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FoundOrEditDelegate <NSObject>


/**
 保存按钮回调

 @param sName 收货人名称
 @param sPhoneNumber 联系方式
 @param sIdentityNumber 身份证号码
 @param sAddressInfo 详细地址
 */
- (void)infoSaveName:(NSString *)sName
         PhoneNumber:(NSString *)sPhoneNumber
      IdentityNumber:(NSString *)sIdentityNumber
         AddressInfo:(NSString *)sAddressInfo;

- (void)selectArea;

@end

@interface FoundOrEditView : UIView

@property (nonatomic, weak) id<FoundOrEditDelegate> delegate;

- (void)loadViewName:(NSString *)sName
               Phone:(NSString *)sPhone
            NumberID:(NSString *)sNumberID
            Province:(NSString *)sProvince
                City:(NSString *)sCity
                Area:(NSString *)sArea
         AddressInfo:(NSString *)sAddressInfo;

- (void)loadViewProvince:(NSString *)sProvince
                    City:(NSString *)sCity
                    Area:(NSString *)sArea;

@end
