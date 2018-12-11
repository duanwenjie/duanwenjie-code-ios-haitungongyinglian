//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "ProductShowTable.h"
#import "SaleGoodsModel.h"
#import "ProductTableViewCell.h"


@interface ProductShowTable ()

@end


@implementation ProductShowTable
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate=self;
        self.dataSource=self;
        self.separatorInset=UIEdgeInsetsZero;
        self.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        [self setSeparatorColor:kLineColer];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.productList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"cellIdentifier";
    SaleGoodsModel * goods = [_productList objectAtIndex:indexPath.row];
    
    ProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isPop"] isEqualToString:@"Yes"]) {
        cell = [[ProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
       
    }else{
    if (cell == nil) {
        cell = [[ProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    }
    [cell updateData:goods status:[NSString stringWithFormat:@"%@",self.status]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:self.model forKey:@"order"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationSelectCell" object:nil userInfo:dict];
    
}



@end
