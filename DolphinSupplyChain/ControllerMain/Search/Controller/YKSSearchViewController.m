//
//  HTSearchViewController.m
//  Distribution
//
//  Created by 汪超 on 16/1/4.
//  Copyright © 2016年 ___YKSKJ.COM___. All rights reserved.
//

#import "YKSSearchViewController.h"
#import "ClassifyTableViewController.h"


@interface YKSSearchViewController ()<UISearchBarDelegate,ClassifyTableViewDelegate>
{
    UIImageView     *topView;//顶部视图
    UISearchBar     *mySearchBar;//搜索框
    UITextField     *textFieldRef;//搜索框中文本框的引用
    ClassifyTableViewController *searchTableView;//搜索历史记录显示控制器
}

@property (nonatomic, assign) BOOL bHome;

@property (nonatomic, strong) YKSSearchBlock searchBlock;

@property (nonatomic, copy) NSString *sType;

@property (nonatomic, copy) NSString *sSKU;


@end

@implementation YKSSearchViewController

- (instancetype)initWithIsHome:(BOOL)bHome Block:(YKSSearchBlock)block
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.bHome = bHome;
        self.searchBlock = block;
        self.sType = @"";
        self.sSKU = @"";

    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self performSelector:@selector(setCorrectFocus) withObject:nil];
    
}


-(void) setCorrectFocus {
    mySearchBar.placeholder = @"请输入商品名称或关键字";
    [mySearchBar becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTopView];
    

}

-(void)addTopView{
    topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDisWidth, kDisNavgation)];
    [topView setImage:[UIImage imageNamed:@"beijing"]];
    topView.userInteractionEnabled = YES;
    [self.view addSubview:topView];
    
    mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 20+KTop, kDisWidth, 44)];
    mySearchBar.delegate = self;
    mySearchBar.tintColor = [UIColor whiteColor];
    [mySearchBar setImage:[UIImage drawImageWithName:@"searchPage_04.png" size:CGSizeMake(15, 14)] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [mySearchBar setImage:[UIImage drawImageWithName:@"searchPage_04.png" size:CGSizeMake(15, 14)] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateSelected];
    [mySearchBar setBackgroundImage:[UIImage imageNamed:@"beijing"]];
    [mySearchBar setBackgroundColor:[UIColor clearColor]];
    mySearchBar.searchTextPositionAdjustment = UIOffsetMake(5, 0);
    [mySearchBar setText:@"搜索海豚商品"];
    
    mySearchBar.layer.cornerRadius = 4;
    mySearchBar.clipsToBounds = YES;
    
    [self setSearchTextFieldBackgroundColor:[UIColor whiteColor]];
    [topView addSubview:mySearchBar];
}

#pragma mark --设置搜索框样式和背景色
- (void)setSearchTextFieldBackgroundColor:(UIColor *)backgroundColor
{
    UITextField *searchTextField = nil;
    // 经测试, 需要设置barTintColor后, 才能拿到UISearchBarTextField对象
    mySearchBar.barTintColor = [UIColor whiteColor];
    searchTextField = [[[mySearchBar.subviews firstObject] subviews] lastObject];
    searchTextField.layer.cornerRadius = 4.0;
    searchTextField.layer.masksToBounds = YES;
    searchTextField.clipsToBounds = YES;
    
    searchTextField.tintColor = [UIColor blackColor];
    searchTextField.backgroundColor = backgroundColor;
    searchTextField.borderStyle = UITextBorderStyleNone;
    searchTextField.textColor = [UIColor darkGrayColor];
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    searchTextField.textAlignment = NSTextAlignmentLeft;
    searchTextField.clearButtonMode = UITextFieldViewModeNever;
    
    textFieldRef = searchTextField;
}

-(void)coverClick{
    [UIView animateWithDuration:0.2 animations:^{
        [mySearchBar setShowsCancelButton:NO animated:YES];
        [mySearchBar resignFirstResponder];
        
        
    } completion:^(BOOL finished) {
        [searchTableView.view removeFromSuperview];
    }];
}

#pragma mark --取消搜索
-(void)giveUpKeyboard
{
    [mySearchBar resignFirstResponder];
    textFieldRef.textColor = [UIColor darkGrayColor];
    textFieldRef.clearButtonMode = UITextFieldViewModeNever;
}



#pragma mark -UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSString *str = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (![str isEqualToString:@""] && str.length != 0) {
        textFieldRef.clearButtonMode = UITextFieldViewModeAlways;
        
    }
    else
    {
        
    }
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    // 修改UISearchBar右侧的取消按钮文字颜色
    for(id cc in [searchBar.subviews[0] subviews])
    {
        UIButton *btn = (UIButton *)cc;
        if([cc isKindOfClass:[UIButton class]])
        {
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:17];
        }
    }
    
    if ([searchBar.text isEqualToString:@"搜索海豚商品"]) {
        searchBar.text = nil;
    }else{
        textFieldRef.clearButtonMode = UITextFieldViewModeAlways;
    }
    
    if (searchTableView==nil) {
        searchTableView = [[ClassifyTableViewController alloc]init];
        
        searchTableView.view.frame = CGRectMake(0, topView.bottom+1, kDisWidth, kDisHeight-topView.bottom-1);
        searchTableView.delegate = self;
        [self addChildViewController:searchTableView];
    }
    searchTableView.isNeedReloard = YES;
    searchTableView.view.frame = CGRectMake(0, topView.bottom+1, kDisWidth, kDisHeight-topView.bottom-1);
    [self.view addSubview:searchTableView.view];
    
}

// 点击取消按钮
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"搜索海豚商品";
    textFieldRef.clearButtonMode = UITextFieldViewModeNever;
    [self coverClick];
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *str = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    searchBar.text = str;
    if (str.length != 0)
    {
        searchTableView.searchString = searchBar.text;
        
        [self loadData:searchBar.text];
    }
    else
    {
        searchBar.text = @"";
        [self.view makeToast:@"请输入关键词" duration:1.0 position:CSToastPositionCenter];
    }
}


#pragma mark - 加载网络数据
- (void)loadData:(NSString *)sKeyWork
{
    [mySearchBar resignFirstResponder];
    [HTLoadingTool showLoadingStringDontOperation:@"搜索中..."];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"1" forKey:@"page"];
    [dic setObject:@"10" forKey:@"page_size"];
    [dic setObject:sKeyWork forKey:@"keyword"];
    
    [AFHTTPClient POST:@"/search/index_v2" params:dic successInfo:^(ResponseModel *response) {
        
        self.sType = response.dataResponse[@"type"];
        if ([self.sType isEqualToString:@"detail"]) {
            self.sSKU = response.dataResponse[@"sku"];
        }
        [self dismissViewControllerAnimated:NO completion:^{
            self.searchBlock(textFieldRef.text, self.sType, self.sSKU);
        }];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        [HTLoadingTool disMissForWindow];
        
        [self.view makeToast:@"搜索出错" duration:1.0 position:CSToastPositionCenter];
    }];
}



#pragma mark - classifyTableViewDelegate
-(void)putTheKeyBoardDown
{
    //放弃键盘后可能会点下面的tabBar  设置isclickButton属性    
    NSString *str = [mySearchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (str.length==0) {
        mySearchBar.text = @"搜索海豚商品";
        textFieldRef.clearButtonMode = UITextFieldViewModeNever;
    }
    
    
    [self setSearchBtnStatus];
    [mySearchBar resignFirstResponder];
    
    /*
     *经测试  只有这样做才能做到释放键盘后取消可以点取 不然点取消会弹键盘
     */
    
    [self setSearchBtnStatus];
    [mySearchBar setShowsCancelButton:YES animated:NO];
    textFieldRef.textColor = [UIColor darkGrayColor];
    [mySearchBar resignFirstResponder];
}

-(void)choseSearchHistoryCellByCellName:(NSString *)searchString Type:(NSString *)sType SKU:(NSString *)sSKU
{
    mySearchBar.text = searchString;
//    self.sType = sType;
//    self.sSKU = sSKU;
    [self searchBarSearchButtonClicked:mySearchBar];
}

-(void)setSearchBtnStatus
{
    for(id cc in [mySearchBar.subviews[0] subviews])
    {
        UIButton *btn = (UIButton *)cc;
        if([cc isKindOfClass:[UIButton class]])
        {
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:17];
        }
        btn.enabled = YES;
        textFieldRef.textColor = [UIColor darkGrayColor];
    }
}


@end
