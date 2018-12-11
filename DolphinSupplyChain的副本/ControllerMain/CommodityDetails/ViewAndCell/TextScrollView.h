//
//  TextScrollView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/4.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextScrollView : UIScrollView


/**
 控件进行赋值

 @param arrAllData 所有数据
 */
- (void)loadTextData:(NSMutableArray *)arrAllData;

@end
