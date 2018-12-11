//
//  HTFMDBTool.m
//  STDBTest
//
//  Created by ZhengXueNing on 2016/12/14.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import "HTFMDBTool.h"
#import <FMDB.h>

@interface HTFMDBTool ()

@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

@end

@implementation HTFMDBTool

static HTFMDBTool *HTfmdb= nil;
+ (HTFMDBTool *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HTfmdb = [[HTFMDBTool alloc] init];
    });
    return HTfmdb;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSFileManager * fmManger = [NSFileManager defaultManager];
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * dbPath = [NSString stringWithFormat:@"%@/HTALLData.db",[paths count] > 0 ? paths.firstObject : nil];
        if (![fmManger fileExistsAtPath:dbPath]) {
            [fmManger createFileAtPath:dbPath contents:nil attributes:nil];
        }
        
        // 创建表
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        [self updateDbVersion:2];
    }
    return self;
}

//更新数据库
- (void)updateDbVersion:(NSInteger)newVersion
{
    // 执行数据库更新
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        // 查询数据库版本
        NSString * sql = [NSString stringWithFormat:@"PRAGMA user_version"];
        FMResultSet * rs = [db executeQuery:sql];
        int oldVersion = 0;
        while ([rs next]) {
            oldVersion = [rs intForColumn:@"user_version"];
        }
        
        [rs close];
        if ([db hadError]) {
            NSLog(@"\n获取DB版本号失败--失败代码:%d:\n失败原因:%@", [db lastErrorCode], [db lastErrorMessage]);
            return;
        }
        
        // 如果版本号为0 或者版本号比储存的版本号大，那么执行更新数据库操作
        if (newVersion > oldVersion || newVersion == 0) {
            __block BOOL bRet = NO;
            [[self setSqliArray] enumerateObjectsUsingBlock:^(NSString *sSQL, NSUInteger idx, BOOL * _Nonnull stop) {
                
                bRet = [db executeUpdate:sSQL];
                if ([db hadError]) {
                    NSLog(@"\n更新DB表失败--失败代码%d:\n失败原因%@\n失败SQL语句:%@", [db lastErrorCode], [db lastErrorMessage], sSQL);
                    *stop = YES;
                }
                
            }];
            
            // 如果更新数据库操作成功，那么会进行更新版本号操作
            if (bRet) {
                NSString *sql = [NSString stringWithFormat:@"PRAGMA user_version = %ld",(long)newVersion];
                [db executeUpdate:sql];
                if ([db hadError])
                {
                    NSLog(@"\n更新DB版本号失败--失败代码:%d:\n失败原因:%@", [db lastErrorCode], [db lastErrorMessage]);
                }
                else
                {
                    NSLog(@"更新DB版本号成功");
                }
                NSLog(@"更新DB数据库数据成功");
            }
            else
            {
                NSLog(@"更新DB数据库数据失败");
            }
        }
        else
        {
            NSLog(@"获取原有DB数据库数据成功");
        }
    }];
}

/// 执行查询SQL
- (void)querySQL:(NSString*)sql block:(void(^)(NSMutableArray *))block
{
    // 进行查询
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        
        if ([db hadError]) {
            NSLog(@"查询失败\n失败信息:%@",[db lastErrorMessage]);
        }
        NSMutableArray *array = [NSMutableArray array];
        while ([rs next]) {
            NSInteger iCount = [rs columnCount];
            if (iCount > 0) {
                NSMutableDictionary* dic = [NSMutableDictionary dictionary];
                
                for (int i = 0; i < iCount; i++) {
                    NSString *sName = [rs columnNameForIndex:i];
                    NSString *sValue = [rs stringForColumn:sName];
                    [dic setObject:sValue == nil ? @"" : sValue forKey:sName];
                }
                [array addObject:dic];
            }
        }
        [rs close];
        block(array);
    }];
}

/// 执行增删改SQL
- (void)execSQL:(NSString *)sql withBlock:(void(^)(BOOL bRet))block
{
    __block BOOL bRet = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        bRet = [db executeUpdate:sql];
        if ([db hadError])
        {
            NSLog(@"执行增删改SQL错误\nc错误代码:%d:\n错误信息:%@\n错误SQL语句:%@", [db lastErrorCode], [db lastErrorMessage], sql);
            block(NO);
        }
        else
        {
            block(YES);
        }
    }];
}


// 插入创建表数组
- (NSArray *)setSqliArray
{
    NSMutableArray * sqlList = @[].mutableCopy;
    [sqlList addObject:@"create table if not exists cart_tb (id INTEGER PRIMARY KEY AUTOINCREMENT, sImage char(128), sName char(128), sMoney char(128), sNumber char(128), sSku char(128), sCommodityID char(128), sMinPurchase char(128), sModulo char(128), sTrade char(128))"];
    return sqlList;
}

@end
