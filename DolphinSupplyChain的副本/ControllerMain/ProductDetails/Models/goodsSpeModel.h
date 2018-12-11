//
//  AppDelegate.m
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//
/*
{
    "attr_type" = 1;
    name = "\U989c\U8272";
    values =                     (
                                  {
                                      "format_price" = "\Uffe50.00\U5143";
                                      "goods_attr_id" = 163;
                                      label = "\U9ed1\U8272";
                                      price = "";
                                      "product_id" = 1;
                                      "product_sn" = "";
                                  }
                                  );
},
*/

#import <Foundation/Foundation.h>

@interface goodsSpeModel : NSObject

@property (nonatomic , copy )NSString *goods_attr_id;
@property (nonatomic , copy )NSString *label;
@property (nonatomic , copy )NSString *format_price;
@property (nonatomic , copy )NSString *product_id;
@property (nonatomic , copy )NSString *product_sn;
@property (nonatomic , copy )NSString *product_number;
@property (nonatomic , copy )NSString *price;

@end
