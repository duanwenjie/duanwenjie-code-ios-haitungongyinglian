//
//  GoodsExtentionView.m
//  DolphinSupplyChain
//
//  Created by Steffen.D on 17/2/18.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import "GoodsExtentionView.h"
#import "GoodsAddsubView.h"
#import "GoodsAddModel.h"
#import "GoodsExtentionModel.h"
#define KarcColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
@interface GoodsExtentionView()<UITableViewDelegate,UITableViewDataSource,GoodsAddsubViewDelegate>{
    
    
}
@property (nonatomic ,strong)UIView * vTopView;

@property (nonatomic ,strong)HTTabbleView * vTabView;

@property (nonatomic ,strong)ZXNImageView * vImageView;

@property (nonatomic ,strong)UILabel * labTitle;

@property (nonatomic ,strong)UILabel * labGoodsSn;

@property (nonatomic ,strong)UILabel * labGoodsSn_plain;

@property (nonatomic ,strong)GoodsAddsubView * vGetnumberView;

@property (nonatomic ,assign)NSInteger  getNum;

@property (nonatomic ,strong)UIButton * btnSure;

@property (nonatomic ,assign)NSInteger  index;

@property (nonatomic ,strong)NSMutableArray * goodsProduct;

@property (nonatomic ,strong)NSMutableDictionary * dictMData;

@property (nonatomic ,strong)GoodsExtentionModel * modelData;

@property (nonatomic ,assign)BOOL  isClick;//组合cell被点击

@property (nonatomic ,assign)BOOL  isClick2;//加减按钮被点击
@end

@implementation GoodsExtentionView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.vTopView];
        [self addSubview:self.vTabView];
        [self.vTopView addSubview:self.vImageView];
        [self.vTopView addSubview:self.labTitle];
        [self.vTopView addSubview:self.labGoodsSn];
        [self.vTopView addSubview:self.labGoodsSn_plain];
        [self.vTopView addSubview:self.vGetnumberView];
        [self addSubview:self.btnSure];
        
        
        [self.vTopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(94);
        }];
        
        [self.vImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.vTopView).offset(15);
            make.height.width.mas_equalTo(kDisNavgation);
        }];
        
        [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.vImageView.mas_right).offset(10);
            make.top.equalTo(self.vImageView);
            make.right.equalTo(self.vTopView).offset(-15);
            make.height.mas_equalTo(34);
        }];
        
        [self.labGoodsSn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.vImageView.mas_right).offset(10);
            make.top.equalTo(self.labTitle.mas_bottom);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(55);
            
        }];
        
        [self.labGoodsSn_plain mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.labGoodsSn.mas_right).offset(2);
            make.top.equalTo(self.labTitle.mas_bottom);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(80);
        }];
        
        [self.vGetnumberView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labTitle.mas_bottom).offset(3);
            make.right.equalTo(self.vTopView.mas_right).offset(-15);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(85);
        }];
        
        [self.btnSure mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(40);
        }];
        
        [self.vTabView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.vTopView.mas_bottom);
            make.left.right.equalTo(self);
            make.bottom.equalTo(self.btnSure.mas_top).offset(0);
        }];
        
        
    }
    
    
    return self;

}

#pragma mark --赋值
-(void)setArrMData:(NSMutableArray *)arrMData{
    //解析数据  赋值
    _arrMData = arrMData;

    self.goodsProduct = arrMData;
    if (arrMData.count <= 3) {
        self.vTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

-(void)setModel:(GoodsAddModel *)model{

    _model = model;
    [self.vImageView downloadImage:model.img_original backgroundImage:ZXNImageDefaul];
    self.labTitle.text = model.goods_name;
    self.labGoodsSn_plain.text = model.goods_sn;
    self.vGetnumberView.countText = model.goods_amount;
    self.getNum = [model.goods_amount integerValue];

}
#pragma mark --UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.goodsProduct.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        GoodsExtentionModel * model = self.goodsProduct[indexPath.row];
        
        ZXNImageView * vimageView = [[ZXNImageView alloc]initWithFrame:CGRectMake(15, 15, kDisNavgation, kDisNavgation)];
        vimageView.layer.borderWidth = 0.5;
        vimageView.layer.borderColor = kLineColer.CGColor;
        vimageView.layer.masksToBounds = YES;
        [vimageView downloadImage:model.img_thumb backgroundImage:ZXNImageDefaul];
        [cell.contentView addSubview:vimageView];
        
        UILabel * labtitile = [[UILabel alloc]initWithFrame:CGRectMake(vimageView.right+10, 15, kDisWidth-104, 34)];
        labtitile.text = model.goods_name;
        labtitile.textColor = [UIColor colorWithHexString:@"#333333"];
        labtitile.font = [UIFont systemFontOfSize:12];
        labtitile.textAlignment = NSTextAlignmentLeft;
        labtitile.numberOfLines = 0;
        [cell.contentView addSubview:labtitile];
        
        UILabel * labGoodsSn = [[UILabel alloc]initWithFrame:CGRectMake(vimageView.right+10, vimageView.bottom-30, 200, 30)];
        
        labGoodsSn.text = [NSString stringWithFormat:@"商品编号: %@",model.sku];
        labGoodsSn.textColor = [UIColor colorWithHexString:@"#666666"];
        labGoodsSn.font = [UIFont systemFontOfSize:12];
        labGoodsSn.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:labGoodsSn];
        
        if (self.arrMData.count <= 3) {
            UIView * vLine = [[UIView alloc]initWithFrame:CGRectMake(10, vimageView.bottom+15, kDisWidth-20, 0.5)];
            vLine.backgroundColor = kLineColer;
            [cell.contentView addSubview:vLine];
        }
        
        
    }
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 94;
}
#pragma mark --刷新商品数据
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.isClick = YES;
    self.index = indexPath.row;
    GoodsExtentionModel * model = self.goodsProduct[self.index];
    [self.vImageView downloadImage:model.img_thumb backgroundImage:ZXNImageDefaul];
    self.labTitle.text = model.goods_name;
    self.labGoodsSn_plain.text = model.sku;
    self.getNum = [model.min_sale_quantity integerValue];
    self.vGetnumberView.countText = model.min_sale_quantity;

    self.modelData = model;
    
    
    if (model.min_sale_quantity != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:model.min_sale_quantity forKey:@"YKSKey"];
        [[NSUserDefaults standardUserDefaults] setBool:model.is_modulo forKey:@"YKSis_modulo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
}


#pragma mark --GetNumerViewDelegate
- (void)getNumberForAddAction{
    
    self.isClick2 = YES;
    NSString * str;
    if (self.isClick) {
        str = self.modelData.min_sale_quantity;
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"YKSis_modulo"] integerValue] == 1) {
            self.getNum += [str integerValue];
        }else{
        
            self.getNum ++;
        }
        
    }else{
        
        str = [[NSUserDefaults standardUserDefaults] objectForKey:@"YKSKey"];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"YKSis_modulo"] integerValue] == 1) {
            self.getNum += [str integerValue];
        }else{
            
            self.getNum ++;
        }

    }

    
    self.vGetnumberView.countText=[NSString stringWithFormat:@"%ld",(long)self.getNum];
}

- (void)getNumberForReduceAction{
    
    self.isClick2 = YES;
    BOOL is_YKSis_modulo;
    is_YKSis_modulo = [[NSUserDefaults standardUserDefaults] objectForKey:@"YKSis_modulo"];
    
    
    NSString * str;
    if (self.isClick) {
        
          str = self.modelData.min_sale_quantity;
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"YKSis_modulo"] integerValue] == 1) {
            self.getNum -= [str integerValue];
        }else{
            
            self.getNum --;
        }

        if (self.getNum <= [str integerValue]) {
            self.getNum = [str integerValue];
        }
        
        
    }else{

        str = [[NSUserDefaults standardUserDefaults] objectForKey:@"YKSKey"];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"YKSis_modulo"] integerValue] == 1) {
            self.getNum -= [str integerValue];
        }else{
            
            self.getNum --;
        }

         if (self.getNum <= [str integerValue]) {
            self.getNum = [str integerValue];
        }
        
    }
    self.vGetnumberView.countText=[NSString stringWithFormat:@"%ld",(long)self.getNum];
}

-(void)btnSureDidCilick:(UIButton *)btn{

    if ([self.delegate respondsToSelector:@selector(updateDataTitle:GoodsSn:number:)]) {
        NSString * title = @"";
        NSString * goodsSn = @"";
        NSString * number = @"";
        if (self.isClick) {
            if (self.isClick2) {
                number = [NSString stringWithFormat:@"%zd",self.getNum];
            }else{
                number = self.modelData.min_sale_quantity;
            }
            title = self.modelData.goods_name;
            goodsSn = self.modelData.sku;
        }else{
            title = self.model.goods_name;
            goodsSn = self.model.goods_sn;
            if (self.isClick2) {
                number = [NSString stringWithFormat:@"%zd",self.getNum];
            }else{
                number = [[NSUserDefaults standardUserDefaults] objectForKey:@"YKSKey"];
            }

        }
        
        [self.delegate updateDataTitle:title GoodsSn:goodsSn number:number];
        
    }
}
#pragma mark --懒加载
-(UIView *)vTopView{

    if (!_vTopView) {
        _vTopView = [[UIView alloc]init];
        _vTopView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
        
    }

    return _vTopView;
    
}

-(HTTabbleView *)vTabView{

    if (!_vTabView) {
        _vTabView = [[HTTabbleView alloc]initWithFrame:CGRectMake(0, 124, kDisWidth, 300) style:UITableViewStylePlain];
        _vTabView.delegate = self;
        _vTabView.dataSource = self;
        _vTabView.backgroundColor = [UIColor whiteColor];
        _vTabView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _vTabView.separatorColor = kLineColer;
    }
    return _vTabView;
}

-(UIImageView *)vImageView{

    if (!_vImageView) {
        _vImageView = [[ZXNImageView alloc]init];
        _vImageView.layer.borderWidth = 0.5;
        _vImageView.layer.borderColor = kLineColer.CGColor;
        _vImageView.layer.masksToBounds = YES;
//        _vImageView.backgroundColor = KarcColor;
        _vImageView.image = [UIImage imageNamed:@"none"];
    }
    return _vImageView;
}

-(UILabel *)labTitle{

    if (!_labTitle) {
        _labTitle = [[UILabel alloc]init];
        _labTitle.font = [UIFont systemFontOfSize:12.0];
        _labTitle.textAlignment = NSTextAlignmentLeft;
//        _labTitle.backgroundColor = KarcColor;
//        _labTitle.text = @"爱他美爱他美爱他美爱他美爱他美爱他美爱他美爱他美爱他美爱他美爱他美爱他美爱他美爱他美爱他美爱他美";
        _labTitle.numberOfLines = 0;
        _labTitle.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _labTitle;
}


-(UILabel *)labGoodsSn{

    if (!_labGoodsSn) {
        _labGoodsSn = [[UILabel alloc]init];
        _labGoodsSn.text = @"商品编号:";
        _labGoodsSn.textAlignment = NSTextAlignmentLeft;
        _labGoodsSn.font = [UIFont systemFontOfSize:12.0];
        _labGoodsSn.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _labGoodsSn;
}

-(UILabel *)labGoodsSn_plain{
    
    if (!_labGoodsSn_plain) {
        _labGoodsSn_plain = [[UILabel alloc]init];
        _labGoodsSn_plain.text = @"DEAP001";
        _labGoodsSn_plain.textAlignment = NSTextAlignmentLeft;
        _labGoodsSn_plain.font = [UIFont systemFontOfSize:12.0];
        _labGoodsSn_plain.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _labGoodsSn_plain;
}

-(GoodsAddsubView *)vGetnumberView{

    if (!_vGetnumberView) {
        _vGetnumberView = [[GoodsAddsubView alloc]init];
        _vGetnumberView.delegate = self;
//        _vGetnumberView.backgroundColor = KarcColor;
    }
    return _vGetnumberView;
}

-(UIButton *)btnSure{

    if (!_btnSure) {
        _btnSure = [[UIButton alloc]init];
        _btnSure.backgroundColor = ColorAPPTheme;
        [_btnSure setTitle:@"提交" forState:UIControlStateNormal];
        [_btnSure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSure addTarget:self action:@selector(btnSureDidCilick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSure;
}

-(NSMutableArray *)goodsProduct{

    if (!_goodsProduct) {
        _goodsProduct = [[NSMutableArray alloc]init];
    }
    return _goodsProduct;
}

-(NSMutableDictionary *)dictMData{

    if (!_dictMData) {
        _dictMData = [[NSMutableDictionary alloc]init];
    }
    return _dictMData;
}

-(GoodsExtentionModel *)modelData{

    if (!_modelData) {
        _modelData = [[GoodsExtentionModel alloc]init];
    }
    return _modelData;
}

@end
