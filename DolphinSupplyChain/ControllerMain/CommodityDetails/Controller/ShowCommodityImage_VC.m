//
//  ShowCommodityImage_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/5.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "ShowCommodityImage_VC.h"

@interface ShowCommodityImage_VC ()

@property (nonatomic, copy) NSArray *arrImageData;

@property (nonatomic, assign) NSInteger iIndex;

@end

@implementation ShowCommodityImage_VC

- (instancetype)initWithImageArray:(NSArray *)array index:(NSInteger)iIndex
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.arrImageData = array;
        self.iIndex = iIndex;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
