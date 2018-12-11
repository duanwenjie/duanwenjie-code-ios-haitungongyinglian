//
//  CommonQusViewController.m
//  Distribution
//
//  Created by 张翔 on 14-11-19.
//  Copyright (c) 2014年 ___YKSKJ.COM___. All rights reserved.
//

#import "CommonQusViewController.h"

@interface CommonQusViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_questionArr;
    NSArray *titleArr;
    NSArray *questionArr1;
    NSArray *questionArr2;
    NSArray *questionArr3;
    NSArray *questionArr4;
}
@end

@implementation CommonQusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    titleArr = [NSArray arrayWithObjects:@"关于收发货",@"支付",@"代发规则",@"关税｜清关", nil];
    questionArr1 = [NSArray arrayWithObjects:@"海豚供应链需要交税么？",@"在海豚供应链是否需要预先缴纳关税？",@"关税该交给谁？",@"税率是多少？",@"身份证报关", nil];
    
    questionArr2 = [NSArray arrayWithObjects:@"网络代发概念",@"网络代发合作条件？",@"代发的价格管理",@"订单流程与管理",@"货款支付",@"货品配送",@"退换货与责任界定",@"争议与违约处理",@"其他", nil];
    
    questionArr3 = [NSArray arrayWithObjects:@"网银支付的银行列表中，为什么没有我的开卡银行？我该如何支付？",@"为什么我订单下单成功后，会显示“被取消”的状态？",@"为什么我支付的时候会显示“超过限额”？",@"关于价格",@"关于物流", nil];
    
    questionArr4 = [NSArray arrayWithObjects:@"海豚供应链平台订单什么时候发货？大概多长时间可以收到货？",@"为什么后下的订单先到了，之前下的订单还没有到，你们是按什么顺序发货的？",@"订单显示发货了，但快递信息为什么还没有更新？",@"产品收到后，发现漏发了或者错发，应该怎么办？",@"为什么我已经收到产品，但是订单仍显示正在配货？",@"海豚供应链平台使用什么快递公司为客户发货？如何收费？", nil];
    
    HTTabbleView *table = [[HTTabbleView alloc] initWithFrame:CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight-60) style:UITableViewStyleGrouped];
    table.dataSource = self;
    table.delegate = self;
    table.showsHorizontalScrollIndicator = NO;
    table.showsVerticalScrollIndicator = NO;
    [self.view addSubview:table];
    
    [self addNavigationType:YKSDefaults NavigationTitle:@"常见问题"];
}

#pragma mark table代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 3:
            return questionArr1.count;
            break;
        case 2:
            return questionArr2.count;
            break;
        case 1:
            return questionArr3.count;
            break;
        case 0:
            return questionArr4.count;
            break;
        
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kDisWidth, 30)];
    lab.text = [titleArr objectAtIndex:section];
    lab.textColor = [UIColor darkGrayColor];
    lab.font = [UIFont systemFontOfSize:12.0f];
    [view addSubview:lab];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch (section) {
        case 3:
            cell.textLabel.text = [questionArr1 objectAtIndex:row];
            cell.textLabel.tag = row;
            break;
        case 2:
            cell.textLabel.text = [questionArr2 objectAtIndex:row];
            cell.textLabel.tag = row + 5;
            break;
        case 1:
            cell.textLabel.text = [questionArr3 objectAtIndex:row];
            cell.textLabel.tag = row + 5 + 9;
            break;
        case 0:
            cell.textLabel.text = [questionArr4 objectAtIndex:row];
            cell.textLabel.tag = row + 5 + 9 + 5;
            break;
            
        
    }
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    AnswerViewController *detailVC = [[AnswerViewController alloc] init];
    detailVC.titleStr = cell.textLabel.text;
    detailVC.row = cell.textLabel.tag;
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

@end
