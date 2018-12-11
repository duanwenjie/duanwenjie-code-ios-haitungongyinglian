//
//  LogisticsNewViewController.m
//  DolphinSupplyChain
//
//  Created by Steffen.D on 16/12/8.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "LogisticsNewViewController.h"
#import "ErpOrderProductModel.h"
#import "TransEventArrayModel.h"
#import "LogisticsTableViewCell.h"
#import "LogisticsTableHeaderView.h"

static NSString * const kLogisticURL = @"/Logistics/info";

@interface LogisticsNewViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    BlankPageView  *blankPageView;
}

@property (nonatomic ,strong)HTTabbleView * tabView;

@property (nonatomic ,strong)NSArray * dataArr;

@property (nonatomic ,strong)NSMutableArray * tranEventArrM;

@property (nonatomic ,strong)NSMutableArray * erpOrderArrM;

@property (nonatomic ,strong)NSMutableArray * arrAll;

@property (nonatomic ,assign)NSInteger count;

@property (nonatomic ,strong)NSMutableArray * sectionArr;

@end

@implementation LogisticsNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(kDisNavgation);
        
    }];
    
    if ([self.tabView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tabView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tabView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tabView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    [self loadData];
    [self addNavigationType:YKSDefaults NavigationTitle:@"物流详情"];
}
#pragma mark - 加载数据
-(void)loadData{
    
    [HTLoadingTool showLoadingForView:self.view];
    NSDictionary *dic = @{
                          @"order_id":_orderID,
                          @"type":_type
                          };
    
    [AFHTTPClient POST:kLogisticURL params:dic successInfo:^(ResponseModel *response) {
        
        
        //解析数据
        id json = @{@"data":response.dataResponse};
        [self reloadLogisticData:json];
        
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT)
        {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            blankPageView.hidden = NO;
            return ;
        }
        
        if (type == NO_NETWORK) {
            blankPageView.hidden=YES;
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            blankPageView.hidden = NO;
            return;
        }
        
        
        if (type == SERVICE_ERROR) {
            blankPageView.hidden = NO;
            return ;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
            [self loadData];
        }
    }];
    
}
-(void)reloadLogisticData:(id)json{
    
    NSArray * result = [json objectForKey:@"data"];
    
    
    if (self.arrList.count != 0) {
        result = self.arrList;
    }
    self.dataArr = result;
    if ([result isKindOfClass:[NSArray class]]) {
        
        for (int i = 0; i < result.count ; i++) {
            NSDictionary * dic = result[i];
            NSDictionary * dict1 = [[NSDictionary alloc]init];
            NSMutableArray * arrTRNTS = [[NSMutableArray alloc]init];
            dict1 = [dic objectForKey:@"trans_events_array"];
            if (dict1.count != 0) {
                TransEventArrayModel * model = [[TransEventArrayModel alloc]init];
                [model setValues:dict1];
                [arrTRNTS addObject:model];
                
            }else{
                
                [arrTRNTS addObject: @[]];
            }
            [self.tranEventArrM addObject:arrTRNTS];
            
            
            NSArray * arr = [[NSArray alloc]init];
            arr = [dic objectForKey:@"erp_order_products"];
            NSMutableArray * arrERP = [[NSMutableArray alloc]init];
            NSDictionary * arrDict = [[NSDictionary alloc]init];
            for (arrDict in arr) {
                ErpOrderProductModel * model = [[ErpOrderProductModel alloc]init];
                [model setValues:arrDict];
                [arrERP addObject:model];
            }
            
            
            [self.erpOrderArrM addObject:arrERP];
        }
        
        
        
    }
    
    [self.tabView reloadData];
    
}


#pragma mark - UITableViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  self.dataArr.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger index = 0;
    
    NSMutableArray * arr = self.tranEventArrM[section];
    if ([arr[0] isEqual:@[]]) {
        index = 0  ;
    }else{
        TransEventArrayModel * model =  arr[0];
        index = model.trans_events.count;
    }
    
    return index;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LogisticsTableViewCell * cell = [[LogisticsTableViewCell alloc]init];
    if (indexPath.row == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSMutableArray * arrM = self.tranEventArrM[indexPath.section];
        TransEventArrayModel * model = arrM[0];
        NSInteger index = model.trans_events.count - 1;
        NSDictionary * dict = model.trans_events[index - indexPath.row];
        [cell updateTrantsEvent:dict model:model];
    }else{
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSMutableArray * arrM = self.tranEventArrM[indexPath.section];
        TransEventArrayModel * model = arrM[0];
        NSDictionary * dict = model.trans_events[indexPath.row];
        [cell updateTrantsEvent:dict];
    }
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    NSMutableArray * arrM = self.tranEventArrM[indexPath.section];
    TransEventArrayModel * model = arrM[0];
    NSInteger index = model.trans_events.count - 1;
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 37.5, 0, 15);
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        if (indexPath.row == index) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        } else {
            [cell setLayoutMargins:inset];
        }
        
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        if (indexPath.row == index) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        } else {
            [cell setSeparatorInset:inset];
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    LogisticsTableHeaderView * headerView = [[LogisticsTableHeaderView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    if (self.erpOrderArrM.count == 0) {
        
    }else{
        [headerView updateData:self.erpOrderArrM[section]];
    }
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = 1;
    
    if (indexPath.row == 0) {
        height = 70 + 70;
    }else{
        
        height = 70;
    }
    return height;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    NSArray * arr = self.erpOrderArrM[section];
    return arr.count*94;
    
}

#pragma mark - 懒加载
-(HTTabbleView *)tabView{
    
    if (!_tabView) {
        _tabView = [[HTTabbleView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tabView.delegate = self;
        _tabView.dataSource = self;
    }
    return _tabView;
    
}

-(NSArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr = [[NSArray alloc]init];
    }
    return _dataArr;
}

-(NSMutableArray *)erpOrderArrM{
    
    if (!_erpOrderArrM) {
        _erpOrderArrM = [[NSMutableArray alloc]init];
    }
    return _erpOrderArrM;
}

-(NSMutableArray *)tranEventArrM{
    
    if (!_tranEventArrM) {
        _tranEventArrM = [[NSMutableArray alloc]init];
    }
    return _tranEventArrM;
}

-(NSMutableArray *)arrAll{
    
    if (!_arrAll) {
        _arrAll = [[NSMutableArray alloc]init];
    }
    return _arrAll;
}


-(NSMutableArray *)sectionArr{
    
    if (!_sectionArr) {
        _sectionArr = [[NSMutableArray alloc]init];
    }
    return _sectionArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
