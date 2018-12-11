//
//  InfoModel.h
//  Distribution
//
//  Created by fei on 15/5/14.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//
/*
 "create_time" = "2015-05-14 18:53:38";
 id = 1;
 message = "\U60a8\U7684\U7f16\U53f7\U4e3a 20150513 \U7684\U8ba2\U5355\U5df2\U53d1\U8d27\Uff01";
 type = "sales_order";
 "value_1" = 123;
 "value_2" = 20150513;
 "value_3" = "";
 */

#import <Foundation/Foundation.h>

@interface InfoModel : NSObject

@property (nonatomic ,copy )NSString *create_time;
@property (nonatomic ,copy )NSString *id;
@property (nonatomic ,copy )NSString *message;
@property (nonatomic ,copy )NSString *type;
@property (nonatomic ,copy )NSString *value_1;
@property (nonatomic ,copy )NSString *value_2;

@end
