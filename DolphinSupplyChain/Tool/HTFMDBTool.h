//
//  HTFMDBTool.h
//  STDBTest
//
//  Created by ZhengXueNing on 2016/12/14.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTFMDBTool : NSObject

+ (HTFMDBTool *)shareInstance;


/**
 执行查询SQL

 @param sql SQL语句
 @param block Block回调
 */
- (void)querySQL:(NSString*)sql block:(void(^)(NSMutableArray *))block;


/**
 执行增删改SQL

 @param sql SQL语句
 @param block Block回调
 */
- (void)execSQL:(NSString *)sql withBlock:(void(^)(BOOL bRet))block;

@end
