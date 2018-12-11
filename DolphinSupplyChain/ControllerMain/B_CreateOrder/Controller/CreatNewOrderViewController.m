//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "CreatNewOrderViewController.h"
#import "ConsigneeView.h"
#import "GetGoodsViewController.h"
#import "GoodsAddModel.h"
#import "ContactServiceViewController.h"
#import "AppDelegate.h"
#import "C_TabBarController.h"
#import "FoundOrEditView.h"
#import "BackScrollView.h"
#import "PhoneText.h"
#import "SelectDistrict_VC.h"
#import "VerificationString.h"
#import "ZXNTool.h"
#import "SuspendView.h"
#import "GoodsExtentionViewController.h"
#import "ChangeOrderViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "GoodsExtentionModel.h"
#import "GoodsExtentionView.h"
#import "B_OrderViewController.h"


static NSString * const KFieldTextDidChangeNotification = @"UITextFieldTextDidChangeNotification";

static NSString * const kOrderSubmitURL = @"/SalesOrder/createSalesOrder";

static CGFloat  const tableHeight = 75;

static CGFloat  const textFieldHeight = 40;

static CGFloat  const kSpecLeft = 10;

NSString *const YKSAllSellOrderCount=@"YKSAllSellOrderCount";

NSString *const YKSShortageSellOrderCount=@"YKSShortageSellOrderCount";

NSString *const YKSDeliveGoodsSellOrderCount=@"YKSDeliveGoodsSellOrderCount";

@interface CreatNewOrderViewController ()<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,FoundOrEditDelegate,UITableViewDataSource,UITableViewDelegate,GetGoodsViewControllerDelegate,UIAlertViewDelegate,UIScrollViewDelegate,GoodsExtentionViewControllerDelegate,GoodsExtentionViewDelegate>
{
    
    BackScrollView *backView;
    FrameView      *fram1;
    
    UITextField    *order_id;
    UILabel        *time_lab;
    
    NSString       *shopStr;
    NSString       *nameStr;
    
    ConsigneeView  *consigneeView;
    UILabel        *lab33;
    
    ConsigneeView *identityView;
    
    NSDictionary   *address_dict;
    
    HTTabbleView    *table;
    UIButton       *addProduct;
    
    NSMutableArray *productList;
    NSInteger      index;
    
    NSString       *consignee;
    NSString       *mobile;
    NSString       *province;
    NSString       *city;
    NSString       *district;
    NSString       *saddress;
    NSString       *sidentity;
    NSString       *create_from_platform;
    UIButton       *submitBtn;
    
    UIAlertView    *alert1;
    UIAlertView    *alert2;
    
    NSNumber      *memberID;
    
    NSMutableArray *consigneeList;
    
    NSString *platType;
    NSString *platformNum;
    NSString *platName;
    NSString *platIdentity;
    
    UILabel *platInfoLab;
    UIButton *platInfoBtn;
    UIButton * quickBtn;
    UIButton * quickBtn2;
    
    
    //新增加的界面属性
    UITextField    *name;
    PhoneText    *phoneNum;
    UILabel        *areaText;
    UITextView     *address;
    UITextField    *identity;
    
    NSString       *provinceStr;
    NSString       *cityStr;
    NSString       *districtStr;
    UITextView     *labb_lab;//留言
    
    
    UIView         *cover;//蒙版
    SuspendView    *suspendView;
    NSInteger          integer;
}

@property (nonatomic ,strong)NSDictionary *consigneeDict;

@property (nonatomic, strong) FoundOrEditView *vFoundOrEdit;

@property (nonatomic, copy) NSString *sProvinceID;

@property (nonatomic, copy) NSString *sCityID;

@property (nonatomic, copy) NSString *sAreaID;

@property (nonatomic ,copy)NSString * dataType;

@property (nonatomic ,strong) UIView * vBjView ;

@property (nonatomic ,strong)NSMutableArray * arrMData;

@property (nonatomic ,strong)GoodsAddModel * model;

@property (nonatomic ,strong)UIButton * barRightOneItem;

@property (nonatomic ,assign)NSInteger * numberInteger;

@property (nonatomic ,strong)UIView * vSubView;

@property (nonatomic ,strong)GoodsExtentionView * goodsExtentionView;
@end

@implementation CreatNewOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"＋销售订单";
    
    platType = @"";
    platName = @"";
    platIdentity = @"";
    platformNum = @"";
    
    backView = [[BackScrollView alloc] initWithFrame:CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight)];
    backView.contentSize = CGSizeMake(kDisWidth, kDisHeight);
    backView.showsVerticalScrollIndicator = NO;
    backView.delegate = self;
    backView.backgroundColor = color(239, 239, 244, 1.0);
    [self.view addSubview:backView];
    
    UIView *orderView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kDisWidth, textFieldHeight)];
    orderView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:orderView];
    
    order_id = [[UITextField alloc] initWithFrame:CGRectMake(kSpecLeft, 0, kDisWidth-15.0, textFieldHeight)];
    order_id.backgroundColor = [UIColor whiteColor];
    order_id.font = [UIFont systemFontOfSize:14.0f];
    order_id.placeholder = @"请输入一个6-20位字母或者数字组成的订单号";
    order_id.delegate=self;
    [order_id setClearButtonMode:UITextFieldViewModeWhileEditing];
    order_id.textColor = [UIColor colorWithHexString:@"#999999"];
    [orderView addSubview:order_id];
    
    UILabel *labZ = [[UILabel alloc] initWithFrame:CGRectMake(kSpecLeft, orderView.bottom + 3, kDisWidth, 20)];
    labZ.text = @"请填写您店铺的订单号，也可以创建一个订单号";
    labZ.font = [UIFont systemFontOfSize:11.0f];
    labZ.textColor = [UIColor colorWithHexString:@"#666666"];
    [backView addSubview:labZ];
    
    
    //    收货信息
    UILabel * lab22 = [[UILabel alloc] initWithFrame:CGRectMake(10, labZ.bottom +5, 100, 20)];
    lab22.text = @"收货信息";
    lab22.font = [UIFont systemFontOfSize:12.0f];
    [backView addSubview:lab22];
    
    FrameView *fram2 = [[FrameView alloc] initWithFrame:CGRectMake(-2, lab22.bottom+5, kDisWidth+4 , 300)];
    [fram2 setIndex:6];
    fram2.backgroundColor=[UIColor whiteColor];
    [backView addSubview:fram2];
    
    CGFloat lblWidth=65.0;
    CGFloat height=50;
    CGFloat textWidth=fram2.width-85;
    
    UILabel *nameLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, lblWidth, height)];
    nameLB.text = @"姓       名";
    nameLB.font = [UIFont systemFontOfSize:14.0f];
    [fram2 addSubview:nameLB];
    
    name = [[UITextField alloc] initWithFrame:CGRectMake(nameLB.right, 0, textWidth, height)];
    name.delegate = self;
    name.returnKeyType=UIReturnKeyDone;
    name.clearButtonMode=UITextFieldViewModeWhileEditing;
    name.font = [UIFont systemFontOfSize:14.0f];
    name.textColor = [UIColor colorWithHexString:@"#666666"];
    name.placeholder = @"收货人姓名";
    [fram2 addSubview:name];
    
    UILabel *identityLab = [[UILabel alloc] initWithFrame:CGRectMake(10, nameLB.bottom , lblWidth, height)];
    identityLab.text = @"身份证号";
    identityLab.font = [UIFont systemFontOfSize:14.0f];
    [fram2 addSubview:identityLab];
    
    identity = [[UITextField alloc] initWithFrame:CGRectMake(identityLab.right, identityLab.top, textWidth, height)];
    identity.delegate = self;
    identity.returnKeyType = UIReturnKeyDone;
    identity.clearButtonMode = UITextFieldViewModeWhileEditing;
    identity.font = [UIFont systemFontOfSize:14.0f];
    identity.textColor = [UIColor colorWithHexString:@"#666666"];
    identity.placeholder = @"身份证号码";
    [fram2 addSubview:identity];
    
    UILabel *phoneLB = [[UILabel alloc] initWithFrame:CGRectMake(10, identityLab.bottom, lblWidth, height)];
    phoneLB.text = @"手机号码";
    phoneLB.font = [UIFont systemFontOfSize:14.0f];
    [fram2 addSubview:phoneLB];
    
    phoneNum = [[PhoneText alloc] initWithFrame:CGRectMake(phoneLB.right, identityLab.bottom, textWidth, height)];
    phoneNum.delegate = self;
    phoneNum.clearButtonMode=UITextFieldViewModeWhileEditing;
    phoneNum.font = [UIFont systemFontOfSize:14.0f];
    phoneNum.textColor = [UIColor colorWithHexString:@"#666666"];
    phoneNum.placeholder = @"手机或联系电话";
    [fram2 addSubview:phoneNum];
    
    UILabel *areaLB = [[UILabel alloc] initWithFrame:CGRectMake(10, phoneLB.bottom, lblWidth, height)];
    areaLB.text = @"所在地区";
    areaLB.font = [UIFont systemFontOfSize:14.0f];
    [fram2 addSubview:areaLB];
    
    //箭头
    UIImageView * vImagView = [[UIImageView alloc]init];
    vImagView.image = [UIImage imageNamed:@"skip"];
    vImagView.frame = CGRectMake(kDisWidth-20, phoneLB.bottom+17, 10, 10);
    [fram2 addSubview:vImagView];
    
    areaText = [[UILabel alloc] initWithFrame:CGRectMake(areaLB.right, phoneLB.bottom, textWidth, height)];
    areaText.text = @"选择省市区";
    areaText.userInteractionEnabled=YES;
    areaText.font = [UIFont systemFontOfSize:14.0f];
    areaText.textColor = [UIColor colorWithHexString:@"#666666"];
    [fram2 addSubview:areaText];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseArea)];
    [areaText addGestureRecognizer:tap];
    
    UILabel * addressLB = [[UILabel alloc] initWithFrame:CGRectMake(10, areaLB.bottom-8, lblWidth, height+8)];
    addressLB.text = @"详细地址";
    addressLB.font = [UIFont systemFontOfSize:14.0f];
    [fram2 addSubview:addressLB];

    address = [[UITextView alloc] initWithFrame:CGRectMake(addressLB.right-5, areaLB.bottom+2, textWidth, height-2)];
    address.delegate = self;
    address.returnKeyType=UIReturnKeyDone;
    address.font=[UIFont systemFontOfSize:14.0];
    address.textColor = [UIColor colorWithHexString:@"#c7c7cd"];
    address.showsVerticalScrollIndicator = NO;
    address.showsHorizontalScrollIndicator = NO;
    address.alwaysBounceVertical = NO;
    address.alwaysBounceHorizontal = NO;
    address.text = @"不需要重复填写省市区，大于5个字符，小于120个字符";
    [fram2 addSubview:address];
    

    UILabel *labb = [[UILabel alloc] initWithFrame:CGRectMake(10, addressLB.bottom,lblWidth, height)];
    labb.text = @"留       言";
    labb.font = [UIFont systemFontOfSize:14.0f];
    labb.textAlignment = NSTextAlignmentLeft;
    [fram2 addSubview:labb];
    
    labb_lab = [[UITextView alloc]init];
    labb_lab.frame = CGRectMake(labb.right-5, addressLB.bottom+7, kDisWidth-100, height);
    labb_lab.text = @"(选填)控制在20个字以内";
    labb_lab.delegate = self;
    labb_lab.textAlignment = NSTextAlignmentLeft;
    labb_lab.returnKeyType=UIReturnKeyDone;
    labb_lab.font = [UIFont systemFontOfSize:14.0f];
    labb_lab.textColor = [UIColor colorWithHexString:@"#c7c7cd"];
    [fram2 addSubview:labb_lab];
    
    
    UIView *vLine = [[UIView alloc]init];
    vLine.frame = CGRectMake(0, addressLB.bottom, kDisWidth, 0.5);
    vLine.backgroundColor = kLineColer;
    [fram2 addSubview:vLine];
    
    
    UIView * platView = [[UIView alloc]init];
    platView.frame = CGRectMake(0 , fram2.bottom , kDisWidth + 4, 44);
    platView.backgroundColor = [UIColor clearColor];
    [backView addSubview:platView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kDisWidth-20, 44)];
    titleLab.center = CGPointMake(kDisWidth/2, submitBtn.bottom + 20);
    titleLab.text = @"注意：身份证将用于过海关，为了您能顺利收到包裹，请确保上传有效身份证号码。";
    titleLab.numberOfLines = 0;
    titleLab.font = [UIFont systemFontOfSize:11.0f];
    titleLab.textColor = [UIColor darkGrayColor];
    titleLab.backgroundColor = [UIColor clearColor];
    [platView addSubview:titleLab];

    //    是否立即通知发货
    UIView * quicklyView = [[UIView alloc]init];
    quicklyView.frame = CGRectMake(0, platView.bottom+5, kDisWidth, textFieldHeight);
    quicklyView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:quicklyView];
    
    UILabel * quickLab = [[UILabel alloc]init];
    quickLab.text = @"立即通知发货";
    quickLab.textAlignment = NSTextAlignmentLeft;
    quickLab.font = [UIFont systemFontOfSize:14.0f];
    quickLab.frame = CGRectMake(10, 10, 200, 20);
    [quicklyView addSubview:quickLab];
    
    quickBtn = [[UIButton alloc]init];
    quickBtn = [[UIButton alloc] initWithFrame:CGRectMake(kDisWidth-25-15, 7.5, 25, 25)];
    [quickBtn setBackgroundImage:[UIImage imageNamed:@"OK"] forState:UIControlStateNormal];
    [quickBtn setBackgroundImage:[UIImage imageNamed:@"cart"] forState:UIControlStateSelected];
    quickBtn.selected = NO;
    [quickBtn addTarget:self action:@selector(quickBtnDidclick:) forControlEvents:UIControlEventTouchUpInside];
    [quicklyView addSubview:quickBtn];
    quickBtn2 = [[UIButton alloc]init];
    quickBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(kDisWidth-100, 0, 100, 35)];
    quickBtn2.selected = NO;
    [quickBtn2 addTarget:self action:@selector(quickBtnDidclick:) forControlEvents:UIControlEventTouchUpInside];
    [quicklyView addSubview:quickBtn2];
    
    //    商品信息
    lab33 = [[UILabel alloc] initWithFrame:CGRectMake(10, quicklyView.bottom +5, 100, 20)];
    lab33.text = @"商品信息";
    lab33.font = [UIFont systemFontOfSize:12.0f];
    [backView addSubview:lab33];
    
    table = [[HTTabbleView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.showsVerticalScrollIndicator=NO;
    table.bounces=NO;
//    table.layer.cornerRadius=5.0;
    table.layer.borderColor = kLineColer.CGColor;
    table.layer.borderWidth = 0.5;
    [backView addSubview:table];
    
    self.vBjView = [[UIView alloc]initWithFrame:CGRectMake(10, lab33.bottom+5.0, kDisWidth-20, 40)];
    self.vBjView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:self.vBjView];
    
    addProduct = [[UIButton alloc] initWithFrame:CGRectMake((kDisWidth-100)/2, 5, 100.0, 30.0)];
    [addProduct setTitle:@" 添加商品" forState:UIControlStateNormal];
    [addProduct setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [addProduct setImage:[UIImage drawImageWithName:@"icon-jia" size:CGSizeMake(25, 25)] forState:UIControlStateNormal];
    [addProduct setExclusiveTouch:YES];
    [addProduct addTarget:self action:@selector(addProduct) forControlEvents:UIControlEventTouchUpInside];
    addProduct.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.vBjView addSubview:addProduct];
    
    
   
    
    submitBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 5, kDisWidth, 35.0)];
    [submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:color(76, 175, 255, 1)];
//    submitBtn.layer.cornerRadius=3.0;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitBtn addTarget:self action:@selector(checkInOrder) forControlEvents:UIControlEventTouchUpInside];
    
    [backView setContentSize:CGSizeMake(kDisWidth, self.vBjView.bottom+125)];

    
    productList=[[NSMutableArray alloc] init];
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    memberID = [f numberFromString:[YKSUserDefaults shareInstance].sUser_ID];
    
    consigneeList=[[NSMutableArray alloc] init];
    
    [self addNavigationType:YKSDefaults NavigationTitle:@"销售订单"];
    [self getConsigneeList];

    [self.view addSubview:self.vSubView];
    [self.vSubView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kDisWidth);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(kDisHeight-45);
    }];
    [self.vSubView addSubview:submitBtn];
    
}



-(void)quickBtnDidclick:(UIButton *)btn{
    btn.selected = !btn.selected;
    quickBtn.selected = btn.selected;
}


#pragma mark shortcutDelegate
- (void)shortcutTouchToPush:(NSInteger)tag{
    if (tag == 100) {
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        C_TabBarController *rootViewController = (C_TabBarController *)appDelegate.window.rootViewController;
        rootViewController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        ContactServiceViewController *VC = [[ContactServiceViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [order_id resignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KFieldTextDidChangeNotification object:order_id];
    
}

#pragma mark --GoodsExtentionViewControllerDelegate
-(void)updateDataTitle:(NSString *)title GoodsSn:(NSString *)goodsSn number:(NSString *)number imgStr:(NSString *)imgStr{
    GoodsAddModel * model = [[GoodsAddModel alloc]init];
    model.goods_sn = goodsSn;
    model.goods_amount = number;
    model.goods_name = title;
    model.goods_imgthumb = imgStr;
    
    [productList replaceObjectAtIndex:integer withObject:model];
    [table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:integer inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    [self makeTableViewHeightChange];
    
    [cover removeFromSuperview];
    [self.goodsExtentionView removeFromSuperview];
    self.goodsExtentionView.arrMData = nil;
    self.goodsExtentionView.model = nil;
}

#pragma mark--显示悬浮视图
-(void)makeSuspendViewWithDict:(NSDictionary *)dict{

    self.goodsExtentionView.frame = CGRectMake(0, kDisHeight - 400, kDisWidth, 400);
    self.goodsExtentionView.delegate = self;
    self.goodsExtentionView.arrMData = self.arrMData;
    self.goodsExtentionView.model = self.model;
    [self.view addSubview:self.goodsExtentionView];
    
}
#pragma mark --隐藏蒙板
-(void)makeHiddenCover{
    [UIView animateWithDuration:0.2 animations:^{
        [self.goodsExtentionView setFrame:CGRectMake(0, kDisHeight, kDisWidth, 400)];
    } completion:^(BOOL finished) {
        cover.alpha=0.0;
        [cover removeFromSuperview];
        [self.goodsExtentionView removeFromSuperview];
    }];
}

-(void)getConsigneeList{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSArray *result=[defaults objectForKey:@"result"];
    if (result.count!=0) {
        [consigneeList addObjectsFromArray:result];
    }
    
}

#pragma mark--收货信息
-(void)dismissViewControllerWithAddress:(NSDictionary *)addressDict{
    address_dict=addressDict;
    consignee=[addressDict objectForKey:@"consignee"];
    mobile=[addressDict objectForKey:@"phone"];
    province=[addressDict objectForKey:@"province"];
    city=[addressDict objectForKey:@"city"];
    district=[addressDict objectForKey:@"district"];
    address=[addressDict objectForKey:@"address"];
    identity = [addressDict objectForKey:@"identity"];
    NSString *addressStr=[NSString stringWithFormat:@"%@%@%@%@",province,city,district,address];
    consigneeView.color=[UIColor darkGrayColor];
    consigneeView.congnee_text=[NSString stringWithFormat:@"%@      %@\n%@\n%@",consignee,mobile,identity,addressStr];
    
}

#pragma mark --提交订单
- (void)checkInOrder{
    
    
    NSString *regex=@"^[A-Za-z0-9]＋$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    NSString *content=order_id.text;
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimedString = [content stringByTrimmingCharactersInSet:set];
    NSString *messageStr = @"";
    if (trimedString.length==0) {
        [self.view makeToast:@"订单号不能为空" duration:1.0 position:CSToastPositionCenter];
    }else if (![predicate evaluateWithObject:order_id.text]){
        [self.view makeToast:@"订单号只能为字母、数字" duration:1.0 position:CSToastPositionCenter];
    }else if (productList.count==0){
        [self.view makeToast:@"请添加商品信息" duration:1.0 position:CSToastPositionCenter];
    }else if (identity.text.length == 0){
        [self.view makeToast:@"身份证信息不能为空" duration:1.0 position:CSToastPositionCenter];
    }else if (![VerificationString Verify_Identity:identity.text]){
        messageStr = @"请输入正确的身份证号码";
        [self.view makeToast:messageStr duration:1.0 position:CSToastPositionCenter];
    }else if (name.text.length==0) {
        messageStr=@"姓名不能为空";
        [self.view makeToast:messageStr duration:1.0 position:CSToastPositionCenter];
    }else if(phoneNum.text.length==0){
        messageStr=@"手机号码不能为空";
        [self.view makeToast:messageStr duration:1.0 position:CSToastPositionCenter];
    }else if(phoneNum.text.length!=11){
        messageStr=@"手机号码输入有误";
        [self.view makeToast:messageStr duration:1.0 position:CSToastPositionCenter];
    }else if (provinceStr.length==0&&cityStr.length==0&&districtStr.length==0){
        messageStr=@"收货地区不能为空";
        [self.view makeToast:messageStr duration:1.0 position:CSToastPositionCenter];
    }else if (address.text.length==0){
        messageStr=@"详细地址不能为空";
        [self.view makeToast:messageStr duration:1.0 position:CSToastPositionCenter];
    }else
    {
        [HTLoadingTool showLoadingStringDontOperation:@"提交中..."];
        NSMutableArray *params=[[NSMutableArray alloc] init];
        for (GoodsAddModel *model in productList) {
            NSDictionary *tempDict=[[NSDictionary alloc] initWithObjects:@[model.goods_sn,model.goods_amount,@"100"] forKeys:@[@"sku",@"quantity",@"sales_price"]];
            [params addObject:tempDict];
        }
        
        NSString *value = [ZXNTool getJSONString:params];
        BOOL is_check = !quickBtn.selected;
        NSString * check = @"";
        if (is_check) {
            check = @"yes";
        }else
            check = @"no";
        NSDictionary * dic = @{ @"sales_order_sn":order_id.text,
                                @"consignee":name.text,
                                @"province":provinceStr,
                                @"city":cityStr,
                                @"district":districtStr,
                                @"address":address.text,
                                @"mobile":phoneNum.text,
                                @"id_card_number":identity.text,
                                @"site_type":@"",
                                @"site_name":@"",
                                @"consumer_note":labb_lab.text,
                                @"create_from_platform":@"ios",
                                @"goodsList":value,
                                @"is_check":check
                                };
        
        
        
        [AFHTTPClient POST:kOrderSubmitURL params:dic successInfo:^(ResponseModel *response) {
            
            
            
            //解析数据
            self.dataType = response.sMsg;
            id json = @{@"data":response.dataResponse};
            [self checkInOrderRefresh:json];
            
            
        } flaseInfo:^(ResponseModel *response, HTTPType type) {
            if (type == NEED_HINT || type == NO_NETWORK)
            {
                [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
                
                return ;
            }
            
            if (type == SERVICE_ERROR) {
                
                return ;
            }
            
            if (type == NEED_LOGIN) {
                ZXNLog(@"需要登录");
            }
        }];
    }

}

-(void)checkInOrderRefresh:(id)json{
    
    
    NSString *message=nil;
    alert1=[[UIAlertView alloc] initWithTitle:@"订单创建成功" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert1 show];
    
}
#pragma mark --删除商品
- (void)deleteGoodsInformation:(UIButton *)btn{
    alert2=[[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要删除吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert2 show];
    index=btn.tag;
}

#pragma mark --alertView 代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alert1 == alertView) {
        
        AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
        C_TabBarController *rootViewController = (C_TabBarController *)appDelegate.window.rootViewController;
        rootViewController.selectedIndex = 3;
        B_OrderViewController * VC = [[B_OrderViewController alloc]init];
        [[NSUserDefaults standardUserDefaults] setObject:@"isYes" forKey:@"isOredeType"];
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"isPop"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if ([self.dataType isEqualToString: @"1"]) {
            VC.order_status = 0;
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"OrderDataType"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else if ([self.dataType isEqualToString: @"2"]){
            VC.order_status = 1;
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"OrderDataType"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else if ([self.dataType isEqualToString: @"3"]){
            VC.order_status = 2;
            [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"OrderDataType"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else
            VC.order_status = 3;
        [[NSUserDefaults standardUserDefaults] setObject:@"3" forKey:@"OrderDataType"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else{
        if (buttonIndex==1) {
            [productList removeObjectAtIndex:index];
            NSIndexPath *indexpath=[NSIndexPath indexPathForRow:index inSection:0];
            [table deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
            [self makeTableViewHeightChange];
        }
    }
}

#pragma mark --添加商品
- (void)addProduct{
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"我的收藏",@"我的微仓", nil];
    
    [sheet showInView:self.view];
}

#pragma mark --actionsheet 代理
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex<2) {
        GetGoodsViewController * getVC = [[GetGoodsViewController alloc] init];
        getVC.type = buttonIndex;
        getVC.delegate = self;
        getVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:getVC animated:YES];
    }
}

#pragma mark--GetGoodsViewController delegate
-(void)GetGoodsActionWithModel:(GoodsAddModel *)goods{
    int flag = 0;
    if (productList.count) {
        NSString *goods_sn = goods.goods_sn;
        int count = [goods.goods_amount intValue];
        for (GoodsAddModel *add in productList) {
            int amount = [add.goods_amount intValue];
            if ([add.goods_sn isEqualToString:goods_sn]) {
                add.goods_amount = [NSString stringWithFormat:@"%d",count+amount];
                flag = 1;
            }
        }
    }
    if (flag == 0) {
        [productList addObject:goods];
    }
    [self makeTableViewHeightChange];
}


#pragma mark--刷新页面
-(void)makeTableViewHeightChange{
    [table setFrame:CGRectMake(10.0, lab33.bottom+5.0, kDisWidth-20.0, tableHeight*[productList count])];
    [self.vBjView setFrame:CGRectMake(10.0, table.bottom+0.2, kDisWidth-20, 40.0)];
     [backView setContentSize:CGSizeMake(kDisWidth, self.vBjView.bottom+125.0)];
    [table reloadData];
}

#pragma mark table 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return productList.count;
}

- (UITableViewCell  *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    GoodsAddModel *goods=productList[indexPath.row];
    
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 20, 20)];
    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteGoodsInformation:) forControlEvents:UIControlEventTouchUpInside];
    deleteBtn.tag = [indexPath row];
    [cell.contentView addSubview:deleteBtn];
    
    UILabel *name_lab=[[UILabel alloc] initWithFrame:CGRectMake(deleteBtn.right+10.0, 10, kDisWidth-70.0, 35.0)];
    name_lab.text=goods.goods_name;
    name_lab.numberOfLines=0;
    name_lab.font=[UIFont systemFontOfSize:12];
    [cell.contentView addSubview:name_lab];
    
    UILabel *sku_lab=[[UILabel alloc] initWithFrame:CGRectMake(deleteBtn.right+10.0, 45.0, 140, 20.0)];
    sku_lab.text=[NSString stringWithFormat:@"商品编号：%@",goods.goods_sn];
    sku_lab.font=[UIFont systemFontOfSize:11];
    sku_lab.textColor=[UIColor colorWithHexString:@"666666"];
    [cell.contentView addSubview:sku_lab];
    
    UILabel *amount_lab=[[UILabel alloc] initWithFrame:CGRectMake(sku_lab.right+10.0, 45.0, 100, 20.0)];
    amount_lab.text=[NSString stringWithFormat:@"数量：%@",goods.goods_amount];
    amount_lab.font=[UIFont systemFontOfSize:11];
    amount_lab.textColor=[UIColor colorWithHexString:@"666666"];
    [cell.contentView addSubview:amount_lab];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    integer = indexPath.row;
    GoodsAddModel * model = productList[integer];
    NSString * sku = model.goods_sn;
    self.model = model;
    if (model.min_sale_quantity != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:model.min_sale_quantity forKey:@"YKSKey"];
        [[NSUserDefaults standardUserDefaults] setBool:model.is_modulo forKey:@"YKSis_modulo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    GoodsExtentionViewController * VC = [[GoodsExtentionViewController alloc]init];
    VC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    VC.providesPresentationContextTransitionStyle = YES;
    VC.definesPresentationContext = YES;
    VC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    VC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    VC.delegate = self;
    [VC loadSuitViewData:sku goodsModl:model];
    [self.navigationController presentViewController:VC animated:NO completion:nil];
    
    
}

#pragma mark --请求组合数据
-(void)loadSuitViewData:(NSString *)sku{

    //接口 请求数据
    [HTLoadingTool showLoadingDontOperation];
    NSDictionary *dic = @{
                          @"sku":sku
                          };
    
    [AFHTTPClient POST:@"/goods/getGoodsExtension" params:dic successInfo:^(ResponseModel *response) {
        
        
        //解析数据
        NSMutableArray * arr2 = [[NSMutableArray alloc]init];
        for (NSDictionary * dic in response.dataResponse) {
            NSString * str = [dic objectForKey:@"sku"];
            if ([str isEqualToString:sku]) {
                
            }else{
            GoodsExtentionModel * model = [[GoodsExtentionModel alloc]init];
            [model setValues:dic];
            [arr2 addObject:model];
            }
        }
        self.arrMData = arr2;
        [self makeShowCover];
        [self makeSuspendViewWithDict:nil];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == NO_NETWORK)
        {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            
            return ;
        }
        
        if (type == SERVICE_ERROR) {
            
            return ;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];

    
    

}


#pragma mark --模拟修改订单
-(void)orderOperation:(UIButton *)btn{

    ChangeOrderViewController * VC = [[ChangeOrderViewController alloc]init];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark--创建蒙板
-(void)makeShowCover{
     CGRect bottomFrame = CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight -66);
    if (cover == nil) {
        cover = [[UIView alloc] init];
        cover.backgroundColor = [UIColor blackColor];
        cover.frame = bottomFrame;
        cover.autoresizingMask = table.autoresizingMask;
        cover.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeHiddenCover)];
        [cover addGestureRecognizer:tap];
    }
    [self.view addSubview:cover];
    cover.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        cover.alpha = 0.5;
    }];
}


-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textfield=(UITextField *)obj.object;
    NSString *toBeString=textfield.text;
    NSString *lang=[[UITextInputMode currentInputMode] primaryLanguage];  //键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange=[textfield markedTextRange];
        //获取高亮部分
        UITextPosition *position=[textfield positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字
        if(!position){
            if (toBeString.length>15) {
                textfield.text=[toBeString substringToIndex:15];
            }
        }else{
            
        }
    }else{
        if (toBeString.length>15) {
            textfield.text=[toBeString substringToIndex:15];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (1 == range.length) {//按下回格键
        return YES;
    }
    
    if (order_id == textField) {
        if ([textField.text length]<15) {
            return YES;
        }
    }
    if (1 == range.length) {//按下回格键
        return YES;
    }
    
    if (phoneNum == textField) {
        if ([textField.text length]<11) {
            return YES;
        }
    }
    
    if (name == textField) {
        if([textField.text length]<30){
            return YES;
        }
    }
    if (identity == textField) {
        if([textField.text length]<19){
            return YES;
        }
    }

    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
}


//点击空白收回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [backView endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

#pragma mark --换PickView
-(void)chooseArea{
    SelectDistrict_VC *select_VC = [[SelectDistrict_VC alloc] initWithSelectDistrict:^(NSString *sProvinceName, NSString *sProvinceID, NSString *sCityName, NSString *sCityID, NSString *sAreaName, NSString *sAreaID) {
        
        [self loadViewProvincee:sProvinceName City:sCityName Area:sAreaName];
        
        self.sProvinceID = sProvinceID;
        self.sCityID = sCityID;
        self.sAreaID = sAreaID;
        
    }];
    select_VC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    select_VC.providesPresentationContextTransitionStyle = YES;
    select_VC.definesPresentationContext = YES;
    select_VC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    select_VC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController presentViewController:select_VC animated:NO completion:nil];
}
#pragma mark - 懒加载
- (FoundOrEditView *)vFoundOrEdit
{
    if (!_vFoundOrEdit) {
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"FoundOrEditView" owner:nil options:nil];
        _vFoundOrEdit = [nibView objectAtIndex:0];
        _vFoundOrEdit.delegate = self;
    }
    return _vFoundOrEdit;
}

- (void)loadViewProvincee:(NSString *)sProvince
                     City:(NSString *)sCity
                     Area:(NSString *)sArea
{
    
    provinceStr=sProvince;
    cityStr=sCity;
    districtStr=sArea;
    areaText.text=[NSString stringWithFormat:@"%@   %@   %@",provinceStr,cityStr,districtStr];
}



#pragma mark--textView 代理

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (1 == range.length) {//按下回格键
        return YES;
    }
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return YES;
    }
    
    if ([textView.text length] < 50) {//判断字符个数
        return YES;
    }
    
    return NO;
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView == labb_lab) {
        if([textView.text isEqualToString:@"(选填)控制在20个字以内"]){
            textView.text=@"";
            textView.textColor=[UIColor colorWithHexString:@"#666666"];
    }
    
    }else if ([textView.text isEqualToString:@"不需要重复填写省市区，大于5个字符，小于120个字符"]){
    
        textView.text=@"";
        textView.textColor=[UIColor colorWithHexString:@"#666666"];
       
    }

    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    backView.bottom = backView.bottom - 160;
    self.vNavigation.frame = CGRectMake(0, 0, kDisWidth, kDisNavgation);
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
     if (textView == labb_lab) {
    if(textView.text.length < 1){
        textView.text = @"(选填)控制在20个字以内";
        textView.textColor = [UIColor colorWithHexString:@"#c7c7cd"];
    }
    }else if (textView == address){
        if (textView.text.length < 1) {
            textView.text = @"不需要重复填写省市区，大于5个字符，小于120个字符";
            textView.textColor = [UIColor colorWithHexString:@"#c7c7cd"];
        }
       
    }

    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    backView.bottom = backView.bottom + 160;
    self.vNavigation.frame = CGRectMake(0, 0, kDisWidth, kDisNavgation);
    [UIView commitAnimations];
    
}



-(NSMutableArray *)arrMData{

    if (!_arrMData) {
        _arrMData = [[NSMutableArray alloc]init];
    }
    return _arrMData;
}

-(GoodsAddModel *)model{

    if (!_model) {
        _model = [[GoodsAddModel alloc]init];
    }
    return _model;
}

-(UIButton *)barRightOneItem{
    
    if (!_barRightOneItem) {
        _barRightOneItem = [[UIButton alloc]initWithFrame:CGRectMake(kDisWidth-90, 27, 80, 30)];
        [_barRightOneItem setTitle:@"修改订单" forState:UIControlStateNormal];
        [_barRightOneItem addTarget:self action:@selector(orderOperation:) forControlEvents:UIControlEventTouchUpInside];
        _barRightOneItem.titleLabel.font = [UIFont systemFontOfSize:15.5];
    }
    return _barRightOneItem;
}

-(UIView *)vSubView{

    if (!_vSubView) {
        _vSubView = [[UIView alloc]init];
        _vSubView.backgroundColor = [UIColor whiteColor];
    }
    return _vSubView;
}
-(GoodsExtentionView *)goodsExtentionView{
    
    if (!_goodsExtentionView) {
        _goodsExtentionView = [[GoodsExtentionView alloc]init];
        
    }
    return _goodsExtentionView;
}
@end
