//
//  ZXNImageView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/30.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ZXNImageView.h"

@interface ZXNImageView ()

@property (nonatomic, assign) BOOL bHaveMode;

@property (nonatomic, assign) UIViewContentMode modeZXN;

@end

@implementation ZXNImageView

- (void)downloadImageAndNoBackImage:(NSString *)sUrl
{
    if (sUrl == nil || [sUrl isEqualToString:@""]) {
        return;
    }
    [self sd_setImageWithURL:[NSURL URLWithString:sUrl]];
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
        [self setImage:imgBackground];
        return;
    }
    
    WS(weakSelf);
    
    [self sd_setImageWithURL:[NSURL URLWithString:[sUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:imgBackground completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (iType == ZXNImageDefaul && error == nil) {
            weakSelf.contentMode = weakSelf.modeZXN;
        }
    }];
}


@end
