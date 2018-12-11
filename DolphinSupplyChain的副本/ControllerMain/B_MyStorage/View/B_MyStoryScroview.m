//
//  B_MyStoryScroview.m
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/3/16.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "B_MyStoryScroview.h"
#import "SDCycleScrollView.h"
#import "DetailsRecommendCell.h"
#import "CommodityRecommendModel.h"
#import "ZXNTool.h"

@interface B_MyStoryScroview()<SDCycleScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

/// ******** 轮播背景 ********
@property (nonatomic, strong) UIView *vBackCycle;

/// 轮播图
@property (nonatomic, strong) SDCycleScrollView *sroCycle;

@property (nonatomic, strong) UIView *vLineOne;

/// 商品名称
@property (nonatomic, strong) UILabel *lblCommodityName;

/// 商品售卖价格
@property (nonatomic, strong) UILabel *lblPrice;

/// 商品单件价格
@property (nonatomic, strong) UILabel *lblOnePrice;

/// 商品市场价格
@property (nonatomic, strong) UILabel *lblBazaarPrice;

@property (nonatomic, strong) UIImageView *imgLineOne;

/// 编号名称
@property (nonatomic, strong) UILabel *lblSKUName;

/// 编号
@property (nonatomic, strong) UILabel *lblSKU;

/// 说明名称
@property (nonatomic, strong) UILabel *lblExplainName;

/// 说明
@property (nonatomic, strong) UILabel *lblExplain;

@property (nonatomic, strong) UIImageView *imgLineTwo;

/// 选择
@property (nonatomic, strong) UILabel *lblSelect;

/// 选择属性
@property (nonatomic, strong) UILabel *lblSelectAttribute;

/// 箭头1
@property (nonatomic, strong) UIImageView *imgArrows;


/// 采购记录
@property (nonatomic ,strong)UILabel * labShopingRecode;

/// 线条
@property (nonatomic ,strong)UIView * vLine3;

/// 箭头2
@property (nonatomic, strong) UIImageView *imgArrows2;

/// 微仓库存
@property (nonatomic ,strong)UILabel * labStock;

@property (nonatomic ,strong)UILabel * labStock_title;



/// ******** 推荐背景 ********
@property (nonatomic, strong) UIView *vBackRecommend;

/// 其他商品品牌名称
@property (nonatomic, strong) UILabel *lblOtherCommodityName;

@property (nonatomic, strong) UIView *vLineTwo;

@property (nonatomic, strong) UICollectionView *cltOtherCommodity;

/// ******** 提示上拉 ********
@property (nonatomic, strong) UIView *vUp;

@property (nonatomic, strong) UIImageView *imgUp;

@property (nonatomic, strong) UILabel *lblUp;

/// ******** 数据 ********
@property (nonatomic, copy) NSMutableArray *arrOtherCommodityData;

@property (nonatomic, strong) NSMutableArray *arrCycleData;




@end

@implementation B_MyStoryScroview

- (instancetype)initWithDetailsScroll
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.arrOtherCommodityData = [NSMutableArray array];
        self.arrCycleData = [NSMutableArray array];
        self.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        
        [self initAddView];
        [self initLayoutView];
    }
    return self;
}

- (void)initAddView
{
    [self addSubview:self.vBackCycle];
    [self.vBackCycle addSubview:self.sroCycle];
    [self.vBackCycle addSubview:self.vLineOne];
    [self.vBackCycle addSubview:self.lblCommodityName];
    [self.vBackCycle addSubview:self.lblPrice];
    [self.vBackCycle addSubview:self.lblOnePrice];
    [self.vBackCycle addSubview:self.lblBazaarPrice];
    [self.vBackCycle addSubview:self.imgLineOne];
    [self.vBackCycle addSubview:self.lblSKUName];
    [self.vBackCycle addSubview:self.lblSKU];
    [self.vBackCycle addSubview:self.labStock];
    [self.vBackCycle addSubview:self.labStock_title];
    [self.vBackCycle addSubview:self.lblExplainName];
    [self.vBackCycle addSubview:self.lblExplain];
    [self.vBackCycle addSubview:self.imgLineTwo];
    [self.vBackCycle addSubview:self.lblSelect];
    [self.vBackCycle addSubview:self.lblSelectAttribute];
    [self.vBackCycle addSubview:self.imgArrows];
    [self.vBackCycle addSubview:self.vLine3];
    [self.vBackCycle addSubview:self.labShopingRecode];
    [self.vBackCycle addSubview:self.imgArrows2];
    
    [self addSubview:self.vBackRecommend];
    [self.vBackRecommend addSubview:self.lblOtherCommodityName];
    [self.vBackRecommend addSubview:self.vLineTwo];
    [self.vBackRecommend addSubview:self.cltOtherCommodity];
    
    [self addSubview:self.vUp];
    [self.vUp addSubview:self.imgUp];
    [self.vUp addSubview:self.lblUp];
    
}

- (void)initLayoutView
{
    [self.vBackCycle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.width.mas_equalTo(kDisWidth);
        make.height.mas_equalTo(kDisHeight * 0.5 + 190 + 28);
    }];
    
    [self.sroCycle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.vBackCycle);
        make.height.mas_equalTo(kDisHeight * 0.5);
    }];
    
    [self.vLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vBackCycle);
        make.top.equalTo(self.sroCycle.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.lblCommodityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBackCycle.mas_left).offset(15);
        make.right.equalTo(self.vBackCycle.mas_right).offset(-15);
        make.top.equalTo(self.vLineOne.mas_top).offset(13);
    }];
    
    [self.lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBackCycle.mas_left).offset(15);
        make.top.equalTo(self.vLineOne.mas_top).offset(58);
        make.height.mas_equalTo(29);
    }];
    
    [self.lblOnePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblPrice.mas_right).offset(10);
        make.height.mas_equalTo(22);
        make.centerY.equalTo(self.lblPrice.mas_centerY);
    }];
    
    [self.lblBazaarPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblOnePrice.mas_right).offset(20);
        make.height.mas_equalTo(22);
        make.centerY.equalTo(self.lblPrice.mas_centerY);
    }];
    
    [self.imgLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBackCycle.mas_left).offset(15);
        make.right.equalTo(self.vBackCycle.mas_right).offset(-15);
        make.top.equalTo(self.lblPrice.mas_bottom).offset(7);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.lblSKUName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBackCycle.mas_left).offset(15);
        make.top.equalTo(self.imgLineOne.mas_top).offset(7);
        make.height.mas_equalTo(24);
    }];
    
    [self.lblSKU mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblSKUName.mas_right).offset(20);
        make.top.equalTo(self.imgLineOne.mas_top).offset(7);
        make.height.mas_equalTo(24);
    }];
    
    [self.labStock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBackCycle.mas_right).offset(-115);
        make.top.equalTo(self.imgLineOne.mas_top).offset(7);
        make.height.mas_equalTo(24);
    }];
    
    [self.labStock_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labStock.mas_right).offset(0);
        make.top.equalTo(self.imgLineOne.mas_top).offset(7);
        make.height.mas_equalTo(24);
    }];
    
    [self.lblExplainName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBackCycle.mas_left).offset(15);
        make.top.equalTo(self.lblSKUName.mas_bottom).offset(0);
        make.height.mas_equalTo(24);
    }];
    
    [self.lblExplain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblExplainName.mas_right).offset(20);
        make.top.equalTo(self.lblSKUName.mas_bottom).offset(0);
        make.height.mas_equalTo(24);
    }];
    
    [self.imgLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBackCycle.mas_left).offset(15);
        make.right.equalTo(self.vBackCycle.mas_right).offset(-15);
        make.top.equalTo(self.lblExplain.mas_bottom).offset(7);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.lblSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBackCycle.mas_left).offset(15);
        make.top.equalTo(self.imgLineTwo.mas_bottom).offset(0);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(25);
    }];
    
    [self.lblSelectAttribute mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgLineTwo.mas_bottom).offset(0);
        make.height.mas_equalTo(30);
        make.left.equalTo(self.lblSelect.mas_right).offset(20);
        make.right.equalTo(self.imgArrows.mas_left).offset(-0);
    }];
    
    [self.imgArrows mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgLineTwo.mas_bottom).offset(0);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(20);
        make.right.equalTo(self.vBackCycle.mas_right).offset(-15);
    }];
    
    
    [self.vLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBackCycle.mas_left).offset(15);
        make.top.equalTo(self.lblSelect.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
        make.right.equalTo(self.vBackCycle.mas_right).offset(-15);
    }];
    
    [self.imgArrows2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLine3.mas_bottom).offset(0);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(20);
        make.right.equalTo(self.vBackCycle.mas_right).offset(-15);
    }];

    [self.labShopingRecode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBackCycle.mas_left).offset(15);
        make.top.equalTo(self.vLine3.mas_bottom).offset(0);
        make.bottom.equalTo(self.vBackCycle.mas_bottom).offset(0);
        make.right.equalTo(self.vBackCycle.mas_right).offset(-15);
    }];

    
    [self.vBackRecommend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vBackCycle.mas_bottom).offset(20);
        make.height.mas_equalTo(235);
        make.width.mas_equalTo(kDisWidth);
    }];
    
    [self.lblOtherCommodityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBackRecommend.mas_left).offset(15);
        make.right.equalTo(self.vBackRecommend.mas_right).offset(-15);
        make.top.equalTo(self.vBackRecommend.mas_top).offset(0);
        make.height.mas_offset(30);
    }];
    
    [self.vLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vBackRecommend);
        make.top.equalTo(self.vBackRecommend.mas_top).offset(29);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.cltOtherCommodity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.vBackRecommend.mas_bottom);
        make.left.right.equalTo(self.vBackRecommend);
        make.height.mas_equalTo(205);
    }];
    
    
    [self.vUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vBackRecommend.mas_bottom);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(kDisWidth);
        make.bottom.equalTo(self);
    }];
    
    [self.imgUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.vUp);
        make.width.mas_equalTo(20);
        make.centerX.equalTo(self.vUp.mas_centerX).offset(-55);
    }];
    
    [self.lblUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.vUp);
        make.left.equalTo(self.imgUp.mas_right).offset(10);
    }];
    
}


- (void)loadData:(CommodityDetailsModel *)model number:(NSInteger)iNumber
{
    [self.arrCycleData removeAllObjects];
    [model.arrImage enumerateObjectsUsingBlock:^(CommodityImageModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.arrCycleData addObject:obj.sImageBig];
    }];
    
    self.sroCycle.imageURLStringsGroup = self.arrCycleData;
    
    self.lblCommodityName.text = model.goods_name;
    self.lblPrice.text = model.price;
    
    self.lblPrice.attributedText = [ZXNTool addMoneySignal:model.price font:12];
    
    self.lblOnePrice.text = [NSString stringWithFormat:@"单价：￥%@",model.single_price];
    self.lblBazaarPrice.text = [NSString stringWithFormat:@"市场价：￥%@",model.market_price];
    
    self.lblSKU.text = model.sku;
    self.lblSelectAttribute.text = [NSString stringWithFormat:@"%@  数量：%ld", model.attribute, (long)iNumber];
    
    NSInteger goodsNumber = [model.mv_stock integerValue];
    self.labStock_title.text =[NSString stringWithFormat:@" %ld 件",(long)goodsNumber];
    self.labStock_title.font = [UIFont systemFontOfSize:12];
    if (goodsNumber >= 10) {
        self.labStock_title.textColor = ColorAPPTheme;
    }else if (goodsNumber > 0){
        self.labStock_title.textColor= [UIColor redColor];
    }else if (goodsNumber == 0){
        self.labStock_title.text = @" 库存不足";
        self.labStock_title.textColor = [UIColor redColor];
    }

}


- (void)loadDataRecommend:(NSMutableArray *)arrData
{
    self.arrOtherCommodityData = arrData;
    [self.cltOtherCommodity reloadData];
}




#pragma mark - 点击选择商品属性
- (void)tapSelectAttribute
{
    if (self.delegateDetails && [self.delegateDetails respondsToSelector:@selector(presentShowCommodityQuality:)]) {
        [self.delegateDetails presentShowCommodityQuality:@""];
    }
}

-(void)tapSelectShoopingRecode{

    if (self.delegateDetails && [self.delegateDetails respondsToSelector:@selector(prentShopingInforViewController)]) {
        [self.delegateDetails prentShopingInforViewController];
    }
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.delegateDetails && [self.delegateDetails respondsToSelector:@selector(presentShowCommodityImage:index:)]) {
        [self.delegateDetails presentShowCommodityImage:self.arrCycleData index:index];
    }
}



#pragma mark - UICollectionViewDelegate UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrOtherCommodityData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailsRecommendCell" forIndexPath:indexPath];
    [cell loadView:self.arrOtherCommodityData[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegateDetails && [self.delegateDetails respondsToSelector:@selector(pusCommodityViewController:)]) {
        CommodityDetailsModel *model = self.arrOtherCommodityData[indexPath.row];
        [self.delegateDetails pusCommodityViewController:model.sku];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(145, 205);
}



#pragma mark - 懒加载
- (UIView *)vBackCycle
{
    if (!_vBackCycle) {
        _vBackCycle = [[UIView alloc] init];
        _vBackCycle.backgroundColor = [UIColor whiteColor];
    }
    return _vBackCycle;
}

- (SDCycleScrollView *)sroCycle
{
    if (!_sroCycle) {
        _sroCycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"Default_Logo"]];
        _sroCycle.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _sroCycle.autoScroll = NO;
        _sroCycle.infiniteLoop = NO;
        _sroCycle.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _sroCycle.pageControlDotSize = CGSizeMake(8, 8);
        _sroCycle.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        _sroCycle.pageDotColor = [UIColor colorWithHexString:@"efeff4"];
        _sroCycle.currentPageDotColor = ColorAPPTheme;
    }
    return _sroCycle;
}

- (UIView *)vLineOne
{
    if (!_vLineOne) {
        _vLineOne = [[UIView alloc] init];
        _vLineOne.backgroundColor = ColorLine;
    }
    return _vLineOne;
}

- (UILabel *)lblCommodityName
{
    if (!_lblCommodityName) {
        _lblCommodityName = [[UILabel alloc] init];
        _lblCommodityName.numberOfLines = 2;
        _lblCommodityName.font = kFont13;
        _lblCommodityName.text = @"商品名称加载中...";
    }
    return _lblCommodityName;
}

- (UILabel *)lblPrice
{
    if (!_lblPrice) {
        _lblPrice = [[UILabel alloc] init];
        _lblPrice.textColor = [UIColor colorWithHexString:@"ef2e23"];
        _lblPrice.font = kFont17_B;
        _lblPrice.text = @"价格:加载中...";
    }
    return _lblPrice;
}

- (UILabel *)lblOnePrice
{
    if (!_lblOnePrice) {
        _lblOnePrice = [[UILabel alloc] init];
        _lblOnePrice.textColor = [UIColor colorWithHexString:@"666666"];
        _lblOnePrice.font = kFont12;
        _lblOnePrice.text = @"单价:加载中...";
    }
    return _lblOnePrice;
}

- (UILabel *)lblBazaarPrice
{
    if (!_lblBazaarPrice) {
        _lblBazaarPrice = [[UILabel alloc] init];
        _lblBazaarPrice.textColor = [UIColor colorWithHexString:@"666666"];
        _lblBazaarPrice.font = kFont12;
        _lblBazaarPrice.text = @"市场价格:加载中...";
    }
    return _lblBazaarPrice;
}

- (UIImageView *)imgLineOne
{
    if (!_imgLineOne) {
        _imgLineOne = [[UIImageView alloc] init];
        _imgLineOne.backgroundColor = ColorLine;
    }
    return _imgLineOne;
}

- (UILabel *)lblSKUName
{
    if (!_lblSKUName) {
        _lblSKUName = [[UILabel alloc] init];
        _lblSKUName.textColor = [UIColor colorWithHexString:@"666666"];
        _lblSKUName.text = @"编号";
        _lblSKUName.font = kFont12;
    }
    return _lblSKUName;
}

- (UILabel *)lblSKU
{
    if (!_lblSKU) {
        _lblSKU = [[UILabel alloc] init];
        _lblSKU.font = kFont12;
        _lblSKU.text = @"加载中...";
    }
    return _lblSKU;
}

- (UILabel *)lblExplainName
{
    if (!_lblExplainName) {
        _lblExplainName = [[UILabel alloc] init];
        _lblExplainName.textColor = [UIColor colorWithHexString:@"666666"];
        _lblExplainName.font = kFont12;
        _lblExplainName.text = @"说明";
    }
    return _lblExplainName;
}

- (UILabel *)lblExplain
{
    if (!_lblExplain) {
        _lblExplain = [[UILabel alloc] init];
        _lblExplain.text = @"商品包税 商品包邮 ";
        _lblExplain.font = kFont12;
    }
    return _lblExplain;
}

- (UIImageView *)imgLineTwo
{
    if (!_imgLineTwo) {
        _imgLineTwo = [[UIImageView alloc] init];
        _imgLineTwo.backgroundColor = ColorLine;
    }
    return _imgLineTwo;
}

- (UILabel *)lblSelect
{
    if (!_lblSelect) {
        _lblSelect = [[UILabel alloc] init];
        _lblSelect.text = @"已选";
        _lblSelect.textColor = [UIColor colorWithHexString:@"666666"];
        _lblSelect.font = kFont12;
    }
    return _lblSelect;
}

- (UILabel *)lblSelectAttribute
{
    if (!_lblSelectAttribute) {
        _lblSelectAttribute = [[UILabel alloc] init];
        _lblSelectAttribute.font = kFont12;
        _lblSelectAttribute.userInteractionEnabled = YES;
        _lblSelectAttribute.text = @"加载中...";
        
        
        UITapGestureRecognizer *tapSelectAttribute = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelectAttribute)];
        [_lblSelectAttribute addGestureRecognizer:tapSelectAttribute];
    }
    return _lblSelectAttribute;
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


- (UIImageView *)imgArrows2
{
    if (!_imgArrows2) {
        _imgArrows2 = [[UIImageView alloc] init];
        _imgArrows2.image = [UIImage imageNamed:@"accessory"];
        _imgArrows2.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgArrows2;
}
- (UIView *)vBackRecommend
{
    if (!_vBackRecommend) {
        _vBackRecommend = [[UIView alloc] init];
        _vBackRecommend.backgroundColor = [UIColor whiteColor];
    }
    return _vBackRecommend;
}

- (UILabel *)lblOtherCommodityName
{
    if (!_lblOtherCommodityName) {
        _lblOtherCommodityName = [[UILabel alloc] init];
        _lblOtherCommodityName.text = @"相关推荐";
        _lblOtherCommodityName.font = kFont13;
    }
    return _lblOtherCommodityName;
}

- (UIView *)vLineTwo
{
    if (!_vLineTwo) {
        _vLineTwo = [[UIView alloc] init];
        _vLineTwo.backgroundColor = ColorLine;
    }
    return _vLineTwo;
}

- (UICollectionView *)cltOtherCommodity
{
    if (!_cltOtherCommodity) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _cltOtherCommodity = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        _cltOtherCommodity.showsHorizontalScrollIndicator = NO;
        _cltOtherCommodity.delegate = self;
        _cltOtherCommodity.dataSource = self;
        [_cltOtherCommodity registerClass:[DetailsRecommendCell class] forCellWithReuseIdentifier:@"DetailsRecommendCell"];
        _cltOtherCommodity.backgroundColor = [UIColor whiteColor];
    }
    return _cltOtherCommodity;
}

- (UIView *)vUp
{
    if (!_vUp) {
        _vUp = [[UIView alloc] init];
    }
    return _vUp;
}

- (UIImageView *)imgUp
{
    if (!_imgUp) {
        _imgUp = [[UIImageView alloc] init];
        _imgUp.image = [UIImage imageNamed:@"Commodity_Up"];
        _imgUp.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgUp;
}

- (UILabel *)lblUp
{
    if (!_lblUp) {
        _lblUp = [[UILabel alloc] init];
        _lblUp.text = @"上拉加载图文详情";
        _lblUp.textColor = [UIColor colorWithHexString:@"666666"];
        _lblUp.font = kFont13;
    }
    return _lblUp;
}

-(UILabel *)labShopingRecode{

    if (!_labShopingRecode) {
        _labShopingRecode = [[UILabel alloc]init];
        _labShopingRecode.text = @"采购记录";
        _labShopingRecode.textColor = [UIColor colorWithHexString:@"666666"];
        _labShopingRecode.font = kFont12;
        _labShopingRecode.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tapSelectShoopingRecode = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelectShoopingRecode)];
        [_labShopingRecode addGestureRecognizer:tapSelectShoopingRecode];
    }
    return _labShopingRecode;
}

-(UIView *)vLine3{

    if (!_vLine3) {
        _vLine3 = [[UIView alloc]init];
        _vLine3.backgroundColor = ColorLine;
    }
    return _vLine3;
}

-(UILabel *)labStock{

    if (!_labStock) {
        _labStock = [[UILabel alloc]init];
        _labStock.text = @"微仓库存:";
        _labStock.textColor = [UIColor colorWithHexString:@"#666666"];
        _labStock.font = [UIFont systemFontOfSize:12.0];
    }
    return _labStock;
}

-(UILabel *)labStock_title{

    if (!_labStock_title) {
        _labStock_title = [[UILabel alloc]init];
    }
    return _labStock_title;
}

@end

