//
//  ClassTableViewCell.m
//  海豚供应链
//
//  Created by Steffen.D on 16/11/26.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "ClassTableViewCell.h"
#import "ClassCollectionCell.h"
#import "ZXNImageView.h"

@interface ClassTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) ZXNImageView *imgBack;

@property (nonatomic, strong) UILabel *lblClassTitle;

@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UILabel *lblClassDescribe;

@property (nonatomic, strong) UIButton *btnTapAll;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *arrData;

@property (nonatomic, strong) ClassCategoryModel *model;


@end

@implementation ClassTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self.contentView addSubview:self.imgBack];
    [self.imgBack addSubview:self.lblClassTitle];
    [self.imgBack addSubview:self.vLine];
    [self.imgBack addSubview:self.lblClassDescribe];
    [self.imgBack addSubview:self.btnTapAll];
    
    [self.contentView addSubview:self.collectionView];
    
    [self.imgBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(kDisWidth/3.12);
    }];
    
    [self.lblClassTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imgBack.mas_centerX);
        make.top.equalTo(self.imgBack.mas_top).offset(20);
        make.height.mas_equalTo(26);
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lblClassTitle);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(self.lblClassTitle.mas_bottom).offset(0);
    }];
    
    [self.lblClassDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLine.mas_bottom).offset(2);
        make.height.mas_equalTo(20);
        make.centerX.equalTo(self.imgBack.mas_centerX);
    }];
    
    [self.btnTapAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imgBack.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 20));
        make.top.equalTo(self.lblClassDescribe.mas_bottom).offset(2);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgBack.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
}


- (void)loadView:(ClassCategoryModel *)model
{
    self.model = model;
    self.arrData = _model.subCategories;
    [self.imgBack downloadImage:model.image_thumbnail backgroundImage:ZXNImageClassify];
    self.lblClassTitle.text = model.category_name;
    self.lblClassDescribe.text = model.keywords;
    [self.collectionView reloadData];
    
    [self setNeedsLayout];
}


#pragma mark - 点击事件
- (void)selectAll
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerBtnDidClick:::)]) {
        [self.delegate headerBtnDidClick:self.model.category_id :self.model.category_id :self.model.category_name];
    }
}


#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassCollectionCell" forIndexPath:indexPath];
    [cell loadView:self.arrData[indexPath.row][@"category_name"]];
    
    if (indexPath.row%4 == 0) {
        cell.lblName.textAlignment = NSTextAlignmentLeft;
    }
    else if (indexPath.row%4 == 3) {
        cell.lblName.textAlignment = NSTextAlignmentRight;
    }
    else
    {cell.lblName.textAlignment = NSTextAlignmentCenter;
        
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(childBtnDidClick::::)]) {
        [self.delegate childBtnDidClick:self.model.category_id :self.arrData[indexPath.row][@"category_id"] :self.model.category_name :self.arrData[indexPath.row][@"category_name"]];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kDisWidth - 20)/4, 30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{

    return 0;
}


#pragma mark - 懒加载
- (ZXNImageView *)imgBack
{
    if (!_imgBack) {
        _imgBack = [[ZXNImageView alloc] init];
        _imgBack.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAll)];
        [_imgBack addGestureRecognizer:tap];
    }
    return _imgBack;
}

- (UILabel *)lblClassTitle
{
    if (!_lblClassTitle) {
        _lblClassTitle = [[UILabel alloc] init];
        _lblClassTitle.textColor = [UIColor whiteColor];
        _lblClassTitle.font = [UIFont systemFontOfSize:15];
        _lblClassTitle.textAlignment = NSTextAlignmentCenter;
        _lblClassTitle.userInteractionEnabled = YES;
    }
    return _lblClassTitle;
}

- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = [UIColor whiteColor];
        _vLine.userInteractionEnabled = YES;
    }
    return _vLine;
}

- (UILabel *)lblClassDescribe
{
    if (!_lblClassDescribe) {
        _lblClassDescribe = [[UILabel alloc] init];
        _lblClassDescribe.textColor = [UIColor whiteColor];
        _lblClassDescribe.font = [UIFont systemFontOfSize:12];
        _lblClassDescribe.textAlignment = NSTextAlignmentCenter;
        _lblClassDescribe.userInteractionEnabled = YES;
    }
    return _lblClassDescribe;
}

- (UIButton *)btnTapAll
{
    if (!_btnTapAll) {
        _btnTapAll = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnTapAll.layer.borderColor = [UIColor whiteColor].CGColor;
        _btnTapAll.layer.borderWidth = 0.5;
        [_btnTapAll addTarget:self action:@selector(selectAll) forControlEvents:UIControlEventTouchUpInside];
        [_btnTapAll setTitle:@"查看全部" forState:UIControlStateNormal];
        [_btnTapAll setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnTapAll.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _btnTapAll;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ClassCollectionCell class] forCellWithReuseIdentifier:@"ClassCollectionCell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.bounces = NO;

        _collectionView.scrollEnabled = NO; //设置不能滚动
    }
    return _collectionView;
}



- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
