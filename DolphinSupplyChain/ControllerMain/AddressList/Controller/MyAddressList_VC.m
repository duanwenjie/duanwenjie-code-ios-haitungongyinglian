//
//  MyAddressList_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/3.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "MyAddressList_VC.h"
#import "AddressListCell.h"
#import "AddAddress_VC.h"
#import "BlankPageView.h"
#import "AddressBll.h"

#import "HTTabbleView.h"


@interface MyAddressList_VC () <UITableViewDelegate, UITableViewDataSource, AddressListDelegate>


@property (nonatomic, strong) HTTabbleView *tbMain;

/// 数据源
@property (nonatomic, strong) NSMutableArray *arrData;

@property (nonatomic, strong) BlankPageView *vBlankView;

@property (nonatomic, assign) NSInteger iPage;

@property (nonatomic, assign) BOOL bReceivingComeIn;

@property (nonatomic, strong) SelectReceivingAddressBlock AddressBlock;

@property (nonatomic, strong) NSString *sDefaultAddressID;

@property (nonatomic, assign) BOOL bDeleteDefaultAddressID;

@end

@implementation MyAddressList_VC

- (instancetype)initWithIsSeletReceivingComeIn:(BOOL)bReceivingComeIn
                              DefaultAddressID:(NSString *)sDefaultAddressID
                        SelectReceivingAddress:(SelectReceivingAddressBlock)block
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.bDeleteDefaultAddressID = NO;
        self.sDefaultAddressID = sDefaultAddressID;
        self.arrData = [NSMutableArray array];
        self.iPage = 2;
        self.bReceivingComeIn = bReceivingComeIn;
        self.AddressBlock = block;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.tbMain];
    [self.view addSubview:self.vBlankView];
    
    [self addNavigationType:YKS_Left_Title_RightTwo NavigationTitle:@"我的地址"];
    [self.btnRigthTwo setTitle:@"添加" forState:UIControlStateNormal];
    [self.btnRigthTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnRigthTwo.titleLabel.font = kFont16;
    
    
    [self.tbMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.vNavigation.mas_bottom);
    }];
    
    WS(weakSelf);
    
    [self.tbMain addHeaderRefresh:^{
        [weakSelf loadDataFirst];
    }];
    
    [self.tbMain addFooterRefresh:^{
        [weakSelf loadDataMore];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.vBlankView.hidden = YES;
    [self.tbMain beginRefreshing];
}

#pragma mark - 网络请求
- (void)loadDataFirst
{
    NSDictionary *dic = @{@"page":@"1",
                          @"page_size":@"10"};
    
    [AFHTTPClient POST:@"/UserAddr/getList" params:dic successInfo:^(ResponseModel *response) {
        
        [self.tbMain endHeaderRefreshing];
        
        [self.arrData removeAllObjects];
        
        self.arrData = [AddressBll gainAddressList:response.dataResponse];
        
        if (self.arrData.count == 0) {
            self.vBlankView.hidden = NO;
        }
        else
        {
            self.vBlankView.hidden = YES;
            [self.tbMain reloadData];
        }
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        [self.tbMain endHeaderRefreshing];
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}



- (void)loadDataPage:(NSInteger)iPage
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setValue:[NSNumber numberWithInteger:iPage] forKey:@"page"];
    [dic setValue:@"10" forKey:@"page_size"];
    
    [AFHTTPClient POST:@"/UserAddr/getList" params:dic successInfo:^(ResponseModel *response) {
        
        [self.tbMain endFooterRefreshing];
        
        NSMutableArray* arrayCollect = [AddressBll gainAddressList:response.dataResponse];
        
        if (arrayCollect.count != 0) {
            self.iPage += 1;
            
            NSInteger i = self.arrData.count;
            
            NSMutableArray *array = [NSMutableArray array];
            for (AddressListModel *obj in arrayCollect) {
                NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
                [array addObject:path];
                
                [self.arrData addObject:obj];
                i += 1;
            }
            
            [self.tbMain insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationTop];
        }
        else
        {
            [self.tbMain showNoMoreData];
        }
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        [self.tbMain endFooterRefreshing];
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}

- (void)loadDataMore
{
    [self loadDataPage:self.iPage];
}

#pragma mark - 删除地址
- (void)deleteAddressID:(NSString *)sAddressID index:(NSIndexPath *)iIndex
{
    NSDictionary *dic = @{@"address_id":sAddressID};
    
    [AFHTTPClient POST:@"/UserAddr/delAddr" params:dic successInfo:^(ResponseModel *response) {
        [self.view makeToast:@"删除地址成功" duration:1.0 position:CSToastPositionCenter];
        
        [self.arrData removeObjectAtIndex:iIndex.row];
        
        [self.tbMain deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:iIndex.row inSection:iIndex.section]] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tbMain reloadData];
        
        // 如果从收货地址进入后，传入的默认地址不为空
        if (self.sDefaultAddressID.length != 0) {
            
            // 如果列表中删除的地址ID 跟传进来的ID相同
            if ([sAddressID isEqualToString:self.sDefaultAddressID]) {
                self.bDeleteDefaultAddressID = YES;
            }
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

#pragma mark - 设为默认地址
- (void)defaultAddressID:(NSString *)sAddressID index:(NSInteger)iIndex
{
    NSDictionary *dic = @{@"address_id":sAddressID};
    
    [AFHTTPClient POST:@"/UserAddr/setAddrDefault" params:dic successInfo:^(ResponseModel *response) {
        [self.view makeToast:@"已设置为默认地址" duration:1.0 position:CSToastPositionCenter];
        
        [self.arrData enumerateObjectsUsingBlock:^(AddressListModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([model.is_default isEqualToString:@"1"]) {
                model.is_default = @"0";
                self.arrData[idx] = model;
                *stop = YES;
            }
        }];
        AddressListModel *modelOne = self.arrData[iIndex];
        modelOne.is_default = @"1";
        self.arrData[iIndex] = modelOne;
        
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



#pragma mark - 按钮点击事件
- (void)tapRightTwo
{
    AddAddress_VC *addAddress_VC = [[AddAddress_VC alloc] initWithProvinceID:nil Title:@"添加地址"];
    [self.navigationController pushViewController:addAddress_VC animated:YES];
}

#pragma mark - AddressListDelegate
- (void)tapDefault:(NSIndexPath *)index
{
    UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否将该地址设为默认地址" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"设为默认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AddressListModel *model = self.arrData[index.row];
        [self defaultAddressID:model.user_addr_id index:index.row];
    }];
    
    [alerController addAction:cancelAction];
    [alerController addAction:okAction];
    
    [self.navigationController presentViewController:alerController animated:YES completion:nil];
}

- (void)tapCompile:(NSIndexPath *)index
{
    AddressListModel *model = self.arrData[index.row];
    AddAddress_VC *addAddress_VC = [[AddAddress_VC alloc] initWithProvinceID:model Title:@"编辑地址"];
    [self.navigationController pushViewController:addAddress_VC animated:YES];
}

- (void)tapDelete:(NSIndexPath *)index
{
    UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否删除地址" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"删除地址" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AddressListModel *model = self.arrData[index.row];
        [self deleteAddressID:model.user_addr_id index:index];
    }];
    
    [alerController addAction:cancelAction];
    [alerController addAction:okAction];
    
    [self.navigationController presentViewController:alerController animated:YES completion:nil];
    
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressListCell"];
    if (cell == nil) {
        cell = [[AddressListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddressListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    AddressListModel *model = self.arrData[indexPath.row];
    [cell loadViewName:model.consignee PhoneNumber:model.mobile IdentityNumber:model.id_card_number Address:[NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.district,model.address] IndextPath:indexPath isDefault:[model.is_default isEqualToString:@"1"] ? YES : NO];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.bReceivingComeIn) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AddressIDChange" object:@"NO"];
        self.AddressBlock(self.arrData[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 重写Back事件
- (void)tapLeft
{
    if (self.bReceivingComeIn && self.sDefaultAddressID.length != 0 && self.bDeleteDefaultAddressID) {
        
        self.AddressBlock(nil);
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 懒加载

- (UITableView *)tbMain
{
    if (!_tbMain) {
        _tbMain = [[HTTabbleView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tbMain.delegate = self;
        _tbMain.dataSource = self;
        _tbMain.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbMain.showsVerticalScrollIndicator = NO;
        _tbMain.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    }
    return _tbMain;
}

- (BlankPageView *)vBlankView
{
    if (!_vBlankView) {
        _vBlankView = [[BlankPageView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, kDisHeight)];
        _vBlankView.title = @"暂无收货地址";
        _vBlankView.hidden = YES;
    }
    return _vBlankView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
