//
//  ClassifyTableViewController.h
//  Weekens
//
//  Created by 汪超 on 15/5/29.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassifyTableViewDelegate <NSObject>

-(void)putTheKeyBoardDown;

-(void)choseSearchHistoryCellByCellName:(NSString*)searchString Type:(NSString *)sType SKU:(NSString *)sSKU;


@end

@interface ClassifyTableViewController : UIViewController
@property(nonatomic,assign)id<ClassifyTableViewDelegate> delegate;
@property(nonatomic,copy)NSString *searchString;
@property(nonatomic,assign)BOOL isNeedReloard;
-(void)updateHistorySearchWithTitle:(NSString *)string;
@end
