//
//  ClassifViewController.h
//  海豚供应链
//
//  Created by Steffen.D on 16/11/23.
//  Copyright © 2016年 小东小东. All rights reserved.
//

#import "ConsigneeView.h"

@interface ConsigneeView (){
    UILabel *lab;
}

@end


@implementation ConsigneeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        lab= [[UILabel alloc] initWithFrame:CGRectMake(10, 10, frame.size.width-40.0, 60)];
        lab.numberOfLines=0;
        lab.font = [UIFont systemFontOfSize:12.0f];
        lab.textColor = [UIColor darkGrayColor];
        [self addSubview:lab];
        
        UIImageView *imgView=[[UIImageView alloc] init];
        [imgView setFrame:CGRectMake(lab.right,34,10.0, 12.0)];
        [imgView setImage:[UIImage drawImageWithName:@"accessory" size:CGSizeMake(20.0, 20.0)]];
        [self addSubview:imgView];
    }
    return self;
}

-(void)setCongnee_text:(NSString *)congnee_text{
    _congnee_text=congnee_text;
    lab.text=congnee_text;
}

-(void)setColor:(UIColor *)color{
    _color=color;
    lab.textColor=color;
}

@end
