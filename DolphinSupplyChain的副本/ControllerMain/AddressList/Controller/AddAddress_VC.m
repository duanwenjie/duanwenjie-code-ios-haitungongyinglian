//
//  AddAddress_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/4.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "AddAddress_VC.h"
#import "FoundOrEditView.h"
#import "SelectDistrict_VC.h"
#import "ZXNTool.h"


@interface AddAddress_VC () <FoundOrEditDelegate>

@property (nonatomic, strong) FoundOrEditView *vFoundOrEdit;

@property (nonatomic, strong) AddressListModel *addressModel;

@property (nonatomic, copy) NSString *sProvinceID;

@property (nonatomic, copy) NSString *sCityID;

@property (nonatomic, copy) NSString *sAreaID;

@property (nonatomic, copy) NSString *sTitle;

@end

@implementation AddAddress_VC

- (instancetype)initWithProvinceID:(AddressListModel *)model Title:(NSString *)sTitle
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.addressModel = model;
        self.sTitle = sTitle;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.vFoundOrEdit];
    
    [self addNavigationType:YKSDefaults NavigationTitle:self.sTitle];
    
    [self.vFoundOrEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.vNavigation.mas_bottom);
    }];
    if (self.addressModel != nil) {
        [self.vFoundOrEdit loadViewName:self.addressModel.consignee Phone:self.addressModel.mobile NumberID:self.addressModel.id_card_number Province:self.addressModel.province City:self.addressModel.city Area:self.addressModel.district AddressInfo:self.addressModel.address];
        
        self.sProvinceID = self.addressModel.province_id;
        self.sCityID = self.addressModel.city_id;
        self.sAreaID = self.addressModel.district_id;
    }
}


#pragma mark - FoundOrEditDelegate
- (void)infoSaveName:(NSString *)sName
         PhoneNumber:(NSString *)sPhoneNumber
      IdentityNumber:(NSString *)sIdentityNumber
         AddressInfo:(NSString *)sAddressInfo
{
    if (sName.length == 0) {
        [self.view makeToast:@"收货人不能为空" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (sPhoneNumber.length == 0) {
        [self.view makeToast:@"电话号码不能为空" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (sIdentityNumber.length == 0) {
        [self.view makeToast:@"身份证号码不能为空" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (sAddressInfo.length == 0) {
        [self.view makeToast:@"详细地址不能为空" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (sAddressInfo.length < 5) {
        [self.view makeToast:@"详细地址必须大于5个字" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (sAddressInfo.length > 200) {
        [self.view makeToast:@"详细地址必须小于200个字" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (self.sProvinceID.length == 0 || self.sCityID.length == 0 || self.sAreaID.length == 0) {
        [self.view makeToast:@"省市区不能为空" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (![VerificationString Verify_Nickname:sName]) {
        [self.view makeToast:@"收货人不能含有空格、表情、符号" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (![VerificationString Verify_Identity:sIdentityNumber]) {
        [self.view makeToast:@"身份证号码格式错误" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
//    if (![VerificationString Verify_Phone:sPhoneNumber]) {
//        [self.view makeToast:@"手机号码格式错误" duration:1.0 position:CSToastPositionCenter];
//        return;
//    }
    
    [self loadDataName:sName PhoneNumber:sPhoneNumber IdentityNumber:sIdentityNumber AddressInfo:sAddressInfo];
}

#pragma mark - 增加或编辑地址
- (void)loadDataName:(NSString *)sName
         PhoneNumber:(NSString *)sPhoneNumber
      IdentityNumber:(NSString *)sIdentityNumber
         AddressInfo:(NSString *)sAddressInfo
{
    [HTLoadingTool showLoadingDontOperation];
    NSDictionary *josn = @{ @"consignee":sName,                // 收件人必填
                            @"country_id":@"1",                // 国家id必填
                            @"province_id":self.sProvinceID,   // 省id必填
                            @"city_id":self.sCityID,           // 城市id必填
                            @"district_id":self.sAreaID,       // 区id 必填
                            @"address":sAddressInfo,           // 地址 必填
                            @"mobile":sPhoneNumber,            // 手机号 必填
                            @"id_card_number":sIdentityNumber  // 身份证
                            };
    
    NSString *sJson = [ZXNTool getJSONString:josn];
    
    
    NSDictionary *dic = nil;
    if (self.addressModel != nil) {
        dic = @{@"address_id":self.addressModel.user_addr_id,
                @"address_info":sJson};
    }
    else
    {
        dic = @{@"address_info":sJson};
    }
    
    [AFHTTPClient POST:@"/UserAddr/setAddr" params:dic successInfo:^(ResponseModel *response) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}



- (void)selectArea
{
    [self.view endEditing:YES];
    
    SelectDistrict_VC *select_VC = [[SelectDistrict_VC alloc] initWithSelectDistrict:^(NSString *sProvinceName, NSString *sProvinceID, NSString *sCityName, NSString *sCityID, NSString *sAreaName, NSString *sAreaID) {
        
        [self.vFoundOrEdit loadViewProvince:sProvinceName City:sCityName Area:sAreaName];
        
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
