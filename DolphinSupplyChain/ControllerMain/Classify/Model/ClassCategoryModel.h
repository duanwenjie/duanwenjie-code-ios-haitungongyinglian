//
//  ClassCategoryModel.h
//  DolphinSupplyChain
//
//  Created by Steffen.D on 16/11/30.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassCategoryModel : NSObject

@property (nonatomic ,copy) NSString *category_id;
@property (nonatomic ,copy) NSString *category_name;
@property (nonatomic ,copy) NSString *ordering;
@property (nonatomic ,copy) NSString *image_large;
@property (nonatomic ,copy) NSString *image_thumbnail;
@property (nonatomic ,copy) NSString *keywords;
@property (nonatomic ,copy) NSString *description;
@property (nonatomic ,copy) NSString * parent_id;
@property (nonatomic ,assign) BOOL  is_enable;
@property (nonatomic ,assign) BOOL  is_detele;
@property (nonatomic ,strong) NSArray * subCategories;

@property (nonatomic, assign) CGFloat fWitdh;

@end
