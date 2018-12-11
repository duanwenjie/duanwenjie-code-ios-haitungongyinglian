//
//  ClassTableViewCell.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/26.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassCategoryModel.h"

@protocol ClassTableViewCellDelegate <NSObject>

- (void)headerBtnDidClick:(NSString *)firstID :(NSString *)nextID :(NSString *)name;
- (void)childBtnDidClick:(NSString *)firstID :(NSString *)nextID :(NSString *)name :(NSString *)sCategoryName;
@end

@interface ClassTableViewCell : UITableViewCell


@property (nonatomic ,weak) id<ClassTableViewCellDelegate>delegate;


- (void)loadView:(ClassCategoryModel *)model;

@end
