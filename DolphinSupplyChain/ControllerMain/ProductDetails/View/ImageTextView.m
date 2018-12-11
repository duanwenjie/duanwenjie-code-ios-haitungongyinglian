//
//  ImageTextView.m
//  Weekens
//
//  Created by fei on 15/4/15.
//  Copyright (c) 2015年 ___YKSKJ.COM___. All rights reserved.
//

#import "ImageTextView.h"
#import "ButtonGroup.h"
#import "LargeImageView.h"
#import "ParameterView.h"

@interface ImageTextView ()<ButtonGroupDelegate,UIScrollViewDelegate>{
    UIScrollView    *rootScrollView;
    //图片
    LargeImageView  *_largeImageView;
    ButtonGroup     *_buttonGroup;
    NSInteger       selectIndex;
    CGFloat          recHeight;

    //商品参数
    ParameterView   *_parameterView;
    
    UILabel *blank_lab;
    UILabel *blank_lab2;
    BOOL     isHidden;
    BOOL     isHidden2;
}

@end

@implementation ImageTextView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=color(244, 244, 244, 1);
        UIView *t_topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 20)];
        t_topView.backgroundColor=[UIColor whiteColor];
        [self addSubview:t_topView];
        
//        创建顶部按钮组
        NSArray *titles=[[NSArray alloc] initWithObjects:@"图文详情",@"商品参数", nil];
        ButtonGroup *buttonGroup=[[ButtonGroup alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 40.0) titles:titles index:0];
        buttonGroup.delegate=self;
        _buttonGroup = buttonGroup;
        [self addSubview:buttonGroup];
        
//        创建根滚动视图
        rootScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0,0, kDisWidth, kDisHeight-40)];
        rootScrollView.backgroundColor=[UIColor clearColor];
        rootScrollView.showsVerticalScrollIndicator=NO;
        rootScrollView.delegate=self;
        rootScrollView.contentSize = CGSizeMake(kDisWidth, kDisHeight+50);
        [self addGestureRecognizerWithView:rootScrollView];
        
        
//    下拉返回商品详情
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake((kDisWidth-130)/2, 5, 130, 15.0)];
        btn.backgroundColor=[UIColor clearColor];
        [btn setImage:[UIImage imageNamed:@"pullImag"] forState:UIControlStateNormal];
        [rootScrollView addSubview:btn];
        
        [self insertSubview:rootScrollView belowSubview:buttonGroup];
        
        [self loadImageTextView];
        
        [self reloadViewWithIndex:0];
        
        selectIndex=0;
        
        blank_lab2=[[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 40)];
        blank_lab2.text=@"暂无商品参数";
        blank_lab2.hidden = YES;
        [_parameterView addSubview:blank_lab2];
       
    }
    return self;
}

//图文详情
-(void)loadImageTextView{
    _largeImageView=[[LargeImageView alloc] initWithFrame:CGRectMake(0, 45, kDisWidth, kDisHeight-50-kDisNavgation-40)];
    _largeImageView.backgroundColor = [UIColor whiteColor];
    _largeImageView.tag = 101;
    [rootScrollView addSubview:_largeImageView];
    _largeImageView.hidden=YES;

    _parameterView = [[ParameterView alloc]initWithFrame:CGRectMake(0, 45, kDisWidth, kDisHeight-50)];
    _parameterView.backgroundColor = [UIColor whiteColor];
    _parameterView.hidden = YES;
    [rootScrollView addSubview:_parameterView];
    
}

- (void)touchGoodsToDetail:(NSString *)goods_sn{
    DetailViewController *VC = [[DetailViewController alloc] init];
    VC.sku = goods_sn;
    if ([self.delegate respondsToSelector:@selector(recommendBtnDidclick:)]) {
        [self.delegate recommendBtnDidclick:VC];
    }
    
}

//添加左右滑动的手势
-(void)addGestureRecognizerWithView:(UIView*)view{
    UISwipeGestureRecognizer *Leftswipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handLeftSwipe:)];
    Leftswipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [view addGestureRecognizer:Leftswipe];
    
    UISwipeGestureRecognizer *Rightswipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handRightSwipe:)];
    Rightswipe.direction = UISwipeGestureRecognizerDirectionRight;
    [view addGestureRecognizer:Rightswipe];
}

//左滑动处理
-(void)handLeftSwipe:(UIGestureRecognizer*)sender{
    
    selectIndex+=1;
    if (selectIndex>2) {
        selectIndex = 1;
    }
    if (selectIndex == 1 && isHidden == NO ) {
        blank_lab.hidden = NO;
    }
    if (selectIndex == 2  && isHidden2 == NO){
        blank_lab2.hidden = NO;
    }
    [self  handSwipeAction];
}

//右滑动处理
-(void)handRightSwipe:(UIGestureRecognizer*)sender{
    
    selectIndex-=1;
    if (selectIndex<0) {
        selectIndex = 0;
    }
    if (selectIndex == 1 && isHidden == NO) {
        blank_lab.hidden = NO;
    }
    if (selectIndex == 2  && isHidden2 == NO){
        blank_lab2.hidden = NO;
    }

    [self  handSwipeAction];
}
//调用按键组点击事件
-(void)handSwipeAction{
    UIButton *btn;
    for (UIView *view in _buttonGroup.subviews) {
        if ([view isKindOfClass:[UIButton class]]&&(view.tag == selectIndex+100)) {
            btn = (UIButton*)view;
        }
    }
    [_buttonGroup changeViewWithButton:btn];
}


-(void)reloadViewWithIndex:(NSUInteger)index{
    rootScrollView.contentSize=CGSizeMake(kDisWidth, kDisHeight);
    if (index==0) {
        _largeImageView.hidden=NO;
        _parameterView.hidden =YES;
        if (_largeImageView.height>kDisHeight) {
            rootScrollView.contentSize=_largeImageView.size;
        }
    }else if (index==1){
        _largeImageView.hidden=YES;
        _parameterView.hidden=NO;
        if (_parameterView.height>kDisHeight) {
            rootScrollView.contentSize=_parameterView.size;
        }
    }
}

#pragma mark -- loadAction
-(void)loadForDescriptionImagesWithImages:(NSString *)desImages{
    _largeImageView.images=desImages;
    
}

-(void)loadForParameterViewWithParameters:(NSArray *)parameters{
    _parameterView.parameterList =parameters;
    if (parameters.count == 0) {
        isHidden2 = NO;
    }else{
        isHidden2 = YES;
    }
}

#pragma mark -- UIScrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==rootScrollView) {
        CGFloat scY=scrollView.contentOffset.y;
        if (scY<-100.00) {
            if ([_delegate respondsToSelector:@selector(imageTextViewReloadAction)]) {
                [_delegate imageTextViewReloadAction];
            }
        }
    }
    
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    
    CGFloat currentOffset = offset.y + bounds.size.height - inset.bottom;
    CGFloat maximumOffset = size.height;
    
    //当currentOffset与maximumOffset的值相等时，说明scrollview已经滑到底部了
    if( (maximumOffset - currentOffset) == 0 ){
        _largeImageView.wbView.frame = CGRectMake(0, 0, kDisWidth, maximumOffset-50-70);
    }
    
    
    else if (_parameterView.hidden == NO){
        if (_parameterView.parameterList == nil) {
            rootScrollView.contentSize = CGSizeMake(kDisWidth, kDisHeight);
        }else{
            if (_parameterView.size.height>kDisHeight-40) {
                rootScrollView.contentSize = _parameterView.size;
            }else{
            rootScrollView.contentSize = CGSizeMake(kDisWidth, kDisHeight);
            }
        }
    }

}

#pragma mark -- buttonGroup delegate
-(void)buttonGroupActionWithIndex:(NSUInteger)index{
    [self reloadViewWithIndex:index];
    rootScrollView.contentOffset = CGPointMake(0, 0);
    selectIndex=index;
}



@end
