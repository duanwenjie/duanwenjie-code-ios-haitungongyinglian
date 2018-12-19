//
//  AttributeView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/7.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "AttributeView.h"
#import "CommodityDetailsModel.h"
#import "ZXNTool.h"

@interface AttributeView ()

@property (nonatomic, strong) ZXNImageView *imgCommodity;

@property (nonatomic, strong) UILabel *lblPrice;

@property (nonatomic, strong) UILabel *lblSKU;

@property (nonatomic, strong) UIButton *btnClose;

@property (nonatomic, strong) UIView *vLineOne;

@property (nonatomic, strong) UIScrollView *scrAttribut;

@property (nonatomic, strong) UIView *vLineInventory;

@property (nonatomic, strong) UILabel *lblInventory;

@property (nonatomic, strong) UILabel *lblBestbeforedate;//保质期

@property (nonatomic, strong) UIView *vAddAndMinus;

@property (nonatomic, strong) UIButton *btnAdd;

@property (nonatomic, strong) UIButton *btnMinus;

@property (nonatomic, strong) UIView *vLineTwo;

@property (nonatomic, strong) UIView *vLineThree;

@property (nonatomic, strong) UILabel *lblNumber;

@property (nonatomic, strong) UIButton *btnAddCart;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) CommodityDetailsModel *model;

@property (nonatomic, strong) NSMutableArray *arrButton;

@property (nonatomic, copy) NSMutableArray *arrData;

@property (nonatomic, assign) BOOL bHave;

@end

@implementation AttributeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAddView];
        [self initLayoutView];
    }
    return self;
}

- (void)initAddView
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.imgCommodity];
    [self addSubview:self.lblPrice];
    [self addSubview:self.lblSKU];
    [self addSubview:self.btnClose];
    
    [self addSubview:self.vLineOne];
    
    [self addSubview:self.scrAttribut];
    [self addSubview:self.vLineInventory];
    [self addSubview:self.lblBestbeforedate];
    [self addSubview:self.lblInventory];
    
    [self addSubview:self.vAddAndMinus];
    [self.vAddAndMinus addSubview:self.btnMinus];
    [self.vAddAndMinus addSubview:self.vLineTwo];
    [self.vAddAndMinus addSubview:self.lblNumber];
    [self.vAddAndMinus addSubview:self.vLineThree];
    [self.vAddAndMinus addSubview:self.btnAdd];
    
    [self addSubview:self.btnAddCart];
}

- (void)initLayoutView
{
    [self.imgCommodity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(-15);
        make.width.mas_equalTo(kDisWidth/4);
        make.height.equalTo(self.imgCommodity.mas_width);
    }];
    
    [self.lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgCommodity.mas_right).offset(15);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(self.imgCommodity.mas_bottom).offset(-15);
    }];
    
    [self.lblSKU mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgCommodity.mas_right).offset(15);
        make.height.mas_equalTo(15);
        make.bottom.equalTo(self.imgCommodity.mas_bottom).offset(0);
    }];
    
    [self.btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-5);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.equalTo(self.mas_top).offset(0);
    }];
    
    [self.vLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgCommodity.mas_bottom).offset(10);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.scrAttribut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLineOne.mas_bottom).offset(0);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.lblInventory.mas_top).offset(0);
    }];
    
    [self.vLineInventory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self.lblBestbeforedate.mas_top);
    }];
    
    [self.lblBestbeforedate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLineInventory.mas_bottom).offset(10);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(30);
        make.bottom.equalTo(self.lblInventory.mas_top).offset(10);
    }];
    
    
    [self.lblInventory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.vAddAndMinus.mas_left).offset(-30);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.btnAddCart.mas_top).offset(0);
    }];
    
    [self.vAddAndMinus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(30);
        make.bottom.equalTo(self.btnAddCart.mas_top).offset(-10);
        make.width.mas_equalTo(118);
    }];
    
    [self.btnMinus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(self.vAddAndMinus);
        make.width.mas_equalTo(34);
    }];
    
    [self.vLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.vAddAndMinus);
        make.width.mas_equalTo(0.5);
        make.left.equalTo(self.btnMinus.mas_right).offset(0);
    }];
    
    [self.lblNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.vAddAndMinus);
        make.left.equalTo(self.vLineTwo.mas_right);
        make.right.equalTo(self.vLineThree.mas_left);
    }];
    
    [self.vLineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.vAddAndMinus);
        make.width.mas_equalTo(0.5);
        make.right.equalTo(self.btnAdd.mas_left).offset(0);
    }];
    
    [self.btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.equalTo(self.vAddAndMinus);
        make.width.mas_equalTo(34);
    }];
    
    [self.btnAddCart mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.equalTo(self);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-(kDisHeight == 812.0 ? 10 : 0));
        make.height.mas_equalTo(40);
    }];
}

- (void)loadData:(NSMutableArray *)arrData index:(NSInteger)iIndex
{
    self.index = iIndex;
    self.arrData = arrData;
    self.model = self.arrData[self.index];
    [self.imgCommodity downloadImage:self.model.img_thumb backgroundImage:ZXNImageDefaul];
    self.lblPrice.text = [NSString stringWithFormat:@"￥%@", self.model.price];
    self.lblSKU.text = [NSString stringWithFormat:@"商品编号：%@", self.model.sku];
    
    if ([self.model.expiration_date isKindOfClass:[NSDictionary class]]) {
        NSString * expiration_date = [self.model.expiration_date objectForKey:@"expiration_date"];
        self.lblBestbeforedate.text = [NSString stringWithFormat:@"到期：约为%@(以收到实物为准)",expiration_date];
    }else{
        self.lblBestbeforedate.text = [NSString stringWithFormat:@""];
        [self.lblBestbeforedate mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(10);
        }];
    }
    
    self.lblInventory.text = [NSString stringWithFormat:@"库存：%@", self.model.stock_description];
    
    self.lblNumber.text = self.model.min_purchase_quantity;
    
    //每次进入已选界面 根据stock来设置底部按钮是显示缺货登记还是显示加入购物车
    if ([self.model.stock isEqualToString:@"0"]) {
        self.bHave = NO;
        [self.btnAddCart setTitle:@"缺货登记" forState:UIControlStateNormal];
    }else{
        
        self.bHave = YES;
        [self.btnAddCart setTitle:@"加入购物车" forState:UIControlStateNormal];
    }

    
    UILabel *lblText = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, 100, 14)];
    lblText.text = @"段位：";
    lblText.font = kFont13;
    [self.scrAttribut addSubview:lblText];
    
    CGFloat fW = kDisWidth - 30;
    __block UIButton *btnOther = nil;
    self.arrButton = [NSMutableArray array];
    [arrData enumerateObjectsUsingBlock:^(CommodityDetailsModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *btnAttribute = [UIButton buttonWithType:UIButtonTypeCustom];
        btnAttribute.tag = idx;
        [btnAttribute setTitle:obj.attribute forState:UIControlStateNormal];
        btnAttribute.titleLabel.font = kFont13;
        btnAttribute.titleLabel.numberOfLines = 0;
        [btnAttribute setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [btnAttribute setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btnAttribute setBackgroundImage:[ZXNTool imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
        [btnAttribute setBackgroundImage:[ZXNTool imageWithColor:ColorAPPTheme size:CGSizeMake(1, 1)] forState:UIControlStateSelected];
        
        btnAttribute.layer.borderWidth = 0.5;
        btnAttribute.layer.borderColor = ColorLine.CGColor;
        btnAttribute.layer.shadowOffset =  CGSizeMake(1, 1);
        btnAttribute.layer.shadowOpacity = 0.3;
        btnAttribute.layer.shadowColor =  [UIColor grayColor].CGColor;
        [btnAttribute addTarget:self action:@selector(tapAttribute:) forControlEvents:UIControlEventTouchUpInside];
        
        if (iIndex == idx) {
            btnAttribute.selected = YES;
           
        }
        
        CGSize sizeWidth = [ZXNTool gainTextSize:kFont13 text:obj.attribute];
        if (sizeWidth.width + 10 <= fW) // 当字体长度小于极限长度
        {
            if (idx == 0) // 当是第一个Button时，可以指定 X Y 坐标
            {
                btnAttribute.frame = CGRectMake(15, 30, sizeWidth.width + 10, sizeWidth.height + 10);
            }
            else // 不是第数组第一个Button时，使用下面布局
            {
                if ((sizeWidth.width + 10) <= fW - (btnOther.right + 15))
                {
                    // 当剩余的宽度 大于 该Button的宽度时，将该Button放在 与 上个Button Y 坐标相同
                    btnAttribute.frame = CGRectMake(btnOther.right + 15, btnOther.top, sizeWidth.width + 10, sizeWidth.height + 10);
                }
                else
                {
                    // 当剩余的宽度 小于 该Button的宽度时，直接将该Button转移到下一行的起始位置，X 坐标为起点坐标，Y 坐标为上个Button的 Y坐标+高度+15
                    btnAttribute.frame = CGRectMake(15, btnOther.bottom + 15, sizeWidth.width + 10, sizeWidth.height + 10);
                }
            }
        }
        else // 当字体长度大于极限长度
        {
            // 计算出该字体在该极限长度下所需要的宽度
            CGSize sizeHeight = [ZXNTool gainTextSize:kFont13 text:obj.attribute Width:fW];
            
            if (idx == 0) // 当是第一个Button时，可以指定 X Y 坐标
            {
                // 指定该文字超出极限的Button长度为极限长度 该极限长度下所需要的宽度 加 10
                btnAttribute.frame = CGRectMake(15, 30, fW, sizeHeight.height + 10);
            }
            else
            {
                // 当不是第一个Button时，但由于超出极限长度，所以只可以指定 X 坐标
                // 指定该文字超出极限的Button长度为极限长度 该极限长度下所需要的宽度 加 10
                btnAttribute.frame = CGRectMake(15, btnOther.bottom + 15, fW, sizeHeight.height + 10);
            }
        }
        
        // 临时保存当前Button 为下一次循环提供上个Button的指针
        btnOther = btnAttribute;
        
        // 将Button加入到数组
        [self.arrButton addObject:btnAttribute];
        [self.scrAttribut addSubview:btnAttribute];
    }];
    
    if (btnOther.bottom + 15 <= kDisHeight/5*3 - kDisWidth/4 - 75) {
        [self.scrAttribut setContentSize:CGSizeMake(kDisWidth, kDisHeight/5*3 - kDisWidth/4 - 75)];
    }
    else
    {
        [self.scrAttribut setContentSize:CGSizeMake(kDisWidth, btnOther.bottom + 15)];
    }
}


- (void)changeAddShoppingCart:(BOOL)bHave
{
    self.bHave = bHave;
    if (bHave) {
        [self.btnAddCart setTitle:@"加入购物车" forState:UIControlStateNormal];
    }
    else
    {
        [self.btnAddCart setTitle:@"缺货登记" forState:UIControlStateNormal];
    }
}


#pragma mark - 属性点击事件
- (void)tapAttribute:(UIButton *)btn
{
    
    if (btn.selected) {
        return;
    }
    
    [self.arrButton enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.selected) {
            obj.selected = NO;
            *stop = YES;
        }
    }];
    
    btn.selected = !btn.selected;
    
    self.index = btn.tag;
    self.model = self.arrData[self.index];
    [self.imgCommodity downloadImage:self.model.img_thumb backgroundImage:ZXNImageDefaul];
    self.lblPrice.text = [NSString stringWithFormat:@"￥%@", self.model.price];
    self.lblSKU.text = [NSString stringWithFormat:@"商品编号：%@", self.model.sku];
    if ([self.model.expiration_date isKindOfClass:[NSDictionary class]]) {
        NSString * expiration_date = [self.model.expiration_date objectForKey:@"expiration_date"];
        self.lblBestbeforedate.text = [NSString stringWithFormat:@"到期：约为%@(以收到实物为准)",expiration_date];
    }else{
        self.lblBestbeforedate.text = [NSString stringWithFormat:@""];
        [self.lblBestbeforedate mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(10);
        }];
    }
    
    self.lblInventory.text = [NSString stringWithFormat:@"库存：%@", self.model.stock_description];
    
    self.lblNumber.text = self.model.min_purchase_quantity;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectAttribute:number:)]) {
        [self.delegate selectAttribute:self.index number:self.lblNumber.text.integerValue];
    }
}

#pragma mark - 点击了关闭
- (void)tapClose
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectClose:number:)]) {
        [self.delegate selectClose:self.index number:self.lblNumber.text.integerValue];
    }
}

#pragma mark - 点击了减数
- (void)tapMinus
{
    NSInteger iMin = self.lblNumber.text.integerValue;
//    
//    if (self.model.stock.integerValue == 0) {
//        return;
//    }
    
    if (iMin <= self.model.min_purchase_quantity.integerValue) {
        return;
    }
    
    if ([self.model.is_modulo isEqual: @"0"]) {
        self.lblNumber.text = [NSString stringWithFormat:@"%zd", iMin - 1];
    }
    else
    {
        self.lblNumber.text = [NSString stringWithFormat:@"%zd", iMin - self.model.min_purchase_quantity.integerValue];
    }
}

#pragma mark - 点击了加数
- (void)tapAdd
{
    
    NSInteger iMax = self.lblNumber.text.integerValue ;
    NSInteger imount = self.lblNumber.text.integerValue +self.model.min_purchase_quantity.integerValue;
   
    if (imount > (self.model.purchase_max_quantity.integerValue)) {
       [self makeToast:@"已达到最大购买量" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    NSInteger iMaxMoney = [self.model.purchase_max_amount integerValue];
    NSInteger money = imount * [self.model.single_price integerValue];
    if (money > iMaxMoney) {
        [self makeToast:@"已达到最大购买金额" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if ([self.model.is_modulo isEqual:@"0"]) {
        self.lblNumber.text = [NSString stringWithFormat:@"%zd", iMax + 1];
    }
    else
    {
        self.lblNumber.text = [NSString stringWithFormat:@"%zd", iMax + self.model.min_purchase_quantity.integerValue];
    }
}

#pragma mark - 点击了加入购物车
- (void)tapAddCart
{
    if (!self.bHave) {  // 库存为0 进入缺货登记
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectPresentStockRegistration)]) {
            [self.delegate selectPresentStockRegistration];
        }
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectAddCart:number:)]) {
        [self.delegate selectAddCart:self.index number:self.lblNumber.text.integerValue];
    }
}


#pragma mark - 懒加载
- (ZXNImageView *)imgCommodity
{
    if (!_imgCommodity) {
        _imgCommodity = [[ZXNImageView alloc] init];
        _imgCommodity.layer.borderColor = ColorLine.CGColor;
        _imgCommodity.layer.borderWidth = 0.5;
        _imgCommodity.backgroundColor = [UIColor whiteColor];
    }
    return _imgCommodity;
}

- (UILabel *)lblPrice
{
    if (!_lblPrice) {
        _lblPrice = [[UILabel alloc] init];
        _lblPrice.textColor = [UIColor redColor];
        _lblPrice.font = kFont13;
    }
    return _lblPrice;
}

- (UILabel *)lblSKU
{
    if (!_lblSKU) {
        _lblSKU = [[UILabel alloc] init];
        _lblSKU.font = kFont12;
        _lblSKU.textColor = [UIColor colorWithHexString:@"333333"];
        _lblSKU.text = @"商品编号：";
    }
    return _lblSKU;
}

- (UIButton *)btnClose
{
    if (!_btnClose) {
        _btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnClose setImage:[UIImage imageNamed:@"Commodity_Close"] forState:UIControlStateNormal];
        [_btnClose addTarget:self action:@selector(tapClose) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnClose;
}

- (UIView *)vLineOne
{
    if (!_vLineOne) {
        _vLineOne = [[UIView alloc] init];
        _vLineOne.backgroundColor = ColorLine;
    }
    return _vLineOne;
}

- (UIScrollView *)scrAttribut
{
    if (!_scrAttribut) {
        _scrAttribut = [[UIScrollView alloc] init];
        _scrAttribut.showsVerticalScrollIndicator = NO;
    }
    return _scrAttribut;
}

- (UIView *)vLineInventory
{
    if (!_vLineInventory) {
        _vLineInventory = [[UIView alloc] init];
        _vLineInventory.backgroundColor = ColorLine;
    }
    return _vLineInventory;
}


- (UILabel *)lblBestbeforedate
{
    if (!_lblBestbeforedate) {
        _lblBestbeforedate = [[UILabel alloc] init];
         _lblBestbeforedate.text = @"到期：加载中...(以收到实物为准)";
        _lblBestbeforedate.font = kFont13;
        _lblBestbeforedate.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _lblBestbeforedate;
}

- (UILabel *)lblInventory
{
    if (!_lblInventory) {
        _lblInventory = [[UILabel alloc] init];
        _lblInventory.text = @"库存：加载中...";
        _lblInventory.font = kFont13;
        _lblInventory.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _lblInventory;
}

- (UIView *)vAddAndMinus
{
    if (!_vAddAndMinus) {
        _vAddAndMinus = [[UIView alloc] init];
        _vAddAndMinus.layer.borderColor = ColorLine.CGColor;
        _vAddAndMinus.layer.borderWidth = 0.5;
    }
    return _vAddAndMinus;
}

- (UIView *)vLineTwo
{
    if (!_vLineTwo) {
        _vLineTwo = [[UIView alloc] init];
        _vLineTwo.backgroundColor = ColorLine;
    }
    return _vLineTwo;
}

- (UIView *)vLineThree
{
    if (!_vLineThree) {
        _vLineThree = [[UIView alloc] init];
        _vLineThree.backgroundColor = ColorLine;
    }
    return _vLineThree;
}

- (UIButton *)btnMinus
{
    if (!_btnMinus) {
        _btnMinus = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnMinus setTitle:@"-" forState:UIControlStateNormal];
        _btnMinus.titleLabel.font = kFont20_B;
        [_btnMinus addTarget:self action:@selector(tapMinus) forControlEvents:UIControlEventTouchUpInside];
        [_btnMinus setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    }
    return _btnMinus;
}

- (UILabel *)lblNumber
{
    if (!_lblNumber) {
        _lblNumber = [[UILabel alloc] init];
        _lblNumber.font = kFont14;
        _lblNumber.textAlignment = NSTextAlignmentCenter;
    }
    return _lblNumber;
}

- (UIButton *)btnAdd
{
    if (!_btnAdd) {
        _btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAdd setTitle:@"+" forState:UIControlStateNormal];
        _btnAdd.titleLabel.font = kFont20_B;
        [_btnAdd addTarget:self action:@selector(tapAdd) forControlEvents:UIControlEventTouchUpInside];
        [_btnAdd setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    }
    return _btnAdd;
}

- (UIButton *)btnAddCart
{
    if (!_btnAddCart) {
        _btnAddCart = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAddCart.backgroundColor = ColorAPPTheme;
        [_btnAddCart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnAddCart setTitle:@"加入购物车" forState:UIControlStateNormal];
        _btnAddCart.titleLabel.font = kFont15;
        [_btnAddCart addTarget:self action:@selector(tapAddCart) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAddCart;
}

@end
