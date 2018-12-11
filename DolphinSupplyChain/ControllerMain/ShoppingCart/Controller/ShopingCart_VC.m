//
//  ShopingCart_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/8.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "ShopingCart_VC.h"
#import "ShoppingCartFoot.h"
#import "ShoppingCartCell.h"
#import "CartZXNModel.h"
#import "ShopingCartBll.h"
#import "ConfirmOrder_VC.h"
#import "ZXNTool.h"
#import "CommodityDetails_VC.h"
#import "LoginViewController.h"
#import "BlankPageView.h"
#import "LoseEfficacyView.h"
#import "LoseEfficacyCell.h"
#import "HintView.h"
#import "HaiWaiHeadView.h"
#import "GuoNeiHeadView.h"

#import "HTTabbleView.h"
#import "HTFMDBTool.h"

@interface ShopingCart_VC () <UITableViewDelegate, UITableViewDataSource, ShoppingCartDelegate, ShoppingCartFootDelegate, LoseEfficacyDelegate, HintViewDelegate, HaiWaiHeadDelegate, GuoNeiHeadDelegate>

@property (nonatomic, strong) HTTabbleView *tbMain;

@property (nonatomic, strong) ShoppingCartFoot *vFoot;

@property (nonatomic, strong) BlankPageView *vBlankView;

@property (nonatomic, strong) LoseEfficacyView *vLoseEfficacy;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, strong) UIWindow *HTWindow;

@property (nonatomic, strong) HintView *vHint;

@property (nonatomic, strong) HaiWaiHeadView *vHaiWaiHead;

@property (nonatomic, strong) GuoNeiHeadView *vGuoNeiHead;

@property (nonatomic, strong) NSMutableDictionary *dicData;

@property (nonatomic, strong) NSMutableArray *arrLoseEfficacyData;

@property (nonatomic, strong) NSMutableArray *arrHaiWai;

@property (nonatomic, strong) NSMutableArray *arrGuoNei;

@property (nonatomic, strong) NSMutableArray *arrHaiWaiSKU;

@property (nonatomic, strong) NSMutableArray *arrGuoNeiSKU;

@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, assign) BOOL isRefresh;

@property (nonatomic, assign) BuyType buyTeyp;

@property (nonatomic, assign) OrderType orderType;

@end

@implementation ShopingCart_VC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // 设置默认购买类型为：C端购买
        self.buyTeyp = C_Pay;
        
        // 设置默认商品订单类型为：境外购订单类型
        self.orderType = JingWai_Order;
        
        self.isEdit = NO;
        self.isRefresh = NO;
        self.dicData = [NSMutableDictionary dictionary];
        self.arrLoseEfficacyData = [NSMutableArray array];
        self.arrHaiWai = [NSMutableArray array];
        self.arrGuoNei = [NSMutableArray array];
        self.arrHaiWaiSKU = [NSMutableArray array];
        self.arrGuoNeiSKU = [NSMutableArray array];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.tbMain];
    [self.view addSubview:self.vFoot];
    
    if (self.bBottom) {
        self.tbMain.frame = CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight - 108);
        //如果是iPhone X KBottomSuit
        if (kDisHeight == 812.0) {
            [self.vFoot mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.height.mas_offset(44);
                make.bottom.equalTo(self.view.mas_bottom).offset(-10);
            }];
        }else{
            [self.vFoot mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.height.mas_offset(44);
                make.bottom.equalTo(self.view.mas_bottom).offset(0);
            }];
        }
        
    }
    else
    {
        if ([YKSUserDefaults isUserIndividual]) {
            //如果是iPhone X KBottomSuit
            if (kDisHeight == 812.0) {
                self.tbMain.frame = CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight - 157-49);
            }else{
                self.tbMain.frame = CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight - 157);
            }
            
            [self.vFoot mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.height.mas_offset(44);
                make.bottom.equalTo(self.view.mas_bottom).offset(-KBottomSuit-49);
            }];
        }
        else
        {
            self.tbMain.frame = CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight - 108);
            [self.vFoot mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.height.mas_offset(44);
                make.bottom.equalTo(self.view.mas_bottom).offset(-KBottomSuit);
            }];
        }
    }
    
    [self.vFoot updateAllMoney:@"0.00"];
    
    [self.view addSubview:self.vBlankView];
    if (self.bBottom) {
        self.vBlankView.frame = CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight - kDisNavgation);
    }
    else
    {
        if ([YKSUserDefaults isUserIndividual]) {
            self.vBlankView.frame = CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight - 113);
        }
        else
        {
            self.vBlankView.frame = CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight - kDisNavgation);
        }
    }
    
    if ([YKSUserDefaults isUserIndividual]) {
        if (self.navigationController.viewControllers.count > 1) {
            [self addNavigationType:YKS_Left_Title_RightTwo NavigationTitle:@"购物车"];
            return;
        }
        [self addNavigationType:YKS_Title_RightTwo NavigationTitle:@"购物车"];
    }
    else
    {
        [self addNavigationType:YKS_Left_Title_RightTwo NavigationTitle:@"购物车"];
    }
    
    
    [self.btnRigthTwo setTitle:@"编辑" forState:UIControlStateNormal];
    [self.btnRigthTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    WS(weakSelf);
    [self.tbMain addHeaderRefresh:^{
        [weakSelf loadData];
    }];
    
    [self.view addSubview:self.activityView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([YKSUserDefaults isLogin]) {
        self.isEdit = NO;
        [self.btnRigthTwo setTitle:@"编辑" forState:UIControlStateNormal];
        [self resetCartModelIsSelectBuy:YES];
        [self.vFoot isSelectAll:YES];
        [self.vFoot isComeDeletePattern:NO];
        [self loadData];
    }
    else
    {
        HTFMDBTool *db = [HTFMDBTool shareInstance];
        [db querySQL:@"select * from cart_tb" block:^(NSMutableArray *obj) {
            
            [self.dicData removeAllObjects];
            
            NSMutableArray *arrHaiWai = [NSMutableArray array];
            NSMutableArray *arrGuoNei = [NSMutableArray array];
            
            for (NSDictionary *dic in obj) {
                CartZXNModel *model = [[CartZXNModel alloc] init];
                model.goods_id = dic[@"sCommodityID"];
                model.img_thumb = dic[@"sImage"];
                model.price = dic[@"sMoney"];
                model.goods_name = dic[@"sName"];
                model.goods_number_edit = dic[@"sNumber"];
                model.sku = dic[@"sSku"];
                model.isSelectBuy = YES;
                model.isSelectEdit = NO;
                model.goods_number = dic[@"sNumber"];
                model.min_purchase_quantity = dic[@"sMinPurchase"];
                model.is_modulo = dic[@"sModulo"];
                
                if ([model.is_trade_sku isEqualToString:@"1"]) // 一般贸易商品
                {
                    [arrGuoNei addObject:model];
                }
                else
                {
                    [arrHaiWai addObject:model];
                }
            }
            
            if (arrHaiWai.count != 0) {
                [self.dicData setValue:arrHaiWai forKey:@"HaiWai"];
            }
            if (arrGuoNei.count != 0) {
                [self.dicData setValue:arrGuoNei forKey:@"GuoNei"];
            }
            
            [self resetCartModelIsSelectBuy:YES];
        }];
        
        if (self.dicData.count == 0) {
            self.vBlankView.hidden = NO;
        }
        else
        {
            self.vBlankView.hidden = YES;
        }
    }
    [self.vHaiWaiHead changeImageSelectState:YES];
    [self.vGuoNeiHead changeImageSelectState:YES];
    
    if (!self.bBottom)
    {
        // 禁用 返回手势
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (!self.bBottom)
    {
        // 开启
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}

#pragma mark - 按钮事件
- (void)tapRightTwo
{
    self.isEdit = !self.isEdit;
    if (self.isEdit) {
        if (self.dicData.count == 0) {
            return;
        }
        self.isRefresh = NO;
        [self.btnRigthTwo setTitle:@"完成" forState:UIControlStateNormal];
        [self resetCartModelIsSelectEdit:NO];
        [self.vFoot isComeDeletePattern:YES];
        [self.vFoot isSelectAll:NO];
        [self.vHaiWaiHead changeImageSelectState:NO];
        [self.vGuoNeiHead changeImageSelectState:NO];
        [self.tbMain reloadData];
    }
    else
    {
        [self.btnRigthTwo setTitle:@"编辑" forState:UIControlStateNormal];
        [self resetCartModelIsSelectBuy:YES];
        [self.vFoot isSelectAll:YES];
        [self.vFoot isComeDeletePattern:NO];
        [self.vHaiWaiHead changeImageSelectState:YES];
        [self.vGuoNeiHead changeImageSelectState:YES];
        if (self.isRefresh) {
            // 发起网络请求
            [self batchEidt:NO];
        }
        else
        {
            [self.tbMain reloadData];
        }
    }
}



#pragma mark - 网络请求
// 请求购物车列表
- (void)loadData
{
    if (![YKSUserDefaults isLogin]) {
        
        HTFMDBTool *db = [HTFMDBTool shareInstance];
        [db querySQL:@"select * from cart_tb" block:^(NSMutableArray *obj) {
            
            [self.dicData removeAllObjects];
            
            NSMutableArray *arrHaiWai = [NSMutableArray array];
            NSMutableArray *arrGuoNei = [NSMutableArray array];
            
            for (NSDictionary *dic in obj) {
                CartZXNModel *model = [[CartZXNModel alloc] init];
                model.goods_id = dic[@"sCommodityID"];
                model.img_thumb = dic[@"sImage"];
                model.price = dic[@"sMoney"];
                model.goods_name = dic[@"sName"];
                model.goods_number_edit = dic[@"sNumber"];
                model.sku = dic[@"sSku"];
                model.isSelectBuy = YES;
                model.isSelectEdit = NO;
                model.goods_number = dic[@"sNumber"];
                model.min_purchase_quantity = dic[@"sMinPurchase"];
                model.is_modulo = dic[@"sModulo"];
                
                if ([model.is_trade_sku isEqualToString:@"1"]) // 一般贸易商品
                {
                    [arrGuoNei addObject:model];
                }
                else
                {
                    [arrHaiWai addObject:model];
                }
            }
            
            if (arrHaiWai.count != 0) {
                [self.dicData setValue:arrHaiWai forKey:@"HaiWai"];
            }
            if (arrGuoNei.count != 0) {
                [self.dicData setValue:arrGuoNei forKey:@"GuoNei"];
            }
            
            [self resetCartModelIsSelectBuy:YES];
            [self.tbMain endHeaderRefreshing];
        }];
        return;
    }
    
    [self.activityView startAnimating];
    
    [AFHTTPClient POST:@"/cart/getList" params:nil successInfo:^(ResponseModel *response) {
        
        [self.activityView stopAnimating];
        [self.tbMain endHeaderRefreshing];
        [self.dicData removeAllObjects];
        
        self.dicData = [ShopingCartBll gainShoppingCartList:response.dataResponse];
        
        if (self.dicData.count == 0) {
            self.vBlankView.hidden = NO;
        }
        else
        {
            self.vBlankView.hidden = YES;
        }
        
        [self resetCartModelIsSelectEdit:NO];
        [self countAllMoney];
        [self.tbMain reloadData];
        
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        [self.activityView stopAnimating];
        [self.tbMain endHeaderRefreshing];
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}

// 增加、减少、删除、设置 购物车数量--单个
- (void)settingCartCommodityNumberType:(CartSettingType)type
                                Number:(NSString *)sNumber
                             CellIndex:(NSIndexPath *)index
{
    
    CartZXNModel *cartmodel = nil;
    if (index.section == 0) {
        
        if ([[self.dicData allKeys] containsObject:@"HaiWai"]) {
            cartmodel = self.dicData[@"HaiWai"][index.row];
        }
        else
        {
            cartmodel = self.dicData[@"GuoNei"][index.row];
        }
        
    }
    else
    {
        cartmodel = self.dicData[@"GuoNei"][index.row];
    }

    if (![YKSUserDefaults isLogin])
    {
       
        HTFMDBTool *db = [HTFMDBTool shareInstance];
        switch (type) {
            case Cart_Add:
            {
                NSString *sSQL = [NSString stringWithFormat:@"update cart_tb set sNumber = '%ld' WHERE sCommodityID = '%@'", [cartmodel.is_modulo isEqualToString:@"1"] ? (cartmodel.goods_number.integerValue + 2) : (cartmodel.goods_number.integerValue + 1), cartmodel.goods_id];
                
                [db execSQL:sSQL withBlock:^(BOOL bRet) {
                    
                    if ([cartmodel.is_modulo isEqualToString:@"1"]) {
                        cartmodel.goods_number = [NSString stringWithFormat:@"%ld", (long)([cartmodel.goods_number integerValue] + 2)];
                        cartmodel.goods_number_edit = cartmodel.goods_number;
                    }
                    else
                    {
                        cartmodel.goods_number = [NSString stringWithFormat:@"%ld", (long)([cartmodel.goods_number integerValue] + 1)];
                        cartmodel.goods_number_edit = cartmodel.goods_number;
                    }
                    
                    [self.tbMain reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
                }];
            }
                break;
            case Cart_Sub:
            {
                NSString *sSQL = [NSString stringWithFormat:@"update cart_tb set sNumber = '%ld' WHERE sCommodityID = '%@'", [cartmodel.is_modulo isEqualToString:@"1"] ? (cartmodel.goods_number.integerValue - 2) : (cartmodel.goods_number.integerValue - 1), cartmodel.goods_id];
                
                [db execSQL:sSQL withBlock:^(BOOL bRet) {
                    
                    if ([cartmodel.is_modulo isEqualToString:@"1"]) {
                        cartmodel.goods_number = [NSString stringWithFormat:@"%ld", (long)([cartmodel.goods_number integerValue] - 2)];
                        cartmodel.goods_number_edit = cartmodel.goods_number;
                    }
                    else
                    {
                        cartmodel.goods_number = [NSString stringWithFormat:@"%ld", (long)([cartmodel.goods_number integerValue] - 1)];
                        cartmodel.goods_number_edit = cartmodel.goods_number;
                    }
                    
                    [self.tbMain reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
                }];
            }
                break;
            case Cart_Set:
            {
                NSString *sSQL = [NSString stringWithFormat:@"update cart_tb set sNumber = '%@' WHERE sCommodityID = '%@'", sNumber, cartmodel.goods_id];
                [db execSQL:sSQL withBlock:^(BOOL bRet) {
                    cartmodel.goods_number = sNumber;
                    cartmodel.goods_number_edit = sNumber;
                    [self.tbMain reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
                }];
                
            }
                break;
            case Cart_Del:
            {
                NSString *sSQL = [NSString stringWithFormat:@"delete from cart_tb where sCommodityID = '%@'", cartmodel.goods_id];
                [db execSQL:sSQL withBlock:^(BOOL bRet) {
                    
                    if (index.section == 0) {
                        if ([[self.dicData allKeys] containsObject:@"HaiWai"]) {
                            [((NSMutableArray *)self.dicData[@"HaiWai"]) removeObjectAtIndex:index.row];
                        }
                        else
                        {
                            [((NSMutableArray *)self.dicData[@"GuoNei"]) removeObjectAtIndex:index.row];
                        }
                    }
                    else
                    {
                        [((NSMutableArray *)self.dicData[@"GuoNei"]) removeObjectAtIndex:index.row];
                    }
                    [self.tbMain deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index.row inSection:index.section]] withRowAnimation:UITableViewRowAnimationNone];
                }];
            }
                break;
        }
        [self countAllMoney];
        return;
    }
   
    NSString *sType = @"";
    switch (type) {
        case Cart_Add:
            sType = @"add";
            [HTLoadingTool showLoadingStringDontOperation:@"修改中...."];
            break;
        case Cart_Sub:
            sType = @"sub";
            [HTLoadingTool showLoadingStringDontOperation:@"修改中...."];
            break;
        case Cart_Set:
            sType = @"set";
            [HTLoadingTool showLoadingStringDontOperation:@"修改中...."];
            break;
        case Cart_Del:
            sType = @"del";
            [HTLoadingTool showLoadingStringDontOperation:@"删除中..."];
            break;
    }
    
    NSDictionary *dic = @{@"goods_id":cartmodel.goods_id,
                          @"type":sType,
                          @"number":sNumber};
    
    [AFHTTPClient POST:@"/cart/modify" params:dic successInfo:^(ResponseModel *response) {
        
        switch (type) {
            case Cart_Add:
                
                if ([cartmodel.is_modulo isEqualToString:@"1"]) {
                    
                    cartmodel.goods_number = [NSString stringWithFormat:@"%ld", (long)([cartmodel.goods_number integerValue] + 2)];
                    cartmodel.goods_number_edit = cartmodel.goods_number;
                }
                else
                {
                    cartmodel.goods_number = [NSString stringWithFormat:@"%ld", (long)([cartmodel.goods_number integerValue] + 1)];
                    cartmodel.goods_number_edit = cartmodel.goods_number;
                }
                [self.tbMain reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
                break;
            case Cart_Sub:
                if ([cartmodel.is_modulo isEqualToString:@"1"]) {
                    cartmodel.goods_number = [NSString stringWithFormat:@"%ld", [cartmodel.goods_number integerValue] - 2];
                    cartmodel.goods_number_edit = cartmodel.goods_number;
                }
                else
                {
                    cartmodel.goods_number = [NSString stringWithFormat:@"%ld", [cartmodel.goods_number integerValue] - 1];
                    cartmodel.goods_number_edit = cartmodel.goods_number;
                }
                
                [self.tbMain reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
                
                break;
            case Cart_Set:
                cartmodel.goods_number = sNumber;
                cartmodel.goods_number_edit = sNumber;
                [self.tbMain reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
                
                break;
            case Cart_Del:
                if (index.section == 0) {
                    if ([[self.dicData allKeys] containsObject:@"HaiWai"]) {
                        [((NSMutableArray *)self.dicData[@"HaiWai"]) removeObjectAtIndex:index.row];
                    }
                    else
                    {
                        [((NSMutableArray *)self.dicData[@"GuoNei"]) removeObjectAtIndex:index.row];
                    }
                }
                else
                {
                    [((NSMutableArray *)self.dicData[@"GuoNei"]) removeObjectAtIndex:index.row];
                }
                [self.tbMain deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index.row inSection:index.section]] withRowAnimation:UITableViewRowAnimationNone];
                break;
        }
        [self countAllMoney];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        [self.activityView stopAnimating];
        
        [self.tbMain reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
        
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}


// 批量删除购物车商品
- (void)batchDelete
{
    if (![YKSUserDefaults isLogin]) {
        
        HTFMDBTool *db = [HTFMDBTool shareInstance];
        
        for (NSMutableArray *arrData in self.dicData.allValues) {
            [arrData enumerateObjectsUsingBlock:^(CartZXNModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
                if (model.isSelectEdit) {
                    NSString *sSQL = [NSString stringWithFormat:@"delete from cart_tb where sCommodityID = '%@'", model.goods_id];
                    [db execSQL:sSQL withBlock:^(BOOL bRet) {
                        [arrData removeObjectAtIndex:idx];
                    }];
                }
            }];
        }
        
        [self.tbMain reloadData];
        return;
    }
    
    
    NSString *GoodId = [self combinationCartSeletcEdit:YES];
    
    if (GoodId.length == 0) {
        [self.view makeToast:@"你需要勾选商品才能删除" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    [HTLoadingTool showLoadingStringDontOperation:@"删除中...."];
    
    NSDictionary *dic = @{@"goods_id":GoodId,
                          @"type":@"del"};
    
    [AFHTTPClient POST:@"/cart/modify" params:dic successInfo:^(ResponseModel *response) {
        
        [self.dicData removeAllObjects];
        [self.tbMain reloadData];
        [self.tbMain beginRefreshing];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}

// 批量编辑
- (void)batchEidt:(BOOL)isDelete
{
    if (![YKSUserDefaults isLogin]) {
        
        HTFMDBTool *db = [HTFMDBTool shareInstance];
        
        for (NSMutableArray *arrData in self.dicData.allValues) {
            [arrData enumerateObjectsUsingBlock:^(CartZXNModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
                if (![model.goods_number isEqualToString:model.goods_number_edit]) {
                    NSString *sSQL = [NSString stringWithFormat:@"update cart_tb set sNumber = '%@' WHERE sCommodityID = '%@'", model.goods_number_edit, model.goods_id];
                    [db execSQL:sSQL withBlock:^(BOOL bRet) {
                        model.goods_number = model.goods_number_edit;
                    }];
                }
            }];
        }
        
        [self.tbMain reloadData];
        return;
    }
    
    
    NSString *GoodIdList = [self combinationCartSeletcEdit:isDelete];
    
    NSDictionary *dic = nil;
    NSString *sURL = @"";
    if (isDelete) {
        sURL = @"/cart/modify";
        dic = @{@"goods_id":GoodIdList,
                @"type":@"del"};
    }
    else
    {
        sURL = @"/cart/batchSet";
        dic = @{@"goods_list":GoodIdList};
    }
    [HTLoadingTool showLoadingStringDontOperation:@"修改中..."];
    [AFHTTPClient POST:sURL params:dic successInfo:^(ResponseModel *response) {
        [self.tbMain beginRefreshing];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}


#pragma mark - ShoppingCartDelegate
- (void)seletcCommodity:(BOOL)bSeletc Index:(NSIndexPath *)index
{
    CartZXNModel *model = nil;
    CartHintENUM type;
    if (index.section == 0) {
        if ([[self.dicData allKeys] containsObject:@"HaiWai"]) {
            model = self.dicData[@"HaiWai"][index.row];
            type = HT_HaiWai;
        }
        else
        {
            model = self.dicData[@"GuoNei"][index.row];
            type = HT_GuoNie;
        }
    }
    else
    {
        model = self.dicData[@"GuoNei"][index.row];
        type = HT_GuoNie;
    }
    
    if (!self.isEdit) {
        model.isSelectBuy = bSeletc;
        [self countAllMoney];
    }
    else
    {
        model.isSelectEdit = bSeletc;
    }
    
    if (type == HT_HaiWai) {
        [self.vHaiWaiHead changeImageSelectState:[self judgeSectionIsTick:type]];
    }
    else
    {
        [self.vGuoNeiHead changeImageSelectState:[self judgeSectionIsTick:type]];
    }
    
}

- (void)subCommodityNumberIndex:(NSIndexPath *)index
{
    if (self.isEdit) {
        
        CartZXNModel *model = nil;
        if (index.section == 0) {
            if ([[self.dicData allKeys] containsObject:@"HaiWai"]) {
                model = self.dicData[@"HaiWai"][index.row];
            }
            else
            {
                model = self.dicData[@"GuoNei"][index.row];
            }
        }
        else
        {
            model = self.dicData[@"GuoNei"][index.row];
        }
        
        if ([model.is_modulo isEqualToString:@"1"]) {
            model.goods_number_edit = [NSString stringWithFormat:@"%ld", (long)([model.goods_number_edit integerValue] - 2)];
        }
        else
        {
            model.goods_number_edit = [NSString stringWithFormat:@"%ld", (long)([model.goods_number_edit integerValue] - 1)];
        }
        self.isRefresh = YES;
        [self.tbMain reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    else
    {
        [self settingCartCommodityNumberType:Cart_Sub Number:@"1" CellIndex:index];
    }
}

- (void)addCommodityNumberIndex:(NSIndexPath *)index
{
    if (self.isEdit) {
        CartZXNModel *model = nil;
        
        if (index.section == 0) {
            if ([[self.dicData allKeys] containsObject:@"HaiWai"]) {
                model = self.dicData[@"HaiWai"][index.row];
            }
            else
            {
                model = self.dicData[@"GuoNei"][index.row];
            }
        }
        else
        {
            model = self.dicData[@"GuoNei"][index.row];
        }
        
        if ([model.is_modulo isEqualToString:@"1"]) {
            model.goods_number_edit = [NSString stringWithFormat:@"%ld", ([model.goods_number_edit integerValue] + 2)];
        }
        else
        {
            model.goods_number_edit = [NSString stringWithFormat:@"%ld", ([model.goods_number_edit integerValue] + 1)];
        }
        self.isRefresh = YES;
        [self.tbMain reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    else
    {
        [self settingCartCommodityNumberType:Cart_Add Number:@"1" CellIndex:index];
    }
}

- (void)BeginEditingKeyBoardIndex:(NSIndexPath *)index
{
    NSInteger iHaiWaiCount = 0;
    if ([[self.dicData allKeys] containsObject:@"HaiWai"])
    {
        iHaiWaiCount = ((NSMutableArray *)self.dicData[@"HaiWai"]).count;
    }
    if (index.section == 0) {
        [self.tbMain setContentOffset:CGPointMake(0, index.row * 100 + 50) animated:YES];
    }
    if (index.section == 1) {
        [self.tbMain setContentOffset:CGPointMake(0, (iHaiWaiCount * 100 + 50) + index.row * 100 + 50) animated:YES];
    }

}

- (void)tapKeyBoardAccomplish:(NSIndexPath *)index Number:(NSString *)sNumber Message:(NSString *)sMessage isCanEidt:(BOOL)bCanEidt
{
    if (!bCanEidt) {
        [self.view makeToast:sMessage duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (self.isEdit) {
        
        CartZXNModel *model = nil;
        
        if (index.section == 0) {
            if ([[self.dicData allKeys] containsObject:@"HaiWai"]) {
                model = self.dicData[@"HaiWai"][index.row];
            }
            else
            {
                model = self.dicData[@"GuoNei"][index.row];
            }
        }
        else
        {
            model = self.dicData[@"GuoNei"][index.row];
        }
        
        model.goods_number_edit = sNumber;
        self.isRefresh = YES;
        [self.tbMain reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    else
    {
        [self settingCartCommodityNumberType:Cart_Set Number:sNumber CellIndex:index];
    }
}

#pragma mark - ShoppingCartFootDelegate
- (void)tapSelectAll:(BOOL)bSelectAll
{
    if (self.isEdit) {
        [self resetCartModelIsSelectEdit:bSelectAll];
    }
    else
    {
        [self resetCartModelIsSelectBuy:bSelectAll];
    }
}

- (void)tapCartSettle
{
    if (![YKSUserDefaults isLogin]) {
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        if ([YKSUserDefaults isUserIndividual]) {
            loginVC.hidesBottomBarWhenPushed = YES;
        }
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    
    NSMutableDictionary *dic = [self combinationCartSeletcBuy];
    if (dic.count == 0) {
        [self.view makeToast:@"您还未选中任何商品" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (dic.count == 4)
    {
        self.buyTeyp = C_Pay;
        [self.arrHaiWai removeAllObjects];
        [self.arrGuoNei removeAllObjects];
        [self.arrHaiWaiSKU removeAllObjects];
        [self.arrGuoNeiSKU removeAllObjects];
        
        [self.HTWindow addSubview:self.vHint];
        if (self.vHint.hidden) {
            self.vHint.hidden = NO;
        }
        [self.vHint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self.HTWindow);
        }];
        
        self.arrHaiWai = dic[@"HaiWaiGoodID"];
        self.arrGuoNei = dic[@"GuoNeiGoodID"];
        self.arrHaiWaiSKU = dic[@"HaiWaiGoodSKU"];
        self.arrGuoNeiSKU = dic[@"GuoNeiGoodSKU"];
        
        [self.vHint changeHaiWaiAndGuoNie:self.arrHaiWai.count :self.arrGuoNei.count];
    }
    else
    {
        NSArray *arr = nil;
        NSArray *arrSKU = nil;
        OrderType type = JingWai_Order;
        if ([[dic allKeys] containsObject:@"HaiWaiGoodID"]) {
            arr = dic[@"HaiWaiGoodID"];
            arrSKU = dic[@"HaiWaiGoodSKU"];
            type = JingWai_Order;
        }
        else
        {
            arr = dic[@"GuoNeiGoodID"];
            arrSKU = dic[@"GuoNeiGoodSKU"];
            type = GuoNei_Order;
        }
        ConfirmOrder_VC *conVC = [[ConfirmOrder_VC alloc] initWithCartData:arr twoCartData:arr BuyType:C_Pay OrderType:type];
        
        if ([YKSUserDefaults isUserIndividual]) {
            conVC.hidesBottomBarWhenPushed = YES;
        }
        [self.navigationController pushViewController:conVC animated:YES];
    }
}

- (void)tapCartPurchase
{
    if (![YKSUserDefaults isLogin]) {
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        if ([YKSUserDefaults isUserIndividual]) {
            loginVC.hidesBottomBarWhenPushed = YES;
        }
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    
    NSMutableDictionary *dic = [self combinationCartSeletcBuy];
    if (dic.count == 0) {
        [self.view makeToast:@"您还未选中任何商品" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (dic.count == 4)
    {
        self.buyTeyp = B_Pay;
        [self.arrHaiWai removeAllObjects];
        [self.arrGuoNei removeAllObjects];
        [self.arrHaiWaiSKU removeAllObjects];
        [self.arrGuoNeiSKU removeAllObjects];
        
        [self.HTWindow addSubview:self.vHint];
        if (self.vHint.hidden) {
            self.vHint.hidden = NO;
        }
        [self.vHint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self.HTWindow);
        }];
        
        self.arrHaiWai = dic[@"HaiWaiGoodID"];
        self.arrGuoNei = dic[@"GuoNeiGoodID"];
        self.arrHaiWaiSKU = dic[@"HaiWaiGoodSKU"];
        self.arrGuoNeiSKU = dic[@"GuoNeiGoodSKU"];
        
        [self.vHint changeHaiWaiAndGuoNie:self.arrHaiWai.count :self.arrGuoNei.count];
    }
    else
    {
        NSArray *arr = nil;
        NSArray *arrSKU = nil;
        OrderType type = JingWai_Order;
        if ([[dic allKeys] containsObject:@"HaiWaiGoodID"]) {
            arr = dic[@"HaiWaiGoodID"];
            arrSKU = dic[@"HaiWaiGoodSKU"];
            type = JingWai_Order;
        }
        else
        {
            arr = dic[@"GuoNeiGoodID"];
            arrSKU = dic[@"GuoNeiGoodSKU"];
            type = GuoNei_Order;
        }
        ConfirmOrder_VC *conVC = [[ConfirmOrder_VC alloc] initWithCartData:arr twoCartData:arr BuyType:B_Pay OrderType:type];
        if ([YKSUserDefaults isUserIndividual]) {
            conVC.hidesBottomBarWhenPushed = YES;
        }
        [self.navigationController pushViewController:conVC animated:YES];
    }
}

- (void)tapCartDelete
{
    UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否确认删除" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self batchDelete];
    }];
    
    [alerController addAction:cancelAction];
    [alerController addAction:okAction];
    
    [self.navigationController presentViewController:alerController animated:YES completion:nil];
    
}

#pragma mark - LoseEfficacyDelegate
#pragma mark 清空所有失效商品
- (void)emptyAll
{
    UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否确认删除" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteAllLoseEfficacyCommodity];
    }];
    
    [alerController addAction:cancelAction];
    [alerController addAction:okAction];
    
    [self.navigationController presentViewController:alerController animated:YES completion:nil];
}

/// 删除所有失效商品
- (void)deleteAllLoseEfficacyCommodity
{
    NSString *GoodId = nil;
    
    if (self.arrLoseEfficacyData.count == 0) {
        return;
    }
    
    __block NSMutableArray *arrEdit = [NSMutableArray array];
    [self.arrLoseEfficacyData enumerateObjectsUsingBlock:^(CartZXNModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dic = @{@"goods_id":obj.goods_id, @"quantity":obj.goods_number};
        [arrEdit addObject:dic];
    }];
    
    GoodId = [ZXNTool getJSONString:arrEdit];
    
    [HTLoadingTool showLoadingStringDontOperation:@"删除中...."];
    
    NSDictionary *dic = @{@"goods_id":GoodId,
                          @"type":@"del"};
    
    [AFHTTPClient POST:@"/cart/modify" params:dic successInfo:^(ResponseModel *response) {
        
        [self.arrLoseEfficacyData removeAllObjects];
        [self.tbMain reloadData];
        [self.tbMain beginRefreshing];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}

#pragma mark - HintViewDelegate
- (void)TapGoShopping
{
    self.vHint.hidden = YES;
}

- (void)TapGoAccount:(CartHintENUM)type
{
    self.vHint.hidden = YES;
    if (type == HT_HaiWai) {
        ConfirmOrder_VC *conVC = [[ConfirmOrder_VC alloc] initWithCartData:self.arrHaiWai twoCartData:self.arrHaiWai BuyType:self.buyTeyp OrderType:JingWai_Order];
        if ([YKSUserDefaults isUserIndividual]) {
            conVC.hidesBottomBarWhenPushed = YES;
        }
        [self.navigationController pushViewController:conVC animated:YES];
    }
    else
    {
        ConfirmOrder_VC *conVC = [[ConfirmOrder_VC alloc] initWithCartData:self.arrGuoNei twoCartData:self.arrGuoNei BuyType:self.buyTeyp OrderType:GuoNei_Order];
        if ([YKSUserDefaults isUserIndividual]) {
            conVC.hidesBottomBarWhenPushed = YES;
        }
        [self.navigationController pushViewController:conVC animated:YES];
    }
}


#pragma mark - HaiWaiHeadDelegate
- (void)tapHaiWaiHead:(BOOL)bSelecte
{
    [self.dicData[@"HaiWai"] enumerateObjectsUsingBlock:^(CartZXNModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.isEdit) {
            obj.isSelectEdit = bSelecte;
        }
        else
        {
            obj.isSelectBuy = bSelecte;
        }
    }];
    
    if (!self.isEdit) {
        [self countAllMoney];
    }
    
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
    [self.tbMain reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - GuoNeiHeadDelegate
- (void)tapGuoNeiHead:(BOOL)bSelecte
{
    [self.dicData[@"GuoNei"] enumerateObjectsUsingBlock:^(CartZXNModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.isEdit) {
            obj.isSelectEdit = bSelecte;
        }
        else
        {
            obj.isSelectBuy = bSelecte;
        }
    }];
    
    if (!self.isEdit) {
        [self countAllMoney];
    }
    
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:1];
    [self.tbMain reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dicData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if ([[self.dicData allKeys] containsObject:@"HaiWai"]) {
            return ((NSMutableArray *)self.dicData[@"HaiWai"]).count;
        }
        else
        {
            return ((NSMutableArray *)self.dicData[@"GuoNei"]).count;
        }
    }
    else
    {
        return ((NSMutableArray *)self.dicData[@"GuoNei"]).count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingCartCell"];
    
    if (cell == nil) {
        cell = [[ShoppingCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShoppingCartCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    
    if (indexPath.section == 0) {
        if ([[self.dicData allKeys] containsObject:@"HaiWai"])
        {
            [cell loadViewModel:((NSMutableArray *)self.dicData[@"HaiWai"])[indexPath.row] Index:indexPath isEdit:self.isEdit];
        }
        else
        {
            [cell loadViewModel:((NSMutableArray *)self.dicData[@"GuoNei"])[indexPath.row] Index:indexPath isEdit:self.isEdit];
        }
    }
    else
    {
        [cell loadViewModel:((NSMutableArray *)self.dicData[@"GuoNei"])[indexPath.row] Index:indexPath isEdit:self.isEdit];
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.dicData.count - 1) {
        return 20;
    }
    else
    {
        return 0.01;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if ([[self.dicData allKeys] containsObject:@"HaiWai"])
        {
            return self.vHaiWaiHead;
        }
        else
        {
            return self.vGuoNeiHead;
        }
    }
    else
    {
        return self.vGuoNeiHead;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.isEdit ? NO : YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

/// 处理删除事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否确认删除" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self settingCartCommodityNumberType:Cart_Del Number:@"0" CellIndex:indexPath];
        }];
        
        [alerController addAction:cancelAction];
        [alerController addAction:okAction];
        
        [self.navigationController presentViewController:alerController animated:YES completion:nil];
        
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CartZXNModel *Model = nil;
    if (indexPath.section == 0) {
        if ([[self.dicData allKeys] containsObject:@"HaiWai"])
        {
            Model = self.dicData[@"HaiWai"][indexPath.row];
        }
        else
        {
            Model = self.dicData[@"GuoNei"][indexPath.row];
        }
    }
    else
    {
        Model = self.dicData[@"GuoNei"][indexPath.row];
    }
    
    CommodityDetails_VC *detail_VC = [[CommodityDetails_VC alloc]initWithSKU:Model.sku];
    detail_VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail_VC animated:YES];
}

#pragma mark - 数据处理
/**
 计算商品总价格 并判断是否Buy的全选是否需要打钩
 */
- (void)countAllMoney
{
    if (self.dicData.count == 0) {
        [self.vFoot updateAllMoney:@"0.00"];
        [self.vFoot isSelectAll:YES];
        return;
    }
    
    __block CGFloat fAllMoney = 0.00;
    __block BOOL bSelectBuy = YES;
    
    for (NSMutableArray *arrDic in self.dicData.allValues) {
        
        [arrDic enumerateObjectsUsingBlock:^(CartZXNModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isSelectBuy) {
                fAllMoney = fAllMoney + [obj.price floatValue] * [obj.goods_number integerValue];
            }
            else
            {
                bSelectBuy = NO;
            }
        }];
    }
    
    [self.vFoot updateAllMoney:[NSString stringWithFormat:@"%0.2f", fAllMoney]];
    [self.vFoot isSelectAll:bSelectBuy];
}



/**
 判断分组头部是否需要打钩

 @param type 分组类型
 @return YES为需要打钩  NO为不需要
 */
- (BOOL)judgeSectionIsTick:(CartHintENUM)type
{
    __block BOOL bSelect = YES;
    if (type == HT_HaiWai) {
        
        [self.dicData[@"HaiWai"] enumerateObjectsUsingBlock:^(CartZXNModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (self.isEdit) {
                if (!obj.isSelectEdit) {
                    bSelect = NO;
                    *stop = YES;
                }
            }
            else
            {
                if (!obj.isSelectBuy) {
                    bSelect = NO;
                    *stop = YES;
                }
            }
        }];
        
    }
    else
    {
        [self.dicData[@"GuoNei"] enumerateObjectsUsingBlock:^(CartZXNModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (self.isEdit) {
                if (!obj.isSelectEdit) {
                    bSelect = NO;
                    *stop = YES;
                }
            }
            else
            {
                if (!obj.isSelectBuy) {
                    bSelect = NO;
                    *stop = YES;
                }
            }
        }];
    }
    
    return bSelect;
}

/**
 将编辑状态下的的所有选中状态改变
 
 @param isSelect YES是选中 NO反之
 */
- (void)resetCartModelIsSelectEdit:(BOOL)isSelect
{
    if (self.dicData.count == 0) {
        return;
    }
    
    for (NSMutableArray *arrData in self.dicData.allValues) {
        [arrData enumerateObjectsUsingBlock:^(CartZXNModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isSelectEdit = isSelect;
            obj.goods_number_edit = obj.goods_number;
        }];
    }
    
    [self.tbMain reloadData];
}


/**
 将购买状态下的所有选中状态改变 并重新将价格赋值给FootView
 
 @param isSelect YES是选中 NO反之
 */
- (void)resetCartModelIsSelectBuy:(BOOL)isSelect
{
    if (self.dicData.count == 0) {
        return;
    }
    
    __block CGFloat fAllMoney = 0.00;
    
    for (NSMutableArray *arrData in self.dicData.allValues) {
        [arrData enumerateObjectsUsingBlock:^(CartZXNModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isSelectBuy = isSelect;
            
            if (isSelect) {
                fAllMoney = fAllMoney + [obj.price floatValue] * [obj.goods_number integerValue];
            }
        }];
    }
    
    if (isSelect) {
        [self.vFoot updateAllMoney:[NSString stringWithFormat:@"%0.2f", fAllMoney]];
    }
    else
    {
        [self.vFoot updateAllMoney:@"0.00"];
    }
    [self.tbMain reloadData];
}


/**
 将选中编辑状态商品遍历出来
 
 @param isDelete YES是指点击了删除按钮 NO是指点击了完成按钮
 @return 如果isDelete是YES 则是由goodsID组成的字符串 如果是NO返回JSON格式的字符串
 */
- (NSString *)combinationCartSeletcEdit:(BOOL)isDelete
{
    if (self.dicData.count == 0) {
        return @"";
    }
    __block NSMutableArray *arrEdit = [NSMutableArray array];
    __block NSMutableString *sGoodsEditID = [NSMutableString string];
    
    for (NSMutableArray *arrData in self.dicData.allValues) {
        [arrData enumerateObjectsUsingBlock:^(CartZXNModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (isDelete)
            {
                if (obj.isSelectEdit) {
                    [sGoodsEditID appendString:[NSString stringWithFormat:@"%@,",obj.goods_id]];
                }
            }
            else
            {
                if (![obj.goods_number isEqualToString:obj.goods_number_edit]) {
                    NSDictionary *dic = @{@"goods_id":obj.goods_id, @"quantity":obj.goods_number_edit};
                    [arrEdit addObject:dic];
                }
            }
        }];
    }
    
    if (isDelete) {
        if (sGoodsEditID.length == 0) {
            return @"";
        }
        [sGoodsEditID deleteCharactersInRange:NSMakeRange([sGoodsEditID length] - 1, 1)];
        return sGoodsEditID;
    }
    else
    {
        return [ZXNTool getJSONString:arrEdit];
    }
}


/**
 获取所有选中的商品
 
 @return 返回一个特定的字典
 */
- (NSMutableDictionary *)combinationCartSeletcBuy
{
    if (self.dicData.count == 0) {
        return nil;
    }
    
    __block NSMutableDictionary *dicGoodID = [NSMutableDictionary dictionary];
    
    if ([[self.dicData allKeys] containsObject:@"HaiWai"]) {
        
        NSMutableArray *arrData = self.dicData[@"HaiWai"];
        NSMutableArray *arr = [NSMutableArray array];
        NSMutableArray *arrSku = [NSMutableArray array];
        [arrData enumerateObjectsUsingBlock:^(CartZXNModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj.isSelectBuy) {
                NSDictionary *dic = @{@"goods_id":obj.goods_id, @"quantity":obj.goods_number_edit};
                [arr addObject:dic];
                
                NSDictionary *dicSku = @{@"sku":obj.sku, @"quantity":obj.goods_number_edit};
                [arrSku addObject:dicSku];
            }
        }];
        if (arr.count > 0 && arrSku.count > 0) {
            [dicGoodID setValue:arr forKey:@"HaiWaiGoodID"];
            [dicGoodID setValue:arrSku forKey:@"HaiWaiGoodSKU"];
        }
    }
    
    if ([[self.dicData allKeys] containsObject:@"GuoNei"]) {
        
        NSMutableArray *arrData = self.dicData[@"GuoNei"];
        NSMutableArray *arr = [NSMutableArray array];
        NSMutableArray *arrSku = [NSMutableArray array];
        [arrData enumerateObjectsUsingBlock:^(CartZXNModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj.isSelectBuy) {
                NSDictionary *dic = @{@"goods_id":obj.goods_id, @"quantity":obj.goods_number_edit};
                [arr addObject:dic];
                
                NSDictionary *dicSku = @{@"sku":obj.sku, @"quantity":obj.goods_number_edit};
                [arrSku addObject:dicSku];
            }
        }];
        
        if (arr.count > 0 && arrSku.count > 0) {
            [dicGoodID setValue:arr forKey:@"GuoNeiGoodID"];
            [dicGoodID setValue:arrSku forKey:@"GuoNeiGoodSKU"];
        }
    }
    
    return dicGoodID;
}





#pragma mark - 懒加载
- (UITableView *)tbMain
{
    if (!_tbMain) {
        _tbMain = [[HTTabbleView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tbMain.delegate = self;
        _tbMain.dataSource = self;
        _tbMain.showsVerticalScrollIndicator = NO;
        _tbMain.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbMain.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    }
    return _tbMain;
}

- (ShoppingCartFoot *)vFoot
{
    if (!_vFoot) {
        _vFoot = [[ShoppingCartFoot alloc] init];
        _vFoot.backgroundColor = [UIColor whiteColor];
        _vFoot.delegate = self;
    }
    return _vFoot;
}

- (UIActivityIndicatorView *)activityView
{
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.frame = CGRectMake(kDisWidth/2 - 10, kDisHeight/2 - 10, 20, 20);
        //当旋转结束时隐藏
        [_activityView setHidesWhenStopped:YES];
    }
    return _activityView;
}

- (BlankPageView *)vBlankView
{
    if (!_vBlankView) {
        _vBlankView = [[BlankPageView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, kDisHeight - 113)];
        _vBlankView.image = [UIImage imageNamed:@"No_Car_Commodity"];
        _vBlankView.title = @"购物车是空哒~快去买买买\n\n登录后可同步购物车";
        _vBlankView.hidden = YES;
    }
    return _vBlankView;
}

- (LoseEfficacyView *)vLoseEfficacy
{
    if (!_vLoseEfficacy) {
        _vLoseEfficacy = [[LoseEfficacyView alloc] init];
        _vLoseEfficacy.delegate = self;
    }
    return _vLoseEfficacy;
}


- (UIWindow *)HTWindow
{
    if (!_HTWindow) {
        _HTWindow = [UIApplication sharedApplication].keyWindow;
    }
    return _HTWindow;
}

- (HintView *)vHint
{
    if (!_vHint) {
        _vHint = [[HintView alloc] init];
        _vHint.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _vHint.delegate = self;
    }
    return _vHint;
}


- (HaiWaiHeadView *)vHaiWaiHead
{
    if (!_vHaiWaiHead) {
        _vHaiWaiHead = [[HaiWaiHeadView alloc] init];
        _vHaiWaiHead.delegate = self;
    }
    return _vHaiWaiHead;
}


- (GuoNeiHeadView *)vGuoNeiHead
{
    if (!_vGuoNeiHead) {
        _vGuoNeiHead = [[GuoNeiHeadView alloc] init];
        _vGuoNeiHead.delegate = self;
    }
    return _vGuoNeiHead;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
