//
//  ShowCommodityQuality_VC.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/5.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "ShowCommodityQuality_VC.h"
#import "AttributeView.h"

@interface ShowCommodityQuality_VC () <AttributeDelegate>

@property (nonatomic, strong) AttributeView *vAttribute;

@property (nonatomic, copy) NSMutableArray *arrData;

@property (nonatomic, copy) NSString *sSku;

@property (nonatomic, strong) SeleteQualityBlock block;

@property (nonatomic, assign) NSInteger iIndex;

@property (nonatomic, copy) NSString *sUserEmaill;

@property (nonatomic, strong) CommodityDetailsModel *model;

@end

@implementation ShowCommodityQuality_VC

- (instancetype)initWithData:(NSMutableArray *)arrData TrueQuality:(NSString *)sSKU block:(SeleteQualityBlock)block
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.arrData = arrData;
        self.sSku = sSKU;
        self.block = block;
        
        [self.arrData enumerateObjectsUsingBlock:^(CommodityDetailsModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([self.sSku isEqualToString:obj.sku]) {
                self.iIndex = idx;
                *stop = YES;
            }
        }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initAddView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.6 animations:^{
        self.vAttribute.frame = CGRectMake(0, kDisHeight - (kDisHeight/5)*3, kDisWidth, (kDisHeight/5)*3);
    }];
}
     
- (void)initAddView
{
    [self.view addSubview:self.vAttribute];
    [self.vAttribute loadData:self.arrData index:self.iIndex];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //宣告一个UITouch的指标来存放事件触发时所撷取到的状态
    UITouch *touch = [[event allTouches] anyObject];
    CGFloat ly = [touch locationInView:self.self.vAttribute].y;
    if ( ly < 0 || ly > self.vAttribute.frame.size.height ) {
        
        [UIView animateWithDuration:0.4 animations:^{
            self.vAttribute.frame = CGRectMake(0, kDisHeight, kDisWidth, (kDisHeight/5)*3);
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:NO completion:nil];
        }];
        
    }
    else
    {
        [super touchesBegan:touches withEvent:event];
    }
}

#pragma mark - AttributeDelegate
- (void)selectClose:(NSInteger)iIndex number:(NSInteger)iNumber;
{
    self.block(self.arrData[iIndex], iNumber, NO);
    [UIView animateWithDuration:0.4 animations:^{
        self.vAttribute.frame = CGRectMake(0, kDisHeight, kDisWidth, (kDisHeight/5)*3);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)selectAddCart:(NSInteger)iIndex number:(NSInteger)iNumber
{
    self.block(self.arrData[iIndex], iNumber, YES);
    [UIView animateWithDuration:0.4 animations:^{
        self.vAttribute.frame = CGRectMake(0, kDisHeight, kDisWidth, (kDisHeight/5)*3);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)selectAttribute:(NSInteger)iIndex number:(NSInteger)iNumber
{
    self.block(self.arrData[iIndex], iNumber, NO);
    self.model = self.arrData[iIndex];
    if ([self.model.stock isEqualToString:@"0"]) {
        [self.vAttribute changeAddShoppingCart:NO];
    }
    else
    {
        [self.vAttribute changeAddShoppingCart:YES];
    }
}

- (void)selectPresentStockRegistration
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

#pragma mark - 跳转缺货登记
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
                                    @"sku":self.model.sku};
            
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
    NSLog(@"%@",textField.text);
    self.sUserEmaill = textField.text;
}


#pragma mark - 懒加载
- (AttributeView *)vAttribute
{
    if (!_vAttribute) {
        _vAttribute = [[AttributeView alloc] initWithFrame:CGRectMake(0, kDisHeight, kDisWidth, (kDisHeight/5)*3)];
        _vAttribute.delegate = self;
    }
    return _vAttribute;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
