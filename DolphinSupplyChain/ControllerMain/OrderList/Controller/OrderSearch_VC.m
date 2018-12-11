//
//  OrderSearch_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/23.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "OrderSearch_VC.h"


@interface OrderSearch_VC () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *barSearch;

@property (nonatomic, strong) HTTabbleView *tbMain;

@property (nonatomic, strong) NSMutableArray *arrData;

@property (nonatomic, strong) OrderSearchKeyWorldBlock SearchBlock;

@end

@implementation OrderSearch_VC

- (instancetype)initWithBlock:(OrderSearchKeyWorldBlock)block
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.SearchBlock = block;
        
        NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"OrderSearch"];
        
        if (array == nil) {
            
            self.arrData = [NSMutableArray arrayWithCapacity:10];
            
            [[NSUserDefaults standardUserDefaults] setValue:self.arrData forKey:@"OrderSearch"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            self.arrData = [array mutableCopy];
            if (self.arrData.count > 10) {
                NSRange range = NSMakeRange(10, self.arrData.count - 10);
                [self.arrData removeObjectsInRange:range];
                [[NSUserDefaults standardUserDefaults] setValue:self.arrData forKey:@"OrderSearch"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //禁用滚动到最顶部的属性
    self.tbMain.scrollsToTop = NO;
    
    [self.view addSubview:self.tbMain];
    
    [self addNavigationType:YKSOnlyRightTwo NavigationTitle:@""];
    [self.btnRigthTwo setTitle:@"取消" forState:UIControlStateNormal];
    [self.btnRigthTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnRigthTwo.titleLabel.font = kFont16;
    [self.vNavigation addSubview:self.barSearch];
    
    [self.tbMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.vNavigation.mas_bottom);
    }];
    
    [self.barSearch becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    // 开启
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark - 点击事件
// 点击了取消
- (void)tapRightTwo
{
    [self.barSearch resignFirstResponder];
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

// 点击了清空数据
- (void)selectorRemove
{
    if (self.arrData.count == 0) {
        return;
    }
    [self.barSearch resignFirstResponder];
    [self.arrData removeAllObjects];
    [[NSUserDefaults standardUserDefaults] setValue:self.arrData forKey:@"OrderSearch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tbMain reloadData];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.barSearch resignFirstResponder];
    NSString *sSearch = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (sSearch.length != 0)
    {
        if (self.arrData.count >= 10) {
            [self.arrData removeObjectAtIndex:9];
        }
        
        [self.arrData enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:sSearch]) {
                [self.arrData removeObjectAtIndex:idx];
                *stop = YES;
            }
        }];
        
        [self.arrData insertObject:sSearch atIndex:0];
        [[NSUserDefaults standardUserDefaults] setValue:self.arrData forKey:@"OrderSearch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.tbMain reloadData];
        [self dismissViewControllerAnimated:NO completion:^{
          self.SearchBlock(sSearch);
        }];
    }
    else
    {
        [self.view makeToast:@"请输入关键词" duration:1.0 position:CSToastPositionCenter];
    }
}


#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.arrData.count == 0) {
        return 1;
    }
    else
    {
        return self.arrData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.arrData.count == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NOOrderSearchCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NOOrderSearchCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
        }
        
        cell.textLabel.text = @"暂无搜索历史";
        
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderSearchCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderSearchCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:13];
        }
        
        cell.textLabel.text = self.arrData[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *sSearch = self.arrData[indexPath.row];
    if (sSearch.length != 0)
    {
        if (self.arrData.count >= 10) {
            [self.arrData removeObjectAtIndex:9];
        }
        
        [self.arrData enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:sSearch]) {
                [self.arrData removeObjectAtIndex:idx];
                *stop = YES;
            }
        }];
        
        [self.arrData insertObject:sSearch atIndex:0];
        [[NSUserDefaults standardUserDefaults] setValue:self.arrData forKey:@"OrderSearch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.tbMain reloadData];
        [self dismissViewControllerAnimated:NO completion:^{
            self.SearchBlock(sSearch);
        }];
    }
    else
    {
        [self.view makeToast:@"请输入关键词" duration:1.0 position:CSToastPositionCenter];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *vBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 50)];
    vBack.backgroundColor = [UIColor whiteColor];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 50)];
    lblTitle.text = @"最近搜索";
    lblTitle.font = [UIFont systemFontOfSize:12];
    [vBack addSubview:lblTitle];
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCancel setImage:[UIImage drawImageWithName:@"delete_search" size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    
    
    btnCancel.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btnCancel.frame = CGRectMake(kDisWidth - 50, 0, 50, 50);
    [btnCancel addTarget:self action:@selector(selectorRemove) forControlEvents:UIControlEventTouchUpInside];
    [vBack addSubview:btnCancel];
    return vBack;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.barSearch resignFirstResponder];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.barSearch resignFirstResponder];
}

#pragma mark - 懒加载
- (UISearchBar *)barSearch
{
    if (!_barSearch) {
        _barSearch = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 27+KTop, kDisWidth - 70, 30)];
        _barSearch.searchBarStyle = UISearchBarStyleDefault;
        _barSearch.barStyle = UIBarStyleDefault;
        _barSearch.placeholder = @"商品名称/商品编号/订单编号";
        _barSearch.barTintColor = ColorAPPTheme;
        // 是否设置半透明效果
//        _barSearch.translucent = NO;
//        _barSearch.barTintColor = [UIColor whiteColor];
//        _barSearch.layer.cornerRadius = 6;
//        _barSearch.clipsToBounds = YES;
        [_barSearch setBackgroundImage:[UIImage new]];
        _barSearch.delegate = self;
    }
    return _barSearch;
}


- (HTTabbleView *)tbMain
{
    if (!_tbMain) {
        _tbMain = [[HTTabbleView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tbMain.delegate = self;
        _tbMain.dataSource = self;
        _tbMain.showsVerticalScrollIndicator = NO;
        _tbMain.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbMain.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tbMain;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
