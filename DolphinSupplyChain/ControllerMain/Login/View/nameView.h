//
//  nameView.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/27.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol nameViewDelegate <NSObject>

-(void)imgViewBtn;


@end
@interface nameView : UIView
@property (nonatomic ,strong)UITextField *pwdTxt;

@property (nonatomic ,copy )NSString *labText;
@property (nonatomic ,copy )NSString *placeText;
@property (nonatomic ,copy )NSString *imgURLData;

@property (nonatomic ,assign)id<nameViewDelegate>delegate;

@end
