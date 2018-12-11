//
//  ZXNTool.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/30.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ZXNTool.h"
#import "SBJsonWriter.h"

@implementation ZXNTool

#pragma mark - 添加¥符号 并修改¥的字体大小
+ (NSMutableAttributedString *)addMoneySignal:(NSString *)sMoney font:(CGFloat)fFont
{
    NSMutableString *s = [NSMutableString stringWithString:sMoney];
    if ([s containsString:@"."]) {
        NSRange r = [s rangeOfString:@"."];
        if (s.length - (r.location + 1) > 2) {
            [s deleteCharactersInRange:NSMakeRange(r.location + 3, s.length - (r.location + 3))];
        }
        if (s.length - (r.location + 1) == 1 ) {
            [s appendString:@"0"];
        }
    }
    else
    {
        [s appendString:@".00"];
    }
    
    
    NSString *sMoneyAll = [NSString stringWithFormat:@"¥%@",s];
    
    NSMutableAttributedString *numText = [[NSMutableAttributedString alloc]initWithString:sMoneyAll attributes:nil];
    
    [numText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fFont] range:NSMakeRange(0, 1)];
    
    NSRange range = [sMoneyAll rangeOfString:@"."];
    [numText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fFont] range:NSMakeRange(range.location + 1, sMoneyAll.length - (range.location + 1))];
    
    return numText;
}

#pragma mark - 获取文字的Size（长度宽度）
+ (CGSize)gainTextSize:(UIFont *)textFont text:(NSString *)sText
{
    CGSize size = CGSizeMake(MAXFLOAT, 18);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:textFont,NSFontAttributeName,nil];
    CGSize  actualsizeDelivery = [sText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    
    return actualsizeDelivery;
}

#pragma mark - 获取文字的Size（长度宽度）--指定宽度下获取高度及宽度
+ (CGSize)gainTextSize:(UIFont *)textFont text:(NSString *)sText Width:(CGFloat)fWidth
{
    return [sText boundingRectWithSize:CGSizeMake(fWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textFont} context:nil].size;
}

#pragma mark - 实例化一个有颜色的UIImage
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark - 压缩图片
+ (UIImage *)compressedImageFiles:(UIImage *)image
                       imageBytes:(CGFloat)fImageBytes
{
    UIImage *imageCope = image;
    fImageBytes = fImageBytes * 1024;
    NSData *uploadImageData = nil;
    
    uploadImageData = UIImagePNGRepresentation(imageCope);
    CGSize size = imageCope.size;
    CGFloat imageWidth = size.width;
    CGFloat imageHeight = size.height;
    
    if (uploadImageData.length > fImageBytes) {
        
        CGFloat fBytes = fImageBytes/uploadImageData.length;
        
        CGFloat fScaleArea = imageWidth * imageHeight * fBytes;
        
        CGFloat fImageScale = 0.0;
        
        CGFloat dHeight = 0.0;
        
        CGFloat dWidth = 0.0;
        
        if (imageWidth > imageHeight) {
            
            fImageScale = imageWidth/imageHeight;
            dHeight = sqrtf(fScaleArea/fImageScale);
            dWidth  = dHeight * fImageScale;
        }
        else if (imageHeight > imageWidth) {
            
            fImageScale = imageHeight/imageWidth;
            dWidth = sqrtf(fScaleArea/fImageScale);
            dHeight  = dWidth * fImageScale;
        }
        else {
            
            dWidth = sqrtf(fScaleArea);
            dHeight = dWidth;
        }
        
        UIGraphicsBeginImageContext(CGSizeMake(dWidth, dHeight));
        [imageCope drawInRect:CGRectMake(0, 0, dWidth, dHeight)];
        imageCope = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        uploadImageData = UIImagePNGRepresentation(imageCope);
        
        if (uploadImageData.length > fImageBytes) {
            uploadImageData = UIImageJPEGRepresentation(imageCope, 1);
        }
        NSLog(@"图片已经压缩成 %zuKB",uploadImageData.length/1024);
        imageCope = [[UIImage alloc] initWithData:uploadImageData];
        
        return imageCope;
        
    }
    else
    {
        return imageCope;
    }
}

#pragma mark - 将对象转换为JSON字符串
+ (NSString *)getJSONString:(id)Value
{
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *value = [writer stringWithObject:Value];
    return value;
}




@end
