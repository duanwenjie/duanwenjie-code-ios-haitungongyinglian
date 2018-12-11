//
//  B_OrderTableHeaderView.m
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/3/13.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "B_OrderTableHeaderView.h"
@interface B_OrderTableHeaderView ()

@property (strong, nonatomic) NSMutableArray *btns;

@property (strong, nonatomic) NSMutableArray *arrVLines;

@property (weak, nonatomic) UIButton *selectedItem;

@property (weak, nonatomic) UIView *selectedView;

@property (copy, nonatomic) itemClick itemClickBlock;


@end



@implementation B_OrderTableHeaderView

#pragma mark - init

- (instancetype)initWithItems:(NSArray<NSDictionary *> *)items Frame:(CGRect)frame itemClick:(itemClick)itemClick
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.btns = [NSMutableArray arrayWithCapacity:items.count];
        self.arrVLines = [NSMutableArray arrayWithCapacity:items.count];
        self.itemClickBlock = itemClick;
        self.items = items;
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
    
}


- (void)setItems:(NSArray *)items{
    
    _items = items;
    
    //创建按钮
    for (NSInteger i = 0; i < items.count; i++) {
        
        UIButton *item = [[UIButton alloc] init];
        [item setTitle:items[i] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [item setTitleColor:ColorAPPTheme forState:UIControlStateSelected];
        item.titleLabel.font = [UIFont systemFontOfSize:14];
        item.titleLabel.textAlignment = NSTextAlignmentCenter;
        item.tag = i + 1;
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btns addObject:item];
        [self addSubview:item];
        
    }
    
    for (NSInteger i = 0; i < self.btns.count; i++) {
        UIButton *item = self.btns[i];
        
        UIView *vLine = [[UIView alloc] init];
        vLine.backgroundColor = [UIColor colorWithHexString:@"12a0ea"];
        vLine.tag = i;
        vLine.hidden = YES;
        [self addSubview:vLine];
        [self.arrVLines addObject:vLine];
        
        item.frame = CGRectMake((kDisWidth/(self.btns.count)*i), 0, (kDisWidth)/(self.btns.count), 35);
        [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(item.mas_left).offset(5);
            make.right.equalTo(item.mas_right).offset(-5);
            make.top.equalTo(item.mas_bottom).offset(0);
            make.height.mas_equalTo(1);
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
