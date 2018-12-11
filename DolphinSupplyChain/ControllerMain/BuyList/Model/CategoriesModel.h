//
//  CategoriesModel.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/1.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXNModel.h"

@interface CategoriesModel : ZXNModel

/// 分类Id
@property (nonatomic, copy) NSString *category_id;

/// 分类名称
@property (nonatomic, copy) NSString *category_name;

/// 对应的父类ID
@property (nonatomic, copy) NSString *parent_id;

/// 关键词
@property (nonatomic, copy) NSString *keywords;

/// 描述
@property (nonatomic, copy) NSString *sDescription;

/// 大图
@property (nonatomic, copy) NSString *image_large;

/// 缩略图
@property (nonatomic, copy) NSString *image_thumbnail;

/// 排序
@property (nonatomic, copy) NSString *ordering;

/// 是否可用
@property (nonatomic, copy) NSString *is_enable;

/// 是否删除
@property (nonatomic, copy) NSString *is_detele;

/// 是否选中了该分类
@property (nonatomic, assign) BOOL bSelect;

@end
