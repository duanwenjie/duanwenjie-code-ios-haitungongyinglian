//
//  PersonalOrderCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/29.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "PersonalOrderCell.h"

@interface PersonalOrderCell ()

@property (nonatomic, strong) PersonalOrderBlock OrderBlock;

//****我的全部订单视图****
/*
@property (nonatomic, strong) UIView *vAllOrder;

@property (nonatomic, strong) UIImageView *imgAllOrder;

@property (nonatomic, strong) UILabel *lblAllOrderName;

@property (nonatomic, strong) UILabel *lblExamineAllOreder;

@property (nonatomic, strong) UIImageView *imgArrows;

@property (nonatomic, strong) UIView *vLine;
*/

//****待付款视图****
@property (nonatomic, strong) UIView *vPayment;

@property (nonatomic, strong) UIImageView *imgPayment;

@property (nonatomic, strong) UILabel *lblPayment;

@property (nonatomic, strong) UILabel *lblNumberPayment;

//****待发货视图****
@property (nonatomic, strong) UIView *vShipments;

@property (nonatomic, strong) UIImageView *imgShipment;

@property (nonatomic, strong) UILabel *lblShipment;

@property (nonatomic, strong) UILabel *lblNumberShipment;

//****待收货视图****
@property (nonatomic, strong) UIView *vGatherGoods;

@property (nonatomic, strong) UIImageView *imgGatherGoods;

@property (nonatomic, strong) UILabel *lblGatherGoods;

@property (nonatomic, strong) UILabel *lblNumberGatherGoods;


//****全部订单视图****
@property (nonatomic, strong) UIView *vEvaluate;

@property (nonatomic, strong) UIImageView *imgEvaluate;

@property (nonatomic, strong) UILabel *lblEvaluate;

@property (nonatomic, strong) UILabel *lblNumberEvaluate;



@end

@implementation PersonalOrderCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier tapSomeButton:(PersonalOrderBlock)block
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.OrderBlock = block;
        [self initView];
    }
    return self;
}

- (void)initView
{
    /*
    [self.contentView addSubview:self.vAllOrder];
    [self.vAllOrder addSubview:self.imgAllOrder];
    [self.vAllOrder addSubview:self.lblAllOrderName];
    [self.vAllOrder addSubview:self.lblExamineAllOreder];
    [self.vAllOrder addSubview:self.imgArrows];
    [self.contentView addSubview:self.vLine];
    */
    
    
    [self.contentView addSubview:self.vPayment];
    [self.vPayment addSubview:self.imgPayment];
    [self.vPayment addSubview:self.lblPayment];
    [self.vPayment addSubview:self.lblNumberPayment];
    
    [self.contentView addSubview:self.vShipments];
    [self.vShipments addSubview:self.imgShipment];
    [self.vShipments addSubview:self.lblShipment];
    [self.vShipments addSubview:self.lblNumberShipment];
    
    [self.contentView addSubview:self.vGatherGoods];
    [self.vGatherGoods addSubview:self.imgGatherGoods];
    [self.vGatherGoods addSubview:self.lblGatherGoods];
    [self.vGatherGoods addSubview:self.lblNumberGatherGoods];
    
    
    [self.contentView addSubview:self.vEvaluate];
    [self.vEvaluate addSubview:self.imgEvaluate];
    [self.vEvaluate addSubview:self.lblEvaluate];
    [self.vEvaluate addSubview:self.lblNumberEvaluate];
    
    
    //****全部订单视图****
    /*
    [self.vAllOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(54);
    }];
    
    [self.imgAllOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vAllOrder.mas_top).offset(11);
        make.left.equalTo(self.vAllOrder.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
    [self.lblAllOrderName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgAllOrder.mas_top);
        make.left.equalTo(self.imgAllOrder.mas_right).offset(15);
        make.bottom.equalTo(self.imgAllOrder.mas_bottom);
        make.width.mas_equalTo(60);
    }];
    
    [self.lblExamineAllOreder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.imgAllOrder);
        make.width.mas_equalTo(80);
        make.right.equalTo(self.imgArrows.mas_left).offset(-10);
    }];
    
    [self.imgArrows mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vAllOrder.mas_top).offset(18);
        make.bottom.equalTo(self.vAllOrder.mas_bottom).offset(-18);
        make.right.equalTo(self.vAllOrder.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.vAllOrder.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    */
    
    //****待付款视图****
    [self.vPayment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.vShipments.mas_width);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.vShipments.mas_left);
    }];
    
    [self.imgPayment mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.vPayment.mas_centerX).with.offset(0);
        make.top.equalTo(self.vPayment.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    
    
    [self.lblPayment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vPayment);
        make.centerX.equalTo(self.vPayment.mas_centerX);
        make.height.mas_equalTo(22);
        make.top.equalTo(self.imgPayment.mas_bottom).offset(0);
    }];
    
    [self.lblNumberPayment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vPayment.mas_top).offset(8);
        make.left.equalTo(self.vPayment.mas_left).offset(kDisWidth/8 + 8);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    
    //****待发货视图****
    [self.vShipments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.vGatherGoods.mas_width);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.vPayment.mas_right);
        make.right.equalTo(self.vGatherGoods.mas_left);
    }];
    
    [self.imgShipment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(36, 36));
        make.centerX.equalTo(self.vShipments.mas_centerX);
        make.top.equalTo(self.vShipments.mas_top).offset(10);
    }];
    
    [self.lblShipment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vShipments);
        make.centerX.equalTo(self.vShipments.mas_centerX);
        make.height.mas_equalTo(22);
        make.top.equalTo(self.imgShipment.mas_bottom).offset(0);
    }];
    
    [self.lblNumberShipment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vShipments.mas_top).offset(8);
        make.left.equalTo(self.vShipments.mas_left).offset(kDisWidth/8 + 8);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    
    //****待收货视图****
    [self.vGatherGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.vEvaluate.mas_width);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.vShipments.mas_right);
        make.right.equalTo(self.vEvaluate.mas_left);
    }];
    
    [self.imgGatherGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(36, 36));
        make.centerX.equalTo(self.vGatherGoods.mas_centerX);
        make.top.equalTo(self.vGatherGoods.mas_top).offset(10);
    }];
    
    [self.lblGatherGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vGatherGoods);
        make.centerX.equalTo(self.vGatherGoods.mas_centerX);
        make.height.mas_equalTo(22);
        make.top.equalTo(self.imgGatherGoods.mas_bottom).offset(0);
    }];
    
    [self.lblNumberGatherGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vGatherGoods.mas_top).offset(8);
        make.left.equalTo(self.vGatherGoods.mas_left).offset(kDisWidth/8 + 8);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    //****待评价视图****
    [self.vEvaluate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.vPayment.mas_width);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.vGatherGoods.mas_right);
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    [self.imgEvaluate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(36, 36));
        make.centerX.equalTo(self.vEvaluate.mas_centerX);
        make.top.equalTo(self.vEvaluate.mas_top).offset(10);
    }];
    
    [self.lblEvaluate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vEvaluate);
        make.centerX.equalTo(self.vEvaluate.mas_centerX);
        make.height.mas_equalTo(22);
        make.top.equalTo(self.imgEvaluate.mas_bottom).offset(0);
    }];
    
    [self.lblNumberEvaluate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vEvaluate.mas_top).offset(8);
        make.left.equalTo(self.vEvaluate.mas_left).offset(kDisWidth/8 + 8);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];

}

#pragma mark - 数值赋值
- (void)loadView:(NSString *)sPaymentNumber
        Shipment:(NSString *)sShipmentNumber
     GatherGoods:(NSString *)sGatherGoodsNumber
{
    if (sPaymentNumber.length == 0 || [sPaymentNumber isEqualToString:@"0"]) {
        self.lblNumberPayment.hidden = YES;
        self.lblNumberPayment.text = @"";
    }
    else {
        self.lblNumberPayment.hidden = NO;
        self.lblNumberPayment.text = sPaymentNumber;
    }
    
    if (sShipmentNumber.length == 0 || [sShipmentNumber isEqualToString:@"0"]) {
        self.lblNumberShipment.hidden = YES;
        self.lblNumberShipment.text = @"";
    }
    else {
        self.lblNumberShipment.hidden = NO;
        self.lblNumberShipment.text = sShipmentNumber;
    }
    
    if (sGatherGoodsNumber.length == 0 || [sGatherGoodsNumber isEqualToString:@"0"]) {
        self.lblNumberGatherGoods.hidden = YES;
        self.lblNumberGatherGoods.text = @"";
    }
    else {
        self.lblNumberGatherGoods.hidden = NO;
        self.lblNumberGatherGoods.text = sGatherGoodsNumber;
    }
    
    /*
    if (sEvaluatNumber.length == 0) {
        self.lblNumberEvaluate.hidden = YES;
        self.lblNumberEvaluate.text = @"";
    }
    else {
        self.lblNumberEvaluate.hidden = NO;
        self.lblNumberEvaluate.text = sEvaluatNumber;
    }
    */
    
    [self setNeedsLayout];
}


#pragma mark - 点击事件
/*
- (void)tapAllOrder
{
    self.OrderBlock(AllOrder);
}
*/
- (void)tapPayment
{
    self.OrderBlock(Payment);
}

- (void)tapShipment
{
    self.OrderBlock(Shipments);
}

- (void)tapGatherGoods
{
    self.OrderBlock(GatherGoods);
}


- (void)tapEvaluat
{
    self.OrderBlock(AllOrder);
}



#pragma mark - 控件懒加载
/*
- (UIView *)vAllOrder
{
    if (!_vAllOrder) {
        _vAllOrder = [[UIView alloc] init];
        
        UITapGestureRecognizer *tapAllOrder = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAllOrder)];
        [_vAllOrder addGestureRecognizer:tapAllOrder];
    }
    return _vAllOrder;
}

- (UIImageView *)imgAllOrder
{
    if (!_imgAllOrder) {
        _imgAllOrder = [[UIImageView alloc] init];
        _imgAllOrder.image = [UIImage imageNamed:@"Personal_Center_Setting_AllOrder"];
    }
    return _imgAllOrder;
}

- (UILabel *)lblAllOrderName
{
    if (!_lblAllOrderName) {
        _lblAllOrderName = [[UILabel alloc] init];
        _lblAllOrderName.font = [UIFont systemFontOfSize:14.0f];
        _lblAllOrderName.textColor = [UIColor darkGrayColor];
        _lblAllOrderName.text = @"我的订单";
    }
    return _lblAllOrderName;
}

- (UILabel *)lblExamineAllOreder
{
    if (!_lblExamineAllOreder) {
        _lblExamineAllOreder = [[UILabel alloc] init];
        _lblExamineAllOreder.font = [UIFont systemFontOfSize:12.0f];
        _lblExamineAllOreder.textColor = [UIColor colorWithHexString:@"e6e6e7"];
        _lblExamineAllOreder.text = @"查看全部订单";
        _lblExamineAllOreder.textAlignment = NSTextAlignmentRight;
    }
    return _lblExamineAllOreder;
}

- (UIImageView *)imgArrows
{
    if (!_imgArrows) {
        _imgArrows = [[UIImageView alloc] init];
        _imgArrows.image = [UIImage imageNamed:@"accessory"];
        _imgArrows.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgArrows;
}

- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = [UIColor colorWithHexString:@"e6e6e7"];
    }
    return _vLine;
}
*/


- (UIView *)vPayment
{
    if (!_vPayment) {
        _vPayment = [[UIView alloc] init];
        
        UITapGestureRecognizer *tapPayment = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPayment)];
        [_vPayment addGestureRecognizer:tapPayment];
    }
    return _vPayment;
}

- (UIImageView *)imgPayment
{
    if (!_imgPayment) {
        _imgPayment = [[UIImageView alloc] init];
        _imgPayment.image = [UIImage imageNamed:@"Personal_Center_Pay"];
    }
    return _imgPayment;
}

- (UILabel *)lblPayment
{
    if (!_lblPayment) {
        _lblPayment = [[UILabel alloc] init];
        _lblPayment.font = [UIFont systemFontOfSize:12];
        _lblPayment.textColor = [UIColor colorWithHexString:@"666666"];
        _lblPayment.text = @"待付款";
        _lblPayment.textAlignment = NSTextAlignmentCenter;
    }
    return _lblPayment;
}

- (UILabel *)lblNumberPayment
{
    if (!_lblNumberPayment) {
        _lblNumberPayment = [[UILabel alloc] init];
        _lblNumberPayment.font = [UIFont systemFontOfSize:10];
        _lblNumberPayment.layer.cornerRadius = 8;
        _lblNumberPayment.layer.masksToBounds = YES;
        _lblNumberPayment.backgroundColor = [UIColor redColor];
        _lblNumberPayment.textColor = [UIColor whiteColor];
        _lblNumberPayment.textAlignment = NSTextAlignmentCenter;
    }
    return _lblNumberPayment;
}

- (UIView *)vShipments
{
    if (!_vShipments) {
        _vShipments = [[UIView alloc] init];
        
        UITapGestureRecognizer *tapShipment = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShipment)];
        [_vShipments addGestureRecognizer:tapShipment];
    }
    return _vShipments;
}

- (UIImageView *)imgShipment
{
    if (!_imgShipment) {
        _imgShipment = [[UIImageView alloc] init];
        _imgShipment.image = [UIImage imageNamed:@"Personal_Center_Receiving"];
    }
    return _imgShipment;
}

- (UILabel *)lblShipment
{
    if (!_lblShipment) {
        _lblShipment = [[UILabel alloc] init];
        _lblShipment.font = [UIFont systemFontOfSize:12];
        _lblShipment.textColor = [UIColor colorWithHexString:@"666666"];
        _lblShipment.text = @"待发货";
        _lblShipment.textAlignment = NSTextAlignmentCenter;
    }
    return _lblShipment;
}

- (UILabel *)lblNumberShipment
{
    if (!_lblNumberShipment) {
        _lblNumberShipment = [[UILabel alloc] init];
        _lblNumberShipment.font = [UIFont systemFontOfSize:10];
        _lblNumberShipment.layer.cornerRadius = 8;
        _lblNumberShipment.backgroundColor = [UIColor redColor];
        _lblNumberShipment.textColor = [UIColor whiteColor];
        _lblNumberShipment.textAlignment = NSTextAlignmentCenter;
        _lblNumberShipment.layer.masksToBounds = YES;
    }
    return _lblNumberShipment;
}

- (UIView *)vGatherGoods
{
    if (!_vGatherGoods) {
        _vGatherGoods = [[UIView alloc] init];
        
        UITapGestureRecognizer *tapGatherGoods = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGatherGoods)];
        [_vGatherGoods addGestureRecognizer:tapGatherGoods];
    }
    return _vGatherGoods;
}

- (UIImageView *)imgGatherGoods
{
    if (!_imgGatherGoods) {
        _imgGatherGoods = [[UIImageView alloc] init];
        _imgGatherGoods.image = [UIImage imageNamed:@"Personal_Center_Dispatch"];
    }
    return _imgGatherGoods;
}

- (UILabel *)lblGatherGoods
{
    if (!_lblGatherGoods) {
        _lblGatherGoods = [[UILabel alloc] init];
        _lblGatherGoods.font = [UIFont systemFontOfSize:12];
        _lblGatherGoods.textColor = [UIColor colorWithHexString:@"666666"];
        _lblGatherGoods.text = @"待收货";
        _lblGatherGoods.textAlignment = NSTextAlignmentCenter;
    }
    return _lblGatherGoods;
}

- (UILabel *)lblNumberGatherGoods
{
    if (!_lblNumberGatherGoods) {
        _lblNumberGatherGoods = [[UILabel alloc] init];
        _lblNumberGatherGoods.font = [UIFont systemFontOfSize:10];
        _lblNumberGatherGoods.layer.cornerRadius = 8;
        _lblNumberGatherGoods.backgroundColor = [UIColor redColor];
        _lblNumberGatherGoods.textColor = [UIColor whiteColor];
        _lblNumberGatherGoods.textAlignment = NSTextAlignmentCenter;
        _lblNumberGatherGoods.layer.masksToBounds = YES;
    }
    return _lblNumberGatherGoods;
}

- (UIView *)vEvaluate
{
    if (!_vEvaluate) {
        _vEvaluate = [[UIView alloc] init];
        
        UIImageView *imgLongArrows = [[UIImageView alloc] init];
        imgLongArrows.image = [UIImage imageNamed:@"Personal_Center_Setting_All-1"];
        [_vEvaluate addSubview:imgLongArrows];
        
        [imgLongArrows mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.top.equalTo(_vEvaluate);
            make.width.mas_equalTo(5);
        }];
        
        UITapGestureRecognizer *tapEvaluat = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvaluat)];
        [_vEvaluate addGestureRecognizer:tapEvaluat];
    }
    return _vEvaluate;
}

- (UIImageView *)imgEvaluate
{
    if (!_imgEvaluate) {
        _imgEvaluate = [[UIImageView alloc] init];
        _imgEvaluate.image = [UIImage imageNamed:@"Personal_Center_Setting_All"];
    }
    return _imgEvaluate;
}

- (UILabel *)lblEvaluate
{
    if (!_lblEvaluate) {
        _lblEvaluate = [[UILabel alloc] init];
        _lblEvaluate.font = [UIFont systemFontOfSize:12];
        _lblEvaluate.textColor = [UIColor colorWithHexString:@"666666"];
        _lblEvaluate.text = @"我的订单";
        _lblEvaluate.textAlignment = NSTextAlignmentCenter;
    }
    return _lblEvaluate;
}

- (UILabel *)lblNumberEvaluate
{
    if (!_lblNumberEvaluate) {
        _lblNumberEvaluate = [[UILabel alloc] init];
        _lblNumberEvaluate.font = [UIFont systemFontOfSize:10];
        _lblNumberEvaluate.layer.cornerRadius = 8;
        _lblNumberEvaluate.backgroundColor = [UIColor redColor];
        _lblNumberEvaluate.textColor = [UIColor whiteColor];
        _lblNumberEvaluate.textAlignment = NSTextAlignmentCenter;
        _lblNumberEvaluate.layer.masksToBounds = YES;
        _lblNumberEvaluate.hidden = YES;
    }
    return _lblNumberEvaluate;
}



- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
