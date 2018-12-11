//
//  InfoTableViewCell.h
//  Distribution
//
//  Created by fei on 15/5/14.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
#import "MessageFourModel.h"

@interface InfoTableViewCell : UITableViewCell


- (void)cellDisplayWithModel:(MessageFourModel *)info;

@end
