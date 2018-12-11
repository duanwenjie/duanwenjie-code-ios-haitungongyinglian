//
//  AFHTTPClient.h
//  ImageDataDownload
//
//  Created by ZhengXueNing on 2016/11/24.
//  Copyright © 2016年 ZhengXueNing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseModel.h"

typedef enum : NSUInteger {
    NEED_LOGIN,       // 自动登录成功
    NEED_LOGIN_FLASE, // 自动登录失败
    NEED_HINT,        // 需要提示
    SERVICE_ERROR,    // HTTP服务错误
    NO_NETWORK,       // 没有网络
} HTTPType;

@interface AFHTTPClient : NSObject

typedef void (^HttpClientRequestCompletionSuccessHandler)(ResponseModel *response);

typedef void (^HttpClientRequestCompletionFlaseHandler)(ResponseModel *response, HTTPType type);

typedef void (^HttpDownloadImageBlock)(bool isSuccess, NSInteger iErrorCode);

typedef void (^HTTPReturnJson)(NSDictionary *Jons);

typedef void (^HTTPError)();

/**
 自动请求登录接口回调
 
 @param bTrue 返回YES表示自动登录成功，返回NO表示自动登录失败
 */
typedef void (^AutoLoginBlock)(BOOL bTrue);

/**
 构造单例方法
 
 @return 实例对象
 */
+ (instancetype)shareInstance;


/**
GET请求-默认超时时间

@param sURL GET HTTP URL
 @param successblock 成功回调
 @param flaseBlock 失败回调
@return NSURLSessionDataTask——方便取消请求
*/
+ (NSURLSessionDataTask *)GET:(NSString *)sURL
                  successInfo:(HttpClientRequestCompletionSuccessHandler)successblock
                    flaseInfo:(HttpClientRequestCompletionFlaseHandler)flaseBlock;



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
                    flaseInfo:(HttpClientRequestCompletionFlaseHandler)flaseBlock;




/**
 GET请求-默认超时时间-没有消除转圈
 
 @param sURL GET HTTP URL
 @param successblock successblock 成功回调
 @param flaseBlock flaseBlock 失败回调
 @return NSURLSessionDataTask——方便取消请求
 */
+ (NSURLSessionDataTask *)GETNODismiss:(NSString *)sURL
                           successInfo:(HttpClientRequestCompletionSuccessHandler)successblock
                             flaseInfo:(HttpClientRequestCompletionFlaseHandler)flaseBlock;

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
                     flaseInfo:(HttpClientRequestCompletionFlaseHandler)flaseBlock;


/**
 POST请求-可设置超时时间（1s-60s)
 
 @param sURL POST HTTP URL
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
                     flaseInfo:(HttpClientRequestCompletionFlaseHandler)flaseBlock;



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
                              flaseInfo:(HttpClientRequestCompletionFlaseHandler)flaseBlock;


/**
 Get请求 不对返回数据做处理

 @param sURL HTTPURL
 @param JsonBlock 成功返回NSDictionary
 @param ErrorBlock 失败返回失败
 @return NSURLSessionDataTask——方便取消请求
 */
+ (NSURLSessionDataTask *)GetNOModify:(NSString *)sURL
                          successInfo:(HTTPReturnJson)JsonBlock
                            falseInfo:(HTTPError)ErrorBlock;


/**
 POST请求 不对返回数据做处理

 @param sURL HTTPURL
 @param dicParams 成功返回NSDictionary
 @param JsonBlock 成功返回NSDictionary
 @param ErrorBlock 失败返回失败
 @return NSURLSessionDataTask——方便取消请求
 */
+ (NSURLSessionDataTask *)POSTNOModify:(NSString *)sURL
                                params:(NSDictionary *)dicParams
                           successInfo:(HTTPReturnJson)JsonBlock
                             falseInfo:(HTTPError)ErrorBlock;


/**
 监测网络状态
 */
- (void)AFNetworkStatus;



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
         ImageBlock:(HttpDownloadImageBlock)block;



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
              ImageBlock:(HttpDownloadImageBlock)block;





@end
