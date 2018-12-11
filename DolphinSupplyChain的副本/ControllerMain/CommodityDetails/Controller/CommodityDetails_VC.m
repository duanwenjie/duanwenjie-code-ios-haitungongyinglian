//
//  CommodityDetails_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/3.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "CommodityDetails_VC.h"
#import <WebKit/WebKit.h>

#import "DetailsScrollView.h"
#import "TextScrollView.h"

#import "FootView.h"
#import "ImageAndTextView.h"
#import "DownImageView.h"

#import "CommodityDetailsModel.h"
#import "CommodityImageModel.h"
#import "CommodityRecommendModel.h"

#import "CommodityDetailsBll.h"

#import "ShowCommodityQuality_VC.h"
#import "ContactServiceViewController.h"
#import "ShopingCart_VC.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "C_TabBarController.h"
#import "ShareTool.h"
#import "VerificationString.h"

#import "HTFMDBTool.h"

@interface CommodityDetails_VC () <UIScrollViewDelegate, DetailsDelegate,  CommodityFootDelegate, ImageAndTextDelegate>

@property (nonatomic, copy) NSString *sSku;

@property (nonatomic, strong) DetailsScrollView *scrDetails;

@property (nonatomic, strong) UIScrollView *scrImageAndText;

@property (nonatomic, strong) WKWebView *wbImage;

@property (nonatomic, strong) TextScrollView *scrText;

@property (nonatomic, strong) FootView *vFoot;

@property (nonatomic, strong) ImageAndTextView *vImageAndText;

@property (nonatomic, strong) UIButton *btnDown;

@property (nonatomic, assign) BOOL bUpAnimation;

@property (nonatomic, assign) BOOL bDownAnimation;

/// 默认商品商品详情
@property (nonatomic, strong) CommodityDetailsModel *mDFLCommodityDetail;

/// 该商品其他SKU详情数组
@property (nonatomic, copy) NSMutableArray *arrCommodityDetail;

/// 推荐商品
@property (nonatomic, copy) NSMutableArray *arrRecommendCommodity;

/// 商品详情Web Html
@property (nonatomic, copy) NSString *sHTML;

/// 加入购物车数量
@property (nonatomic, assign) NSInteger iNumber;

/// 缺货通知邮箱
@property (nonatomic, copy) NSString *sUserEmaill;

@end

@implementation CommodityDetails_VC


- (instancetype)initWithSKU:(NSString *)sSKU
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.bUpAnimation = NO;
        self.bDownAnimation = NO;
        self.sSku = sSKU;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initAddView];
    [self loadData];
    [self loadCartBadgeData];
}

#pragma mark - 添加控件
- (void)initAddView
{
    [self.view addSubview:self.scrDetails];
    
    [self.view addSubview:self.vImageAndText];
    
    [self.view addSubview:self.scrImageAndText];
    [self.scrImageAndText addSubview:self.wbImage];
    [self.scrImageAndText addSubview:self.scrText];
    
    [self.view addSubview:self.btnDown];
    
    [self.view addSubview:self.vFoot];
    
    [self addNavigationType:YKS_Left_Title_RightOne_RightTwo NavigationTitle:@"商品详情"];
    [self.btnRigthOne setImage:[UIImage imageNamed:@"Commodity_Share"] forState:UIControlStateNormal];
    [self.btnRigthTwo setImage:[UIImage imageNamed:@"Commodity_Home"] forState:UIControlStateNormal];
}

#pragma mark - 请求商品信息数据
- (void)loadData
{
    [HTLoadingTool showLoadingDontOperation];
    
    NSDictionary *dic = @{@"sku":self.sSku,
                          @"description":@"1",
                          @"gallery":@"1",
                          @"standard":@"1",
                          @"extension":@"1",
                          @"brand_sku":@"1",
                          @"type":@"ios"};
    
    [AFHTTPClient POST:@"/goods/getGoodsInfo" params:dic successInfo:^(ResponseModel *response) {
        
        
        NSMutableDictionary *dic = [CommodityDetailsBll gainCommodityDetails:response.dataResponse];
        self.arrCommodityDetail = dic[@"Extension"];
        self.mDFLCommodityDetail = dic[@"DFLModel"];
        self.arrRecommendCommodity = dic[@"Recommend"];
        self.sHTML = dic[@"HTML"];
        
        self.iNumber = [self.mDFLCommodityDetail.min_purchase_quantity integerValue];
        
        [self.scrDetails loadData:self.mDFLCommodityDetail number:self.mDFLCommodityDetail.min_purchase_quantity.integerValue];
        [self.scrDetails loadDataRecommend:self.arrCommodityDetail];
        [self.scrText loadTextData:self.mDFLCommodityDetail.arrAttribute];
        
        [self.vFoot changeCollect:[self.mDFLCommodityDetail.is_collect isEqualToString:@"0"] ? NO : YES];
        
        if ([self.mDFLCommodityDetail.stock isEqualToString:@"0"]) {
            [self.vFoot changeAddShoppingCart:NO];
        }
        else
        {
            [self.vFoot changeAddShoppingCart:YES];
        }
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == NO_NETWORK || type == SERVICE_ERROR)
        {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            return ;
        }
    }];

}

#pragma mark - 请求购物车数量
- (void)loadCartBadgeData
{
    if ([YKSUserDefaults isLogin])
    {
        NSDictionary *dic = nil;
        
        [AFHTTPClient POSTNODismiss:@"/cart/getTotal" params:dic successInfo:^(ResponseModel *response) {
            
            [self.vFoot changeShoppingCartNumber:response.dataResponse];
            [YKSUserDefaults storeCartNumber:(NSString *)response.dataResponse];
            
        } flaseInfo:^(ResponseModel *response, HTTPType type) {
            
            if (type == NEED_HINT || type == NO_NETWORK || type == SERVICE_ERROR)
            {
                [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
                return ;
            }
        }];
    }
}

#pragma mark - 获取最近一次用户通知的邮箱
- (void)getUserEmaill
{
    if (self.sUserEmaill.length != 0) {
        [self presentStockRegistration];
        return;
    }
    [HTLoadingTool showLoadingDontOperation];
    
    [AFHTTPClient POST:@"/User/getLastSkuArrivalEmail" params:nil successInfo:^(ResponseModel *response) {
        
        self.sUserEmaill = [response.dataResponse objectForKey:@"email"];
        [self presentStockRegistration];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        if (type == NEED_HINT || type == NO_NETWORK || type == SERVICE_ERROR)
        {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
    }];
}


#pragma mark --跳转缺货登记
- (void)presentStockRegistration
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"缺货登记"
                                message:@"若该商品到货，海豚会第一时间通知您！"
                                preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        if (self.sUserEmaill.length != 0) {
            textField.placeholder = self.sUserEmaill;
        }else{
            textField.placeholder = @"请输入接收通知的邮箱地址";
        }
        [textField addTarget:self action:@selector(textFieldsValueDidChange:) forControlEvents:UIControlEventEditingChanged];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.sUserEmaill = @"";
    }];
    [alert addAction:cancelAction];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        BOOL isTure = [VerificationString Verify_Email:self.sUserEmaill];
        if (!isTure) {
            [self.view makeToast:@"请输入正确的邮箱" duration:1.0 position:CSToastPositionCenter];
            self.sUserEmaill = @"";
        }
        else
        {
            [HTLoadingTool showLoadingForView:self.view Hint:@"缺货登记中..."];
            NSDictionary * dict = @{@"email":self.sUserEmaill,
                                    @"sku":self.mDFLCommodityDetail.sku};
            
            [AFHTTPClient POST:@"/Goods/arrivalNotify" params:dict successInfo:^(ResponseModel *response) {
                
            } flaseInfo:^(ResponseModel *response, HTTPType type) {
                [HTLoadingTool disMissForView];
                if (type == NEED_HINT || type == NO_NETWORK || type == SERVICE_ERROR)
                {
                    [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
                    return ;
                }
            }];
        }
        
        
    }];
    [alert addAction:OKAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)textFieldsValueDidChange:(UITextField *)textField
{
    self.sUserEmaill = textField.text;
}


#pragma mark - 点击向上事件
- (void)tapDown
{
    self.btnDown.hidden = YES;
    [UIView animateWithDuration:0.4 animations:^{
        self.scrDetails.frame = CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight - kDisNavgation - 43);
        self.vImageAndText.frame = CGRectMake(0, kDisHeight - 43+KBottomSuit, kDisWidth, 40);
        self.scrImageAndText.frame = CGRectMake(0, kDisHeight - 43+KBottomSuit + 40, kDisWidth, kDisHeight - kDisNavgation - 40 - 43);
    } completion:^(BOOL finished) {
        self.bDownAnimation = NO;
        [self.scrImageAndText setContentOffset:CGPointMake(0, 0) animated:NO];
    }];
}

#pragma mark - 分享
- (void)tapRightOne
{
    ZXNImageView *imageView = [[ZXNImageView alloc]initWithFrame:CGRectZero];
    [imageView downloadImage:self.mDFLCommodityDetail.img_original backgroundImage:ZXNImageDefaul];
    UIImage * img = imageView.image;
    [ShareTool shareHaiTunCommodity:self.mDFLCommodityDetail.sku Title:self.mDFLCommodityDetail.goods_name Image:img];
}

#pragma mark - 回首页
- (void)tapRightTwo
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    C_TabBarController *rootViewController = (C_TabBarController *)appDelegate.window.rootViewController;
    rootViewController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - DetailsDelegate
#pragma mark 点击了商品展示图
- (void)presentShowCommodityImage:(NSArray *)arrImageData index:(NSInteger)iIndex
{
    
}

#pragma mark 点击了商品选择属性
- (void)presentShowCommodityQuality:(NSString *)sQualityID
{
    if (self.arrCommodityDetail.count == 0) {
        return;
    }
    
    WS(weakSelf);
    ShowCommodityQuality_VC *qualityVC = [[ShowCommodityQuality_VC alloc] initWithData:self.arrCommodityDetail TrueQuality:self.mDFLCommodityDetail.sku block:^(CommodityDetailsModel *model, NSInteger number, BOOL isAddCart) {
        
        weakSelf.mDFLCommodityDetail = model;
        
        [weakSelf.scrDetails loadData:weakSelf.mDFLCommodityDetail number:number];
        
        [weakSelf.scrDetails loadDataRecommend:weakSelf.arrCommodityDetail];
        [weakSelf.scrText loadTextData:weakSelf.mDFLCommodityDetail.arrAttribute];
        
        if ([weakSelf.mDFLCommodityDetail.stock isEqualToString:@"0"]) {
            [weakSelf.vFoot changeAddShoppingCart:NO];
        }
        else
        {
            [weakSelf.vFoot changeAddShoppingCart:YES];
        }
        
        weakSelf.iNumber = number;
        if (isAddCart) {
            [weakSelf touchAddShoppingCart:YES];
        }
    }];
    qualityVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    qualityVC.providesPresentationContextTransitionStyle = YES;
    qualityVC.definesPresentationContext = YES;
    qualityVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    qualityVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController presentViewController:qualityVC animated:NO completion:nil];
}

#pragma mark 跳转其他商品界面
- (void)pusCommodityViewController:(NSString *)sSKU
{
    CommodityDetails_VC *vc = [[CommodityDetails_VC alloc] initWithSKU:sSKU];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - CommodityFootDelegate
#pragma mark 客服
- (void)touchService
{
    ContactServiceViewController *ContactServiceVC = [[ContactServiceViewController alloc] init];
    [self.navigationController pushViewController:ContactServiceVC animated:YES];
}

#pragma mark 收藏
- (void)touchCollect:(BOOL)isCollect
{
    
    if (![YKSUserDefaults isLogin])
    {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        return;
    }
    
    NSString *sURL = nil;
    if (isCollect) {
        [HTLoadingTool showLoadingForView:self.view Hint:@"加入收藏中..."];
        sURL = @"/CollectGoods/setSelfCollectGoods";
    }
    else
    {
        [HTLoadingTool showLoadingForView:self.view Hint:@"取消收藏中..."];
        sURL = @"/CollectGoods/delSelfCollectGoods";
    }
    
    NSDictionary *dic = @{@"goods_id" : self.mDFLCommodityDetail.goods_id};
    
    [AFHTTPClient POST:sURL params:dic successInfo:^(ResponseModel *response) {
        
        if (isCollect) {
            [self.view makeToast:@"收藏成功" duration:1.0 position:CSToastPositionCenter];
            [self.vFoot changeCollect:YES];
        }
        else
        {
            [self.view makeToast:@"已取消" duration:1.0 position:CSToastPositionCenter];
            [self.vFoot changeCollect:NO];
        }
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == NO_NETWORK || type == SERVICE_ERROR)
        {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            return ;
        }
    }];
}

#pragma mark 购物车
- (void)touchShoppingCart
{
    if ([YKSUserDefaults isLogin]) {
        ShopingCart_VC *shopCartVC = [[ShopingCart_VC alloc] init];
        shopCartVC.bBottom = YES;
        [self.navigationController pushViewController:shopCartVC animated:YES];
    }else{
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

#pragma mark 加入购物车
- (void)touchAddShoppingCart:(BOOL)isAddCart
{
    if (!isAddCart) { // 无库存 执行缺货登记
        [self getUserEmaill];
        return;
    }
    
    [self promptMessage];
    
}


#pragma mark - 执行风控提示
-(void)promptMessage{

    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"消费者告知书" message:@"尊敬的客户：\n\t\t您好！\n\t\t在您选购境外商品前，请您仔细阅读此文，同意以下所告知内容后再进行下单购买：\n\t1、您在本（公司）网站上购买的境外商品为产地直销商品，我司承诺保证质量安全，但仅限个人自用不得进行销售，商品本身可能无中文标签，您可以查看网站的翻译或在线联系我们的客服。\n\t2、您购买的境外商品适用的品质、健康、标识等项目适用标准或与我国标准有所不同，可能不符合我国《食品安全法》的标准,所以在使用过程中由此可能产生的危害或损失以及其他风险，将由您个人承担。\n\t3、本商品为跨境贸易电子商务进口商品，根据海关法和国家相关政策规定，依据中华人民共和国海关总署2016年第26号文件，以及海关总署，财政部和税务总局《于关于跨境电子商务零售进口税收政策的通知》等相关文件要求，以个人名义购买的商品应以“个人自用、合理数量”为原则，跨境电子商务零售进口商品的单次交易限值为人民币2000元，个人年度交易限值为人民币20000元。在限值以内进口的跨境电子商务零售进口商品，关税税率暂设为0%；进口环节增值税、消费税取消免征税额，暂按法定应纳税额的70%征收。超过单次限值、累加后超过个人年度限值的单次交易，以及完税价格超过2000元限值的单个不可分割商品，均按照一般贸易方式全额征税。\n\t4、个人消费者在本网站购买进境商品的，应当提供收件人真实姓名和身份证号码，同意委托本电商企业或其代理企业代表收件人向海关办理通关申报和税款缴纳手续。个人消费者需正确填写订单信息，禁止虚假信息，购买商品需符合个人自用合理数量，禁止二次销售。若个人消费者购买商品超出个人自用原则，将受到执法部门核查，情节严重者，将依法追究刑事责任。\n\n\t\t\t\t\t海豚供应链" preferredStyle:UIAlertControllerStyleAlert];
    //适配iOS12
    float floatString = [[[UIDevice currentDevice] systemVersion] floatValue];
    UIView *subView1 = alert.view.subviews[0];
    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
    UILabel *message = [[UILabel alloc]init];
    if (floatString < 12){
        message = subView5.subviews[1];
    }else{
        message = subView5.subviews[2];
    }
    message.textAlignment = NSTextAlignmentLeft;
    
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"我清楚了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        if ([YKSUserDefaults isLogin])
        {
            if (self.mDFLCommodityDetail.stock.integerValue >= self.iNumber) {
                
                [HTLoadingTool showLoadingForView:self.view Hint:@"添加到购物车中..."];
                NSDictionary *dic = @{@"goods_id":self.mDFLCommodityDetail.goods_id,
                                      @"number":[NSString stringWithFormat:@"%zd",self.iNumber],
                                      @"type":@"add"};
                
                [AFHTTPClient POST:@"/cart/modify" params:dic successInfo:^(ResponseModel *response) {
                    
                    [self.view makeToast:@"加入购物车成功" duration:1.0 position:CSToastPositionCenter];
                    [self loadCartBadgeData];
                    
                } flaseInfo:^(ResponseModel *response, HTTPType type) {
                    [HTLoadingTool  disMissForView];
                    if (type == NEED_HINT || type == NO_NETWORK || type == SERVICE_ERROR)
                    {
                        [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
                        return ;
                    }
                }];
                
            }
            else
            {
                [self.view makeToast:@"库存不足，添加购物车失败！" duration:1.0 position:CSToastPositionCenter];
            }
        }
        else
        {
            
            HTFMDBTool *db = [HTFMDBTool shareInstance];
            
            NSString *sSQL = [NSString stringWithFormat:@"insert into cart_tb (sImage, sName, sMoney, sNumber, sSku, sCommodityID, sMinPurchase, sModulo) values ('%@', '%@', '%@', '%zd', '%@', '%@', '%@', '%@')", self.mDFLCommodityDetail.img_thumb, self.mDFLCommodityDetail.goods_name, self.mDFLCommodityDetail.price, self.iNumber, self.mDFLCommodityDetail.sku, self.mDFLCommodityDetail.goods_id, self.mDFLCommodityDetail.min_purchase_quantity, self.mDFLCommodityDetail.is_modulo];
            
            [db execSQL:sSQL withBlock:^(BOOL bRet) {
                [self.view makeToast:@"加入购物车成功" duration:1.0 position:CSToastPositionCenter];
            }];        
        }
    }];
    
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - ImageAndTextDelegate
#pragma mark 切换图文详情 与 商品属性
- (void)changeImageAndTextScrollView:(BOOL)bImage
{
    [self.scrImageAndText setContentOffset:CGPointMake(bImage ? 0 : kDisWidth, 0) animated:NO];
}


#pragma mark - UIScrollViewDelegate
#pragma mark ScrollView滚动 拖、拉、放大、缩小等
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 100)
    {
        scrollView.contentOffset.y > (kDisHeight * 0.5 - kDisHeight + 687) ? (self.bUpAnimation = YES) : (self.bUpAnimation = NO);
    }
    
    if (scrollView.tag == 300 || scrollView.tag == 400) {
        
        scrollView.contentOffset.y < -100 ? (self.bDownAnimation = YES) : (self.bDownAnimation = NO);
    }
}

#pragma mark 已经结束拖拽
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.tag == 100)
    {
        if (self.bUpAnimation)
        {
            [UIView animateWithDuration:0.4 animations:^{
                self.scrDetails.frame = CGRectMake(0, -(kDisHeight - kDisNavgation - 43 - kDisNavgation), kDisWidth, kDisHeight - kDisNavgation - 43-KBottom);
                self.vImageAndText.frame = CGRectMake(0, kDisNavgation, kDisWidth, 40);
                self.scrImageAndText.frame = CGRectMake(0, kDisNavgation + 40, kDisWidth, kDisHeight - kDisNavgation - 40 - 43-KBottom);
            } completion:^(BOOL finished) {
                self.bUpAnimation = NO;
                self.btnDown.hidden = NO;
                
                [self.wbImage loadHTMLString:self.sHTML baseURL:nil];
            }];
        }
    }
    
    if (scrollView.tag == 300 || scrollView.tag == 400)
    {
        if (self.bDownAnimation) {
            self.btnDown.hidden = YES;
            [UIView animateWithDuration:0.4 animations:^{
                self.scrDetails.frame = CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight - kDisNavgation - 43-KBottom);
                self.vImageAndText.frame = CGRectMake(0, kDisHeight - 43+KBottomSuit, kDisWidth, 40);
                self.scrImageAndText.frame = CGRectMake(0, kDisHeight - 43+KBottomSuit + 40, kDisWidth, kDisHeight - kDisNavgation - 40 - 43-KBottom);
            } completion:^(BOOL finished) {
                self.bDownAnimation = NO;
                [self.scrImageAndText setContentOffset:CGPointMake(0, 0) animated:NO];
                [self.vImageAndText changeImageAndTextShow:YES];
            }];
        }
    }
}

#pragma mark scrollView已经停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 200) {
        if (scrollView.contentOffset.x == kDisWidth)
        {
            [self.vImageAndText changeImageAndTextShow:NO];
        }
        else
        {
            [self.vImageAndText changeImageAndTextShow:YES];
        }
    }
}








#pragma mark - 懒加载
- (DetailsScrollView *)scrDetails
{
    if (!_scrDetails) {
        _scrDetails = [[DetailsScrollView alloc] initWithDetailsScroll];
        _scrDetails.frame = CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight - kDisNavgation - 43-KBottom);
        _scrDetails.delegate = self;
        _scrDetails.delegateDetails = self;
        _scrDetails.showsVerticalScrollIndicator = NO;
        _scrDetails.tag = 100;
    }
    return _scrDetails;
}

- (UIScrollView *)scrImageAndText
{
    if (!_scrImageAndText) {
        _scrImageAndText = [[UIScrollView alloc] init];
        _scrImageAndText.frame = CGRectMake(0, kDisHeight - 43-KBottom + 40, kDisWidth, kDisHeight - kDisNavgation - 40 - 43-KBottom);
        _scrImageAndText.tag = 200;
        _scrImageAndText.contentSize = CGSizeMake(kDisWidth*2, kDisHeight - kDisNavgation - 43 - 40);
        _scrImageAndText.showsHorizontalScrollIndicator = NO;
        _scrImageAndText.pagingEnabled = YES;
        _scrImageAndText.bounces = NO;
        _scrImageAndText.delegate = self;
        _scrImageAndText.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    }
    return _scrImageAndText;
}

- (ImageAndTextView *)vImageAndText
{
    if (!_vImageAndText) {
        _vImageAndText = [[ImageAndTextView alloc] init];
        _vImageAndText.backgroundColor = [UIColor whiteColor];
        _vImageAndText.frame = CGRectMake(0, kDisHeight - 43-KBottom, kDisWidth, 40);
        _vImageAndText.delegate = self;
    }
    return _vImageAndText;
}

- (WKWebView *)wbImage
{
    if (!_wbImage) {
        _wbImage = [[WKWebView alloc] init];
        _wbImage.scrollView.tag = 300;
        _wbImage.frame = CGRectMake(0, 0, kDisWidth, kDisHeight - kDisNavgation - 43 - 40-KBottom);
        _wbImage.scrollView.delegate = self;
        _wbImage.scrollView.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        _wbImage.scrollView.showsVerticalScrollIndicator = NO;
        
        DownImageView *vDownImage = [[DownImageView alloc] initWithFrame:CGRectMake(0, -40, kDisWidth, 40)];
        [_wbImage.scrollView addSubview:vDownImage];
    }
    return _wbImage;
}

- (TextScrollView *)scrText
{
    if (!_scrText) {
        _scrText = [[TextScrollView alloc] init];
        _scrText.frame = CGRectMake(kDisWidth, 0, kDisWidth, kDisHeight - kDisNavgation - 43 - 40);
        _scrText.showsVerticalScrollIndicator = NO;
        _scrText.tag = 400;
        _scrText.delegate = self;
        _scrText.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    }
    return _scrText;
}

- (UIButton *)btnDown
{
    if (!_btnDown) {
        _btnDown = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnDown.frame = CGRectMake(kDisWidth - 45, kDisHeight - 43-KBottom - 50, 30, 30);
        _btnDown.hidden = YES;
        [_btnDown setImage:[UIImage imageNamed:@"New_Home_Top_Up"] forState:UIControlStateNormal];
        [_btnDown addTarget:self action:@selector(tapDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDown;
}

- (FootView *)vFoot
{
    if (!_vFoot) {
        _vFoot = [[FootView alloc] initWithFootView];
        _vFoot.frame = CGRectMake(0, kDisHeight - 43-KBottom, kDisWidth, 43);
        _vFoot.backgroundColor = [UIColor whiteColor];
        _vFoot.delegate = self;
    }
    return _vFoot;
}

- (void)dealloc
{
    self.scrDetails.delegateDetails = nil;
    self.scrDetails.delegate = nil;
    self.scrImageAndText.delegate = nil;
    self.wbImage.scrollView.delegate = nil;
    self.scrText.delegate = nil;
    self.vFoot.delegate = nil;
    self.vImageAndText.delegate = nil;
    self.btnDown = nil;
    self.mDFLCommodityDetail = nil;
    self.arrCommodityDetail = nil;
    self.arrRecommendCommodity = nil;
    self.sHTML = nil;
    
    self.scrDetails = nil;
    self.scrDetails = nil;
    self.scrImageAndText = nil;
    self.wbImage = nil;
    self.scrText = nil;
    self.vFoot = nil;
    self.vImageAndText = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
