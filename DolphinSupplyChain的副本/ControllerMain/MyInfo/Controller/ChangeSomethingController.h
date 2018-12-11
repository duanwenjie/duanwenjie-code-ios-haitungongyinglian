//
//  ChangeSomethingController.h
//  Distribution
//
//  Created by 张翔 on 14-11-22.
//  Copyright (c) 2014年 ___YKSKJ.COM___. All rights reserved.
//

#import "HTBase_VC.h"
#import "UserInformationController.h"

@interface ChangeSomethingController : HTBase_VC

@property (nonatomic, assign)NSInteger numOfRow;
@property (nonatomic, copy)  NSString *nickName;

typedef void (^ChangeSomethingBlock)(NSString *sNeiRon, NSString *Type);

- (instancetype)initWithChangeSomething:(ChangeSomethingBlock)block;

@end
