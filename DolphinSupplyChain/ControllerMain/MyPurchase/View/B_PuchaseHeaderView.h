//
//  B_PuchaseHeaderView.h
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/3/10.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^itemClick)(NSInteger selectedIndex);

@interface B_PuchaseHeaderView : UIScrollView
@property (assign, nonatomic) NSInteger selectedItemIndex;

@property (strong, nonatomic) NSArray<NSDictionary *> *items;

- (instancetype)initWithItems:(NSArray *)items
                        Frame:(CGRect)frame
                    itemClick:(itemClick)itemClick;
@end
