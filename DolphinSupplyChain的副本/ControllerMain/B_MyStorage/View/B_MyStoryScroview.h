//
//  B_MyStoryScroview.h
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/3/16.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityDetailsModel.h"


@protocol B_MyStoryScroviewDelegate <NSObject>


/**
 显示大图片
 
 @param arrImageData 图片数组
 @param iIndex 图片对应的下标
 */
- (void)presentShowCommodityImage:(NSArray *)arrImageData index:(NSInteger)iIndex;


/**
 显示商品属性
 
 @param sQualityID 商品属性ID
 */
- (void)presentShowCommodityQuality:(NSString *)sQualityID;

/**
 跳转采购记录
 */
- (void)prentShopingInforViewController;
/**
 跳转到商品详情
 
 @param sSKU 商品SKU
 */
- (void)pusCommodityViewController:(NSString *)sSKU;

@end

@interface B_MyStoryScroview : UIScrollView
@property (nonatomic, weak) id<B_MyStoryScroviewDelegate> delegateDetails;

/**
 默认初始化方法
 
 @return 返回类本身
 */
- (instancetype)initWithDetailsScroll;


/**
 对数据进行赋值
 
 @param model 模型数据
 @param iNumber 购买数量
 */
- (void)loadData:(CommodityDetailsModel *)model number:(NSInteger)iNumber;



/**
 对推荐商品赋值
 
 @param arrData 推荐商品数组
 */
- (void)loadDataRecommend:(NSMutableArray *)arrData;

@end
