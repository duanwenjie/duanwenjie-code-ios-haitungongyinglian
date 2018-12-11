//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "PurchaseGoodsView.h"
#import "PurchaseGoodsCell.h"
#import "PurchaseGoodsModel.h"

@implementation PurchaseGoodsView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate=self;
        self.dataSource=self;
        self.separatorColor = kLineColer;
        self.separatorInset = UIEdgeInsetsMake(0,0, 0, 0);        // 设置端距，这里表示separator离左边和右边均0像素
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_purchaseGoodsList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIentifier=@"PurchaseGoodsCell";
    PurchaseGoodsCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIentifier];
    if ( cell==nil) {
        cell=[[PurchaseGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    PurchaseGoodsModel *goodsModel=_purchaseGoodsList[indexPath.row];
    [cell purchaseGoodsCellDisplayWithModel:goodsModel];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PurchaseGoodsModel *goodsModel=_purchaseGoodsList[indexPath.row];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:goodsModel.goods_id forKey:@"goods_id"];
    [dict setValue:goodsModel.sku forKey:@"goods_sn"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationPurchaseCell" object:nil userInfo:dict];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95.0;
}


@end
