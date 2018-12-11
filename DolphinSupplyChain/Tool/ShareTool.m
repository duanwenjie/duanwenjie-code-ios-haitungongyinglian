//
//  ShareTool.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/8.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ShareTool.h"
#import "ZXNTool.h"
@implementation ShareTool


/**
 构造单例方法
 
 @return 实例对象
 */
+ (instancetype)shareInstance
{
    static ShareTool *share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[ShareTool alloc] init];
    });
    return share;
}

+ (void)shareHaiTunAPP
{
    [[ShareTool shareInstance] shareHaiTunAPPOrCommodity:YES SKU:nil Title:nil Image:nil];
}


+ (void)shareHaiTunCommodity:(NSString *)sSKU
                       Title:(NSString *)sTitle
                       Image:(UIImage *)image
{
    [[ShareTool shareInstance] shareHaiTunAPPOrCommodity:NO SKU:sSKU Title:sTitle Image:image];
}



- (void)shareHaiTunAPPOrCommodity:(BOOL)bAPPOrCommodity
                              SKU:(NSString *)sSKU
                            Title:(NSString *)sTitle
                            Image:(UIImage *)image
{
    __weak typeof(self) weakSelf = self;
    //显示分享面板
    //配置上面需求的参数
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.isShow = NO;
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxRowCountForPortraitAndMid = 2;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForPortraitAndMid = 3;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxRowCountForLandscapeAndMid = 2;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForLandscapeAndMid = 6;
    [UMSocialShareUIConfig shareInstance].shareCancelControlConfig.isShow = NO;
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        if (bAPPOrCommodity) {
            [weakSelf shareAPPToPlatformType:platformType];
        }
        else
        {
            UIImage *image1 = [ZXNTool compressedImageFiles:image imageBytes:20];
            
            [weakSelf shareCommodityToPlatformType:platformType SKU:sSKU Title:sTitle Image:image1];
        }
    }];
}

- (void)shareAPPToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"海豚供应链APP";
    
    UMShareWebpageObject *web = [UMShareWebpageObject shareObjectWithTitle:@"海豚供应链" descr:@"致力于成为中国进口最大的供应链平台" thumImage:[UIImage imageNamed:@"Share_Default_Head_Image"]];
    web.webpageUrl = @"https://itunes.apple.com/us/app/hai-tun-gong-ying-lian-zhong/id954817077";
    messageObject.shareObject = web;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"分享错误-错误代码：%@",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}


- (void)shareCommodityToPlatformType:(UMSocialPlatformType)platformType SKU:(NSString *)sSKU Title:(NSString *)sTitle Image:(UIImage *)image
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"海豚供应链APP";
    
    UMShareWebpageObject *web = [UMShareWebpageObject shareObjectWithTitle:sTitle descr:@"海豚优质商品" thumImage:image];
    web.webpageUrl = [NSString stringWithFormat:@"https://www.haitun.hk/index/details/sku/%@.html", sSKU];
    messageObject.shareObject = web;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"分享错误-错误代码：%@",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}





@end
