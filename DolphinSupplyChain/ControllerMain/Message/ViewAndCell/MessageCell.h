//
//  MessageCell.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/9.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell


- (void)loadView:(NSString *)sURL
            Name:(NSString *)sName
         Subhead:(NSString *)sSubhead
            Time:(NSString *)sTime;

@end
