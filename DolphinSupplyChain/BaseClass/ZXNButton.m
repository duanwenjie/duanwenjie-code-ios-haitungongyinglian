//
//  ZXNButton.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/1/13.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "ZXNButton.h"
#import "UIButton+WebCache.h"

@interface ZXNButton ()

@property (nonatomic, assign) BOOL bHaveMode;

@property (nonatomic, assign) UIViewContentMode modeZXN;

@end


@implementation ZXNButton

- (void)downloadImageAndNoBackImage:(NSString *)sUrl
{
    if (sUrl == nil || [sUrl isEqualToString:@""]) {
        return;
    }
    [self sd_setBackgroundImageWithURL:[NSURL URLWithString:sUrl] forState:UIControlStateNormal];
}

/// 下载图片（有背景图）
- (void)downloadImage:(NSString *)sUrl backgroundImage:(ZXNBackgroundImage)iType
{
    
    UIImage *imgBackground = nil;
    
    if (!self.bHaveMode) {
        self.modeZXN = self.contentMode;
        self.bHaveMode = YES;
    }
    
    switch (iType) {
        case ZXNImageDefaul: // 默认图片
        {
            self.contentMode = UIViewContentModeScaleAspectFit;
            imgBackground = [UIImage imageNamed:@"Default_Logo"];
        }
            break;
        case ZXNImageClassify: // 分类默认图片
        {
            imgBackground = [UIImage imageNamed:@"Classify_Logo"];
        }
            break;
        default:
        {
            imgBackground = [UIImage imageNamed:@"Default_Logo"];
        }
            break;
    }
    
    if ([sUrl isKindOfClass:[NSNull class]] || sUrl == nil || [sUrl isEqualToString:@""]) {
        [self setBackgroundImage:imgBackground forState:UIControlStateNormal];
        return;
    }
    
    WS(weakSelf);
    [self sd_setBackgroundImageWithURL:[NSURL URLWithString:[sUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (iType == ZXNImageDefaul && error == nil) {
            weakSelf.contentMode = weakSelf.modeZXN;
        }
    }];
}


@end
