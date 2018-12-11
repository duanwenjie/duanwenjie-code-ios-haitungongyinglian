//
//  SelectDistrict_VC.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/4.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectDistrict_VC : UIViewController

typedef void (^SelectDistrictBlock)(NSString *sProvinceName, NSString *sProvinceID, NSString *sCityName, NSString *sCityID, NSString *sAreaName, NSString *sAreaID);

- (instancetype)initWithSelectDistrict:(SelectDistrictBlock)block;

@end
