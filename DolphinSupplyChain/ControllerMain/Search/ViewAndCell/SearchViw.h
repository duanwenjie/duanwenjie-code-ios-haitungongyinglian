//
//  SearchViw.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/3.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViw : UIView

- (instancetype)initWithKewWordName:(NSString *)sName;

- (void)loadView:(NSString *)sKeyWord;

@end
