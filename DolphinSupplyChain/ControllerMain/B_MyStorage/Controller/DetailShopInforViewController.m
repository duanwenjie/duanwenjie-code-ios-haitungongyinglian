//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "DetailShopInforViewController.h"
#import "ShoppingInforView.h"
#import "OrderInforModel.h"
#import "BlankPageView.h"

static NSString * const KgetMessage = @"/PurchaseOrder/getPurchaseOrderList";

@interface DetailShopInforViewController ()
{
       UIScrollView *scrollView;
       BlankPageView * blankView;
}

@end

@implementation DetailShopInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"采购信息详情";
    
    scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0.0, kDisNavgation, kDisWidth, kDisHeight - kDisNavgation)];
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
    [self.view addSubview:scrollView];
    
    
    blankView = [[BlankPageView alloc]init];
    blankView.frame = self.view.bounds;
    blankView.hidden = YES;
    [self.view addSubview:blankView];
    [self addNavigationType:YKSDefaults NavigationTitle:@"采购信息详情"];
    [self reloadData];
    
}

-(void)reloadData{
    [HTLoadingTool showLoadingForView:self.view];
    NSDictionary *dic = @{
                          @"sku_in":self.sku_in,
                          @"goods":@"1"
                          };
    
    [AFHTTPClient POST:KgetMessage params:dic successInfo:^(ResponseModel *response) {
        
        
        //解析数据
        id json = @{@"data":response.dataResponse};
        [self reloadDataRefresh:json];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == NO_NETWORK)
        {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            blankView.hidden = NO;
            return ;
        }
        
        if (type == SERVICE_ERROR) {
            blankView.hidden = NO;
            return ;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
    
}

-(void)reloadDataRefresh:(id)json{
    NSDictionary * arrData = [json objectForKey:@"data"];
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    if (arrData != nil) {
        NSArray * arrList = [arrData objectForKey:@"list"];
        for (NSDictionary * dict in arrList) {
            OrderInforModel * model = [[OrderInforModel alloc]init];
            [model setValues:dict];
            [arr addObject:model];
        }
        
    }
    for (int i= 0; i<[arr count];i++)
    {
        CGRect frame = CGRectMake(10, 10+i*(140+5),kDisWidth-20, 135);
        OrderInforModel *order = arr[i];
        ShoppingInforView *shopinforView =[[ShoppingInforView alloc] initWithFrame:frame Index:(i+1) Infor:order];
        [shopinforView setBackgroundColor:[UIColor whiteColor]];
        [scrollView addSubview:shopinforView];
        
    }
    if (arr.count*(140 + 5) > kDisHeight - kDisNavgation) {
        scrollView.contentSize = CGSizeMake(kDisWidth, [arr count]*(140+5));
    }else{
        scrollView.contentSize = CGSizeMake(kDisWidth, kDisHeight);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
