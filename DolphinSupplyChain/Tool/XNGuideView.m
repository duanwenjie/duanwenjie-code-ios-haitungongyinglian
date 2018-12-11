//
//  XNGuideView.m
//
//  Created by LuohanCC on 15/11/30.
//  Copyright © 2015年 罗函. All rights reserved.
//

#import "XNGuideView.h"
//#import "BFKit.h"
#define     GUIDE_FLAGS    @"/guide"

@interface XNGuideView() <UIScrollViewDelegate> {
    int screen_width;
    int screen_height;
}
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSArray *imageArray;

@property (nonatomic, strong) UIPageControl *pageView;

@end

@implementation XNGuideView

+ (void)showGudieView:(NSArray *)imageArray top:(CGFloat)fTop{
    if(imageArray && imageArray.count > 0)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString *sShowGuide = [userDefaults objectForKey:@"YKSShowGuide"];
        
        if ([sShowGuide isEqualToString:@"1"]) {
            return;
        }
        
        XNGuideView *xnGuideView = [[XNGuideView alloc] init:imageArray top:fTop];
        [[UIApplication sharedApplication].delegate.window addSubview:xnGuideView];
        [userDefaults setValue:@"1" forKey:@"YKSShowGuide"];
        [userDefaults synchronize];
    }
}

- (instancetype)init:(NSArray *)imageArray top:(CGFloat)fTop{
    self = [super init];
    if(self) {
        [self initThisView:imageArray top:fTop];
    }
    return self;
}

- (void)initThisView:(NSArray *)imageArray top:(CGFloat)fTop{
    _imageArray = imageArray;
    screen_width  = [UIScreen mainScreen].bounds.size.width;
    screen_height = [UIScreen mainScreen].bounds.size.height;
    self.frame = CGRectMake(0, 0, screen_width, screen_height);

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    _scrollView.contentSize=CGSizeMake(screen_width * (_imageArray.count + 1), screen_height);
    _scrollView.pagingEnabled=YES;
    _scrollView.bounces = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.tag = 7000;
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < imageArray.count; i++) {
        CGRect frame = CGRectMake(i * screen_width, 0, screen_width, screen_height);
        UIImageView *img = [[UIImageView alloc] initWithFrame:frame];
        img.image = [UIImage imageNamed:imageArray[i]];
        [_scrollView addSubview:img];
        
        if (i == imageArray.count - 1) {
            img.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapCominHome)];
            [img addGestureRecognizer:tap];
        }
    }
    [self addSubview:_scrollView];
    
    [self addSubview:self.pageView];
    self.pageView.numberOfPages = imageArray.count;
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scrollView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.top.equalTo(_scrollView.mas_top).offset(kDisHeight - 20 - fTop);
    }];
}

- (void)TapCominHome
{
    [self dismissGuideView];
}

- (UIPageControl *)pageView
{
    if (!_pageView) {
        _pageView = [[UIPageControl alloc] init];
        _pageView.backgroundColor = [UIColor colorWithHexString:@"ffffff" Alpha:0.7];
        _pageView.layer.cornerRadius = 10;
        _pageView.layer.borderColor = [UIColor colorWithHexString:@"cdcdcd"].CGColor;
        _pageView.layer.borderWidth = 0.5;
        _pageView.currentPage = 0;
        _pageView.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"11a1ea"];
        _pageView.pageIndicatorTintColor = [UIColor colorWithHexString:@"c8c8c8"];
    }
    return _pageView;
}

#pragma mark scrollView的代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x >= 4 * screen_width){
        [self dismissGuideView];
    }
}

// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageView.currentPage = scrollView.contentOffset.x/kDisWidth;
    if (scrollView.contentOffset.x >= 3 * screen_width){
        self.pageView.hidden = YES;
    }
    else
    {
        self.pageView.hidden = NO;
    }
}


-(void)dismissGuideView
{
    [UIView animateWithDuration:0.6f animations:^{
        self.transform = (CGAffineTransformMakeScale(1.5, 1.5));
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0; //让scrollview 渐变消失
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];


}

@end
