//
//  SelectDistrict_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/4.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "SelectDistrict_VC.h"
#import "ZXNTool.h"
#import "DistrictCell.h"
#import "AddressBll.h"
#import "DistrictModel.h"

@interface SelectDistrict_VC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *vBack;

@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UIButton *btnCancl;

@property (nonatomic, strong) UIView *vLineOne;

@property (nonatomic, strong) UIView *vDistrictBack;

@property (nonatomic, strong) UILabel *lblProvince;

@property (nonatomic, strong) UIView *vProvinceLine;

@property (nonatomic, strong) UILabel *lblCity;

@property (nonatomic, strong) UIView *vCityLine;

@property (nonatomic, strong) UILabel *lblArea;

@property (nonatomic, strong) UIView *vAreaLine;

@property (nonatomic, strong) UIView *vLineTwo;

@property (nonatomic, strong) HTTabbleView *tbMain;

@property (nonatomic, strong) NSMutableArray *arrProvince;

@property (nonatomic, strong) NSMutableArray *arrCity;

@property (nonatomic, strong) NSMutableArray *arrArea;

@property (nonatomic, assign) BOOL bProvinceTable;

@property (nonatomic, assign) BOOL bCityTable;

@property (nonatomic, assign) BOOL bAreaTable;

@property (nonatomic, strong) SelectDistrictBlock DistrictBlock;


@property (nonatomic, copy) NSString *sProvinceName;

@property (nonatomic, copy) NSString *sProvinceID;

@property (nonatomic, copy) NSString *sCityName;

@property (nonatomic, copy) NSString *sCityID;

@property (nonatomic, copy) NSString *sAreaName;

@property (nonatomic, copy) NSString *sAreaID;


@end

@implementation SelectDistrict_VC

- (instancetype)initWithSelectDistrict:(SelectDistrictBlock)block
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.bProvinceTable = YES;
        self.bCityTable = NO;
        self.bAreaTable = NO;
        self.arrProvince = [NSMutableArray array];
        self.arrCity = [NSMutableArray array];
        self.arrArea = [NSMutableArray array];
        self.DistrictBlock = block;
        self.sProvinceName = @"";
        self.sProvinceID = @"";
        self.sCityName = @"";
        self.sCityID = @"";
        self.sAreaName = @"";
        self.sAreaID = @"";
    }
    return self;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.tbMain.delegate = nil;
    self.tbMain.dataSource = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.vBack];
    [self.vBack addSubview:self.lblTitle];
    [self.vBack addSubview:self.btnCancl];
    [self.vBack addSubview:self.vLineOne];
    
    [self.vBack addSubview:self.vDistrictBack];
    [self.vDistrictBack addSubview:self.vLineTwo];
    
    [self.vDistrictBack addSubview:self.lblProvince];
    [self.vDistrictBack addSubview:self.vProvinceLine];
    
    [self.vDistrictBack addSubview:self.lblCity];
    [self.vDistrictBack addSubview:self.vCityLine];
    
    [self.vDistrictBack addSubview:self.lblArea];
    [self.vDistrictBack addSubview:self.vAreaLine];
    
    [self.vBack addSubview:self.tbMain];
    
    
    [self.vBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(280);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.top.equalTo(self.vBack.mas_top);
        make.centerX.equalTo(self.vBack.mas_centerX);
        make.height.mas_equalTo(39.5);
    }];
    
    [self.btnCancl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 39.5));
        make.right.top.equalTo(self.vBack);
    }];
    
    [self.vLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vBack);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.vDistrictBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.vBack);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.vLineOne.mas_bottom);
    }];
    
    [self.vLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.vDistrictBack);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.lblProvince mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vDistrictBack.mas_top).offset(0);
        make.left.equalTo(self.vDistrictBack.mas_left).offset(20);
        make.right.equalTo(self.lblCity.mas_left).offset(-20);
        make.height.mas_equalTo(30);
    }];
    
    [self.vProvinceLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblProvince.mas_left).offset(-5);
        make.right.equalTo(self.lblProvince.mas_right).offset(5);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.vDistrictBack.mas_bottom);
    }];
    
    [self.lblCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vDistrictBack.mas_top).offset(0);
        make.left.equalTo(self.lblProvince.mas_right).offset(20);
        make.right.equalTo(self.lblArea.mas_left).offset(-20);
        make.height.mas_equalTo(30);
    }];
    
    [self.vCityLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblCity.mas_left).offset(-5);
        make.right.equalTo(self.lblCity.mas_right).offset(5);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.vDistrictBack.mas_bottom);
    }];
    
    [self.lblArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vDistrictBack.mas_top).offset(0);
        make.left.equalTo(self.lblCity.mas_right).offset(20);
        make.height.mas_equalTo(30);
    }];
    
    [self.vAreaLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblArea.mas_left).offset(-5);
        make.right.equalTo(self.lblArea.mas_right).offset(5);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.vDistrictBack.mas_bottom);
    }];
    
    [self.tbMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vDistrictBack.mas_bottom).offset(0);
        make.right.left.bottom.equalTo(self.vBack);
    }];
    
    [self loadDataProvince];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //宣告一个UITouch的指标来存放事件触发时所撷取到的状态
    UITouch *touch = [[event allTouches] anyObject];
    CGFloat ly = [touch locationInView:self.self.vBack].y;
    if ( ly < 0 || ly > self.vBack.frame.size.height ) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    else
    {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)loadDataProvince
{
    
    self.bProvinceTable = YES;
    self.bCityTable = NO;
    self.bAreaTable = NO;
    
    NSDictionary *dic = @{@"id":@"1"};
    
    [AFHTTPClient POST:@"/Region/getList" params:dic successInfo:^(ResponseModel *response) {
        
        [self.arrProvince removeAllObjects];
        
        self.arrProvince = [AddressBll gainDistrictList:response.dataResponse];
        
        if (self.arrProvince.count == 0) {
            [self.view makeToast:@"服务出错" duration:1.0 position:CSToastPositionCenter];
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
    }];
}


- (void)loadDataCity:(NSString *)sCity
{
    self.bProvinceTable = NO;
    self.bCityTable = YES;
    self.bAreaTable = NO;
    
    NSDictionary *dic = @{@"id":sCity};
    
    [AFHTTPClient POST:@"/Region/getList" params:dic successInfo:^(ResponseModel *response) {
        
        [self.arrCity removeAllObjects];
        
        self.arrCity = [AddressBll gainDistrictList:response.dataResponse];
        
        if (self.arrCity.count == 0) {
            [self.view makeToast:@"服务出错" duration:1.0 position:CSToastPositionCenter];
        }

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


- (void)loadDataArea:(NSString *)sArea
{
    self.bProvinceTable = NO;
    self.bCityTable = NO;
    self.bAreaTable = YES;
    NSDictionary *dic = @{@"id":sArea};
    
    [AFHTTPClient POST:@"/Region/getList" params:dic successInfo:^(ResponseModel *response) {
        
        [self.arrArea removeAllObjects];
        
        self.arrArea = [AddressBll gainDistrictList:response.dataResponse];
        
        if (self.arrArea.count == 0) {
            [self.view makeToast:@"服务出错" duration:1.0 position:CSToastPositionCenter];
        }
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.bProvinceTable) {
        return self.arrProvince.count;
    }
    else if (self.bCityTable)
    {
        return self.arrCity.count;
    }
    else
    {
        return self.arrArea.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DistrictCell *ProvinceCell = [tableView dequeueReusableCellWithIdentifier:@"SelectDistrictCell"];
    if (ProvinceCell == nil) {
        ProvinceCell = [[DistrictCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelectDistrictCell"];
        ProvinceCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    DistrictModel *model = nil;
    if (self.bProvinceTable) {
        model = self.arrProvince[indexPath.row];
    }
    else if (self.bCityTable)
    {
        model = self.arrCity[indexPath.row];
    }
    else
    {
        model = self.arrArea[indexPath.row];
    }
    
    [ProvinceCell loadViewName:model.region_name isSelect:model.bSelect];
    return ProvinceCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DistrictModel *model = nil;
    if (self.bProvinceTable) {
        
        if (self.arrProvince.count == 0) {
            return;
        }
        
        [self.arrProvince enumerateObjectsUsingBlock:^(DistrictModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            if (model.bSelect) {
                model.bSelect = NO;
                *stop = YES;
            }
        }];
        
        model = self.arrProvince[indexPath.row];
        model.bSelect = YES;
        self.sProvinceName = model.region_name;
        self.sProvinceID = model.region_id;
        
        self.lblProvince.text = model.region_name;
        self.lblProvince.textColor = [UIColor blackColor];
        self.vProvinceLine.hidden = YES;
        
        self.lblCity.hidden = NO;
        self.vCityLine.hidden = NO;
        self.lblCity.text = @"请选择";
        self.lblCity.textColor = [UIColor colorWithHexString:@"12a0ea"];
        
        [self loadDataCity:model.region_id];
    }
    else if (self.bCityTable)
    {
        if (self.arrCity.count == 0) {
            return;
        }
        
        [self.arrCity enumerateObjectsUsingBlock:^(DistrictModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            if (model.bSelect) {
                model.bSelect = NO;
                *stop = YES;
            }
        }];
        
        model = self.arrCity[indexPath.row];
        model.bSelect = YES;
        self.sCityName = model.region_name;
        self.sCityID = model.region_id;
        
        self.lblCity.text = model.region_name;
        self.lblCity.textColor = [UIColor blackColor];
        self.vCityLine.hidden = YES;
        
        self.lblArea.hidden = NO;
        self.vAreaLine.hidden = NO;
        self.lblArea.text = @"请选择";
        self.lblArea.textColor = [UIColor colorWithHexString:@"12a0ea"];
        
        [self loadDataArea:self.sCityID];
    }
    else
    {
        
        if (self.arrArea.count == 0) {
            return;
        }
        
        [self.arrArea enumerateObjectsUsingBlock:^(DistrictModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            if (model.bSelect) {
                model.bSelect = NO;
                *stop = YES;
            }
        }];
        
        model = self.arrArea[indexPath.row];
        model.bSelect = YES;
        self.sAreaName = model.region_name;
        self.sAreaID = model.region_id;
        
        
        if (self.sProvinceID.length == 0 || self.sCityID.length == 0 || self.sAreaID.length == 0) {
            [self.view makeToast:@"获取数据出错请重新选择" duration:1.0 position:CSToastPositionCenter];
            return;
        }
        
        self.DistrictBlock(self.sProvinceName, self.sProvinceID, self.sCityName, self.sCityID, self.sAreaName, self.sAreaID);
        
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}


#pragma mark - 点击事件
- (void)selectCancl
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)tapProvince
{
    self.bProvinceTable = YES;
    self.bCityTable = NO;
    self.bAreaTable = NO;
    
    self.sCityName = @"";
    self.sCityID = @"";
    
    self.sAreaName = @"";
    self.sAreaID = @"";
    
    self.lblCity.hidden = YES;
    self.vCityLine.hidden = YES;
    self.lblArea.hidden = YES;
    self.vAreaLine.hidden = YES;
    
    self.lblProvince.textColor = [UIColor colorWithHexString:@"12a0ea"];
    self.vProvinceLine.hidden = NO;
    
    [self.tbMain reloadData];
}

- (void)tapCity
{
    self.bProvinceTable = NO;
    self.bCityTable = YES;
    self.bAreaTable = NO;
    
    self.sAreaName = @"";
    self.sAreaID = @"";

    self.lblArea.hidden = YES;
    self.vAreaLine.hidden = YES;
    
    self.lblCity.textColor = [UIColor colorWithHexString:@"12a0ea"];
    self.vCityLine.hidden = NO;
    
    [self.tbMain reloadData];
}



#pragma mark - 懒加载
- (UIView *)vBack
{
    if (!_vBack) {
        _vBack = [[UIView alloc] init];
        _vBack.backgroundColor = [UIColor whiteColor];
    }
    return _vBack;
}

- (UIView *)vLineOne
{
    if (!_vLineOne) {
        _vLineOne = [[UIView alloc] init];
        _vLineOne.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
    }
    return _vLineOne;
}

- (HTTabbleView *)tbMain
{
    if (!_tbMain) {
        _tbMain = [[HTTabbleView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tbMain.delegate = self;
        _tbMain.dataSource = self;
        _tbMain.tag = 0;
        _tbMain.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbMain.showsVerticalScrollIndicator = NO;
        _tbMain.bounces = NO;
    }
    return _tbMain;
}

- (UILabel *)lblTitle
{
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.text = @"所在地区";
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        _lblTitle.font = [UIFont systemFontOfSize:14];
    }
    return _lblTitle;
}

- (UIButton *)btnCancl
{
    if (!_btnCancl) {
        _btnCancl = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCancl.contentMode = UIViewContentModeScaleAspectFit;
        [_btnCancl addTarget:self action:@selector(selectCancl) forControlEvents:UIControlEventTouchUpInside];
//        [_btnCancl setImage:[[HelpTool sharedHelpTool] drawImageWithName:@"close_Two" withX:15 andY:15] forState:UIControlStateNormal];
        
        [_btnCancl setImage:[UIImage drawImageWithName:@"close_Two" size:CGSizeMake(15, 15)] forState:UIControlStateNormal];
    }
    return _btnCancl;
}

- (UIView *)vDistrictBack
{
    if (!_vDistrictBack) {
        _vDistrictBack = [[UIView alloc] init];
    }
    return _vDistrictBack;
}

- (UILabel *)lblProvince
{
    if (!_lblProvince) {
        _lblProvince = [[UILabel alloc] init];
        _lblProvince.text = @"请选择";
        _lblProvince.textColor = [UIColor colorWithHexString:@"12a0ea"];
        _lblProvince.font = [UIFont systemFontOfSize:13];
        _lblProvince.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapProvince = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProvince)];
        [_lblProvince addGestureRecognizer:tapProvince];
    }
    return _lblProvince;
}

- (UIView *)vProvinceLine
{
    if (!_vProvinceLine) {
        _vProvinceLine = [[UIView alloc] init];
        _vProvinceLine.backgroundColor = [UIColor colorWithHexString:@"12a0ea"];
    }
    return _vProvinceLine;
}

- (UILabel *)lblCity
{
    if (!_lblCity) {
        _lblCity = [[UILabel alloc] init];
        _lblCity.textColor = [UIColor colorWithHexString:@"12a0ea"];
        _lblCity.font = [UIFont systemFontOfSize:13];
        _lblCity.hidden = YES;
        _lblCity.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapCity = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCity)];
        [_lblCity addGestureRecognizer:tapCity];
    }
    return _lblCity;
}

- (UIView *)vCityLine
{
    if (!_vCityLine) {
        _vCityLine = [[UIView alloc] init];
        _vCityLine.backgroundColor = [UIColor colorWithHexString:@"12a0ea"];
        _vCityLine.hidden = YES;
    }
    return _vCityLine;
}

- (UILabel *)lblArea
{
    if (!_lblArea) {
        _lblArea = [[UILabel alloc] init];
        _lblArea.textColor = [UIColor colorWithHexString:@"12a0ea"];
        _lblArea.font = [UIFont systemFontOfSize:13];
        _lblArea.hidden = YES;
    }
    return _lblArea;
}

- (UIView *)vAreaLine
{
    if (!_vAreaLine) {
        _vAreaLine = [[UIView alloc] init];
        _vAreaLine.backgroundColor = [UIColor colorWithHexString:@"12a0ea"];
        _vAreaLine.hidden = YES;
    }
    return _vAreaLine;
}

- (UIView *)vLineTwo
{
    if (!_vLineTwo) {
        _vLineTwo = [[UIView alloc] init];
        _vLineTwo.backgroundColor = [UIColor colorWithHexString:@"c1c1c1"];
    }
    return _vLineTwo;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
