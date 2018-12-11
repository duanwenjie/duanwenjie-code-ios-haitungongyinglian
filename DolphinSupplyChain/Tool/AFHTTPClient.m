//
//  AFHTTPClient.m
//  ImageDataDownload
//
//  Created by ZhengXueNing on 2016/11/24.
//  Copyright © 2016年 ZhengXueNing. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFNetworking.h"
#import "ResponseModel.h"
#include "AppDelegate.h"

@interface AFHTTPClient ()

@property (nonatomic, assign) BOOL bNetwork;

@end


@implementation AFHTTPClient


/**
 构造单例方法

 @return 实例对象
 */
+ (instancetype)shareInstance
{
    static AFHTTPClient *httpClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpClient = [[AFHTTPClient alloc] init];
        httpClient.bNetwork = YES;
    });
    return httpClient;
}



/**
 GET请求-默认超时时间

 @param sURL GET HTTP URL
 @param successblock 成功回调
 @param flaseBlock 失败回调
 @return NSURLSessionDataTask——方便取消请求
 */
+ (NSURLSessionDataTask *)GET:(NSString *)sURL
                  successInfo:(HttpClientRequestCompletionSuccessHandler)successblock
                    flaseInfo:(HttpClientRequestCompletionFlaseHandler)flaseBlock
{
    return [[AFHTTPClient shareInstance] httpRequestURL:sURL params:nil isPOST:NO timeoutInterval:0 isDisMiss:YES successInfo:successblock falseInfo:flaseBlock];
}



/**
 GET请求-可设置超时时间（1s-60s)

 @param sURL GET HTTP URL
 @param iTime 超时时间（1s-60s)
 @param successblock 成功回调
 @param flaseBlock 失败回调
 @return NSURLSessionDataTask——方便取消请求
 */
+ (NSURLSessionDataTask *)GET:(NSString *)sURL
              timeoutInterval:(NSInteger)iTime
                  successInfo:(HttpClientRequestCompletionSuccessHandler)successblock
                    flaseInfo:(HttpClientRequestCompletionFlaseHandler)flaseBlock
{
    return [[AFHTTPClient shareInstance] httpRequestURL:sURL params:nil isPOST:NO timeoutInterval:iTime isDisMiss:YES successInfo:successblock falseInfo:flaseBlock];
}


/**
 GET请求-默认超时时间-没有消除转圈

 @param sURL GET HTTP URL
 @param successblock successblock 成功回调
 @param flaseBlock flaseBlock 失败回调
 @return NSURLSessionDataTask——方便取消请求
 */
+ (NSURLSessionDataTask *)GETNODismiss:(NSString *)sURL
                           successInfo:(HttpClientRequestCompletionSuccessHandler)successblock
                             flaseInfo:(HttpClientRequestCompletionFlaseHandler)flaseBlock
{
    return [[AFHTTPClient shareInstance] httpRequestURL:sURL params:nil isPOST:NO timeoutInterval:0 isDisMiss:NO successInfo:successblock falseInfo:flaseBlock];
}

/**
 POST请求-默认超时时间

 @param sURL POST HTTP URL
 @param dicParams POST上传内容
 @param successblock 成功回调
 @param flaseBlock 失败回调
 @return NSURLSessionDataTask——方便取消请求
 */
+ (NSURLSessionDataTask *)POST:(NSString *)sURL
                        params:(NSDictionary *)dicParams
                   successInfo:(HttpClientRequestCompletionSuccessHandler)successblock
                     flaseInfo:(HttpClientRequestCompletionFlaseHandler)flaseBlock
{
    return [[AFHTTPClient shareInstance] httpRequestURL:sURL params:dicParams isPOST:YES timeoutInterval:0 isDisMiss:YES successInfo:successblock falseInfo:flaseBlock];
}


/**
 POST请求-可设置超时时间（1s-60s)

 @param sURL HTTP URL
 @param dicParams POST上传内容
 @param iTime 超时时间（1s-60s)
 @param successblock 成功回调
 @param flaseBlock 失败回调
 @return NSURLSessionDataTask——方便取消请求
 */
+ (NSURLSessionDataTask *)POST:(NSString *)sURL
                        params:(NSDictionary *)dicParams
               timeoutInterval:(NSInteger)iTime
                   successInfo:(HttpClientRequestCompletionSuccessHandler)successblock
                     flaseInfo:(HttpClientRequestCompletionFlaseHandler)flaseBlock
{
    return [[AFHTTPClient shareInstance] httpRequestURL:sURL params:dicParams isPOST:YES timeoutInterval:iTime isDisMiss:YES successInfo:successblock falseInfo:flaseBlock];
}


/**
 POST请求-默认超时时间-没有消除转圈
 
 @param sURL POST HTTP URL
 @param dicParams POST上传内容
 @param successblock 成功回调
 @param flaseBlock 失败回调
 @return NSURLSessionDataTask——方便取消请求
 */
+ (NSURLSessionDataTask *)POSTNODismiss:(NSString *)sURL
                                 params:(NSDictionary *)dicParams
                            successInfo:(HttpClientRequestCompletionSuccessHandler)successblock
                              flaseInfo:(HttpClientRequestCompletionFlaseHandler)flaseBlock
{
    return [[AFHTTPClient shareInstance] httpRequestURL:sURL params:dicParams isPOST:YES timeoutInterval:0 isDisMiss:NO successInfo:successblock falseInfo:flaseBlock];
}


+ (NSURLSessionDataTask *)GetNOModify:(NSString *)sURL
                          successInfo:(HTTPReturnJson)JsonBlock
                            falseInfo:(HTTPError)ErrorBlock
{
    return [[AFHTTPClient shareInstance] httpRequestURL:sURL params:nil isPOST:NO successInfo:JsonBlock falseInfo:ErrorBlock];
}

+ (NSURLSessionDataTask *)POSTNOModify:(NSString *)sURL
                                params:(NSDictionary *)dicParams
                          successInfo:(HTTPReturnJson)JsonBlock
                            falseInfo:(HTTPError)ErrorBlock
{
    return [[AFHTTPClient shareInstance] httpRequestURL:sURL params:dicParams isPOST:YES successInfo:JsonBlock falseInfo:ErrorBlock];
}


/**
 监测网络状态
 */
- (void)AFNetworkStatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
                
            case AFNetworkReachabilityStatusUnknown:
                ZXNLog(@"未知网络状态");
                self.bNetwork = YES;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                ZXNLog(@"蜂窝数据网");
                self.bNetwork = YES;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                ZXNLog(@"WiFi网络");
                self.bNetwork = YES;
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                ZXNLog(@"无网络");
                self.bNetwork = NO;
                break;
                
            default:
                self.bNetwork = YES;
                break;
        }
    }] ;
}


/**
 上传单张图片

 @param sURL HTTP URL
 @param dicParameters HTTP参数
 @param sImageName 图片名称
 @param dataImage 图片二进制
 @param isPNG 是否是PNG格式-（PNG格式传YES，JPEG传NO）
 @param block Block回调
 */
- (void)uploadImage:(NSString *)sURL
         parameters:(NSDictionary *)dicParameters
          imageName:(NSString *)sImageName
          imageData:(NSData *)dataImage
         isPNGImage:(BOOL)isPNG
         ImageBlock:(HttpDownloadImageBlock)block
{
    // 向服务器提交图片
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:sURL parameters:dicParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSString *name = [NSString stringWithFormat:@"%@.%@",sImageName,isPNG ? @"png" : @"jpg"];
        
        [formData appendPartWithFormData:dataImage name:name];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        ZXNLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        ZXNLog(@"完成 %@", result);
        block(YES, 0);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        ZXNLog(@"错误 %@", error.localizedDescription);
        block(NO, error.code);
        
    }];
}


/**
 上传多张图片

 @param sURL HTTP URL
 @param dicParameters HTTP参数
 @param arrayImage 图片二进制（数组）
 @param isPNG 是否是PNG格式-（PNG格式传YES，JPEG传NO）
 @param block Block回调
 */
- (void)uploadMultiImage:(NSString *)sURL
              parameters:(NSDictionary *)dicParameters
               imageData:(NSArray *)arrayImage
              isPNGImage:(BOOL)isPNG
              ImageBlock:(HttpDownloadImageBlock)block
{
 
    // 向服务器提交图片
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:sURL parameters:dicParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 上传 多张图片
        for(int i = 0; i < arrayImage.count; i++)
        {
            
            //根据当前系统时间生成图片名称
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:date];
            NSData * imageData = arrayImage[i];
            
            // 上传的图片名称
            NSString * Name = [NSString stringWithFormat:@"%@-%d", dateString, i];
            // 上传图片路径
            NSString * fileName = [NSString stringWithFormat:@"%@.%@", Name, isPNG ? @"png": @"jpg"];
            
            ZXNLog(@"name=%@", Name);
            
            [formData appendPartWithFileData:imageData name:Name fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        ZXNLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        ZXNLog(@"完成 %@", result);
        block(YES, 0);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        ZXNLog(@"错误 %@", error.localizedDescription);
        block(NO, error.code);
        
    }];
}



/**
  HTTP请求

 @param sURL HTTP URL
 @param dicParams 上传内容（可传nil
 @param isPOST 判断是否是POST还是GET (POST-传入YES GET传入NO
 @param iTime 设置超时时间（1s-60s)
 @param bDisMiss 是否消除转圈
 @param successBlock 成功回调
 @param falseBlock 失败回调
 @return NSURLSessionDataTask——方便取消请求
 */
- (NSURLSessionDataTask *)httpRequestURL:(NSString *)sURL
                                  params:(NSDictionary *)dicParams
                                  isPOST:(BOOL)isPOST
                         timeoutInterval:(NSInteger)iTime
                               isDisMiss:(BOOL)bDisMiss
                             successInfo:(HttpClientRequestCompletionSuccessHandler)successBlock
                               falseInfo:(HttpClientRequestCompletionFlaseHandler)falseBlock
{
    if (!self.bNetwork) {
        ZXNLog(@"----请求没有网络----\n");
        [HTLoadingTool disMissForWindow];
        [HTLoadingTool disMissForView];
        ResponseModel *response = [[ResponseModel alloc] init];
        response.sMsg = @"亲！网络不给力~";
        falseBlock(response, NO_NETWORK);
        return nil;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if (iTime > 0 && iTime < 60) {
        [manager.requestSerializer setTimeoutInterval:iTime];
    }
    else
    {
        [manager.requestSerializer setTimeoutInterval:60];
    }
    
//    [manager setSecurityPolicy:[self customSecurityPolicy]];
    
    NSString *URL = [NSString stringWithFormat:KHTTPURLBBC,sURL];
    
    NSURLSessionDataTask *sessionDataTask;
    
    if (isPOST) {
        
        NSMutableDictionary *dic = [dicParams mutableCopy];
        if (dic == nil) {
            dic = [NSMutableDictionary dictionary];
        }
        
        [dic setValue:[YKSUserDefaults shareInstance].sUser_Ticket forKey:@"ticket"];
        
        ZXNLog(@"POST请求：%@\n请求参数：%@", URL, dic);
        
        sessionDataTask = [manager POST:URL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress){
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            ResponseModel *response = [self convertResponseToResultInfo:responseObject];
            
            if ([response.sCode isEqualToString:@"0X0004"] || [response.sCode isEqualToString:@"0X0004"])
            {
                // 需要重新启用登录接口
                [self registerAppForAutoLogin:^(BOOL bTrue) {
                    ZXNLog(@"需要登录");
                    bTrue ? falseBlock(response, NEED_LOGIN) : falseBlock (response, NEED_LOGIN_FLASE);
                }];
            }
            else if ([response.sCode isEqualToString:@"0X0000"])
            {
                successBlock(response);
            }
            else
            {
                falseBlock(response, NEED_HINT);
            }
            if (bDisMiss) {
                [HTLoadingTool disMissForWindow];
                [HTLoadingTool disMissForView];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            ZXNLog(@"----Post请求错误----\n错误信息：\n%@\n错误码：%ld\n",[error userInfo],(long)error.code);
            
            ResponseModel *response = [[ResponseModel alloc] init];
            response.sCode = [NSString stringWithFormat:@"%ld",(long)error.code];
            response.sMsg = [NSString stringWithFormat:@"HTTP请求错误（服务%@错误）", response.sCode];
            falseBlock(response, SERVICE_ERROR);
            
            if (bDisMiss) {
                [HTLoadingTool disMissForWindow];
                [HTLoadingTool disMissForView];
            }
            
        }];
    }
    else
    {
        NSDictionary *dicTicket = @{@"ticket":[YKSUserDefaults gainTicKet]};
        
        ZXNLog(@"GET请求：%@\n请求参数：%@", URL, dicTicket);
        
        sessionDataTask = [manager GET:URL parameters:dicTicket progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            ResponseModel *response = [self convertResponseToResultInfo:responseObject];
            
            if ([response.sCode isEqualToString:@"0X0004"])
            {
                // 需要重新启用登录接口
                [self registerAppForAutoLogin:^(BOOL bTrue) {
                    
                    ZXNLog(@"需要登录");
                    bTrue ? falseBlock(response, NEED_LOGIN) : falseBlock (response, NEED_LOGIN_FLASE);
                    
                }];
            }
            else if ([response.sCode isEqualToString:@"0X0000"])
            {
                successBlock(response);
            }
            else
            {
                falseBlock(response, NEED_HINT);
            }
            
            if (bDisMiss) {
                [HTLoadingTool disMissForWindow];
                [HTLoadingTool disMissForView];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            ZXNLog(@"----Get请求错误----\n错误信息：\n%@\n错误码：%ld\n",[error userInfo],(long)error.code);
            ResponseModel *response = [[ResponseModel alloc] init];
            response.sCode = [NSString stringWithFormat:@"%ld",(long)error.code];
            response.sMsg = [NSString stringWithFormat:@"HTTP请求错误（服务%@错误）", response.sCode];
            falseBlock(response, SERVICE_ERROR);
            
            if (bDisMiss) {
                [HTLoadingTool disMissForWindow];
                [HTLoadingTool disMissForView];
            }
            
        }];
    }
    return sessionDataTask;
}





/**
 HTTP请求
 
 @param sURL HTTP URL
 @param dicParams 上传内容（可传nil
 @param isPOST 判断是否是POST还是GET (POST-传入YES GET传入NO
 @param JsonBlock 成功回调
 @param ErrorBlock 失败回调
 @return NSURLSessionDataTask——方便取消请求
 */
- (NSURLSessionDataTask *)httpRequestURL:(NSString *)sURL
                                  params:(NSDictionary *)dicParams
                                  isPOST:(BOOL)isPOST
                             successInfo:(HTTPReturnJson)JsonBlock
                               falseInfo:(HTTPError)ErrorBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSString *URL = [NSString stringWithFormat:KHTTPURLBBC,sURL];
    
    NSURLSessionDataTask *sessionDataTask;
    
    if (isPOST) {
        
        NSMutableDictionary *dic = [dicParams mutableCopy];
        if (dic == nil) {
            dic = [NSMutableDictionary dictionary];
        }
        ZXNLog(@"POST请求：%@\n请求参数：%@", URL, dic);
        
        sessionDataTask = [manager POST:URL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress){
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            JsonBlock(responseDict);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            ErrorBlock();
        }];
    }
    else
    {
        ZXNLog(@"GET请求：%@", URL);
        
        sessionDataTask = [manager GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            JsonBlock(responseDict);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            ErrorBlock();
        }];
    }
    return sessionDataTask;
}

- (void)registerAppForAutoLogin:(AutoLoginBlock)block
{
    if ([YKSUserDefaults shareInstance].sUser_Mobile.length == 0 || [YKSUserDefaults readUserPassword].length == 0 || [YKSUserDefaults shareInstance].sUser_PasswordKey.length == 0) {
        
        block(NO);
        return;
    }
    
    
    NSDictionary *dic = @{@"user_name":[YKSUserDefaults shareInstance].sUser_Mobile,
                          @"password":[YKSUserDefaults readUserPassword],
                          @"password_key":[YKSUserDefaults shareInstance].sUser_PasswordKey
                          };

    [AFHTTPClient POSTNODismiss:@"/user/login" params:dic successInfo:^(ResponseModel *response) {
        
        block(YES);
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == NO_NETWORK)
        {
            ZXNLog(@"----------自动登录错误----------\n%@",response.sMsg);
            if ([YKSUserDefaults isLogin]) {
                [YKSUserDefaults deleteAllUserInfo];
                [YKSUserDefaults deleteUserPassword];
                
                // 返回经销商个人中心
                AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [appDelegate changeRootView:YES cutSomeController:0];
            }
            
            block(NO);
            return ;
        }

    }];
}


// 添加自签证书
- (AFSecurityPolicy *)customSecurityPolicy
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HTHttpsSever" ofType:@"cer"];
    NSData *certDate = [NSData dataWithContentsOfFile:path];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    [securityPolicy setAllowInvalidCertificates:YES];
    [securityPolicy setValidatesDomainName:NO];
    NSSet *set = [NSSet setWithArray:@[certDate]];
    [securityPolicy setPinnedCertificates:set];
    
    return securityPolicy;
}

//json数据解析
- (ResponseModel *)convertResponseToResultInfo:(id)obc
{
    ResponseModel *response = [[ResponseModel alloc] init];
    if (obc == nil) {
        return nil;
    }
    
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:obc options:NSJSONReadingMutableContainers error:nil];
    
    response.bSuccess     = (BOOL)responseDict[@"success"];
    response.sMsg         = responseDict[@"message"];
    response.dataResponse = responseDict[@"data"];
    response.sCode        = responseDict[@"code"];
    
    if (((NSString *)responseDict[@"ticket"]).length != 0) {
        // 更新并储存Ticket
        [YKSUserDefaults upDateUser_Ticket:responseDict[@"ticket"]];
    }
    
    
    if (response.sMsg.length == 0 || response.sMsg == nil) {
        response.sMsg = @"";
    }
    
    if (response.sCode.length == 0 || response.sCode == nil) {
        response.sCode = @"";
    }

    return response;
}


@end
