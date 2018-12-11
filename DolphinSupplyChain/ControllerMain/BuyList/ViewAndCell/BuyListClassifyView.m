//
//  BuyListClassifyView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/11/30.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "BuyListClassifyView.h"
#import "BuyListClassifyCell.h"
#import "CategoriesModel.h"

@interface BuyListClassifyView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) BuyListClassifyBlock classifyBlock;

@property (nonatomic, strong) UICollectionView *collectionView;



@end

@implementation BuyListClassifyView

- (instancetype)initWithBlock:(BuyListClassifyBlock)block
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.classifyBlock = block;
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    UIView *vBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 180)];
    vBack.backgroundColor = [UIColor whiteColor];
    [self addSubview:vBack];
    
    [vBack addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vBack.mas_top).offset(22);
        make.left.equalTo(vBack.mas_left).offset(20);
        make.right.equalTo(vBack.mas_right).offset(-20);
        make.bottom.equalTo(vBack.mas_bottom).offset(-22);
    }];
    
}

- (void)setArrClassify:(NSMutableArray *)arrClassify
{
    _arrClassify = arrClassify;
    [self.collectionView reloadData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.hidden = YES;
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.arrClassify == nil) {
        return 0;
    }
    return self.arrClassify.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BuyListClassifyCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BuyListClassifyCell" forIndexPath:indexPath];
    CategoriesModel *model = self.arrClassify[indexPath.row];
    
    [Cell loadViewClassifyName:model.category_name isSelect:model.bSelect];
    
    return Cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CategoriesModel *model = self.arrClassify[indexPath.row];
    
    if (!model.bSelect) {
        
        [self.arrClassify enumerateObjectsUsingBlock:^(CategoriesModel *mod, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (mod.bSelect) {
                ((CategoriesModel *)self.arrClassify[idx]).bSelect = NO;
                *stop = YES;
            }
        }];
        
        ((CategoriesModel *)self.arrClassify[indexPath.row]).bSelect = YES;
        [self.collectionView reloadData];
        
        self.classifyBlock(model.category_id, model.category_name, self.arrClassify);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kDisWidth - 40)/3, 45);
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
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[BuyListClassifyCell class] forCellWithReuseIdentifier:@"BuyListClassifyCell"];
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}


@end
