//
//  SearchScreenListView.m
//  DolphinSupplyChain
//
//  Created by zhengxuening on 2017/2/13.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "SearchScreenListView.h"
#import "BuyListScreenCell.h"
#import "BrandsModel.h"


@interface SearchScreenListView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *vLineOne;

@property (nonatomic, strong) UILabel *lblBrandName;

@property (nonatomic, strong) UIView *vLineTwo;

@property (nonatomic, strong) UITableView *tbBrand;

@property (nonatomic, strong) UIView *vLineThree;

@property (nonatomic, strong) UILabel *lblOnlyHaveGoods;

@property (nonatomic, strong) UISwitch *sihOnlyHaveGoods;

@end

@implementation SearchScreenListView

- (instancetype)initWithList
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    UIView *vBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 216)];
    vBack.backgroundColor = [UIColor whiteColor];
    [self addSubview:vBack];
    
    [vBack addSubview:self.vLineThree];
    [vBack addSubview:self.lblOnlyHaveGoods];
    [vBack addSubview:self.sihOnlyHaveGoods];
    
    [vBack addSubview:self.lblBrandName];
    [vBack addSubview:self.vLineOne];
    [vBack addSubview:self.vLineTwo];
    
    [vBack addSubview:self.tbBrand];
    
    [self.vLineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vBack.mas_left).offset(0);
        make.right.equalTo(vBack.mas_right).offset(0);
        make.height.mas_equalTo(1);
        make.top.equalTo(vBack.mas_top).offset(35);
    }];
    
    [self.lblOnlyHaveGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vBack.mas_left).offset(15);
        make.top.equalTo(vBack.mas_top);
        make.bottom.equalTo(self.vLineThree.mas_top);
    }];
    
    [self.sihOnlyHaveGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vBack.mas_top).offset(2.5);
        make.bottom.equalTo(self.vLineThree.mas_top).offset(-2.5);
        make.right.equalTo(vBack.mas_right).offset(-15);
    }];
    
    
    [self.lblBrandName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vBack.mas_top).offset(36);
        make.left.equalTo(vBack);
        make.height.mas_equalTo(37);
        make.width.mas_equalTo(54);
    }];
    
    
    
    [self.vLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblBrandName.mas_bottom);
        make.left.equalTo(vBack);
        make.size.mas_equalTo(CGSizeMake(54, 1));
    }];
    
    [self.vLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vBack.mas_top).offset(36);
        make.bottom.equalTo(vBack.mas_bottom);
        make.left.equalTo(self.lblBrandName.mas_right);
        make.width.mas_equalTo(1);
    }];
    
    [self.tbBrand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(vBack);
        make.top.mas_equalTo(36);
        make.left.equalTo(self.vLineTwo.mas_right);
    }];
    
}

- (void)amendSwitchState
{
    self.sihOnlyHaveGoods.on = NO;
}



- (void)setArrScree:(NSMutableArray *)arrScree
{
    _arrScree = arrScree;
    [self.tbBrand reloadData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.hidden = YES;
}

- (void)switchOnlyHaveGoods:(UISwitch *)sihOnlyGoods
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectOnlyGoods:)]) {
        [self.delegate selectOnlyGoods:sihOnlyGoods.on];
    }
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrScree.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuyListScreenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrandCell"];
    if (cell == nil) {
        cell = [[BuyListScreenCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"BrandCell"];
    }
    BrandsModel *model = self.arrScree[indexPath.row];
    [cell loadViewClassifyName:model.brand_name isSelect:model.bSelect];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BrandsModel *model = self.arrScree[indexPath.row];
    
    if (!model.bSelect) {
        [self.arrScree enumerateObjectsUsingBlock:^(BrandsModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (model.bSelect) {
                ((BrandsModel *)self.arrScree[idx]).bSelect = NO;
                *stop = YES;
            }
        }];
        
        ((BrandsModel *)self.arrScree[indexPath.row]).bSelect = YES;
        [self.tbBrand reloadData];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectBrand:ScreenName:ScreenData:)]) {
            [self.delegate selectBrand:model.brand_id ScreenName:model.brand_name ScreenData:self.arrScree];
        }
    }
}

#pragma mark - 懒加载
- (UIView *)vLineThree
{
    if (!_vLineThree) {
        _vLineThree = [[UIView alloc] init];
        _vLineThree.backgroundColor = ColorLine;
    }
    return _vLineThree;
}

- (UILabel *)lblOnlyHaveGoods
{
    if (!_lblOnlyHaveGoods) {
        _lblOnlyHaveGoods = [[UILabel alloc] init];
        _lblOnlyHaveGoods.text = @"仅看有货";
        _lblOnlyHaveGoods.textColor = [UIColor colorWithHexString:@"333333"];
        _lblOnlyHaveGoods.font = [UIFont systemFontOfSize:13];
    }
    return _lblOnlyHaveGoods;
}


- (UISwitch *)sihOnlyHaveGoods
{
    if (!_sihOnlyHaveGoods) {
        _sihOnlyHaveGoods = [[UISwitch alloc] init];
        _sihOnlyHaveGoods.on = NO;
        [_sihOnlyHaveGoods addTarget:self action:@selector(switchOnlyHaveGoods:) forControlEvents:UIControlEventValueChanged];
    }
    return _sihOnlyHaveGoods;
}

- (UILabel *)lblBrandName
{
    if (!_lblBrandName) {
        _lblBrandName = [[UILabel alloc] init];
        _lblBrandName.text = @"品牌";
        _lblBrandName.textColor = [UIColor colorWithHexString:@"333333"];
        _lblBrandName.font = [UIFont systemFontOfSize:13];
        _lblBrandName.textAlignment = NSTextAlignmentCenter;
    }
    return _lblBrandName;
}

- (UITableView *)tbBrand
{
    if (!_tbBrand) {
        _tbBrand = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tbBrand.delegate = self;
        _tbBrand.dataSource = self;
        _tbBrand.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbBrand.showsVerticalScrollIndicator = NO;
    }
    return _tbBrand;
}

- (UIView *)vLineOne
{
    if (!_vLineOne) {
        _vLineOne = [[UIView alloc] init];
        _vLineOne.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _vLineOne;
}

- (UIView *)vLineTwo
{
    if (!_vLineTwo) {
        _vLineTwo = [[UIView alloc] init];
        _vLineTwo.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    }
    return _vLineTwo;
}


@end













