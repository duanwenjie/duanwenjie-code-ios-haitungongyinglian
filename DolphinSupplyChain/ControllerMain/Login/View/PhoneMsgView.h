//
//  PhoneMsgView.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/29.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PhoneMsgViewDelegate <NSObject>

-(void)PhoneMsgViewBtn;


@end

@interface PhoneMsgView : UIView


@property (nonatomic ,strong) UITextField *phoneTxt;
@property (nonatomic ,assign)id<PhoneMsgViewDelegate>delegate;
@property (nonatomic , copy)NSString * imgMSg;
@property (nonatomic , copy)NSString * phoneMSg;


/**
 开始定时器
 */
- (void)getAgainVerifyMessage;


/**
 停止定时器，并删除
 */
- (void)stopTiem;

@end
