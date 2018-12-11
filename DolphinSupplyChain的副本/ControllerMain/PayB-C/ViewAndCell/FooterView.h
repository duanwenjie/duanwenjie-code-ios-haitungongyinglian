//
//  FooterView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/5/16.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HandleFooterDelegate <NSObject>

- (void)tapGoPay:(NSInteger)iSection;

@end

@interface FooterView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<HandleFooterDelegate> delegate;

- (void)loadData:(NSString *)sMoney Section:(NSInteger)iSection isPay:(BOOL)bIsPay;

@end
