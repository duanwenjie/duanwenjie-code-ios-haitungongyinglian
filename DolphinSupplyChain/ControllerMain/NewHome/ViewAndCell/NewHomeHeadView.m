//
//  NewHomeHeadView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/22.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "NewHomeHeadView.h"

#define kViewH 35
#define kItemW 70
#define kMargin 10


@interface NewHomeHeadView ()

@property (strong, nonatomic) NSMutableArray *btns;

@property (strong, nonatomic) NSMutableArray *arrVLines;

@property (weak, nonatomic) UIButton *selectedItem;

@property (weak, nonatomic) UIView *selectedView;

@property (copy, nonatomic) itemClick itemClickBlock;


@end

@implementation NewHomeHeadView

#pragma mark - init

- (instancetype)initWithItems:(NSArray<NSDictionary *> *)items Frame:(CGRect)frame itemClick:(itemClick)itemClick
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.btns = [NSMutableArray arrayWithCapacity:items.count];
        self.arrVLines = [NSMutableArray arrayWithCapacity:items.count];
        self.itemClickBlock = itemClick;
        self.items = items;
        //禁用滚动到最顶部的属性
        self.scrollsToTop = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)itemClick:(UIButton *)sender {
    
    if ([sender isEqual:self.selectedItem]) return;
    
    self.selectedItem.selected = NO;
    self.selectedView.hidden = YES;
    sender.selected = YES;
    if (self.arrVLines.count > 0) {
        ((UIView *)self.arrVLines[sender.tag - 1]).hidden = NO;
    }
    
    if (self.itemClickBlock) {
        self.itemClickBlock(sender.tag - 1);
    }
    
    //更改字体大小
    [UIView animateWithDuration:0.5 animations:^{
        sender.titleLabel.font = [UIFont systemFontOfSize:15];
        self.selectedItem.titleLabel.font = [UIFont systemFontOfSize:13];
    }];
    
    //判断位置
    CGFloat offsetX = sender.center.x - self.center.x;
    
    if (offsetX < 0){
        
        self.contentOffset = CGPointMake(0, 0);
        
    }else if (offsetX > (self.contentSize.width - self.bounds.size.width)){
        
        self.contentOffset = CGPointMake(self.contentSize.width - self.bounds.size.width, 0);
        
    }else{
        
        self.contentOffset = CGPointMake(offsetX, 0);
    }
    
    self.selectedItem = sender;
    if (self.arrVLines.count > 0) {
        self.selectedView = self.arrVLines[sender.tag - 1];
    }
    
}

- (void)setSelectedItemIndex:(NSInteger)selectedItemIndex{
    
    _selectedItemIndex = selectedItemIndex;
    
    UIButton *item = self.btns[selectedItemIndex];
    
    [self itemClick:item];
}


- (void)setContentOffset:(CGPoint)contentOffset{
    
    [UIView animateWithDuration:0.25 animations:^{
        [super setContentOffset:contentOffset];
    }];
}


- (void)setItems:(NSArray<NSDictionary *> *)items{
    
    _items = items;
    
    //创建按钮
    for (NSInteger i = 0; i < items.count; i++) {
        
        UIButton *item = [[UIButton alloc] init];
        [item setTitle:items[i][@"category_name"] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateSelected];
        item.titleLabel.font = [UIFont systemFontOfSize:14];
        item.titleLabel.textAlignment = NSTextAlignmentCenter;
        item.tag = i + 1;
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btns addObject:item];
        [self addSubview:item];
        
    }
    
    UIButton *btnLast = nil;
    for (NSInteger i = 0; i < self.btns.count; i++) {
        UIButton *item = self.btns[i];
        
        UIView *vLine = [[UIView alloc] init];
        vLine.backgroundColor = [UIColor colorWithHexString:@"12a0ea"];
        vLine.tag = i;
        vLine.hidden = YES;
        [self addSubview:vLine];
        [self.arrVLines addObject:vLine];
        
        if (i == 0) {
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top);
                make.left.equalTo(self.mas_left).offset(15);
                make.right.equalTo(((UIButton *)self.btns[i + 1]).mas_left).offset(-15);
                make.height.mas_equalTo(kViewH);
            }];
        }
        else if (i == self.btns.count - 1) {
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top);
                make.left.equalTo(((UIButton *)self.btns[i - 1]).mas_right).offset(15);
                make.right.equalTo(self.mas_right).offset(-15);
                make.height.mas_equalTo(kViewH);
            }];
            btnLast = item;
        }
        else
        {
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top);
                make.left.equalTo(((UIButton *)self.btns[i - 1]).mas_right).offset(15);
                make.right.equalTo(((UIButton *)self.btns[i + 1]).mas_left).offset(-15);
                make.height.mas_equalTo(kViewH);
            }];
        }
        
        [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(item.mas_left).offset(0);
            make.right.equalTo(item.mas_right).offset(0);
            make.top.equalTo(item.mas_bottom).offset(0);
            make.height.mas_equalTo(2);
        }];
    }
    
    if (btnLast != nil) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(self);
            make.right.equalTo(btnLast.mas_right).offset(15);
        }];
    }

}


- (instancetype)init{
    
    if (self = [super init]) {
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
    }
    return self;
}


@end
