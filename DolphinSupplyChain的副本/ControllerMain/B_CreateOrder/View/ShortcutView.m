//
//  ShortcutView.m
//  Distribution
//
//  Created by DIOS on 15/5/12.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import "ShortcutView.h"

@implementation ShortcutView

- (id)initWithFrame:(CGRect)frame titleArr:(NSArray *)arr withImageArr:(NSArray *)imgArr{
    self = [super initWithFrame:frame];
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width - 35, 0, 20, 10)];
    imageView.image = [UIImage imageNamed:@"trigon"];
    [self addSubview:imageView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, imageView.bottom, width, height - imageView.bottom)];
    view.backgroundColor = color(45, 45, 45, 0.95);
    view.layer.cornerRadius = 4.0;
    [self addSubview:view];
    
    
    NSInteger num = arr.count;
    CGFloat scale = view.height/num;
    
    for (int i = 0; i < num; i ++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, i * scale, view.width, scale)];
        [btn setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn addTarget:self action:@selector(touchShortcut:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 100;
        [view addSubview:btn];
        
        NSString *str = [imgArr objectAtIndex:i];
        [btn setImage:[self drawImageWithName:str] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 50)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
        if(i != num - 1){
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, btn.bottom, view.width, 0.5)];
            line.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1.0];
            [view addSubview:line];
        }
    }
    
    return self;
}

- (void)touchShortcut:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(shortcutTouchToPush:)]) {
        [_delegate shortcutTouchToPush:btn.tag];
    }
    
}


- (UIImage *)drawImageWithName:(NSString *)sender{
    UIImage *icon = [UIImage imageNamed:sender];
    CGSize itemSize = CGSizeMake(23, 23);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    
    icon = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return icon;
    
}
@end
