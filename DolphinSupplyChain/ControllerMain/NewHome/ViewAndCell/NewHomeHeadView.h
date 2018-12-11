//
//  NewHomeHeadView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/22.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^itemClick)(NSInteger selectedIndex);

@interface NewHomeHeadView : UIScrollView

@property (assign, nonatomic) NSInteger selectedItemIndex;

@property (strong, nonatomic) NSArray<NSDictionary *> *items;

- (instancetype)initWithItems:(NSArray<NSDictionary *> *)items
                        Frame:(CGRect)frame
                    itemClick:(itemClick)itemClick;

@end
