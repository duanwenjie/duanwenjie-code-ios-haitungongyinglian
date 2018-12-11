//
//  DefaultAddressHeadView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DefaultAddressHeadDelegate <NSObject>

- (void)tapAddAddress;

@end

@interface DefaultAddressHeadView : UIView

@property (nonatomic, weak) id<DefaultAddressHeadDelegate> delegate;

/**
 传入数据渲染界面

 @param sName 收货人名称
 @param sIdentity 收货人身份证号码
 @param sAddress 收货人地址
 @param bData 是否有收货人默认地址 有传入YES 没有传入NO
 */
- (void)loadViewName:(NSString *)sName
            identity:(NSString *)sIdentity
             address:(NSString *)sAddress
              isData:(BOOL )bData;

@end
