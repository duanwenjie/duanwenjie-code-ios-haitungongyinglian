//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderInforModel;

@interface ShoppingInforView : UIView

-(instancetype)initWithFrame:(CGRect)frame Index:(int)index Infor:(OrderInforModel *)orderinfor;

@end
