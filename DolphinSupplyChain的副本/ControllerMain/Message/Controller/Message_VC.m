//
//  Message_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/9.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "Message_VC.h"
#import "MessageCell.h"
#import "MessageBll.h"
#import "MessageFirstModel.h"
#import "InformationViewController.h"
#import "MessageFourModel.h"

@interface Message_VC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) HTTabbleView *tbMain;

@property (nonatomic, strong) NSArray *arrOne;

@property (nonatomic, strong) NSArray *arrTwo;

@property (nonatomic, strong) NSMutableDictionary *dic;


@end

@implementation Message_VC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.arrOne = @[@{@"image":@"Message_One", @"title":@"发货提醒"},
                        @{@"image":@"Message_Two", @"title":@"缺货通知"},
                        @{@"image":@"Message_Three", @"title":@"库存提醒"}];
        self.arrTwo = @[@{@"image":@"Message_Four", @"title":@"公告"}];
        
        self.dic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tbMain];
    
    [self addNavigationType:YKSDefaults NavigationTitle:@"消息"];
    
    [self.tbMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.vNavigation.mas_bottom);
    }];
    
    if ([YKSUserDefaults isLogin]) {
        [self loadData];
    }
}



- (void)loadData
{
    [HTLoadingTool showLoadingForView:self.view];
    
    [AFHTTPClient POST:@"/MessageView/getFirstAll" params:nil successInfo:^(ResponseModel *response) {
        
        self.dic = [MessageBll MessageFirstJson:response.dataResponse];
        [self.tbMain reloadData];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.arrOne.count;
    }
    return self.arrTwo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageCell"];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if ([[self.dic allKeys] containsObject:@"One"]) {
                
                MessageFirstModel *model = self.dic[@"One"];
                [cell loadView:self.arrOne[indexPath.row][@"image"] Name:self.arrOne[indexPath.row][@"title"] Subhead:model.message Time:model.add_time];
            }
            else
            {
                [cell loadView:self.arrOne[indexPath.row][@"image"] Name:self.arrOne[indexPath.row][@"title"] Subhead:@"暂无消息" Time:@""];
            }
        }
        if (indexPath.row == 1) {
            if ([[self.dic allKeys] containsObject:@"Two"]) {
                
                MessageFirstModel *model = self.dic[@"Two"];
                [cell loadView:self.arrOne[indexPath.row][@"image"] Name:self.arrOne[indexPath.row][@"title"] Subhead:model.message Time:model.add_time];
            }
            else
            {
                [cell loadView:self.arrOne[indexPath.row][@"image"] Name:self.arrOne[indexPath.row][@"title"] Subhead:@"暂无消息" Time:@""];
            }
        }
        
        if (indexPath.row == 2) {
            if ([[self.dic allKeys] containsObject:@"Three"]) {
                
                MessageFirstModel *model = self.dic[@"Three"];
                [cell loadView:self.arrOne[indexPath.row][@"image"] Name:self.arrOne[indexPath.row][@"title"] Subhead:model.message Time:model.add_time];
            }
            else
            {
                [cell loadView:self.arrOne[indexPath.row][@"image"] Name:self.arrOne[indexPath.row][@"title"] Subhead:@"暂无消息" Time:@""];
            }
        }
    }
    else
    {
        if ([[self.dic allKeys] containsObject:@"Four"]) {
            
            MessageFourModel *model = self.dic[@"Four"];
            [cell loadView:self.arrTwo[indexPath.row][@"image"] Name:self.arrTwo[indexPath.row][@"title"] Subhead:model.title Time:model.add_time];
        }
        else
        {
            [cell loadView:self.arrTwo[indexPath.row][@"image"] Name:self.arrTwo[indexPath.row][@"title"] Subhead:@"暂无消息" Time:@""];
        }
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        InformationViewController *infoListVC = [[InformationViewController alloc] initWithType:4 Name:self.arrTwo[indexPath.row][@"title"]];
        [self.navigationController pushViewController:infoListVC animated:YES];
    }
    else
    {
        InformationViewController *infoListVC = [[InformationViewController alloc] initWithType:indexPath.row + 1 Name:self.arrOne[indexPath.row][@"title"]];
        [self.navigationController pushViewController:infoListVC animated:YES];
    }
    
}



- (HTTabbleView *)tbMain
{
    if (!_tbMain) {
        _tbMain = [[HTTabbleView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tbMain.delegate = self;
        _tbMain.dataSource = self;
        _tbMain.showsVerticalScrollIndicator = NO;
        _tbMain.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tbMain.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    }
    return _tbMain;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
