//
//  DetailGoodsScroView.m
//  海豚供应链
//
//  Created by Steffen.D on 16/11/25.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "DetailGoodsScroView.h"
@interface DetailGoodsScroView(){
    UIView      *topView;
    UILabel     *title_lab;
    UIImageView *lineView;
    
    NSArray     *goods_list;
    NSString    *titleText;
    NSString    *category_id;
    
    //滑动View
    UIScrollView * scroView;
}

@end


@implementation DetailGoodsScroView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
    }
    return  self;
}


-(void)setDetailGoodsScroArr:(NSArray *)detailGoodsScroArr{
    topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 44)];
    [self addSubview:topView];
    
//    UILabel *horiLab=[[UILabel alloc] initWithFrame:CGRectMake(8, 3, 2, 24)];
//    horiLab.backgroundColor=KSystemColor;
//    [topView addSubview:horiLab];
    
    //    标题
    title_lab=[[UILabel alloc] initWithFrame:CGRectMake(15, 3.0, 150, 24)];
    title_lab.font=[UIFont boldSystemFontOfSize:14];
   title_lab.textColor = [UIColor colorWithHexString:@"#333333"];
    [topView addSubview:title_lab];
    
    //    线条
    lineView=[[UIImageView alloc] initWithFrame:CGRectMake(0, title_lab.bottom+4, kDisWidth, 0.5)];
    lineView.backgroundColor=kLineColer;
    [topView addSubview:lineView];
    
    UILabel *moreLab=[[UILabel alloc] initWithFrame:CGRectMake(kDisWidth-50, 3, 30, 24)];
    moreLab.text=@"更多";
    moreLab.textColor=[UIColor colorWithHexString:@"#8e8e8e"];
    moreLab.font=[UIFont systemFontOfSize:12];
    //        [topView addSubview:moreLab];
    
    UIImageView *accessoryView=[[UIImageView alloc] initWithFrame:CGRectMake(kDisWidth-20, 10, 8, 10)];
    accessoryView.image=[UIImage drawImageWithName:@"skip" size:CGSizeMake(5, 10)];
    //        [topView addSubview:accessoryView];
    
    topView.userInteractionEnabled=YES;
    
    goods_list=[[NSArray alloc] init];

    
    
    title_lab.text= [NSString stringWithFormat:@"商品品牌"];
    _detailGoodsScroArr = detailGoodsScroArr;
    scroView = [[UIScrollView alloc]init];
    scroView.backgroundColor = [UIColor clearColor];
    scroView.pagingEnabled = YES;
    scroView.showsVerticalScrollIndicator = NO;
    scroView.showsHorizontalScrollIndicator = NO;
    NSInteger countNum = detailGoodsScroArr.count;
    for (int i=0; i<countNum; i++) {
        CateGoodsButton *btn=[[CateGoodsButton alloc] initWithFrame:CGRectMake(10+(kDisWidth/3.0 + 15)*i, 35, 0, 0)];
        btn.tag=10+i;
        GoodsInfoModel *goodsInfoModel=[[GoodsInfoModel alloc] init];
        NSDictionary *dict=detailGoodsScroArr[i];
        [goodsInfoModel setValues:dict];
        btn.goodsInfo=goodsInfoModel;
        [btn addTarget:self action:@selector(clickGoodsActionn:) forControlEvents:UIControlEventTouchUpInside];
        [scroView addSubview:btn];
        scroView.frame = CGRectMake(0,0 , kDisWidth, btn.height+44);
        UIButton * morebtn = [[UIButton alloc]init];
        morebtn.frame = CGRectMake(0, 0, kDisWidth, 44);
        morebtn.backgroundColor = [UIColor clearColor];
//        [morebtn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
        [scroView addSubview:morebtn];
    }
    if (countNum <= 3) {
        scroView.contentSize = CGSizeMake(((kDisWidth-30)/3+25)*3, (kDisWidth-30)/3+60);
    }else
        scroView.contentSize = CGSizeMake(((kDisWidth-30)/3+25)*countNum, (kDisWidth-30)/3+60);
    [self addSubview:scroView];

}
-(void)detailGoodsScroViewDisplayWithMode:(DetailGoodsScroModel *)categoryModel{
////    title_lab.text=categoryModel.cat_name;
//    title_lab.text=categoryModel.goods_name;
//    titleText=categoryModel.goods_name;
//    category_id=categoryModel.goods_id;
//    goods_list=categoryModel.goods;
//    scroView = [[UIScrollView alloc]init];
//    scroView.backgroundColor = [UIColor clearColor];
//    scroView.pagingEnabled = YES;
//    scroView.showsVerticalScrollIndicator = NO;
//    scroView.showsHorizontalScrollIndicator = NO;
//    NSInteger countNum = goods_list.count;
//    for (int i=0; i<countNum; i++) {
//        CateGoodsButton *btn=[[CateGoodsButton alloc] initWithFrame:CGRectMake((kDisWidth/3.0)*i, 35, 0, 0)];
//        btn.tag=10+i;
//        GoodsInfoModel *goodsInfoModel=[[GoodsInfoModel alloc] init];
//        NSDictionary *dict=goods_list[i];
//        [goodsInfoModel setValues:dict];
//        btn.goodsInfo=goodsInfoModel;
//        [btn addTarget:self action:@selector(clickGoodsAction:) forControlEvents:UIControlEventTouchUpInside];
//        [scroView addSubview:btn];
//        scroView.frame = CGRectMake(0,0 , kDisWidth, btn.height+44);
//        UIButton * morebtn = [[UIButton alloc]init];
//        morebtn.frame = CGRectMake(0, 0, kDisWidth, 44);
//        morebtn.backgroundColor = [UIColor clearColor];
////        [morebtn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
//        [scroView addSubview:morebtn];
//    }
//    if (countNum <= 3) {
//        scroView.contentSize = CGSizeMake(kDisWidth, kCateButtonW+60);
//    }else
//        scroView.contentSize = CGSizeMake((kCateButtonW+20)*countNum, kCateButtonW+60);
//    [self addSubview:scroView];
    
}
-(void)detailGoodsScroViewDisplayWithMode2:(DetailGoodsScroModel *)categoryModel{
//    title_lab.text= [NSString stringWithFormat:@"同类热销排行推荐"];
//    titleText=categoryModel.category_name;
//    category_id=categoryModel.category_id;
//    goods_list=categoryModel.goods;
//    scroView = [[UIScrollView alloc]init];
//    scroView.backgroundColor = [UIColor clearColor];
//    scroView.frame = CGRectMake(0,35 , kDisWidth, kCateButtonW+60);
//    scroView.pagingEnabled = YES;
//    scroView.showsVerticalScrollIndicator = NO;
//    scroView.showsHorizontalScrollIndicator = NO;
//    NSInteger countNum = goods_list.count;
//    //    NSInteger countNum = 6;
//    for (int i=0; i<countNum; i++) {
//        CateGoodsButton *btn=[[CateGoodsButton alloc] initWithFrame:CGRectMake((kDisWidth/3.0)*i, 35, 0, 0)];
//        btn.tag=10+i;
//        btn.backgroundColor = KarcRandomColor;
//        GoodsInfoModel *goodsInfoModel=[[GoodsInfoModel alloc] init];
//        NSDictionary *dict=goods_list[i];
//        [goodsInfoModel setValues:dict];
//        btn.goodsInfo=goodsInfoModel;
//        [btn addTarget:self action:@selector(clickGoodsAction:) forControlEvents:UIControlEventTouchUpInside];
//        [scroView addSubview:btn];
//        scroView.frame = CGRectMake(0,0 , kDisWidth, btn.height+44);
//    }
//    scroView.contentSize = CGSizeMake((kCateButtonW+20)*(countNum + 3), kCateButtonW+60);
//    //     scroView.contentSize = CGSizeMake((kCateButtonW+20)*(3 + 3), kCateButtonW+60);
//    [self addSubview:scroView];
//    
}

-(void)clickGoodsActionn:(CateGoodsButton *)sender{
    NSDictionary *dict=_detailGoodsScroArr[sender.tag-10];
    NSString * sku = [dict objectForKey:@"goods_sn"];
    NSString *goods_id=[dict objectForKey:@"goods_id"];
    NSString * cat_id = category_id;
    if ([_delegate respondsToSelector:@selector(cellGoodsButtonActionWithID:::)]) {
        [_delegate cellGoodsButtonActionWithID:goods_id :sku :cat_id];
    }
}

//-(void)tapAction{
//    if ([_delegate respondsToSelector:@selector(cellTapActionWithTitle:categoryID:)]) {
//        [_delegate cellTapActionWithTitle:titleText categoryID:category_id];
//    }
//}
@end
