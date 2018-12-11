//
//  AppDelegate.m
//  海豚供应链
//
//  Created by Steffen.D on 16/11/22.
//  Copyright © 2016年 小东小东. All rights reserved.
//
#import "DetailViewController.h"
#import "ProductDetailModel.h"
#import "ProductParaModel.h"
#import "LoginViewController.h"
#import "ContactServiceViewController.h"
#import "ImageTextView.h"
#import "Message_VC.h"
#import "ShopingCart_VC.h"
#import "GetNumerView.h"
#import "AppDelegate.h"
#import "C_TabBarController.h"
#import "ProductExtentionModel.h"
#import "RecommendModel.h"
#import "DetailGoodsScroView.h"
#import "DetailGoodsScroModel.h"
#import "ShareTool.h"
#import "BackScrollView.h"
#import "HTLoadingTool.h"


//收藏
//加入收藏

static NSString * const kCancelCollectURL = @"/CollectGoods/delSelfCollectGoods";

static NSString * const kAddToCollectURL = @"/CollectGoods/setSelfCollectGoods";

static NSString * const KisCollectURL = @"/CollectGoods/checkSelfCollectGoods";

static NSString * const kGetCartNumURL = @"/cart/getTotal";

static NSString * const kAddToAddCartURLNEW = @"/cart/modify";

static NSString * const kProductInforURL = @"/goods/getGoodsInfo";

static CGFloat  const KSpaceW = 15;


NSString *const YKSShareSuccessCount=@"YKSShareSuccessCount";//友盟统计分享次数

@interface DetailViewController ()<UIScrollViewDelegate,ImageTextViewDelegate,GetNumerViewDelegate,DetailGoodsScroViewDelegate>
{
    BackScrollView  *rootScrollView;
    ImageTextView   *imageTextView;
    
    ZXNImageView     *imgView;          //图片
    UIView          *titleView;
    
    //    UITextView      *desc_lab;             //标题
    UILabel         *desc_lab;
    UIButton        *shareBtn;
    UILabel         *snlbl;
    UILabel         *sn_lab;               //商品编号
    
    UILabel         *passlbl;
    UILabel         *purchase_lab;         //采购价
    
    UILabel         *shoplbl;
    UILabel         *pricelbl;
    UILabel         *currentPrice_lab;     //包邮价
    UILabel         *stock_lab;            //库存
    
    UILabel         *salelbl;
    UILabel         *salePrice_lab;        //市场价
    
    UILabel         *for_lab;
    UILabel         *formula_lab;          //毛利公式
    
    UIView          *countView;
    
    UILabel         *cout_label ;
    GetNumerView    *getNumView;
    NSInteger        getNum;
    
    UILabel         *standard_label;       //规格
    UIView          *iconView;
    UIButton        *detailBtn;          //商品详情按钮
    UILabel         *bagelab;
    ZXNImageView     *comicView;
    
    ProductDetailModel *detailproduct;
    ProductExtentionModel *extentionData;
    NSString              *extentionCollet;
    NSString        *iscolletID;
    UIButton        *collectBtn;
    NSMutableArray  *speArray;
    NSMutableArray  *valuseArray;   //属性数组
    NSMutableArray  *paraArray;     //参数数组
    
    BlankPageView  *blankView;
    
    UIView          *bottomView;
    
    NSMutableDictionary * colletDict;
    
    float            product_price;
    float            makprice;
    
    BOOL             isClick;//组合按钮是否点击
    NSNumber         *memberID;
    
    CGFloat          recHeight;
    UIView           *suitview;
    
    DetailGoodsScroView *detailgoodsScroView; //商品排行推荐
    DetailGoodsScroModel *detailgoodsModel;
    NSMutableArray *detailgoodsArr;
    
    //    这里是新界面的属性
    UIView           *goodsView;//商品模块
    UIView           *goodsBjview;
    UIView           *blurredView;//蒙版
    UIButton         *pictureBtn;
    UILabel          *priceLab;//价格
    UILabel          *numberLab;//商品编号
    UIButton         *cancerBtn;//取消
    UIButton         *gradeBtn;//几段
    UILabel          *numbercountLab;//数量
    UILabel          *stockLab;//库存
    GetNumerView     *getnumberView;//加减数量按钮
    NSInteger         gradeCount;
    
    UIButton         *collectHouseBtn;//加入收藏
    int              tagTAG;
    UIView           *suitView;//套装View
    NSInteger         suitGroupCount;//组合套装的个数
    UILabel          *snLab;
    UILabel          *sn_Lab;
    UIButton         *serviceBtn;
    UIButton         *selectBtn;
    NSDictionary     *suitDict;
    UILabel          *suit_Lab;//已选lab
    UILabel          *testBtn;
    CGFloat          testLength;
    UILabel *        stock_Lab;
    
    
    //图片滚动
    UIScrollView     *scroView;
    ZXNImageView     *scroImageView;
    UIPageControl    *pageController;
    UILabel          *countLab;
    ZXNImageView      *firstView;
    NSInteger        count;
    
    //大图展示
    UIScrollView     *largeImageView;//大图展示界面
    UILabel          *pageLab;
    UIScrollView     *largeScrollerView;
    
    NSMutableArray * imgoriginal;
    NSString * imagesStr;
    
    NSInteger        number;//购物车小图标数量
    UILabel *line;
    UIImageView *parting_line2;
    UIImageView *parting_line;
    UILabel * suitLab;
    UIImageView * suitImage;
    UIButton * suitBtn;
    UIView * coverView;
    
    NSMutableDictionary * dictDict;
    
    UIButton * Btn;
    UIButton *cartBtn;
    
}
@property (nonatomic ,strong)UIScrollView * scroBottomView;
@property (nonatomic, assign) BOOL isEnd;

@end

@implementation DetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isEnd = NO;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"商品详情";
    
    [self setUI];
    [self loadRightItems];
    [self makeBottomView];
    
    [self loadData];
    
}

-(void)setUI
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40,30)];
    [btn setImage:[UIImage drawImageWithName:@"detailBack" size:CGSizeMake(40, 30)] forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    
    recHeight = 0.0;
    self.view.backgroundColor=color(240, 240, 240, 1);
    
    rootScrollView=[[BackScrollView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, kDisHeight - kDisNavgation - 40)];
    rootScrollView.tag = 100;
    rootScrollView.showsHorizontalScrollIndicator=NO;
    rootScrollView.showsVerticalScrollIndicator=NO;
    rootScrollView.backgroundColor=color(239, 239, 244, 1.0);
    rootScrollView.directionalLockEnabled =YES;
    [self.view addSubview:rootScrollView];
    
    //创建图文详情视图
    imageTextView=[[ImageTextView alloc] initWithFrame:CGRectMake(0, kDisHeight, kDisWidth, kDisHeight-40)];
    imageTextView.delegate=self;
    
    [self.view addSubview:imageTextView];
    imgView=[[ZXNImageView alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, kDisWidth)];
    
    //图片滚动界面
    scroView = [[UIScrollView alloc]init];
    scroView.tag = 101;
    scroView.delegate = self;
    scroView.frame = CGRectMake(0, 0, kDisWidth, kDisWidth);
    scroView.showsHorizontalScrollIndicator = NO;
    scroView.showsVerticalScrollIndicator = YES;
    [rootScrollView addSubview:scroView];
    
    comicView = [[ZXNImageView alloc] initWithFrame:CGRectZero];
    comicView.center = self.view.center;
    [self.view addSubview:comicView];
    
    titleView = [[UIView alloc] initWithFrame:CGRectZero];
    titleView.backgroundColor=[UIColor whiteColor];
    [rootScrollView addSubview:titleView];
    
    //商品名字
    desc_lab = [[UILabel alloc] init];
    desc_lab.numberOfLines = 0;
    desc_lab.font=[UIFont systemFontOfSize:14.0f];
    desc_lab.textColor=[UIColor colorWithHexString:@"#333333"];
    [titleView addSubview:desc_lab];
    
    snlbl=[[UILabel alloc] init];
    snlbl.text=@"编 号 ";
    snlbl.textColor=[UIColor colorWithHexString:@"#666666"];
    snlbl.font=[UIFont systemFontOfSize:12.0];
    [titleView addSubview:snlbl];
    
    sn_lab=[[UILabel alloc] init];
    sn_lab.textColor=[UIColor colorWithHexString:@"#333333"];
    sn_lab.font=[UIFont systemFontOfSize:12];
    [titleView addSubview:sn_lab];
    
    snLab = [[UILabel alloc]init];
    snLab.text = @"说 明 ";
    snLab.textColor=[UIColor colorWithHexString:@"#666666"];
    snLab.font=[UIFont systemFontOfSize:12.0];
    [titleView addSubview:snLab];
    
    sn_Lab = [[UILabel alloc]init];
    sn_Lab.text = @"商品包税 商品包邮";
    sn_Lab.textColor=[UIColor colorWithHexString:@"#333333"];
    sn_Lab.font=[UIFont systemFontOfSize:12.0];
    [titleView addSubview:sn_Lab];
    
    stock_lab = [[UILabel alloc]init];
    stock_lab.font = [UIFont systemFontOfSize:14];
    stock_lab.textColor=kCustomBlack;
    [titleView addSubview:stock_lab];
    
    passlbl=[[UILabel alloc] init];
    passlbl.textColor=[UIColor colorWithHexString:@"#666666"];
    passlbl.text=@"单件价：";
    passlbl.font=[UIFont systemFontOfSize:12.0];
    [titleView addSubview:passlbl];
    
    purchase_lab=[[UILabel alloc] init];
    purchase_lab.textColor=[UIColor colorWithHexString:@"#666666"];
    purchase_lab.font=[UIFont systemFontOfSize:12.0];
    [titleView addSubview:purchase_lab];
    
    shoplbl=[[UILabel alloc] init];
    shoplbl.text=@"含税总价：";
    shoplbl.textColor=[UIColor colorWithHexString:@"#666666"];
    shoplbl.font=[UIFont systemFontOfSize:12.0];
    [titleView addSubview:shoplbl];
    
    pricelbl=[[UILabel alloc] init];
    pricelbl.text=@"¥";
    pricelbl.textColor=[UIColor redColor];
    pricelbl.font=[UIFont systemFontOfSize:11.0];
    [titleView addSubview:pricelbl];
    
    currentPrice_lab = [[UILabel alloc]init];
    currentPrice_lab.textColor = [UIColor redColor];
    currentPrice_lab.font=[UIFont systemFontOfSize:22];
    currentPrice_lab.textAlignment = NSTextAlignmentLeft;
    [titleView addSubview:currentPrice_lab];
    
    salelbl=[[UILabel alloc] init];
    salelbl.textColor=[UIColor colorWithHexString:@"#666666"];
    salelbl.text=@"市场价：";
    salelbl.font=[UIFont systemFontOfSize:12.0];
    [titleView addSubview:salelbl];
    
    salePrice_lab = [[UILabel alloc]init];
    salePrice_lab.font = [UIFont systemFontOfSize:12.0];
    salePrice_lab.textColor=[UIColor colorWithHexString:@"#666666"];
    [titleView addSubview:salePrice_lab];
    
    suitview = [[UIView alloc]init];
    suitview.backgroundColor = [UIColor whiteColor];
    [titleView addSubview:suitview];
    
    //滑动商品goods
    detailgoodsScroView = [[DetailGoodsScroView alloc]init];
    detailgoodsScroView.tag = 102;
    detailgoodsScroView.delegate = self;
    detailgoodsScroView.backgroundColor = [UIColor whiteColor];
    [titleView addSubview:detailgoodsScroView];
    
    countView=[[UIView alloc] initWithFrame:CGRectZero];
    countView.backgroundColor=[UIColor whiteColor];
    
    cout_label = [[UILabel alloc]init];
    cout_label.text = @"邮费";
    cout_label.textColor=[UIColor colorWithHexString:@"#666666"];
    cout_label.font = [UIFont systemFontOfSize:12];
    [countView addSubview:cout_label];
    
    getNumView=[[GetNumerView alloc] init];
    getNumView.delegate=self;
    [titleView addSubview:getNumView];
    
    standard_label = [[UILabel alloc]init];
    standard_label.font = [UIFont boldSystemFontOfSize:12.0];
    [countView addSubview:standard_label];
    
    //详情属性
    scroImageView = [[ZXNImageView alloc]init];
    firstView = [[ZXNImageView alloc]init];
    countLab = [[UILabel alloc]init];
    pageController = [[UIPageControl alloc]init];
    line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 0.5)];
    parting_line2 = [[UIImageView alloc] init];
    parting_line = [[UIImageView alloc] init];
    suit_Lab = [[UILabel alloc]init];
    suitLab = [[UILabel alloc]init];
    suitImage = [[UIImageView alloc]init];
    suitBtn = [[UIButton alloc]init];
    coverView =[[UIView alloc]init];
    
    //上拉查看图文详情
    detailBtn=[[UIButton alloc] initWithFrame:CGRectZero];
    [detailBtn setImage:[UIImage drawImageWithName:@"toppull" size:CGSizeMake(130, 15)] forState:UIControlStateNormal];
    [rootScrollView addSubview:detailBtn];
    
    //属性初始化
    detailproduct=[[ProductDetailModel alloc] init];
    extentionData = [[ProductExtentionModel alloc]init];
    extentionCollet = [[NSString alloc]init];
    iscolletID = [[NSString alloc]init];
    colletDict = [[NSMutableDictionary alloc]init];
    valuseArray = [[NSMutableArray alloc] init];
    speArray = [[NSMutableArray alloc] init];
    paraArray = [[NSMutableArray alloc] init];
    blankView = [[BlankPageView alloc] initWithFrame:CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight-kDisNavgation)];
    [self.view addSubview:blankView];
    blankView.hidden = YES;
    dictDict = [[NSMutableDictionary alloc]init];
    
    //加减按钮是否被点击
    getnumberView.isdidClick = NO;
    //组合按钮是否被点击
    isClick = NO;
    
    
}

#pragma mark--获得商品详情数据
-(void)loadData{
    blankView.hidden=YES;
    rootScrollView.hidden=NO;
    bottomView.hidden=NO;
    
    [HTLoadingTool showLoadingForView:self.view];
    NSDictionary *dic = @{@"sku":_sku,
                          @"description":@"1",
                          @"gallery":@"1",
                          @"standard":@"1",
                          @"extension":@"1",
                          @"brand_sku":@"1",
                          @"type":@"ios"
                          };
    
    [AFHTTPClient POST:kProductInforURL params:dic successInfo:^(ResponseModel *response) {
        
        
        //解析数据
        id json = @{@"data":response.dataResponse};
        [self refreshData:json];
        
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        if (type == NEED_HINT || type == NO_NETWORK)
        {
            blankView.hidden = NO;
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            return ;
        }
        
        if (type == SERVICE_ERROR) {
            blankView.hidden = NO;
            return ;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
    
}

-(void)refreshData:(id)json{
    
    NSDictionary *dict=[json objectForKey:@"data"];
    
    [detailproduct setValues:dict];
    extentionCollet = detailproduct.goods_id;
    iscolletID = detailproduct.goods_id;
    if (detailproduct.is_collect) {
        collectBtn.selected = YES;
    }
    imgoriginal = [[NSMutableArray alloc]init];
    NSArray * img_original = [[json objectForKey:@"data"] objectForKey:@"gallery"];
    if (img_original.count != 0) {
        for (NSDictionary * dic in img_original) {
            NSString * str = [dic objectForKey:@"img_original"];
            [imgoriginal addObject:str];
        }
    }
    
    
    //先判断商品是否收藏
    if ([YKSUserDefaults isLogin]) {
        [self checkIscollect];
    }
    imagesStr = [dict objectForKey:@"description_html"];
    
    NSArray * arr = [dict objectForKey:@"brand_sku"];
    detailgoodsScroView.frame = CGRectMake(0,suitview.bottom, kDisWidth, (kDisWidth-30)/3+100);
    detailgoodsScroView.detailGoodsScroArr = arr;
    suitDict = [[NSMutableDictionary alloc]init];
    NSString * imgStr = @"";
    //轮换图如果为空 则轮换图为@“none” picture 图为@“none”
    if (imgoriginal.count == 0) {
        imgStr = detailproduct.img_original;
        [imgoriginal addObject:imgStr];
    }else{
        imgStr = imgoriginal[0];
    }
    [suitDict setValue:imgStr forKey:@"imgKey"];
    [suitDict setValue:detailproduct.price forKey:@"priceKey"];
    //如果商品没有属性组合 取商品本身一个属性
    if (detailproduct.extension.count == 0) {
        [suitDict setValue:detailproduct.goods_id forKey:@"goods_id"];
        [suitDict setValue:detailproduct.stock forKey:@"numberKey"];
        //如果数量按钮和组合按钮都不点击 取默认值
        
        [dictDict setValue:detailproduct.goods_id forKey:@"goods_id"];
        [dictDict setValue:detailproduct.min_purchase_quantity forKey:@"min_purchase_quantity"];
    }else{
        NSString * goods_id = [detailproduct.extension[0] objectForKey:@"goods_id"];
        [suitDict setValue:goods_id forKey:@"goods_id"];
        NSString * stock = [detailproduct.extension[0] objectForKey:@"stock"];
        NSString * minQuantity = [detailproduct.extension[0] objectForKey:@"min_purchase_quantity"];
        [suitDict setValue:stock forKey:@"numberKey"];
        //如果数量按钮和组合按钮都不点击 取默认值
        
        [dictDict setValue:goods_id forKey:@"goods_id"];
        [dictDict setValue:minQuantity forKey:@"min_purchase_quantity"];
    }
    [suitDict setValue:detailproduct.goods_name forKey:@"btnKey"];
    
    NSMutableArray *pro= detailproduct.standard;
    if (pro.count) {
        for (int i =0; i< pro.count; i++) {
            NSDictionary * arrM = pro[i];
            ProductParaModel *paraModel = [[ProductParaModel alloc]init];
            [paraModel setValues:arrM];
            [paraArray addObject:paraModel];
        }
        [imageTextView loadForParameterViewWithParameters:paraArray];
    }
    [self refreshData];
    cartBtn.userInteractionEnabled = YES;
    collectBtn.userInteractionEnabled = YES;
}

#pragma mark 刷新数据
-(void)refreshData{
    NSString * str1 = @"";
    if (imgoriginal.count == 0) {
        str1 = @"none";
    }else{
        str1 = imgoriginal[0];
    }
    
    if (str1 != nil) {
        NSString *str=[NSString stringWithFormat:@"%@", str1];
        
        [imgView downloadImage:str backgroundImage:ZXNImageDefaul];
        
        [comicView downloadImage:str backgroundImage:ZXNImageDefaul];
        
        //设置滚动图片
        count = imgoriginal.count;
        for (int i =0; i<count-1; i++) {
            scroImageView=[[ZXNImageView alloc] initWithFrame:CGRectMake((i+1)*kDisWidth, 0, kDisWidth, kDisWidth)];
            NSString * strUrl = [NSString stringWithFormat:@"%@", imgoriginal[i+1]];
            //            [scroImageView sd_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:@"none"]];
            [scroImageView downloadImage:strUrl backgroundImage:ZXNImageDefaul];
            scroView.pagingEnabled =YES;
            scroView.tag = 1000;
            scroView.contentSize = CGSizeMake(kDisWidth*count, kDisWidth);
            [scroView addSubview:scroImageView];
        }
        firstView.frame = CGRectMake(0, 0, kDisWidth, kDisWidth);
        NSString * firstrStr = @"";
        if (imgoriginal.count == 0) {
            firstrStr = @"none";
        }else{
            firstrStr = imgoriginal[0];
        }
        [firstView downloadImage:firstrStr backgroundImage:ZXNImageDefaul];
        
        [scroView addSubview:firstView];
        countLab.backgroundColor = [UIColor whiteColor];
        countLab.frame = CGRectMake(kDisWidth/8-8, 15, 35, 35);
        countLab.textAlignment = NSTextAlignmentCenter;
        countLab.textColor = [UIColor colorWithHexString:@"#666666"];
        if (count == 1 || count == 0) {
            countLab.hidden = YES;
        }else{
            countLab.text = [NSString stringWithFormat:@"1/%ld",(long)count];
            countLab.layer.cornerRadius = 35/2;
            countLab.layer.borderWidth = 1;
            countLab.layer.borderColor = [UIColor colorWithHexString:@"#666666"].CGColor;
            countLab.layer.masksToBounds = YES;
            [rootScrollView addSubview:countLab];
        }
        
        pageController.frame = CGRectMake((kDisWidth-100)/2, scroImageView.bottom-30, 100, 30);
        pageController.currentPageIndicatorTintColor = ColorAPPTheme;
        pageController.pageIndicatorTintColor = [UIColor whiteColor];
        pageController.enabled = NO;
        if (count == 1) {
            pageController.hidden = YES;
        }
        else
        {
            pageController.numberOfPages = count;
            [rootScrollView addSubview:pageController];
        }
    }
    //商品编号
    snlbl.frame=CGRectMake(KSpaceW, parting_line2.bottom+5, 35.0, 20.0);
    sn_lab.frame=CGRectMake(snlbl.right, parting_line2.bottom+5.0, 150.0, 20.0);
    
    //商品说明
    snLab.frame = CGRectMake(KSpaceW, snlbl.bottom+5, 35, 20.0);
    sn_Lab.frame = CGRectMake(snLab.right, snlbl.bottom+5, 200, 20.0);
    
    //商品名字
    line.backgroundColor = kLineColer;
    desc_lab.text = detailproduct.goods_name;
    CGFloat labWidth=kDisWidth-20;
    CGFloat labHeight=[desc_lab.text boundingRectWithSize:CGSizeMake(labWidth,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:desc_lab.font,NSFontAttributeName,nil] context:nil].size.height;
    desc_lab.frame=CGRectMake(KSpaceW, line.bottom +5, labWidth, labHeight+35);
    CGFloat line_width = kDisWidth - KSpaceW * 2;
    
    //设置行距
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:detailproduct.goods_name];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 5.f;
    [att addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [detailproduct.goods_name length])];
    [desc_lab setAttributedText:att];
    //    desc_lab.backgroundColor = [UIColor redColor];
    
    //已选
    suitLab.text = @"已 选 ";
    suitLab.font = [UIFont systemFontOfSize:12];
    suitLab.textColor = kCustomWordColor;
    suitLab.frame = CGRectMake(KSpaceW, 0, 35, 34);
    [suitview addSubview:suitLab];
    
    //官网价
    pricelbl.frame=CGRectMake(KSpaceW, desc_lab.bottom+5.0,10.0, 20);
    currentPrice_lab.frame = CGRectMake(pricelbl.right, desc_lab.bottom, 80.0, 25);
    
    //单件价
    passlbl.frame=CGRectMake(currentPrice_lab.right, desc_lab.bottom+5.0, 50.0, 20.0);
    float purPrice=[detailproduct.single_price floatValue];
    purchase_lab.text=[NSString stringWithFormat:@"¥%.2f",purPrice];
    purchase_lab.frame=CGRectMake(passlbl.right, desc_lab.bottom+5.0, 50.0, 20.0);
    
    //市场价
    makprice=[detailproduct.market_price floatValue];
    salePrice_lab.text = [NSString stringWithFormat:@"¥%.2f",makprice];
    salelbl.frame=CGRectMake(purchase_lab.right+5.0, desc_lab.bottom+5.0, 50.0, 20.0);
    salePrice_lab.frame = CGRectMake(salelbl.right, desc_lab.bottom+5.0, 50, 20);
    
    parting_line2.frame = CGRectMake(KSpaceW, currentPrice_lab.bottom+5, line_width, line_width/345);
    parting_line2.image = [UIImage imageNamed:@"parting_line"];
    [titleView addSubview:parting_line2];
    
    
    snlbl.frame=CGRectMake(KSpaceW, parting_line2.bottom+5, 35.0, 20.0);
    sn_lab.frame=CGRectMake(snlbl.right, parting_line2.bottom+5.0, 150.0, 20.0);
    
    snLab.frame = CGRectMake(KSpaceW, snlbl.bottom+5, 35, 20.0);
    sn_Lab.frame = CGRectMake(snLab.right, snlbl.bottom+5, 200, 20.0);
    
    parting_line.frame = CGRectMake(KSpaceW, snLab.bottom + 5, line_width, line_width/345);
    parting_line.image = [UIImage imageNamed:@"parting_line"];
    [titleView addSubview:parting_line];
    suitview.frame = CGRectMake(0,parting_line.bottom, kDisWidth, 44);
    
    suitLab.text = @"已 选 ";
    suitLab.font = [UIFont systemFontOfSize:12];
    suitLab.textColor = kCustomWordColor;
    suitLab.frame = CGRectMake(KSpaceW, 0, 35, 34);
    [suitview addSubview:suitLab];
    
    suit_Lab.font = [UIFont systemFontOfSize:12];
    suit_Lab.textColor = [UIColor colorWithHexString:@"#333333"];
    suit_Lab.frame = CGRectMake(suitLab.right, 0, 200, 34);
    [suitview addSubview:suit_Lab];
    
    suitImage.image = [UIImage imageNamed:@"accessory"];
    suitImage.frame = CGRectMake(suitview.right-KSpaceW-20, 7, 20, 20);
    [suitview addSubview:suitImage];
    
    //已选按钮
    suitBtn.backgroundColor = [UIColor clearColor];
    suitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    suitBtn.frame = CGRectMake(0, 0, kDisWidth, 34);
    [suitBtn addTarget:self action:@selector(addProductToCart:) forControlEvents:UIControlEventTouchUpInside];
    [suitview addSubview:suitBtn];
    
    //阴影View
    coverView.frame = CGRectMake(0, suitImage.bottom+7, kDisWidth, 20);
    coverView.backgroundColor = color(239, 239, 244, 1.0);
    [suitview addSubview:coverView];
    
    detailgoodsScroView.frame = CGRectMake(0,suitview.bottom, kDisWidth, (kDisWidth-30)/3+100);
    [titleView addSubview:line];
    
    titleView.frame = CGRectMake(0, imgView.bottom, kDisWidth, detailgoodsScroView.bottom);
    cout_label.frame = CGRectMake(KSpaceW, 0, 50, 30);
    
    
    [countView setFrame:CGRectMake(0, titleView.bottom+5, kDisWidth, 30)];
    sn_lab.text = detailproduct.sku;
    product_price = [detailproduct.price floatValue];
    
    
    currentPrice_lab.text =  [NSString stringWithFormat:@"%.2f",product_price];
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:currentPrice_lab.text];
    NSInteger index = currentPrice_lab.text.length-3;
    if (index < 0) {
        index = 2;
    }
    NSRange rangel = [[textColor string] rangeOfString:[currentPrice_lab.text substringFromIndex:index]];
    [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rangel];
    [textColor addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:rangel];
    [currentPrice_lab setAttributedText:textColor];
    
    
    [self changeView];
}

//设置recommendView坐标以及设置rootScroller的滑动区域
- (void)changeView{
    [detailBtn setFrame:CGRectMake(KSpaceW, titleView.bottom+20, kDisWidth-2*KSpaceW, 30.0)];
    [rootScrollView setContentSize:CGSizeMake(0, detailBtn.bottom+90.0)];
}

-(void)setGoodsView{
    //套装界面的设置
    CGFloat margin = 10;
    CGFloat margin2 = 15;
    pictureBtn = [[UIButton alloc]initWithFrame:CGRectMake(margin, -margin, 90, 90)];
    NSDictionary * arrDict = [[NSDictionary alloc]init];
    if (detailproduct.extension.count != 0) {
        arrDict = detailproduct.extension[0];
    }
    if ([detailproduct.img_original isEqual:[NSNull null]]) {
        UIImageView * btnImgView = [[UIImageView alloc]initWithFrame:CGRectMake(margin, -margin, 80, 90)];
        btnImgView.image = [UIImage imageNamed:@"none"];
        UIImage * img = btnImgView.image;
        [pictureBtn addTarget:self action:@selector(pictureBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [pictureBtn setImage:img forState:UIControlStateNormal];
    }else
    {
        NSString * str1 = @"";
        if (detailproduct.extension.count == 0) {
            if (imgoriginal.count == 0) {
                str1 = @"";
            }
            else
            {
                str1 = [suitDict objectForKey:@"imgKey"];
            }
        }
        else
        {
            str1 = [suitDict objectForKey:@"imgKey"];
        }
        if (str1 != nil) {
            ZXNImageView * btnImgView = [[ZXNImageView alloc]initWithFrame:CGRectMake(margin, -margin, 80, 90)];
            //            [btnImgView sd_setImageWithURL:[NSURL URLWithString:str1] placeholderImage:[UIImage imageNamed:@"none"]];
            [btnImgView downloadImage:str1 backgroundImage:ZXNImageDefaul];
            UIImage * img = btnImgView.image;
            [pictureBtn addTarget:self action:@selector(pictureBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
            [pictureBtn setImage:img forState:UIControlStateNormal];
            
        }
    }
    pictureBtn.backgroundColor=[UIColor clearColor];
    pictureBtn.layer.borderColor=kLineColer.CGColor;
    pictureBtn.layer.borderWidth=0.5;
    pictureBtn.layer.masksToBounds=YES;
    [goodsView addSubview:pictureBtn];
    
    numberLab = [[UILabel alloc]init];
    if (detailproduct.extension.count == 0) {
        numberLab.text = [NSString stringWithFormat:@"商品编号：%@",detailproduct.sku];
    }else{
        numberLab.text = [NSString stringWithFormat:@"商品编号：%@",[arrDict objectForKey:@"sku"]];
    }
    numberLab.textColor = [UIColor colorWithHexString:@"#333333"];
    numberLab.font = [UIFont systemFontOfSize:12];
    numberLab.frame = CGRectMake(pictureBtn.right+margin, pictureBtn.bottom-25, 150, 25);
    numberLab.backgroundColor = [UIColor whiteColor];
    [goodsView addSubview:numberLab];
    
    priceLab = [[UILabel alloc]init];
    priceLab.backgroundColor = [UIColor whiteColor];
    if (detailproduct.extension.count == 0) {
        priceLab.text = [NSString stringWithFormat:@"￥%@",detailproduct.price];
    }else{
        priceLab.text = [NSString stringWithFormat:@"￥%@",[arrDict objectForKey:@"price"]];
    }
    
    priceLab.font = [UIFont systemFontOfSize:18];
    [priceLab setTextColor:[UIColor redColor]];
    priceLab.frame = CGRectMake(pictureBtn.right+margin, numberLab.top-25, 100, 25);
    [goodsView addSubview:priceLab];
    
    UIImageView * labImageView = [[UIImageView alloc]init];
    labImageView.frame = CGRectMake(goodsView.right-margin-25, margin, 15, 15);
    labImageView.image = [UIImage drawImageWithName:@"close-1" size:CGSizeMake(15, 15)];
    [goodsView addSubview:labImageView];
    
    cancerBtn = [[UIButton alloc]init];
    cancerBtn.backgroundColor = [UIColor clearColor];
    cancerBtn.frame = CGRectMake(goodsView.right-margin-50, margin, 70, 50);
    [cancerBtn addTarget:self action:@selector(cancerBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [goodsView addSubview:cancerBtn];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = kLineColer;
    lineView1.frame = CGRectMake(0, pictureBtn.bottom+margin, kDisWidth, 1);
    [goodsView addSubview:lineView1];
    
    UILabel * lab = [[UILabel alloc]init];
    lab.backgroundColor = [UIColor whiteColor];
    lab.text = [NSString stringWithFormat:@"段位"];
    lab.textColor = [UIColor colorWithHexString:@"#333333"];
    lab.font = [UIFont systemFontOfSize:12];
    lab.frame = CGRectMake(margin, lineView1.bottom+margin, 25, 25);
    lab.textAlignment = NSTextAlignmentCenter;
    [goodsView addSubview:lab];
    
    NSMutableArray * arrExtention = detailproduct.extension;
    [goodsView addSubview:self.scroBottomView];
    
    [self.scroBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(goodsView);
        make.top.equalTo(lab.mas_bottom);
        make.bottom.equalTo(goodsView).offset(-44);
    }];
    
    gradeCount = arrExtention.count;
    CGFloat width = 0;
    CGFloat Height = 0;
    CGFloat height = 0+margin2;
    CGRect  testFrame = CGRectZero;
    NSString *testStr = [[NSString alloc]init];
    for (int i =0; i<gradeCount; i++) {
        NSMutableDictionary * dict = arrExtention[i];
        UIButton * btn = [[UIButton alloc]init];
        //        btn.backgroundColor = [UIColor redColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitle:[NSString stringWithFormat:@"%@",[dict objectForKey:@"attribute"]]forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%@",[dict objectForKey:@"attribute"]]forState:UIControlStateHighlighted];
        [btn setTitleColor:ColorAPPTheme forState:UIControlStateHighlighted];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.backgroundColor=[UIColor clearColor];
        btn.layer.borderColor=kLineColer.CGColor;
        btn.layer.borderWidth=0.5;
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds=YES;
        btn.tag = i;
        selectBtn = [[UIButton alloc]init];
        
        //设置btn宽度随字体变化而变化
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGFloat length = [[dict objectForKey:@"attribute"] boundingRectWithSize:CGSizeMake(kDisWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        testLength = length;
        btn.frame = CGRectMake(margin2+width,height , length+margin2, 25);
        if (margin2+width+length+margin2 > kDisWidth) {
            width = 0;
            height = height +25 + margin;
            btn.frame = CGRectMake(margin2 +width, height, length +margin2, 25);
        }
        width = btn.frame.size.width + btn.frame.origin.x;
        Height = btn.frame.origin.y+40;
        [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        if (btn.tag == 0) {
            testFrame = btn.frame;
            testStr = btn.titleLabel.text;
        }
        [self.scroBottomView addSubview:btn];
    }
    testBtn = [[UILabel alloc]initWithFrame:CGRectZero];
    testBtn.backgroundColor = [UIColor whiteColor];
    testBtn.hidden = NO;
    testBtn.frame = testFrame;
    testBtn.text = testStr;
    testBtn.textColor = ColorAPPTheme;
    testBtn.layer.borderColor = ColorAPPTheme.CGColor;
    testBtn.layer.borderWidth = 0.5;
    testBtn.layer.cornerRadius = 5;
    testBtn.layer.masksToBounds = YES;
    testBtn.font = [UIFont systemFontOfSize:12];
    testBtn.textAlignment = NSTextAlignmentCenter;
    [self.scroBottomView addSubview:testBtn];
    
    //如果extention 数据 为空
    UIView * groupView = [[UIView alloc]init];
    if (arrExtention.count == 0) {
        groupView.frame = CGRectMake(0, 0, kDisWidth, 50);
        
    }else{
        groupView.frame = CGRectMake(0, Height+2, kDisWidth, 50);
        
    }
    groupView.backgroundColor = [UIColor whiteColor];
    [self.scroBottomView addSubview:groupView];
    [self.scroBottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(goodsView);
        make.top.equalTo(lab.mas_bottom);
        make.bottom.equalTo(groupView);
    }];
    
    
    numbercountLab = [[UILabel alloc]init];
    numbercountLab.backgroundColor = [UIColor whiteColor];
    numbercountLab.text = [NSString stringWithFormat:@"数量"];
    numbercountLab.font = [UIFont systemFontOfSize:12];
    numbercountLab.textColor = [UIColor colorWithHexString:@"#333333"];
    numbercountLab.frame = CGRectMake(margin, 10, (kDisWidth-5*margin)/4+margin, 25);
    [groupView addSubview:numbercountLab];
    
    getnumberView = [[GetNumerView alloc]init];
    getnumberView.backgroundColor = [UIColor whiteColor];
    getnumberView.delegate = self;
    getnumberView.frame = CGRectMake(groupView.right-120-margin,5, 120, 35);
    if (detailproduct.extension.count == 0) {
        getnumberView.countText=[NSString stringWithFormat:@"%@",detailproduct.min_purchase_quantity];
        getNum=[detailproduct.min_purchase_quantity integerValue];
    }else{
        getnumberView.countText=[NSString stringWithFormat:@"%@",[arrDict objectForKey:@"min_purchase_quantity"]];
        getNum=[[arrDict objectForKey:@"min_purchase_quantity"] integerValue];
    }
    
    [groupView addSubview:getnumberView];
    
    stockLab = [[UILabel alloc]init];
    stockLab.backgroundColor = [UIColor whiteColor];
    stockLab.textAlignment = NSTextAlignmentCenter;
    stockLab.textColor = [UIColor colorWithHexString:@"#333333"];
    stockLab.text = @"库存 :";
    stockLab.font = [UIFont systemFontOfSize:12];
    stockLab.frame = CGRectMake(getnumberView.left-40-50, 10,40, 25);
    [groupView addSubview:stockLab];
    
    stock_Lab = [[UILabel alloc]init];
    stock_Lab.backgroundColor = [UIColor whiteColor];
    stock_Lab.textAlignment = NSTextAlignmentLeft;
    stock_Lab.textColor = [UIColor colorWithHexString:@"#333333"];
    if (detailproduct.extension.count == 0) {
        stock_Lab.text = [NSString stringWithFormat:@"%@",detailproduct.stock];
    }else{
        stock_Lab.text = [NSString stringWithFormat:@"%@",[arrDict objectForKey:@"stock"]];
    }
    
    stock_Lab.font = [UIFont systemFontOfSize:12];
    stock_Lab.frame = CGRectMake(stockLab.right, 10, 45, 25);
    [groupView addSubview:stock_Lab];
    
    
    collectHouseBtn = [[UIButton alloc]init];
    collectHouseBtn.backgroundColor = [UIColor colorWithHexString:@"#12a1ea"];
    [collectHouseBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [collectHouseBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [collectHouseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    collectHouseBtn.frame = CGRectMake(0, goodsView.size.height-44, kDisWidth, 44);
    [collectHouseBtn addTarget:self action:@selector(todoSomethingg:) forControlEvents:UIControlEventTouchUpInside];
    collectHouseBtn.hidden = YES;
    [goodsView addSubview:collectHouseBtn];
    
    UIView * suitGroupBtnView = [[UIView alloc]init];
    suitGroupBtnView.frame = CGRectMake(0, goodsView.size.height-48, kDisWidth, 44);
    suitGroupBtnView.hidden = NO;
    [goodsView addSubview:suitGroupBtnView];
    
    switch (tagTAG) {
        case 100:
            collectHouseBtn.hidden = NO;
            suitGroupBtnView.hidden = YES;
            break;
        case 200:
            collectHouseBtn.hidden = YES;
            suitGroupBtnView.hidden = YES;
            break;
        case 300:
            collectHouseBtn.hidden = YES;
            suitGroupBtnView.hidden = NO;
            break;
        default:
            break;
    }
}
#pragma mark 套装按钮点击刷新数据

-(void)btnDidClick:(UIButton *)btn{
    isClick = YES;
    if (selectBtn == btn) {
    }else{
        [btn setTitleColor:ColorAPPTheme forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor clearColor];
        btn.layer.borderColor=ColorAPPTheme.CGColor;
        btn.layer.borderWidth=0.5;
        btn.layer.masksToBounds=YES;
        
        //开始刷新套装数据
        [self refreshSuitViewData:btn];
        [selectBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        selectBtn.backgroundColor=[UIColor clearColor];
        selectBtn.layer.borderColor=kLineColer.CGColor;
        selectBtn.layer.borderWidth=0.5;
        selectBtn.layer.masksToBounds=YES;
    }
    selectBtn = btn;
    [testBtn removeFromSuperview];
    
}

-(void)refreshSuitViewData:(UIButton *)btn{
    NSMutableArray * arrExtention = detailproduct.extension;
    for (NSDictionary * dict in arrExtention) {
        [extentionData setValues:dict];
        if ([btn.titleLabel.text isEqualToString:extentionData.attribute]) {
            
            NSString *str1=[NSString stringWithFormat:@"%@",extentionData.img_original];
            CGFloat margin = 10;
            ZXNImageView * btnImgView = [[ZXNImageView alloc]initWithFrame:CGRectMake(margin, -margin, 90, 90)];
            if (str1 != nil) {
                //                [btnImgView sd_setImageWithURL:[NSURL URLWithString:str1] placeholderImage:[UIImage imageNamed:@"none"]];
                [btnImgView downloadImage:str1 backgroundImage:ZXNImageDefaul];
                UIImage * img = btnImgView.image;
                [pictureBtn setImage:img forState:UIControlStateNormal];
            }
            numberLab.text = [NSString stringWithFormat:@"商品编号：%@",extentionData.sku];
            priceLab.text = [NSString stringWithFormat:@"￥%@",extentionData.price];
            stock_Lab.text = [NSString stringWithFormat:@"%@",extentionData.stock];
            getnumberView.countText=[NSString stringWithFormat:@"%@",extentionData.min_purchase_quantity];
            getNum=[extentionData.min_purchase_quantity integerValue];
            
            //主界面数据更新
            sn_lab.text = [NSString stringWithFormat:@"%@",extentionData.sku];
            purchase_lab.text = [NSString stringWithFormat:@"¥%@",extentionData.single_price];
            currentPrice_lab.text = [NSString stringWithFormat:@"%@",extentionData.price];
            NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:currentPrice_lab.text];
            NSInteger index = currentPrice_lab.text.length-3;
            if (index < 0) {
                index = 2;
            }
            NSRange rangel = [[textColor string] rangeOfString:[currentPrice_lab.text substringFromIndex:index]];
            [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rangel];
            [textColor addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:rangel];
            [currentPrice_lab setAttributedText:textColor];
            salePrice_lab.text=[NSString stringWithFormat:@"¥%@",extentionData.market_price];
            
            //设置已选的数据
            suitDict = [[NSMutableDictionary alloc]init];
            [suitDict setValue:btn.titleLabel.text forKey:@"btnKey"];
            [suitDict setValue:extentionData.price forKey:@"priceKey"];
            [suitDict setValue:str1 forKey:@"imgKey"];
            [suitDict setValue:extentionData.goods_id forKey:@"goods_id"];
            [suitDict setValue:extentionData.stock forKey:@"numberKey"];
            [suitDict setValue:extentionData.min_purchase_quantity forKey:@"min_purchase_quantity"];
        }
    }
}
-(void)exitBtnDidClick{
    
    ZXNLog(@"退出按钮被点击了");
    CGFloat margin = 10;
    [largeImageView removeFromSuperview];
    largeImageView.hidden =YES;
    pictureBtn = [[UIButton alloc]initWithFrame:CGRectMake(margin, -margin, 90, 90)];
    if ([detailproduct.img_original isEqual:[NSNull null]]) {
        UIImageView * btnImgView = [[UIImageView alloc]initWithFrame:CGRectMake(margin, -margin, 90, 90)];
        btnImgView.image = [UIImage imageNamed:@"none"];
        UIImage * img = btnImgView.image;
        [pictureBtn addTarget:self action:@selector(pictureBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [pictureBtn setImage:img forState:UIControlStateNormal];
    }else
    {
        NSString * str1 = @"";
        if (imgoriginal.count == 0) {
            str1 = @"none";
        }else{
            str1 = imgoriginal[0];
        }
        if (str1 != nil) {
            ZXNImageView * btnImgView = [[ZXNImageView alloc]initWithFrame:CGRectMake(margin, -margin, 90, 90)];
            [btnImgView downloadImage:str1 backgroundImage:ZXNImageDefaul];
            
            UIImage * img = btnImgView.image;
            [pictureBtn addTarget:self action:@selector(pictureBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
            [pictureBtn setImage:img forState:UIControlStateNormal];
        }
    }
    pictureBtn.backgroundColor=[UIColor clearColor];
    pictureBtn.layer.borderColor=kLineColer.CGColor;
    pictureBtn.layer.borderWidth=0.5;
    pictureBtn.layer.masksToBounds=YES;
    [goodsView addSubview:pictureBtn];
}
//大图按钮被点击
-(void)pictureBtnDidClick
{
    largeImageView = [[UIScrollView alloc]init];
    largeImageView.alpha = 0;
    largeImageView.tag = 102;
    largeImageView.backgroundColor = [UIColor whiteColor];
    largeImageView.showsHorizontalScrollIndicator = NO;
    largeImageView.showsVerticalScrollIndicator = NO;
    largeImageView.frame = CGRectMake(0, 0, kDisWidth, kDisHeight);
    pictureBtn.frame = CGRectMake(10, (kDisHeight-60)/3-10, 90, 90);
    pictureBtn.userInteractionEnabled = NO;
    [self.view addSubview:largeImageView];
    
    //手势点击
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(exitBtnDidClick)];
    [largeImageView addGestureRecognizer:tapRecognizer];
    
    largeScrollerView = [[UIScrollView alloc]init];
    largeScrollerView.delegate = self;
    largeScrollerView.tag = 102;
    NSArray * arrURL = imgoriginal;
    NSInteger countarrURL = count;
    largeScrollerView.frame = CGRectMake(0, 80, kDisWidth, kDisWidth);
    largeScrollerView.contentSize = CGSizeMake(kDisWidth*countarrURL, kDisWidth);
    largeScrollerView.showsVerticalScrollIndicator = NO;
    largeScrollerView.pagingEnabled = YES;
    [largeScrollerView addSubview:pictureBtn];
    [largeImageView addSubview:largeScrollerView];
    
    //添加大图图片
    for (int i =0; i<countarrURL-1; i++) {
        scroImageView=[[ZXNImageView alloc] initWithFrame:CGRectMake((i+1)*kDisWidth, 0, kDisWidth, kDisWidth)];
        
        NSString * strURl = [NSString stringWithFormat:@"%@", arrURL[i+1]];
        
        //        [scroImageView sd_setImageWithURL:[NSURL URLWithString:strURl] placeholderImage:[UIImage imageNamed:@"none"]];
        [scroImageView downloadImage:strURl backgroundImage:ZXNImageDefaul];
        scroImageView.layer.borderColor = kLineColer.CGColor;
        scroImageView.layer.borderWidth = 0.5;
        scroImageView.layer.masksToBounds = YES;
        [largeScrollerView addSubview:scroImageView];
    }
    [UIView animateWithDuration:0.8 animations:^{
        pictureBtn.frame = CGRectMake(0, 0, kDisWidth, kDisWidth);
        largeImageView.alpha = 1.0;
        
    }];
    
    pageLab = [[UILabel alloc]init];
    pageLab.frame = CGRectMake((kDisWidth-50)/2, largeScrollerView.top-45, 50, 35);
    pageLab.textAlignment = NSTextAlignmentCenter;
    if (count == 1) {
        pageLab.hidden = YES;
    }else{
        pageLab.text = [NSString stringWithFormat:@"1/%ld",(long)count];
        [largeImageView addSubview:pageLab];
    }
}
-(void)blurredBtnDidClick{
    
    
    
    isClick = NO;
    getnumberView.isdidClick = NO;
    NSInteger  numberInteger = 0;
    if (getnumberView.isdidClick == NO) {
        numberInteger = [[suitDict objectForKey:@"min_purchase_quantity"] integerValue];
    }else{
        numberInteger = [[suitDict objectForKey:@"numKey"] integerValue];
        if (numberInteger == 0) {
            numberInteger = getNum;
        }
    }
    if ([suitDict objectForKey:@"btnKey"] == nil) {
        suit_Lab.text = [NSString stringWithFormat:@"%@ 数量:%ld",testBtn.text,(long)numberInteger];
    }else{
        suit_Lab.text = [NSString stringWithFormat:@"%@ 数量:%ld",[suitDict objectForKey:@"btnKey"],(long)numberInteger];
    }
    [blurredView removeFromSuperview];
    [goodsBjview removeFromSuperview];
    [suitView removeFromSuperview];
    
    
    [scroView setContentOffset:CGPointMake(0, 0) animated:NO];
    NSString * strUrl = [suitDict objectForKey:@"imgKey"];
    NSString *str=[NSString stringWithFormat:@"%@", strUrl];
    if (strUrl == nil) {
        firstView.image = [UIImage imageNamed:@"none"];
    }else {
        
        //        [firstView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"none"]];
        [firstView downloadImage:str backgroundImage:ZXNImageDefaul];
    }
}
-(void)cancerBtnDidClick{
    isClick = NO;
    getnumberView.isdidClick = NO;
    NSInteger  numberInteger = 0;
    if (getnumberView.isdidClick == NO) {
        numberInteger = [[suitDict objectForKey:@"min_purchase_quantity"] integerValue];
    }else{
        numberInteger = [[suitDict objectForKey:@"numKey"] integerValue];
        if (numberInteger == 0) {
            numberInteger = getNum;
        }
    }
    if ([suitDict objectForKey:@"btnKey"] == nil) {
        suit_Lab.text = [NSString stringWithFormat:@"%@ 数量:%ld",testBtn.text,(long)numberInteger];
    }else{
        suit_Lab.text = [NSString stringWithFormat:@"%@ 数量:%ld",[suitDict objectForKey:@"btnKey"],(long)numberInteger];
    }
    [blurredView removeFromSuperview];
    [goodsBjview removeFromSuperview];
    [suitView removeFromSuperview];
    
    
    [scroView setContentOffset:CGPointMake(0, 0) animated:NO];
    NSString * strUrl = [suitDict objectForKey:@"imgKey"];
    NSString *str=[NSString stringWithFormat:@"%@", strUrl];
    if (strUrl == nil) {
        firstView.image = [UIImage imageNamed:@"none"];
    }else {
        //        [firstView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"none"]];
        [firstView downloadImage:str backgroundImage:ZXNImageDefaul];
    }
}

-(void)addProductToCart:(UIButton *)btn{
    tagTAG = 100;
    //模糊界面
    blurredView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDisWidth, kDisHeight)];
    Btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kDisWidth, kDisHeight)];
    Btn.backgroundColor = [UIColor grayColor];
    Btn.alpha = 0;
    [blurredView addSubview:Btn];
    [Btn addTarget:self action:@selector(blurredBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blurredView];
    
    goodsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDisWidth, 2*(kDisHeight-60)/3)];
    goodsBjview = [[UIView alloc]init];
    goodsView.backgroundColor = [UIColor whiteColor];
    CGRect frame = CGRectMake(0, kDisHeight, kDisWidth, kDisHeight-(kDisHeight-60)/3);
    goodsBjview =[[UIView alloc]initWithFrame:frame];
    goodsBjview.backgroundColor = [UIColor whiteColor];
    self.scroBottomView = [[UIScrollView alloc]init];
    self.scroBottomView.showsVerticalScrollIndicator = NO;
    self.scroBottomView.showsHorizontalScrollIndicator = NO;
    self.scroBottomView.backgroundColor = [UIColor whiteColor];
    [goodsView addSubview:self.scroBottomView];
    [self setGoodsView];
    [self.view addSubview:goodsBjview];
    [goodsBjview addSubview:goodsView];
    
    [UIView animateWithDuration:0.8 animations:^{
        goodsBjview.frame = CGRectMake(0, (kDisHeight-60)/3, kDisWidth, kDisHeight-(kDisHeight-60)/3);
        Btn.alpha = 0.5;
    } completion:^(BOOL finished) {
        
    }];
}

//分享 返回首页
-(void)loadRightItems{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:[UIImage drawImageWithName:@"icon-shar" size:CGSizeMake(22, 22)] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn1 setImage:[UIImage drawImageWithName:@"icon-main" size:CGSizeMake(22, 22)] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(backToHome) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *home = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    NSArray *arr = @[home,share];
    self.navigationItem.rightBarButtonItems = arr;
}

- (void)backToHome{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    C_TabBarController *rootViewController = (C_TabBarController *)appDelegate.window.rootViewController;
    rootViewController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    rootScrollView.delegate=self;
    if ([YKSUserDefaults isLogin]) {
        [self getCartBadgeData];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    rootScrollView.delegate=nil;
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --相关商品选择
-(void)relationGoodsChoosedAction:(NSNotification *)notifi{
    NSDictionary *dict=[notifi userInfo];
    NSString *goodsID=[dict objectForKey:@"goods_id"];
    DetailViewController *detailVC=[[DetailViewController alloc] init];
    detailVC.productID=goodsID;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark--创建底部视图
-(void)makeBottomView{
    bottomView=[[UIView alloc] initWithFrame:CGRectMake(0.0, kDisHeight-kDisNavgation-50, kDisWidth, 50)];
    bottomView.backgroundColor=color(252, 252, 252, 1);
    [self.view addSubview:bottomView];
    
    UILabel *linee = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDisWidth, 0.5)];
    linee.backgroundColor = [UIColor colorWithHexString:@"#dbdbdc"];
    [bottomView addSubview:linee];
    
    //添加新的按钮客服
    CGFloat margin = 5;
    if (kDisWidth == 320) {
        margin = 5;
    }else{
        margin = 10;
    }
    
    serviceBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    serviceBtn.frame = CGRectMake(margin, 3, 43, 49);
    [serviceBtn setImage:[UIImage imageNamed:@"icon-service"] forState:UIControlStateNormal];
    serviceBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 10, 20, 10);
    [serviceBtn setTitle:@"客服" forState:UIControlStateNormal];
    [serviceBtn setTitleColor:kCustomWordColor forState:UIControlStateNormal];
    serviceBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    serviceBtn.titleEdgeInsets = UIEdgeInsetsMake(30, -33, 0, 0);
    [serviceBtn addTarget:self action:@selector(serviceBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:serviceBtn];
    
    
    collectBtn=[[UIButton alloc] initWithFrame:CGRectMake(serviceBtn.right+2*margin,3, 43, 49.0)];
    [collectBtn setImage:[UIImage imageNamed:@"icon-collectImag"] forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"icon-tureCollectImag"] forState:UIControlStateSelected];
    collectBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 10, 20, 10);
    [collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [collectBtn setTitle:@"已收藏" forState:UIControlStateSelected];
    [collectBtn setTitleColor:kCustomWordColor forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    [collectBtn setTitleColor:kCustomWordColor forState:UIControlStateSelected];//设置title在button被选中情况下为灰色字体
    collectBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    collectBtn.titleEdgeInsets = UIEdgeInsetsMake(30, -33, 0, 0);
    [collectBtn setExclusiveTouch:YES];
    collectBtn.userInteractionEnabled = NO;
    [collectBtn addTarget:self action:@selector(collectActionn:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:collectBtn];
    
    
    UIButton *toCartBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    toCartBtn.frame = CGRectMake(collectBtn.right+2*margin, 3, 43, 49);
    [toCartBtn setImage:[UIImage imageNamed:@"icon-shoppingCart"] forState:UIControlStateNormal];
    toCartBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 8, 20, 12);
    [toCartBtn setTitle:@"购物车" forState:UIControlStateNormal];
    [toCartBtn setTitleColor:kCustomWordColor forState:UIControlStateNormal];
    toCartBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    toCartBtn.titleEdgeInsets = UIEdgeInsetsMake(30, -33, 0, 0);
    [toCartBtn addTarget:self action:@selector(jumpToShoppingCart:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:toCartBtn];
    
    
    bagelab=[[UILabel alloc] initWithFrame:CGRectMake(28, 4, 14, 14)];
    bagelab.layer.cornerRadius=7;
    bagelab.layer.masksToBounds=YES;
    bagelab.backgroundColor=[UIColor redColor];
    bagelab.textColor=[UIColor whiteColor];
    bagelab.textAlignment=NSTextAlignmentCenter;
    bagelab.font=[UIFont systemFontOfSize:10];
    [toCartBtn addSubview:bagelab];
    bagelab.hidden=YES;
    
    cartBtn = [[UIButton alloc] initWithFrame:CGRectMake(toCartBtn.right+margin, 0, (kDisWidth-130-5*margin), 50)];
    [cartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [cartBtn setBackgroundColor:[UIColor colorWithHexString:@"#12a1ea"]];
    [cartBtn setBackgroundImage:[UIImage imageNamed:@"shoppingHilight"] forState:UIControlStateHighlighted];
    [cartBtn setExclusiveTouch:YES];
    cartBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [cartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cartBtn.userInteractionEnabled = NO;
    [cartBtn addTarget:self action:@selector(addProductToCart:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cartBtn];
    
    UIView * line1 = [[UIView alloc]init];
    line1.frame = CGRectMake(serviceBtn.right+margin, 0, 0.5, 50);
    //    line1.backgroundColor = [UIColor colorWithHexString:@"#f0f0f3"];
    line1.backgroundColor = kLineColer;
    [bottomView addSubview:line1];
    
    
    UIView * line2 = [[UIView alloc]init];
    line2.frame = CGRectMake(collectBtn.right+margin, 0, 0.5, 50);
    line2.backgroundColor = kLineColer;
    [bottomView addSubview:line2];
}



-(void)serviceBtnDidClick:(UIButton *)Btn{
    self.navigationController.navigationBar.hidden=NO;
    if ([YKSUserDefaults isLogin]) {
        ContactServiceViewController *ContactServiceVC = [[ContactServiceViewController alloc] init];
        [self.navigationController pushViewController:ContactServiceVC animated:YES];
    }else{
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}
#pragma mark --分享
-(void)shareAction
{
    NSString * goods_name = detailproduct.goods_name;
    UIImage * img = imgView.image;
    
    [ShareTool shareHaiTunCommodity:self.sku Title:goods_name Image:img];
}

#pragma mark --购物车小图标方法
-(void)getCartBadgeData{
    if ([YKSUserDefaults isLogin])
    {
        NSDictionary *dic = nil;
        
        [AFHTTPClient POST:kGetCartNumURL params:dic successInfo:^(ResponseModel *response) {
            
            
            //解析数据
            id json = @{@"data":response.dataResponse};
            [self getCartBadgeDataRefresh:json];
            
            
        } flaseInfo:^(ResponseModel *response, HTTPType type) {
            
            if (type == NEED_HINT || type == NO_NETWORK)
            {
                [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
                return ;
            }
            
            if (type == SERVICE_ERROR) {
                return ;
            }
            
            if (type == NEED_LOGIN) {
                ZXNLog(@"需要登录");
            }
        }];
        
    }else
    {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}

-(void)getCartBadgeDataRefresh:(id)json{
    {
        number = [[json objectForKey:@"data"] integerValue];
        
        if (number==0) {
            bagelab.hidden=YES;
        }
        else
        {
            bagelab.hidden=NO;
            bagelab.text=[NSString stringWithFormat:@"%ld",(long)number];
        }
        
    }
}


- (void)touchGoodsToDetail:(NSInteger)goods_id{
    DetailViewController *VC = [[DetailViewController alloc] init];
    VC.productID = [NSString stringWithFormat:@"%li",(long)goods_id];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark --相关商品（RelationView）代理
-(void)relationViewDelegateActionWithGoodsID:(NSNumber *)goods_id{
    DetailViewController *detailVC=[[DetailViewController alloc] init];
    detailVC.productID=[NSString stringWithFormat:@"%@",goods_id];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark --数量加减选择
-(void)getNumberForAddAction{
    getnumberView.isdidClick = YES;
    NSDictionary * arrDict ;
    NSInteger minCount = 0;
    if (detailproduct.extension.count != 0) {
        arrDict = detailproduct.extension[0];
        minCount=[[arrDict objectForKey:@"min_purchase_quantity"] integerValue];
    }else{
        minCount=[detailproduct.min_purchase_quantity integerValue];
    }
    if (getNum >= [detailproduct.stock integerValue]) {
        [self.view makeToast:@"商品库存不足" duration:1.0 position:CSToastPositionCenter];
    }else{
        if (detailproduct.is_modulo) {
            getNum+=minCount;
        }else{
            getNum++;
        }
        getnumberView.countText=[NSString stringWithFormat:@"%ld",(long)getNum];
        NSString * strInteger = [NSString stringWithFormat:@"%ld",(long)getNum];
        if (strInteger == nil) {
            getNum = [extentionData.min_purchase_quantity integerValue];
            strInteger = [NSString stringWithFormat:@"%ld",(long)getNum];
            [suitDict setValue:strInteger forKey:@"numKey"];
        }else {
            [suitDict setValue:strInteger forKey:@"numKey"];
        }
    }
}

-(void)getNumberForReduceAction{
    getnumberView.isdidClick = YES;
    NSDictionary * arrDict ;
    NSInteger minCount = 0;
    if (detailproduct.extension.count != 0) {
        arrDict = detailproduct.extension[0];
        minCount=[[arrDict objectForKey:@"min_purchase_quantity"] integerValue];
    }else{
        minCount=[detailproduct.min_purchase_quantity integerValue];
    }
    
    NSInteger coun=minCount;
    if (detailproduct.is_modulo) {
        getNum-=minCount;
        
    }else{
        getNum--;
    }
    if (getNum<coun){
        getNum=minCount;
        return;
    }
    getnumberView.countText=[NSString stringWithFormat:@"%ld",(long)getNum];
    NSString * strInteger = [NSString stringWithFormat:@"%ld",(long)getNum];
    if (strInteger == nil) {
        getNum = [extentionData.min_purchase_quantity integerValue];
        strInteger = [NSString stringWithFormat:@"%ld",(long)getNum];
        [suitDict setValue:strInteger forKey:@"numKey"];
    }else{
        [suitDict setValue:strInteger forKey:@"numKey"];
    }
}

#pragma mark--加入购物车动画
-(void)productIntoCartAnimation{
    [comicView setSize:CGSizeMake(30.0, 30.0)];
    [UIView animateWithDuration:0.5 animations:^{
        [comicView setSize:CGSizeMake(0, 0)];
        [comicView setOrigin:CGPointMake(65, kDisHeight-20.0)];
    } completion:^(BOOL finished) {
        [comicView setOrigin:self.view.center];
        [self.view makeToast:@"成功加入购物车" duration:1.0 position:CSToastPositionCenter];
    }];
    
}
#pragma mark --加入购物车
-(void)todoSomethingg:(UIButton *)btn{
    if ([YKSUserDefaults isLogin]) {
        if (isClick == NO && getnumberView.isdidClick == NO) {
            
            //加入购物车
            NSString * goods_id = [NSString stringWithFormat:@"%@",[dictDict objectForKey:@"goods_id"]];
            NSInteger numBer = [[dictDict objectForKey:@"min_purchase_quantity"] integerValue];
            [HTLoadingTool showLoadingForView:self.view Hint:@"添加到购物车中..."];
            
            NSDictionary *dic = @{
                                  @"goods_id":goods_id,
                                  @"number":[NSString stringWithFormat:@"%ld",(long)numBer],
                                  @"type":@"add"
                                  };
            
            [AFHTTPClient POST:kAddToAddCartURLNEW params:dic successInfo:^(ResponseModel *response) {
                
                
                //解析数据
                id json = @{@"data":response.dataResponse};
                [self todoSomething:json];
                
                
            } flaseInfo:^(ResponseModel *response, HTTPType type) {
                if (type == NEED_HINT || type == NO_NETWORK)
                {
                    [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
                    return ;
                }
                
                if (type == SERVICE_ERROR) {
                    return ;
                }
                
                if (type == NEED_LOGIN) {
                    ZXNLog(@"需要登录");
                }
            }];
            
            
        }else
        {
            
            NSInteger  numberInteger = 0;
            if (getnumberView.isdidClick == NO ) {
                numberInteger = [[suitDict objectForKey:@"numberKey"] integerValue];
            }else{
                numberInteger = [[suitDict objectForKey:@"numKey"] integerValue];
                if (numberInteger == 0) {
                    numberInteger = getNum;
                }
            }
            if (numberInteger < getNum)
            {
                NSString *messageStr = @"库存不足，添加购物车失败！";
                [self.view makeToast:messageStr duration:1.0 position:CSToastPositionCenter];
            }else{
                
                //加入购物车
                NSString * goods_id = @"";
                if (detailproduct.extension.count == 0) {
                    goods_id=[NSString stringWithFormat:@"%@",detailproduct.goods_id];
                }else{
                    goods_id=[NSString stringWithFormat:@"%@",[suitDict objectForKey:@"goods_id"]];
                }
                [HTLoadingTool showLoadingForView:self.view Hint:@"添加到购物车中..."];
                
                NSDictionary *dic = @{
                                      @"goods_id":goods_id,
                                      @"number":[NSString stringWithFormat:@"%ld",(long)getNum],
                                      @"type":@"add"
                                      };
                
                [AFHTTPClient POST:kAddToAddCartURLNEW params:dic successInfo:^(ResponseModel *response) {
                    
                    
                    //解析数据
                    id json = @{@"data":response.dataResponse};
                    [self todoSomething:json];
                    
                    
                } flaseInfo:^(ResponseModel *response, HTTPType type) {
                    if (type == NEED_HINT || type == NO_NETWORK)
                    {
                        [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
                        return ;
                    }
                    
                    if (type == SERVICE_ERROR) {
                        return ;
                    }
                    
                    if (type == NEED_LOGIN) {
                        ZXNLog(@"需要登录");
                    }
                }];
            }
        }
        
    }else
    {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

-(void)todoSomething:(id)json
{
    [self productIntoCartAnimation];
    [self getCartBadgeData];
    [self cancerBtnDidClick];
    
}

#pragma mark --跳转到购物车界面
-(void)jumpToShoppingCart:(UIButton *)button{
    self.navigationController.navigationBar.hidden=NO;
    if ([YKSUserDefaults isLogin]) {
        ShopingCart_VC *shopCartVC = [[ShopingCart_VC alloc] init];
        shopCartVC.bBottom = YES;
        [self.navigationController pushViewController:shopCartVC animated:YES];
    }else{
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}

#pragma mark--加收藏和取消收藏
//检查是否收藏
-(void)checkIscollect{
    NSDictionary *dic = @{
                          @"goods_id":detailproduct.goods_id
                          };
    
    [AFHTTPClient POST:KisCollectURL params:dic successInfo:^(ResponseModel *response) {
        
        
        //解析数据
        id json = response.sMsg;
        [self checkIscollectRefresh:json];
        
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == NO_NETWORK)
        {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            return ;
        }
        
        if (type == SERVICE_ERROR) {
            return ;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
    
}
-(void)checkIscollectRefresh:(id)json{
    
    NSString * message = json ;
    if ([message isEqualToString:@"已存在该收藏"]) {
        collectBtn.selected = YES;
    }else{
        collectBtn.selected = NO;
    }
}
//加入/取消 收藏
-(void)collectActionn:(UIButton *)btn
{
    if ([YKSUserDefaults isLogin])
    {
        //        NSString * url=[NSString stringWithFormat:@"goods_id=%@",detailproduct.goods_id];
        NSDictionary * dic = @{
                               @"goods_id":detailproduct.goods_id
                               };
        [self checkGoodsIsCollectBBCURL:KisCollectURL dic:dic];
    }
    else
    {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

-(void)checkGoodsIsCollectBBCURL:(NSString *)BBCURL dic:(NSDictionary *)dic{
    [HTLoadingTool showLoadingForView:self.view Hint:@"加入收藏中..."];
    NSDictionary *dict = dic;
    
    [AFHTTPClient POST:BBCURL params:dict successInfo:^(ResponseModel *response) {
        
        
        //解析数据
        id json = response.sMsg;
        [self checkGoodsIsCollectBBCURL:json BBCURL:BBCURL dic:dic];
        
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == NO_NETWORK)
        {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            return ;
        }
        
        if (type == SERVICE_ERROR) {
            return ;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
    
}
-(void)checkGoodsIsCollectBBCURL:(id)json BBCURL:(NSString *)BBCURL dic:(NSDictionary *)dic{
    NSString * message = json;
    if ( [message isEqualToString:@"已存在该收藏"]) {
        
        collectBtn.selected = NO;
        [self getProductCollectDataWithUrlStrBBCURL:kCancelCollectURL dic:dic];
        [self.view makeToast:@"取消收藏" duration:1.0 position:CSToastPositionCenter];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"collect"];
    }else if ( [message isEqualToString:@"不存在该收藏"]) {
        
        collectBtn.selected = YES;
        [self getProductCollectDataWithUrlStrBBCURL:kAddToCollectURL dic:dic];
        [self.view makeToast:@"收藏成功" duration:1.0 position:CSToastPositionCenter];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"collect"];
    }else{
        collectBtn.selected = NO;
        [self getProductCollectDataWithUrlStrBBCURL:kCancelCollectURL dic:@{@"goods_id":detailproduct.goods_id}];
    }
}
- (void)getProductCollectDataWithUrlStrBBCURL:(NSString * )BBCURL dic:(NSDictionary * )dic
{
    NSDictionary *dict = dic;
    
    [AFHTTPClient POST:BBCURL params:dict successInfo:^(ResponseModel *response) {
        
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        
        if (type == NEED_HINT || type == NO_NETWORK)
        {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
            return ;
        }
        
        if (type == SERVICE_ERROR) {
            return ;
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
    
}
#pragma mark --商品推荐代理
-(void)cellGoodsButtonActionWithID:(NSString *)goodsID :(NSString *)sku :(NSString *)cat_id{
    ZXNLog(@"点击了goodsBtn");
    DetailViewController *detailVC=[[DetailViewController alloc] init];
    detailVC.sku = sku;
    detailVC.cat_id = cat_id;
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark --图文详情 代理

-(void)imageTextViewReloadAction
{
    
    if (!self.isEnd) {
        self.isEnd = YES;
        [UIView animateWithDuration:0.3 animations:^{
            [rootScrollView setFrame:CGRectMake(0, 0, kDisWidth, kDisHeight+20)];
            [imageTextView setFrame:CGRectMake(0, kDisHeight, kDisWidth, kDisHeight-50)];
            self.isEnd = NO;
        }];
    }
}

-(void)recommendBtnDidclick:(DetailViewController *)VC{
    
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark --UIScrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scY=scrollView.contentOffset.y;
    CGFloat maxOffY ;
    if (kDisWidth == 320) {
        maxOffY = 360;
    }else if(kDisWidth == 375){
        maxOffY = 360 ;
    }else{
        maxOffY = 360;
    }
    
    if (scY>maxOffY) {
        if (!self.isEnd) {
            self.isEnd = YES;
            [UIView animateWithDuration:0.3 animations:^{
                [rootScrollView setFrame:CGRectMake(0, -kDisHeight, kDisWidth, kDisHeight)];
                [imageTextView setFrame:CGRectMake(0, 0, kDisWidth, kDisHeight)];
                [imageTextView loadForDescriptionImagesWithImages:imagesStr];
                self.isEnd = NO;
            }];
        }
    }
    //图片滚动scrollView
    CGFloat contentSizeX = scrollView.contentOffset.x;
    int page =contentSizeX/ scrollView.frame.size.width;
    
    if (count == 1) {
        countLab.hidden = YES;
        pageController.hidden = YES;
    }else{
        if (scrollView.tag == 1000) {
            pageController.currentPage = page;
            countLab.text = [NSString stringWithFormat:@"%d/%ld",page+1,(long)count];
            pageLab.text = [NSString stringWithFormat:@"%d/%ld",page+1,(long)count];
        }if (scrollView.tag == 102) {
            pageController.currentPage = page;
            countLab.text = [NSString stringWithFormat:@"%d/%ld",page+1,(long)count];
            pageLab.text = [NSString stringWithFormat:@"%d/%ld",page+1,(long)count];
        }
    }
}

#pragma mark 绘制图片
- (UIImage *)drawImageWithName:(NSString *)sender{
    UIImage *icon = [UIImage imageNamed:sender];
    CGSize itemSize = CGSizeMake(30, 30);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    
    icon = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return icon;
    
}

//-(UIScrollView *)scroBottomView{
//
//    if (!_scroBottomView) {
//        _scroBottomView = [[UIScrollView alloc]init];
//        _scroBottomView.showsVerticalScrollIndicator = NO;
//        _scroBottomView.showsHorizontalScrollIndicator = NO;
//        _scroBottomView.backgroundColor = [UIColor whiteColor];
//    }
//    return _scroBottomView;
//}
@end
