//
//  HotWordView.m
//  Weekens
//
//  Created by DIOS on 15/12/17.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import "HotWordView.h"

static CGFloat  const kItemFont = 12;

static CGFloat  const kItemH = 30;

static CGFloat  const newAddWidth = 10;

static CGFloat  const kMargin = 10;

static CGFloat  const kGapping = 10;

@implementation HotWordView

- (id)init{
    self = [super init];
    
    
    return self;
};

- (void)setHotArr:(NSArray *)hotArr{
    _hotArr = hotArr;
    //创建等数量的btn
    NSInteger num;
    if (hotArr.count > 20) {
        num = 20;
    }else{
        num = hotArr.count;
    }
    for (int i = 0; i < num; i ++) {
        UIButton *item = [[UIButton alloc] init];
        item.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [item setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        item.layer.cornerRadius = 1.0;
        item.layer.borderWidth = 0.5;
        item.layer.borderColor = [color(200, 200, 200, 1) CGColor] ;
        [item addTarget:self action:@selector(itenClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
    }
}

-(void)itenClick:(UIButton *)item
{
    if (self.hotSearchClick) {
        self.hotSearchClick(item.currentTitle);
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSMutableArray *itemArr = [NSMutableArray new];
    for (UIView *view in self.subviews) {
        [itemArr addObject:view];
    }
    //重新布局
    //先取出第一个button并布好局
    UIButton *lastBtn = nil;
    for (int i = 0; i < itemArr.count; i++) {
        UIButton *item = itemArr[i];
        [item setTitle:self.hotArr[i] forState:UIControlStateNormal];
        //设置文字的宽度
        item.width = [self itemWithWithTitle:self.hotArr[i] Font:kItemFont]+newAddWidth;
        item.height = kItemH;
        if (i == 0) {  //第一个的时候放心大胆的布局，并记录下上一个button的位置
            if(item.width > kDisWidth - 2 * kGapping)  //单行文字超过一行处理
            {
                item.width = kDisWidth -2 * kGapping;
            }
            item.x = kGapping;
            item.y = 0;
            lastBtn =item;
        }
        else   //依据上一个button来布局
        {
            if (lastBtn.right + item.width + kMargin > kDisWidth - 10) {  //不足以再摆一行了
                
                item.y = lastBtn.bottom + kMargin;
                item.x = kGapping;
                if(item.width > kDisWidth - 2 * kGapping - 10) //单行文字超过一行处理
                {
                    item.width = kDisWidth - 2 * kGapping - 10;
                }
                
            }
            else  //还能在摆同一行
            {
                item.y = lastBtn.y;
                item.x = lastBtn.right + kMargin;
            }
            //            保存上一次的Button
            lastBtn = item;
        }
        
    }
    
    __weak typeof(self) weakSelf = self;
    //动态计算高度
    if (self.viewHeightRecalc) {
        weakSelf.viewHeightRecalc(lastBtn.bottom+kMargin);
    }
    //    self.rowHeight = lastBtn.bottom+kMargin;
}

/**
 *  动态计算字符串的高度
 */
-(CGFloat)itemWithWithTitle:(NSString *)title Font:(CGFloat)fontSize
{
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0)
    {
        return [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}  context:nil].size.width;
    }
    else
    {
        return [title sizeWithFont:[UIFont systemFontOfSize:kItemFont]].width;
    }
    
}
    


@end
