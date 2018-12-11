//
//  OrderListHeadView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/5.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "OrderListHeadView.h"

@interface OrderListHeadView ()

@property (nonatomic, strong) UIView *vBack;

@property (nonatomic, strong) UILabel *lblOrderNumber;

@property (nonatomic, strong) UILabel *lblTime;

@property (nonatomic, strong) UILabel *lblOrder;


//@property (nonatomic, strong) UIImageView *imgArrows;

@property (nonatomic, assign) NSInteger iIndex;

@end

@implementation OrderListHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        self.iIndex = 0;
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self.contentView addSubview:self.vBack];
    [self.vBack addSubview:self.lblOrderNumber];
    [self.vBack addSubview:self.lblOrder];
    [self.vBack addSubview:self.lblTime];
//    [self.vBack addSubview:self.imgArrows];
    
    [self.vBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(10);
    }];
    
    [self.lblOrderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vBack);
        make.left.equalTo(self.vBack.mas_left).offset(8);
        make.right.equalTo(self.lblTime.mas_left).offset(-3);
        make.height.mas_equalTo(25);
    }];
    
    [self.lblOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblOrderNumber.mas_bottom).offset(0);
        make.left.equalTo(self.vBack.mas_left).offset(8);
        make.right.equalTo(self.lblTime.mas_left).offset(-3);
        make.height.mas_equalTo(25);
    }];

    
    [self.lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.vBack);
        make.right.equalTo(self.vBack.mas_right).offset(-10);
        make.left.equalTo(self.lblOrderNumber.mas_right).offset(3);
    }];
    
//    [self.imgArrows mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(self.vBack);
//        make.right.equalTo(self.vBack.mas_right).offset(-8);
//        make.width.mas_equalTo(10);
//    }];
    
    UITapGestureRecognizer *tapOrderNumber = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOrderNumber)];
    
    [self addGestureRecognizer:tapOrderNumber];
}

#pragma mark - 渲染数据
- (void)loadViewOrderNumber:(NSString *)sOrderNumber
                       Time:(NSString *)sTime
                      Order:(NSString *)sOrder
                      Index:(NSInteger )iIndex
{
    self.iIndex = iIndex;
    self.lblOrderNumber.text = [NSString stringWithFormat:@"下单时间:%@",sOrderNumber];
    self.lblTime.text = sTime;
    self.lblOrder.text = [NSString stringWithFormat:@"订单号:%@",sOrder];
    [self setNeedsLayout];
}


#pragma mark - 点击事件
- (void)tapOrderNumber
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ComeInOederInfoVC:)]) {
        [self.delegate ComeInOederInfoVC:self.iIndex];
    }
}



#pragma mark - 懒加载

- (UIView *)vBack
{
    if (!_vBack) {
        _vBack = [[UIView alloc] init];
        _vBack.backgroundColor = [UIColor whiteColor];
    }
    return _vBack;
}

- (UILabel *)lblOrderNumber
{
    if (!_lblOrderNumber) {
        _lblOrderNumber = [[UILabel alloc] init];
        _lblOrderNumber.textColor = [UIColor colorWithHexString:@"333333"];
        _lblOrderNumber.font = [UIFont systemFontOfSize:12];
    }
    return _lblOrderNumber;
}

- (UILabel *)lblTime
{
    if (!_lblTime) {
        _lblTime = [[UILabel alloc] init];
        _lblTime.textColor = [UIColor colorWithHexString:@"ef2e23"];
        _lblTime.font = [UIFont systemFontOfSize:14];
        _lblTime.textAlignment = NSTextAlignmentRight;
    }
    return _lblTime;
}

- (UILabel *)lblOrder
{
    if (!_lblOrder) {
        _lblOrder = [[UILabel alloc] init];
        _lblOrder = [[UILabel alloc] init];
        _lblOrder.textColor = [UIColor colorWithHexString:@"333333"];
        _lblOrder.font = [UIFont systemFontOfSize:12];
    }
    return _lblOrder;
}


//- (UIImageView *)imgArrows
//{
//    if (!_imgArrows) {
//        _imgArrows = [[UIImageView alloc] init];
//        _imgArrows.image = [UIImage imageNamed:@"accessory"];
//        _imgArrows.contentMode = UIViewContentModeScaleAspectFit;
//    }
//    return _imgArrows;
//}




@end
