//
//  DefaultAddressFootView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/2.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "DefaultAddressFootView.h"

@interface DefaultAddressFootView ()

/// 立即购买
@property (nonatomic, strong) UIButton *btnSubmitOrder;

@property (nonatomic, strong) UILabel *lblRealitySum;

@property (nonatomic, assign) BuyType buyType;

@property (nonatomic, assign) OrderType orderType;

@property (nonatomic, copy) NSString *sAllMoney;

@property (nonatomic, strong) DefaultAddressFootBlock footBlock;



@property (nonatomic, strong) UIButton *btnOrderRiskTipsTitle;

@end

@implementation DefaultAddressFootView

- (instancetype)initWithBuyTpye:(BuyType)buyType
                      OrderType:(OrderType)orderType
                goUserOrDealers:(DefaultAddressFootBlock)block
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.buyType = buyType;
        self.orderType = orderType;
        self.footBlock = block;
        [self initView];
    }
    return self;
}

- (void)initView
{
    CGFloat fWidth = kDisWidth/3;
    
    [self addSubview:self.lblRealitySum];
    [self addSubview:self.btnSubmitOrder];
    
    if (self.buyType == C_Pay && self.orderType == JingWai_Order) {
        [self addSubview:self.btnCheck];
        [self addSubview:self.btnOrderRiskTipsTitle];
    }
    
    
    [self.lblRealitySum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self);
        make.right.equalTo(self.btnSubmitOrder.mas_left).offset(-5);
    }];

    
    [self.btnSubmitOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.right.equalTo(self);
        make.left.equalTo(self.lblRealitySum.mas_right).offset(5);
        make.width.mas_equalTo(fWidth);
    }];
    
    if (self.buyType == C_Pay && self.orderType == JingWai_Order) {
        [self.btnCheck mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(1);
            make.top.equalTo(self.mas_top).offset(2);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [self.btnOrderRiskTipsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btnCheck.mas_right).offset(3);
            make.top.equalTo(self.mas_top).offset(2);
            make.bottom.equalTo(self.mas_bottom).offset(-2);
        }];
    }
}

- (void)loadViewAllMoney:(NSString *)sAllMoney
{
    self.lblRealitySum.text = [NSString stringWithFormat:@"实付款:¥%@",sAllMoney];
}

#pragma mark - 点击
// 立即采购或立即购买
- (void)SubmitOrder
{
    self.buyType == C_Pay ? self.footBlock(Go_C_Pay) : self.footBlock(Go_B_Pay);
}

// 立即购买
- (void)Purchase
{
    self.footBlock(Go_C_Pay);
}

- (void)buttonCheck:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

- (void)buttonOrderRiskTipsTitle
{
    self.TipsBlock();
}

- (BOOL)isButtonSelect
{
    return self.btnCheck.selected;
}

#pragma mark - 懒加载
- (UIButton *)btnSubmitOrder
{
    if (!_btnSubmitOrder) {
        _btnSubmitOrder = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSubmitOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSubmitOrder setBackgroundColor:[UIColor colorWithHexString:@"1ea5eb"]];
        [_btnSubmitOrder setTitle:@"提交订单" forState:UIControlStateNormal];
        _btnSubmitOrder.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnSubmitOrder addTarget:self action:@selector(SubmitOrder) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmitOrder;
}


- (UILabel *)lblRealitySum
{
    if (!_lblRealitySum) {
        _lblRealitySum = [[UILabel alloc] init];
        _lblRealitySum.textColor = [UIColor redColor];
        _lblRealitySum.font = [UIFont systemFontOfSize:12];
        _lblRealitySum.textAlignment = NSTextAlignmentRight;
    }
    return _lblRealitySum;
}

- (UIButton *)btnCheck
{
    if (!_btnCheck) {
        _btnCheck = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCheck setImage:[UIImage drawImageWithName:@"choose_default" size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
        [_btnCheck setImage:[UIImage drawImageWithName:@"choose_selected" size:CGSizeMake(20, 20)] forState:UIControlStateSelected];
        [_btnCheck addTarget:self action:@selector(buttonCheck:) forControlEvents:UIControlEventTouchUpInside];
        _btnCheck.selected = NO;
    }
    return _btnCheck;
}

- (UIButton *)btnOrderRiskTipsTitle
{
    if (!_btnOrderRiskTipsTitle) {
        _btnOrderRiskTipsTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"本人同意并接受\n以下申报委托"];
        
        [str addAttribute:NSForegroundColorAttributeName
                    value:ColorAPPTheme
                    range:NSMakeRange(10,4)];
        
        [_btnOrderRiskTipsTitle setAttributedTitle:str forState:UIControlStateNormal];
        [_btnOrderRiskTipsTitle addTarget:self action:@selector(buttonOrderRiskTipsTitle) forControlEvents:UIControlEventTouchUpInside];
        _btnOrderRiskTipsTitle.titleLabel.font = kFont12;
        _btnOrderRiskTipsTitle.titleLabel.numberOfLines = 0;
    }
    return _btnOrderRiskTipsTitle;
}


@end
