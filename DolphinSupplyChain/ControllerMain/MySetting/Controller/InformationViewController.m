//
//  InformationViewController.m
//  Distribution
//
//  Created by fei on 15/5/14.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import "InformationViewController.h"
#import "InfoTableViewCell.h"
#import "OrderModel.h"
#import "MessageBll.h"
#import "MessageModel.h"
#import "MessageInfo_VC.h"
#import "InfoTableViewTwoCell.h"
#import "MessageFourModel.h"
#import "HTTabbleView.h"


@interface InformationViewController () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) BlankPageView *vBlank;

@property (nonatomic, strong) NSMutableArray *arrData;

@property (nonatomic, strong) HTTabbleView *tbMain;

@property (nonatomic, assign) NSInteger iPage;

@property (nonatomic, assign) NSInteger iType;

@property (nonatomic, assign) NSString *sTitle;

@end

@implementation InformationViewController

- (instancetype)initWithType:(NSInteger)iType Name:(NSString *)sName
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.arrData = [NSMutableArray array];
        self.iType = iType;
        self.sTitle = sName;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.iPage = 1;
    
    self.tbMain = [[HTTabbleView alloc] initWithFrame:CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight - kDisNavgation) style:UITableViewStyleGrouped];
    self.tbMain.dataSource = self;
    self.tbMain.delegate = self;
    self.tbMain.showsVerticalScrollIndicator = NO;
    self.tbMain.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tbMain.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    [self.view addSubview:self.tbMain];
    
    
    self.vBlank = [[BlankPageView alloc] initWithFrame:CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight)];
    self.vBlank.title = @"暂无消息";
    self.vBlank.hidden = YES;
    [self.view addSubview:self.vBlank];
    
    self.vBlank.block = ^(){
        
    };
    
    
    WS(weakSelf);
    [self.tbMain addHeaderRefresh:^{
        [weakSelf loadInfoFirstData];
    }];
    
    [self.tbMain addFooterRefresh:^{
        [weakSelf loadInfoMoreData];
    }];
    
    if (self.iType == 4) {
        [self.tbMain beginRefreshing];
    }
    else
    {
        if ([YKSUserDefaults isLogin]) {
            [self.tbMain beginRefreshing];
        }
        else
        {
            self.vBlank.hidden = NO;
        }
    }
    
    [self addNavigationType:YKSDefaults NavigationTitle:self.sTitle];
    
}


#pragma mark --加载消息信息
- (void)loadInfoFirstData
{
    if (self.iType == 4) {
        [self loadDataFour];
        return;
    }
    
    self.iPage = 1;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.iPage],    // 当前页，从1开始，默认为1
                          @"limit":@"10",  // 分页数，默认为10
                          @"type":[NSNumber numberWithInteger:self.iType],    // 消息类型，默认为0 0=全部 1=发货提醒 2=缺货通知 3=库存提醒 4=公告
                          @"is_read":@"2"};// 是否已读，默认为2 0=未读，1=已读，2=全部
    
    [AFHTTPClient POST:@"/MessageView/getSelfList" params:dic successInfo:^(ResponseModel *response) {
        
        [self.arrData removeAllObjects];
        [self.tbMain endHeaderRefreshing];
        self.arrData = [MessageBll MessageJson:response.dataResponse];
        
        if (self.arrData.count == 0) {
            self.vBlank.hidden = NO;
        }
        else
        {
            [self.tbMain reloadData];
        }
        
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
        self.vBlank.hidden = NO;
        [self.tbMain endHeaderRefreshing];
    }];
}

#pragma mark -- 加载更多消息信息
- (void)loadInfoMoreData
{
    if (self.iType == 4) {
        [self loadMoreDataFour];
        return;
    }
    self.iPage += 1;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.iPage],    // 当前页，从1开始，默认为1
                          @"limit":@"10",  // 分页数，默认为10
                          @"type":[NSNumber numberWithInteger:self.iType],    // 消息类型，默认为0 0=全部 1=发货提醒 2=缺货通知 3=库存提醒 4=公告
                          @"is_read":@"2"};// 是否已读，默认为2 0=未读，1=已读，2=全部
    
    [AFHTTPClient POST:@"/MessageView/getSelfList" params:dic successInfo:^(ResponseModel *response) {
        [self.tbMain endFooterRefreshing];
        NSMutableArray *array = [MessageBll MessageJson:response.dataResponse];
        
        if (array.count == 0) {
            [self.tbMain showNoMoreData];
            return ;
        }
        
        /// 叠加数据
        NSMutableArray* insertPath = [NSMutableArray array];
        
        for (id item in array) {
            [self.arrData addObject:item];
            NSIndexPath* path = [NSIndexPath indexPathForRow:1 inSection:[self.arrData count]];
            [insertPath addObject:path];
        }
        
        // 加载更多数据
        [self.tbMain insertRowsAtIndexPaths:insertPath withRowAnimation:UITableViewRowAnimationMiddle];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
        self.iPage -= 1;
        [self.tbMain endFooterRefreshing];
    }];
}


- (void)loadDataFour
{
    self.iPage = 1;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.iPage],    // 当前页，从1开始，默认为1
                          @"page_size":@"10", // 分页数，默认为10
                          @"valid":@"1"};
    
    [AFHTTPClient POST:@"/Bulletin/getBulletinList" params:dic successInfo:^(ResponseModel *response) {
        
        [self.arrData removeAllObjects];
        [self.tbMain endHeaderRefreshing];
        
        self.arrData = [MessageBll MessageFourJson:response.dataResponse];
        
        if (self.arrData.count == 0) {
            self.vBlank.hidden = NO;
        }
        else
        {
            [self.tbMain reloadData];
        }
        
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
        self.vBlank.hidden = NO;
        [self.tbMain endHeaderRefreshing];
    }];
}

#pragma mark -- 加载更多消息信息
- (void)loadMoreDataFour
{
    self.iPage += 1;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.iPage],    // 当前页，从1开始，默认为1
                          @"page_size":@"10", // 分页数，默认为10
                          @"valid":@"1"};
    
    [AFHTTPClient POST:@"/Bulletin/getBulletinList" params:dic successInfo:^(ResponseModel *response) {
        [self.tbMain endFooterRefreshing];
        NSMutableArray *array = [MessageBll MessageFourJson:response.dataResponse];
        
        if (array.count == 0) {
            self.iPage -= 1;
            [self.tbMain showNoMoreData];
            return ;
        }
        
        /// 叠加数据
        NSMutableArray* insertPath = [NSMutableArray array];
        
        for (id item in array) {
            NSIndexPath* path = [NSIndexPath indexPathForRow:[self.arrData count] inSection:0];
            [self.arrData addObject:item];
            [insertPath addObject:path];
        }
        
        // 加载更多数据
        [self.tbMain insertRowsAtIndexPaths:insertPath withRowAnimation:UITableViewRowAnimationMiddle];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
        self.iPage -= 1;
        [self.tbMain endFooterRefreshing];
    }];
}

#pragma mark -- 删除信息
- (void)deleteMessage:(NSString *)sMessage_id index:(NSInteger)iIndex
{
    if (self.iType == 4) {
        return;
    }
    
    NSDictionary *dic = @{@"message_id":sMessage_id};
    
    [AFHTTPClient POST:@"/MessageView/delSelfMsg" params:dic successInfo:^(ResponseModel *response) {
        [self.view makeToast:@"删除成功" duration:1.0 position:CSToastPositionCenter];
        
        [self.arrData removeObjectAtIndex:iIndex];
        
        [self.tbMain deleteSections:[NSIndexSet indexSetWithIndex:iIndex] withRowAnimation:UITableViewRowAnimationFade];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}

#pragma mark --UITableview Delegate and Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.iType == 4)
    {
        InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoTableCell"];
        if (cell == nil) {
            cell = [[InfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"infoTableCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        MessageFourModel *model = self.arrData[indexPath.row];
        [cell cellDisplayWithModel:model];
        return cell;
    }
    else
    {
        InfoTableViewTwoCell *TwoCell = [tableView dequeueReusableCellWithIdentifier:@"InfoTableViewTwoCell"];
        if (TwoCell == nil) {
            TwoCell = [[InfoTableViewTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoTableViewTwoCell"];
            TwoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        MessageModel *model = self.arrData[indexPath.row];
        [TwoCell cellDisplayWithModel:model];
        return TwoCell;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.iType == 4) {
        return 160;
    }
    return 131;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.iType == 4) {
        return nil;
    }
    
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.iType == 4) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (self.iType == 4) {
            return;
        }
        MessageModel *infoModel = self.arrData[indexPath.row];
        [self deleteMessage:infoModel.message_id index:indexPath.row];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.iType == 4) {
        MessageFourModel *infoModel = self.arrData[indexPath.row];
        // 跳转公告详情
        MessageInfo_VC *info_VC = [[MessageInfo_VC alloc] initWithNavName:@"消息公告" Time:infoModel.add_time NeiRon:infoModel.content Keyid:infoModel.KeyId];
        
        [self.navigationController pushViewController:info_VC animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
