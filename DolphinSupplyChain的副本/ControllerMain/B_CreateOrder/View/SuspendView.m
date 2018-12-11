//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "SuspendView.h"
#import "BackScrollView.h"


@interface SuspendView ()<UITextFieldDelegate>{
    BackScrollView *rootScrollView;
    UILabel     *name_lab;
    
    UILabel     *spe_name_lab;
    UIButton    *selectBtn;

    UILabel     *vertLine;
    
    UILabel     *sn_lab;
    NSString    *g_sn;
    UILabel     *num_lab;
    UIView      *quatity_view;
    NSInteger   num;
    
    NSDictionary *valueDict;
}

@end

@implementation SuspendView
@synthesize quatity_text;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
        rootScrollView=[[BackScrollView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, kDisHeight-200)];
        rootScrollView.showsVerticalScrollIndicator=NO;
        [self addSubview:rootScrollView];
        
        _imgView=[[ZXNImageView alloc] initWithFrame:CGRectMake(5.0, 5.0, 60.0, 60.0)];
        _imgView.layer.borderWidth=0.5;
        _imgView.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [rootScrollView addSubview:_imgView];
        
        name_lab=[[UILabel alloc] initWithFrame:CGRectMake(_imgView.right+5.0, 10.0, frame.size.width-75.0, 35.0)];
        name_lab.numberOfLines=0;
        name_lab.textColor=[UIColor blackColor];
        name_lab.font=[UIFont systemFontOfSize:12.0];
        [rootScrollView addSubview:name_lab];
        
        UILabel *line=[[UILabel alloc] initWithFrame:CGRectMake(0,_imgView.bottom+5.0, frame.size.width, 1)];
        line.backgroundColor=[UIColor lightGrayColor];
        line.text=@"";
        [rootScrollView addSubview:line];
        
        spe_name_lab=[[UILabel alloc] initWithFrame:CGRectZero];
        spe_name_lab.textColor=[UIColor blackColor];
        spe_name_lab.font=[UIFont systemFontOfSize:12.0];
        [rootScrollView addSubview:spe_name_lab];
        
        vertLine=[[UILabel alloc] initWithFrame:CGRectZero];
        vertLine.backgroundColor=[UIColor lightGrayColor];
        vertLine.text=@"";
        [rootScrollView addSubview:vertLine];
        
        sn_lab=[[UILabel alloc] initWithFrame:CGRectMake(10.0, _imgView.bottom+15.0,250, 20.0)];
        sn_lab.textColor=[UIColor blackColor];
        sn_lab.font=[UIFont systemFontOfSize:12.0];
        [rootScrollView addSubview:sn_lab];
        
        num_lab=[[UILabel alloc] initWithFrame:CGRectZero];
        num_lab.text=@"数量：";
        num_lab.textColor=[UIColor blackColor];
        num_lab.font=[UIFont systemFontOfSize:12.0];
        [rootScrollView addSubview:num_lab];
        
        quatity_view=[[UIView alloc] initWithFrame:CGRectZero];
        quatity_view.backgroundColor=[UIColor clearColor];
        quatity_view.layer.borderColor=ColorAPPTheme.CGColor;
        quatity_view.layer.borderWidth=0.5;
        quatity_view.layer.masksToBounds=YES;
        [rootScrollView addSubview:quatity_view];
        
        UIButton *reduceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0, 35, 35)];
        [reduceBtn addTarget:self action:@selector(changeQuatity:) forControlEvents:UIControlEventTouchUpInside];
        reduceBtn.tag = 100;
        [reduceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [reduceBtn setTitle:@"-" forState:UIControlStateNormal];
        [reduceBtn setBackgroundColor:ColorAPPTheme];
        [quatity_view addSubview:reduceBtn];
        
        quatity_text = [[UILabel alloc]init];
        quatity_text.frame = CGRectMake(reduceBtn.right, 0, 50, 35);
        quatity_text.textColor = [UIColor blackColor];
        quatity_text.textAlignment=NSTextAlignmentCenter;
        [quatity_view addSubview:quatity_text];
        
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(quatity_text.right,0, 35, 35)];
        [addBtn addTarget:self action:@selector(changeQuatity:) forControlEvents:UIControlEventTouchUpInside];
        addBtn.tag = 101;
        [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addBtn setTitle:@"+" forState:UIControlStateNormal];
        [addBtn setBackgroundColor:ColorAPPTheme];
        [quatity_view addSubview:addBtn];
        
        UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-60.0, frame.size.width, 60)];
        [self addSubview:bottomView];
        
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmBtn.frame = CGRectMake(50, 10, kDisWidth-100, 40);
        confirmBtn.layer.cornerRadius=5.0;
        [confirmBtn addTarget:self action:@selector(confirmGoods) forControlEvents:UIControlEventTouchUpInside];
        [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirmBtn setBackgroundColor:ColorAPPTheme];
        [bottomView addSubview:confirmBtn];
        
        num=1;
    }
    return self;
}

-(void)setMinSaleNum:(NSNumber *)minSaleNum{
    _minSaleNum=minSaleNum;
    quatity_text.text=[NSString stringWithFormat:@"%@",minSaleNum];
    num=[minSaleNum integerValue];
}

-(void)setSalePolicy:(NSString *)salePolicy{
    _salePolicy=salePolicy;
}

-(void)setGoodsImge:(UIImage *)goodsImge{
    _goodsImge=goodsImge;
    _imgView.image=goodsImge;
}

-(void)setName:(NSString *)name{
    _name=name;
    name_lab.text=name;
}

-(void)setSpeName:(NSString *)speName{
    _speName=speName;
    spe_name_lab.text=speName;
}

-(void)setGoods_sn:(NSString *)goods_sn{
    _goods_sn=goods_sn;
    sn_lab.text=[NSString stringWithFormat:@"商品编号：%@",goods_sn];
}

-(void)setSpeValues:(NSArray *)speValues{
    _speValues=speValues;
    
    if (speValues.count==0) {
        [num_lab setFrame:CGRectMake(10.0, sn_lab.bottom+10.0, 50, 20.0)];
        [quatity_view setFrame:CGRectMake(num_lab.right, sn_lab.bottom+10.0, 120, 35)];
    }else{
        [spe_name_lab setFrame:CGRectMake(10.0, sn_lab.bottom+10.0, kDisWidth-20.0, 20.0)];
        for (int i=0; i<[speValues count]; i++) {
            UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(10.0+i%3*85, spe_name_lab.bottom+5.0+i/3*35.0, 80.0, 30.0)];
            NSDictionary *tempDict=speValues[i];
            [btn setTitle:[tempDict objectForKey:@"attr"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            btn.layer.borderColor=[UIColor lightGrayColor].CGColor;
            btn.layer.borderWidth=0.5;
            btn.layer.cornerRadius=5.0;
            btn.tag=i;
            if (i==0) {
                btn.selected=YES;
                selectBtn=btn;
                valueDict=speValues[0];
                if (![[valueDict objectForKey:@"product_sn"] isKindOfClass:[NSNull class]]) {
                   g_sn=[valueDict objectForKey:@"product_sn"];
                    sn_lab.text=[NSString stringWithFormat:@"商品编号：%@",g_sn];
                }
            }
            
            [btn addTarget:self action:@selector(getSpeValueAction:) forControlEvents:UIControlEventTouchUpInside];
            [rootScrollView addSubview:btn];
        }
        [vertLine setFrame:CGRectMake(10.0, spe_name_lab.bottom+([speValues count  ]/3+1)*40.0, kDisWidth-20.0, 1)];
        [num_lab setFrame:CGRectMake(10.0, vertLine.bottom+10.0, 60, 20.0)];
        [quatity_view setFrame:CGRectMake(num_lab.right, vertLine.bottom+5.0, 120, 35)];
    }
    [rootScrollView setContentSize:CGSizeMake(kDisWidth, quatity_view.bottom+120.0)];
}

-(void)getSpeValueAction:(UIButton *)btn{
    selectBtn.selected=NO;
    btn.selected=YES;
    selectBtn=btn;
    valueDict=_speValues[btn.tag];
    if (![[valueDict objectForKey:@"product_sn"] isKindOfClass:[NSNull class]]) {
        g_sn=[valueDict objectForKey:@"product_sn"];
        sn_lab.text=[NSString stringWithFormat:@"商品编号：%@",g_sn];
    }
}

-(void)changeQuatity:(UIButton *)btn{
    NSInteger minCount=[_minSaleNum integerValue];
    NSInteger coun=minCount;
    if (btn.tag==100) {
        if ([_salePolicy isEqualToString:@"modulo"]) {
            num-=minCount;
        }else{
            num--;
        }
        if (num<coun){
            num=minCount;
            return;
        }
    }else{
        if ([_salePolicy isEqualToString:@"modulo"]) {
            num+=minCount;
        }else{
            num++;
        }
    }
    
    quatity_text.text =[NSString stringWithFormat:@"%li",(long)num];
}

-(void)confirmGoods{
    NSArray * objects ;
    NSArray * keys ;
    if (_status == 0) {
        if (_img_original == nil) {
            _img_original = @"none";
        }
        if (_speValues.count == 0) {
            objects = @[_goods_sn,_name,quatity_text.text,_min_sale_quantity,_max_sale_quantity,_img_original,[NSString stringWithFormat:@"%d",_is_modulo]];
            keys= @[@"goods_sn",@"goods_name",@"goods_amount",@"min_sale_quantity",@"max_sale_quantity",@"img_original",@"is_modulo"];
        }else{
            objects = @[g_sn,_name,quatity_text.text,_speName,valueDict,_min_sale_quantity,_max_sale_quantity,_img_original,[NSString stringWithFormat:@"%d",_is_modulo]];
            keys = @[@"goods_sn",@"goods_name",@"goods_amount",@"spe_name",@"value",@"min_sale_quantity",@"max_sale_quantity",@"img_original",@"is_modulo"];
        }
    }else{
        if (_img_original == nil) {
            _img_original = @"none";
        }
        objects = @[_goods_sn,_name,quatity_text.text,_min_sale_quantity,_max_sale_quantity,_img_original,[NSString stringWithFormat:@"%d",_is_modulo]];
        keys = @[@"goods_sn",@"goods_name",@"goods_amount",@"min_sale_quantity",@"max_sale_quantity",@"img_original",@"is_modulo"];
    }
    NSDictionary * dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    GoodsAddModel * goods = [[GoodsAddModel alloc] init];
    [goods setValues:dict];
    
    if ([_delegate respondsToSelector:@selector(suspendViewDidConfirmWithModel:)]) {
        [_delegate suspendViewDidConfirmWithModel:goods];
    }
}

-(void)setMin_sale_quantity:(NSString *)min_sale_quantity{

    _min_sale_quantity = min_sale_quantity;
}

-(void)setMax_sale_quantity:(NSString *)max_sale_quantity{

    _max_sale_quantity = max_sale_quantity;
}

-(void)setIs_modulo:(BOOL)is_modulo{

    _is_modulo = is_modulo;
}

-(void)setImg_original:(NSString *)img_original{

    _img_original = img_original;
}



//点击空白收回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [rootScrollView endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

@end
