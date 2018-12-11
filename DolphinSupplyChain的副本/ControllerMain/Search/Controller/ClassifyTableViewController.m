//
//  ClassifyTableViewController.m
//  Weekens
//
//  Created by 汪超 on 15/5/29.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import "ClassifyTableViewController.h"
#import "HotWordView.h"

static NSString * const kGetHotWord = @"goods/get_key_search";

static CGFloat  const kNavHeight = 44.0;

static CGFloat  const kTabBarH = 49.0;

@interface ClassifyTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BlankPageView   *blankView;
    HTTabbleView     *myTableView;
    NSMutableArray  *historySearch;
    NSMutableArray  *hotArr;
    
    CGFloat footerH;
    CGFloat headerH;
}
@end

@implementation ClassifyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self reloadHistory];
    [self initView];
//    [self showViewAction];
    historySearch = [[NSMutableArray alloc] init];
    hotArr = [NSMutableArray new];
    [self getHotWord];
    headerH = 44;
}




static NSString *const IdentifierStr = @"historyCell";

- (void)getHotWord
{    
    [hotArr addObjectsFromArray:@[@"爱他美",@"牛栏",@"喜宝",@"花王",@"铁元",@"小甘菊",@"S26惠氏",@"贝拉米",@"可瑞康",@"深海鱼油",@"德国双心",@"月见草"]];
    [myTableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [myTableView reloadData];
}

-(void)initView
{
    blankView = [[BlankPageView alloc]initWithFrame:self.view.frame];
    blankView.image =[UIImage drawImageWithName:@"NonSearchResults.png"size:CGSizeMake(100, 100)] ;
    blankView.title = @"没有历史记录";
    blankView.backgroundColor = [UIColor whiteColor];
    UIGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickOnView)];
    [blankView addGestureRecognizer:tap1];
    
    myTableView = [[HTTabbleView alloc]initWithFrame:CGRectMake(0, 0, kDisWidth, kDisHeight-kTabBarH-kNavHeight) style:UITableViewStyleGrouped];
    myTableView.backgroundColor = [UIColor whiteColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.scrollsToTop = YES;
    [self.view addSubview:myTableView];
    [myTableView reloadData];
}

#pragma mark --读取搜索记录
-(void)reloadHistory{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *tempArray = [userDefaults objectForKey:@"historySearch"];
    historySearch = [NSMutableArray arrayWithArray:tempArray];
}


-(void)showViewAction{
    if (historySearch.count>0) {
        myTableView.hidden = NO;
        blankView.hidden = YES;
    }else{
        myTableView.hidden = YES;
        blankView.hidden = NO;
    }
}

//触摸
-(void)clickOnView
{
    if ([self.delegate respondsToSelector:@selector(putTheKeyBoardDown)]) {
        [self.delegate putTheKeyBoardDown];
    }
}

//是否确认刷新该页
-(void)setIsNeedReloard:(BOOL)isNeedReloard{
    _isNeedReloard = isNeedReloard;
    [self reloadHistory];
    [myTableView reloadData];
}

-(void)setSearchString:(NSString *)searchString{
    [self updateHistorySearchWithTitle:searchString];
    [self reloadHistory];
    [myTableView reloadData];
}


#pragma mark --跟新历史搜索
- (void)updateHistorySearchWithTitle:(NSString *)string
{
    if ([historySearch containsObject:string]) {
        [historySearch removeObject:string];
        [historySearch insertObject:string atIndex:0];
    }else{
        if ([historySearch count]==0) {
            [historySearch addObject:string];
        }else{
            [historySearch insertObject:string atIndex:0];
        }
    }
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:historySearch forKey:@"historySearch"];
    [userDefaults synchronize];
}

#pragma mark --清除历史纪录
- (void)clearHistory
{
    headerH = 44;
    [historySearch removeAllObjects];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"historySearch"];//历史搜索记录清除
    [myTableView reloadData];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(putTheKeyBoardDown)])
    {
        [self.delegate putTheKeyBoardDown];
    }
}



#pragma mark - UITabelViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, kDisWidth - 50, 20)];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.text = @"最近搜索";
    label.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label];
    if (section == 0) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kDisWidth - 30, 10, 25, 25)];
        [btn setBackgroundImage:[UIImage imageNamed:@"delete_search"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clearHistory) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }else{
        label.text = @"热门搜索";
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 0.5)];
        line.backgroundColor = kLineColer;
        [view addSubview:line];
    }
    
    
    
    return view;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return headerH;
    }else{
        return footerH;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifierStr];
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];  //删除并进行重新分配
            
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (historySearch.count == 0) {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 44)];
            lab.font = [UIFont systemFontOfSize:16.0f];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.text = @"暂无搜索历史";
            lab.textColor = color(153, 153, 153, 1.0);
            [cell.contentView addSubview:lab];
            headerH = 44;
        }else{
            HotWordView *view = [[HotWordView alloc] init];
            view.hotArr = historySearch;
            __weak typeof(view) weakView = view;
            view.viewHeightRecalc = ^(CGFloat height){
                headerH = height;
                weakView.frame = CGRectMake(0, 0, myTableView.frame.size.width - 10, height);
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
            
            WS(weakSelf);
            view.hotSearchClick = ^(NSString *title){
                
                [weakSelf loadData:title];
            };
            [cell.contentView addSubview:view];
        }
    }
    else
    {
        HotWordView *view = [[HotWordView alloc] init];
        view.hotArr = hotArr;
        __weak typeof(view) weakView = view;
        
        
        
        view.viewHeightRecalc = ^(CGFloat height){
            footerH = height;
            weakView.frame = CGRectMake(0, 0, myTableView.frame.size.width - 10, height);
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        WS(weakSelf);
        view.hotSearchClick = ^(NSString *title){
            [weakSelf loadData:title];
        };
        [cell.contentView addSubview:view];
    }
    return cell;
}


#pragma mark - 加载网络数据
- (void)loadData:(NSString *)sKeyWork
{
//    [HTLoadingTool showLoadingStringDontOperation:@"搜索中..."];
//    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:@"1" forKey:@"page"];
//    [dic setObject:@"10" forKey:@"page_size"];
//    [dic setObject:sKeyWork forKey:@"keyword"];
//    
//    [AFHTTPClient POST:@"/search/index_v2" params:dic successInfo:^(ResponseModel *response) {
//        [HTLoadingTool disMissForWindow];
//        
//        if ([self.delegate respondsToSelector:@selector(putTheKeyBoardDown)]) {
//            [self.delegate putTheKeyBoardDown];
//        }
//        if ([self.delegate respondsToSelector:@selector(choseSearchHistoryCellByCellName:Type:SKU:)]) {
//            
//            NSString *sSKU = @"";
//            if ([response.dataResponse[@"type"] isEqualToString:@"detail"]) {
//                sSKU = response.dataResponse[@"sku"];
//            }
//            [self.delegate choseSearchHistoryCellByCellName:sKeyWork Type:response.dataResponse[@"type"] SKU:sSKU];
//        }
//        
//    } flaseInfo:^(ResponseModel *response, HTTPType type) {
//        [HTLoadingTool disMissForWindow];
//        
//        [self.view makeToast:@"搜索出错" duration:1.0 position:CSToastPositionCenter];
//    }];
    
    [self.delegate choseSearchHistoryCellByCellName:sKeyWork Type:@"" SKU:@""];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
