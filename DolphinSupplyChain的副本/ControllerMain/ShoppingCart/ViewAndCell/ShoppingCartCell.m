//
//  ShoppingCartCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/8.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ShoppingCartCell.h"
#import "ZXNImageView.h"

@interface ShoppingCartCell () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *btnSeletc;

@property (nonatomic, strong) ZXNImageView *imgCommodity;

@property (nonatomic, strong) UIImageView *imgStockExhausted;

@property (nonatomic, strong) UILabel *lblStockExhausted;

@property (nonatomic, strong) UILabel *lblCommodityName;

@property (nonatomic, strong) UILabel *lblMoney;

@property (nonatomic, strong) UIView *vAddOrSub;

@property (nonatomic, strong) UIButton *btnSub;

@property (nonatomic, strong) UIButton *btnAdd;

@property (nonatomic, strong) UITextField *tfNumber;

@property (nonatomic, strong) UIView *vLineOne;

@property (nonatomic, strong) UIView *vLineTwo;

@property (nonatomic, strong) UIView *vLineBottom;

@property (nonatomic, strong) UIImageView *imgUnderstock;

@property (nonatomic, strong) UIView *vKeyboardTop;

@property (nonatomic, strong) CartZXNModel *CartModel;

@property (nonatomic, strong) NSIndexPath *indexP;

@property (nonatomic, copy) NSString *sNumber;

@property (nonatomic, copy) NSString *sMin;



@end


@implementation ShoppingCartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}


- (void)initView
{
    [self.contentView addSubview:self.btnSeletc];
    [self.contentView addSubview:self.imgCommodity];
    
    [self.imgCommodity addSubview:self.imgStockExhausted];
    [self.imgCommodity addSubview:self.lblStockExhausted];
    
    [self.contentView addSubview:self.lblCommodityName];
    [self.contentView addSubview:self.lblMoney];
    
    [self.contentView addSubview:self.vAddOrSub];
    [self.vAddOrSub addSubview:self.btnSub];
    [self.vAddOrSub addSubview:self.tfNumber];
    [self.vAddOrSub addSubview:self.btnAdd];
    [self.vAddOrSub addSubview:self.vLineOne];
    [self.vAddOrSub addSubview:self.vLineTwo];
    
    [self.contentView addSubview:self.vLineBottom];
    
    [self.contentView addSubview:self.imgUnderstock];
    
    [self.btnSeletc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(43);
    }];
    
    [self.imgCommodity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.left.equalTo(self.btnSeletc.mas_right).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        make.width.equalTo(self.imgCommodity.mas_height);
    }];
    
    [self.imgStockExhausted mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.imgCommodity);
    }];
    
    [self.lblStockExhausted mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.centerX.equalTo(self.imgCommodity.mas_centerX);
        make.centerY.equalTo(self.imgCommodity.mas_centerY);
        make.left.right.equalTo(self.imgCommodity);
    }];
    
    [self.lblCommodityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.left.equalTo(self.imgCommodity.mas_right).offset(8);
        make.right.equalTo(self.contentView.mas_right).offset(-8);
    }];
    
    [self.lblMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgCommodity.mas_right).offset(8);
        make.bottom.equalTo(self.imgCommodity.mas_bottom).offset(0);
        make.height.mas_equalTo(23);
    }];
    
    [self.vAddOrSub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imgCommodity.mas_bottom).offset(0);
        make.width.mas_equalTo(90);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(25);
    }];
    
    [self.btnSub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.left.top.equalTo(self.vAddOrSub);
    }];
    
    [self.vLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.vAddOrSub);
        make.left.equalTo(self.btnSub.mas_right).offset(0);
        make.width.mas_equalTo(0.5);
    }];
    
    [self.tfNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.vAddOrSub);
        make.left.equalTo(self.vLineOne.mas_right).offset(0);
        make.right.equalTo(self.vLineTwo.mas_left).offset(0);
    }];
    
    [self.vLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.vAddOrSub);
        make.right.equalTo(self.btnAdd.mas_left).offset(0);
        make.width.mas_equalTo(0.5);
    }];
    
    [self.btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.top.equalTo(self.vAddOrSub);
    }];
    
    [self.vLineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.imgUnderstock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(65, 50));
    }];
}

#pragma mark - 界面渲染
- (void)loadViewModel:(CartZXNModel *)model Index:(NSIndexPath *)index isEdit:(BOOL)bEdit
{
    self.CartModel = model;
    self.indexP = index;
    
    [self.imgCommodity downloadImage:model.img_thumb backgroundImage:ZXNImageDefaul];
    self.lblCommodityName.text = model.goods_name;

    self.sMin = model.min_purchase_quantity;
    // 是否在编辑状态下
    if (bEdit) {
        // 是否达到了最小数量
        if ([model.min_purchase_quantity isEqualToString:model.goods_number_edit]) {
            self.btnSub.selected = NO;
            self.btnSub.alpha = 0.4;
        }
        else
        {
            self.btnSub.selected = YES;
            self.btnSub.alpha = 1;
        }
    }
    else
    {
        // 是否达到了最小数量
        if ([model.min_purchase_quantity isEqualToString:model.goods_number]) {
            self.btnSub.selected = NO;
            self.btnSub.alpha = 0.4;
        }
        else
        {
            self.btnSub.selected = YES;
            self.btnSub.alpha = 1;
        }
    }
    
    // 是否在编辑状态下
    if (bEdit) {
        // 是否选中了
        if (model.isSelectEdit) {
            self.btnSeletc.selected = YES;
        }
        else
        {
            self.btnSeletc.selected = NO;
        }
        self.tfNumber.text = model.goods_number_edit;
    }
    else
    {
        // 是否选中了
        if (model.isSelectBuy) {
            self.btnSeletc.selected = YES;
        }
        else
        {
            self.btnSeletc.selected = NO;
        }
        self.tfNumber.text = model.goods_number;
    }
    
    // 如果库存为0
    if (model.stock.length == 0) {
        return;
    }
    
    if ([model.stock isEqualToString:@"0"]) {
        self.vAddOrSub.hidden = YES;
        self.imgUnderstock.hidden = YES;
        self.imgStockExhausted.hidden = NO;
        self.lblStockExhausted.hidden = NO;
        self.lblCommodityName.textColor = [UIColor colorWithHexString:@"999999"];
        self.lblMoney.textColor = [UIColor colorWithHexString:@"999999"];
        
        self.lblMoney.text = [NSString stringWithFormat:@"¥ %@   数量：%@",model.price, model.goods_number];
        
    }
    else
    {
        self.lblMoney.text = [NSString stringWithFormat:@"¥ %@",model.price];
        
        self.vAddOrSub.hidden = NO;
        self.imgStockExhausted.hidden = YES;
        self.lblStockExhausted.hidden = YES;
        self.lblCommodityName.textColor = [UIColor blackColor];
        self.lblMoney.textColor = [UIColor colorWithHexString:@"ef2e23"];
        
        if ([model.goods_number integerValue] > [model.stock integerValue]) {
            self.imgUnderstock.hidden = NO;
        }
        else
        {
            self.imgUnderstock.hidden = YES;
        }
    }
    
}

#pragma mark - 点击事件
- (void)tapSeletc:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(seletcCommodity:Index:)]) {
        [self.delegate seletcCommodity:btn.selected Index:self.indexP];
    }
}

- (void)tapSub:(UIButton *)btn
{
    if (!btn.isSelected) {
        [self makeToast:[NSString stringWithFormat:@"最低%@件起售", self.sMin] duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(subCommodityNumberIndex:)]) {
        [self.delegate subCommodityNumberIndex:self.indexP];
    }
}

- (void)tapAdd
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addCommodityNumberIndex:)]) {
        [self.delegate addCommodityNumberIndex:self.indexP];
    }
}

- (void)tapCance
{
    self.tfNumber.text = self.CartModel.goods_number;
    [self.tfNumber resignFirstResponder];
}

- (void)tapAccomplish
{
    [self.tfNumber resignFirstResponder];
    if (self.sNumber.length == 0) {
        self.tfNumber.text = self.CartModel.goods_number;
        return;
    }
    
    if ([self.sNumber isEqualToString:self.CartModel.goods_number]) {
        return;
    }
    
    if ([self.sNumber integerValue] < [self.CartModel.min_purchase_quantity integerValue]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(tapKeyBoardAccomplish:Number:Message:isCanEidt:)]) {
            NSString *sMessage = [NSString stringWithFormat:@"购买的数量不能少于 %@",self.CartModel.min_purchase_quantity];
            self.tfNumber.text = self.CartModel.goods_number;
            [self.delegate tapKeyBoardAccomplish:self.indexP Number:nil Message:sMessage isCanEidt:NO];
        }
        return;
    }
    
    
    if ([self.CartModel.is_modulo isEqualToString:@"1"]) {
        
        if ([self.sNumber integerValue] % 2 == 1) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(tapKeyBoardAccomplish:Number:Message:isCanEidt:)]) {
                self.tfNumber.text = self.CartModel.goods_number;
                [self.delegate tapKeyBoardAccomplish:self.indexP Number:nil Message:@"该商品只能买倍数" isCanEidt:NO];
            }
            return;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapKeyBoardAccomplish:Number:Message:isCanEidt:)]) {
        [self.delegate tapKeyBoardAccomplish:self.indexP Number:self.sNumber Message:nil isCanEidt:YES];
    }
     self.sNumber = nil;
}

- (void)textFieldDidChange:(UITextField*)sender
{
    self.sNumber = @"";
    if ([self checkNumber:sender.text]) {
        self.sNumber = sender.text;
    }
}

// 验证数字
-(BOOL)checkNumber:(NSString *)_text{
    
    NSString *regex =@"^[0-9]+$";

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:_text]) {
        return YES;
    }
    return NO;
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(BeginEditingKeyBoardIndex:)]) {
        [self.delegate BeginEditingKeyBoardIndex:self.indexP];
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason
{
    self.tfNumber.text = self.CartModel.goods_number;
}

#pragma mark - 懒加载
- (UIButton *)btnSeletc
{
    if (!_btnSeletc) {
        _btnSeletc = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSeletc setImage:[UIImage drawImageWithName:@"choose_default" size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
        [_btnSeletc setImage:[UIImage drawImageWithName:@"choose_selected" size:CGSizeMake(20, 20)] forState:UIControlStateSelected];
        
        
        _btnSeletc.selected = YES;
        [_btnSeletc addTarget:self action:@selector(tapSeletc:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSeletc;
}

- (ZXNImageView *)imgCommodity
{
    if (!_imgCommodity) {
        _imgCommodity = [[ZXNImageView alloc] init];
        _imgCommodity.contentMode = UIViewContentModeScaleAspectFit;
        _imgCommodity.layer.borderColor = [UIColor colorWithHexString:@"c1c1c1"].CGColor;
        _imgCommodity.layer.borderWidth = 0.5;
    }
    return _imgCommodity;
}

- (UIImageView *)imgStockExhausted
{
    if (!_imgStockExhausted) {
        _imgStockExhausted = [[UIImageView alloc] init];
        _imgStockExhausted.image = [UIImage imageNamed:@"CollectBuy_Lose_Efficacy"];
        _imgStockExhausted.hidden = YES;
    }
    return _imgStockExhausted;
}

- (UILabel *)lblStockExhausted
{
    if (!_lblStockExhausted) {
        _lblStockExhausted = [[UILabel alloc] init];
        _lblStockExhausted.font = kFont12;
        _lblStockExhausted.textColor = [UIColor whiteColor];
        _lblStockExhausted.textAlignment = NSTextAlignmentCenter;
        _lblStockExhausted.text = @"已无货";
        _lblStockExhausted.hidden = YES;
    }
    return _lblStockExhausted;
}

- (UILabel *)lblCommodityName
{
    if (!_lblCommodityName) {
        _lblCommodityName = [[UILabel alloc] init];
        _lblCommodityName.font = [UIFont systemFontOfSize:13];
        _lblCommodityName.numberOfLines = 2;
    }
    return _lblCommodityName;
}

- (UILabel *)lblMoney
{
    if (!_lblMoney) {
        _lblMoney = [[UILabel alloc] init];
        _lblMoney.textColor = [UIColor colorWithHexString:@"ef2e23"];
        _lblMoney.font = [UIFont systemFontOfSize:13];
    }
    return _lblMoney;
}

- (UIView *)vAddOrSub
{
    if (!_vAddOrSub) {
        _vAddOrSub = [[UIView alloc] init];
        _vAddOrSub.layer.cornerRadius = 3;
        _vAddOrSub.layer.borderColor = [UIColor colorWithHexString:@"c1c1c1"].CGColor;
        _vAddOrSub.layer.borderWidth = 0.5;
    }
    return _vAddOrSub;
}

- (UIButton *)btnSub
{
    if (!_btnSub) {
        _btnSub = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSub setTitle:@"-" forState:UIControlStateNormal];
        [_btnSub setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btnSub.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_btnSub addTarget:self action:@selector(tapSub:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnSub;
}

- (UITextField *)tfNumber
{
    if (!_tfNumber) {
        _tfNumber = [[UITextField alloc] init];
        _tfNumber.textAlignment = NSTextAlignmentCenter;
        _tfNumber.font = [UIFont systemFontOfSize:13];
        _tfNumber.borderStyle = UITextBorderStyleNone;
        _tfNumber.keyboardType = UIKeyboardTypeNumberPad;
        _tfNumber.returnKeyType = UIReturnKeySend;
        _tfNumber.inputAccessoryView = self.vKeyboardTop;
        _tfNumber.delegate = self;
        [_tfNumber addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _tfNumber;
}

- (UIButton *)btnAdd
{
    if (!_btnAdd) {
        _btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAdd setTitle:@"+" forState:UIControlStateNormal];
        [_btnAdd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btnAdd.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_btnAdd addTarget:self action:@selector(tapAdd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAdd;
}

- (UIView *)vLineOne
{
    if (!_vLineOne) {
        _vLineOne = [[UIView alloc] init];
        _vLineOne.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
    }
    return _vLineOne;
}

- (UIView *)vLineTwo
{
    if (!_vLineTwo) {
        _vLineTwo = [[UIView alloc] init];
        _vLineTwo.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
    }
    return _vLineTwo;
}

- (UIView *)vLineBottom
{
    if (!_vLineBottom) {
        _vLineBottom = [[UIView alloc] init];
        _vLineBottom.backgroundColor = ColorLine;
    }
    return _vLineBottom;
}

- (UIImageView *)imgUnderstock
{
    if (!_imgUnderstock) { // 65 50
        _imgUnderstock = [[UIImageView alloc] init];
        _imgUnderstock.image = [UIImage imageNamed:@"Shopping_Cart_ Understock"];
        _imgUnderstock.hidden = YES;
    }
    return _imgUnderstock;
}

- (UIView *)vKeyboardTop
{
    if (!_vKeyboardTop) {
        
        _vKeyboardTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 40)];
        _vKeyboardTop.backgroundColor = [UIColor whiteColor];
        
        UIView *vLineOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 0.5)];
        vLineOne.backgroundColor = [UIColor colorWithHexString:@"8b8b8b"];
        [_vKeyboardTop addSubview:vLineOne];
        
        UIView *vLineTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, kDisWidth, 0.5)];
        vLineTwo.backgroundColor = [UIColor colorWithHexString:@"8b8b8b"];
        [_vKeyboardTop addSubview:vLineTwo];
        
        UIButton *btnCance = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnCance setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [btnCance setTitle:@"取消" forState:UIControlStateNormal];
        btnCance.frame = CGRectMake(0, 0, 50, 40);
        [btnCance addTarget:self action:@selector(tapCance) forControlEvents:UIControlEventTouchUpInside];
        btnCance.titleLabel.font = [UIFont systemFontOfSize:14];
        [_vKeyboardTop addSubview:btnCance];
        
        
        UIButton *btnAccomplish = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnAccomplish setTitleColor:[UIColor colorWithHexString:@"12a0ea"] forState:UIControlStateNormal];
        [btnAccomplish setTitle:@"完成" forState:UIControlStateNormal];
        btnAccomplish.frame = CGRectMake(kDisWidth - 50, 0, 50, 40);
        [btnAccomplish addTarget:self action:@selector(tapAccomplish) forControlEvents:UIControlEventTouchUpInside];
        btnAccomplish.titleLabel.font = [UIFont systemFontOfSize:14];
        [_vKeyboardTop addSubview:btnAccomplish];
    }
    return _vKeyboardTop;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
