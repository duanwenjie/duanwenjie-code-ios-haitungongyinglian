//
//  ClassCollectionCell.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/13.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *lblName;

- (void)loadView:(NSString *)sName;

@end
