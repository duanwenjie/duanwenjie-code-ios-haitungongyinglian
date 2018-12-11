//
//  SearchResult_VC.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/3.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "HTBase_VC.h"

@interface SearchResult_VC : HTBase_VC


/**
 初始化构造器

 @param sKeyWork sKeyWork 通知返回的信息
 @param sCategory_id_in 首页轮播图传入的分类ID信息
 @param sBrand_id_in 首页轮播图传入的分类ID信息
 @param sGoods_id_in 首页轮播图传入的分类ID信息
 @param sBrand_id 首页轮播图传入的分类ID信息
 @param HaveKeyWork 如果为Yes 那么为搜索页面进入  如果为NO 那么为首页轮播图进入
 @return 本身
 */
- (instancetype)initWithInfo:(NSString *)sKeyWork
              category_id_in:(NSString *)sCategory_id_in
                 brand_id_in:(NSString *)sBrand_id_in
                 goods_id_in:(NSString *)sGoods_id_in
                    brand_id:(NSString *)sBrand_id
                 HaveKeyWork:(BOOL)HaveKeyWork;

@end
