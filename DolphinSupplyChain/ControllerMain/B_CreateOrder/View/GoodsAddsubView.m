//
//  GoodsAddsubView.m
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/2/18.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "GoodsAddsubView.h"

//@implementation GoodsAddsubView
//
///*
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}
//*/
//
//@end

@interface GoodsAddsubView(){
    UILabel *quatity_text;
}

@end


@implementation GoodsAddsubView


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //120 35
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = kLineColer.CGColor;
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = 0.5;
        self.layer.masksToBounds = YES;
        
        UIButton *reduceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0, 25, 25)];
        [reduceBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [reduceBtn setTitle:@"-" forState:UIControlStateNormal];
        //        [reduceBtn setBackgroundColor:KSystemColor];
        [self addSubview:reduceBtn];
        
        quatity_text = [[UILabel alloc]init];
        quatity_text.frame = CGRectMake(reduceBtn.right, 0, 35, 25);
        quatity_text.textColor = [UIColor blackColor];
        quatity_text.textAlignment=NSTextAlignmentCenter;
        quatity_text.layer.borderColor = kLineColer.CGColor;
        quatity_text.layer.borderWidth = 0.5;
        quatity_text.layer.masksToBounds = YES;
        [self addSubview:quatity_text];
        
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(quatity_text.right,0, 25, 25)];
        [addBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [addBtn setTitle:@"+" forState:UIControlStateNormal];
        //        [addBtn setBackgroundColor:KSystemColor];
        [self addSubview:addBtn];
        
        UIButton * btnReduce = [[UIButton alloc]initWithFrame:CGRectMake(-5, 0, 35, 35)];
        [btnReduce addTarget:self action:@selector(reduceQuatityAction:) forControlEvents:UIControlEventTouchUpInside];
        btnReduce.backgroundColor = [UIColor clearColor];
        btnReduce.tag = 100;
        [self addSubview:btnReduce];
        
        UIButton * btnAdd = [[UIButton alloc]initWithFrame:CGRectMake(quatity_text.right-10, -5, 55, 55)];
        [btnAdd addTarget:self action:@selector(addQuatityAction:) forControlEvents:UIControlEventTouchUpInside];
        btnAdd.backgroundColor = [UIColor clearColor];
        btnAdd.tag = 101;
        [self addSubview:btnAdd];
        
    }
    return self;
}

-(void)setCountText:(NSString *)countText{
    _countText=countText;
    quatity_text.text=countText;
}

- (void)addQuatityAction:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(getNumberForAddAction)]) {
        [_delegate getNumberForAddAction];
    }
}

- (void)reduceQuatityAction:(UIButton *)btn{
    
    if ([_delegate respondsToSelector:@selector(getNumberForReduceAction)]) {
        [_delegate getNumberForReduceAction];
    }
    
}

@end
