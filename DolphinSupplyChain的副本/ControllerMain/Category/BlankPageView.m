//
//  AppDelegate.m
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "BlankPageView.h"

@interface BlankPageView ()

@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UIImageView *imgBack;

@property (nonatomic, strong) UIButton *btnNONetwork;

@end

@implementation BlankPageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        [self initView];
    }
    return self;
}


- (void)initView
{
    [self addSubview:self.imgBack];
    [self addSubview:self.lblTitle];
    [self addSubview:self.btnNONetwork];
    
    [self.imgBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-60);
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(self.imgBack.mas_bottom).offset(4);
//        make.height.mas_equalTo(20);
    }];
    
    [self.btnNONetwork mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.imgBack.mas_bottom).offset(6);
    }];
}

- (void)setImage:(UIImage *)image
{
    self.imgBack.image = image;
}

- (void)setTitle:(NSString *)title
{
    self.lblTitle.text = title;
}

/**
 切换到无网络状态显示风格
 */
- (void)switchToNoNetwork
{
    self.lblTitle.hidden = YES;
    self.btnNONetwork.hidden = NO;
    self.imgBack.image = [UIImage imageNamed:@"No_Network"];
}


/**
 切换到无数据显示风格 并可以修改提示语

 @param sPrompt 默认可以传入nil 如果想要自定义文字内容，请传入对应的文字
 */
- (void)switchToNoDataPrompt:(NSString *)sPrompt
{
    if (sPrompt.length != 0 && sPrompt != nil) {
        self.lblTitle.text = sPrompt;
    }
    self.lblTitle.hidden = NO;
    self.btnNONetwork.hidden = YES;
    self.imgBack.image = [UIImage imageNamed:@"Order_List_NO_Data"];
}


#pragma mark - 按钮点击事件
- (void)taoNoNetwork
{
    if (self.block) {
        self.block();
    }
}


- (UILabel *)lblTitle
{
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.textColor = [UIColor colorWithHexString:@"666666"];
        _lblTitle.font = [UIFont systemFontOfSize:14];
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        _lblTitle.text = @"亲~暂时没有数据哦！";
        _lblTitle.numberOfLines = 0;
    }
    return _lblTitle;
}

- (UIImageView *)imgBack
{
    if (!_imgBack) {
        _imgBack = [[UIImageView alloc] init];
        _imgBack.contentMode = UIViewContentModeScaleAspectFit;
        _imgBack.image = [UIImage imageNamed:@"Order_List_NO_Data"];
    }
    return _imgBack;
}

- (UIButton *)btnNONetwork
{
    if (!_btnNONetwork) {
        _btnNONetwork = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnNONetwork addTarget:self action:@selector(taoNoNetwork) forControlEvents:UIControlEventTouchUpInside];
        _btnNONetwork.layer.cornerRadius = 3;
        _btnNONetwork.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
        _btnNONetwork.clipsToBounds = YES;
        _btnNONetwork.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnNONetwork setTitle:@"重新连接" forState:UIControlStateNormal];
        [_btnNONetwork setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnNONetwork.hidden = YES;
    }
    return _btnNONetwork;
}


@end
