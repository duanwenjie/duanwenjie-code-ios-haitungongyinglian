//
//  ViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol  CodeViewDelegate<NSObject>

-(void)getCodeAction;
-(void)setImagwithImgBtn:(UIImageView *)imgView;
@end

@interface CodeView : UIView

@property (nonatomic ,assign)id<CodeViewDelegate>delegate;
@property (nonatomic ,strong)UITextField *verifyText;
@property (nonatomic ,strong)UITextField *verifyText2;
@property (nonatomic ,copy)NSString *msg;
@property (nonatomic ,copy)NSString *imgUrlStr;

//@property (nonatomic ,strong)void (^RRRReturnMsg)(NSString *);
-(NSString *)getVerifyMessage:(NSString *)message phone:(NSString *)phoneStr isLogin:(BOOL)isLogin;

@end
