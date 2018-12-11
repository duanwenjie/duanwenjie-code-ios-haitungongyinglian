//
//  BuyListClassifyView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/30.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyListClassifyView : UIView

typedef void (^BuyListClassifyBlock)(NSString *sClassifyID, NSString *sClassifyName, NSMutableArray *arrClassify);

@property (nonatomic, strong) NSMutableArray *arrClassify;

- (instancetype)initWithBlock:(BuyListClassifyBlock)block;

@end
