//
//  ResponseModel.h
//  ImageDataDownload
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 ZhengXueNing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseModel : NSObject

/// 网络是否成功
@property (nonatomic, assign) BOOL bSuccess;

/** 网络状态码 */
@property (nonatomic, copy) NSString *sCode;

/** 网络请求回数据 */
@property (nonatomic, copy) id dataResponse;

/** 网络请求码提示 */
@property (nonatomic, copy) NSString *sMsg;

@end
