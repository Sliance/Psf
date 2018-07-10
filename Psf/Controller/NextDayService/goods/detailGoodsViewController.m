//
//  detailGoodsViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/22.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "detailGoodsViewController.h"
#import "ZSCycleScrollView.h"
#import "EvaluateViewController.h"
#import "GoodHeadView.h"
#import "GoodEvaluateView.h"
#import "GoodFootView.h"
#import "GetCouponsCellView.h"
#import "GetCouponsView.h"
#import "TourDiyGooddetailView.h"
#import "DetailGroupController.h"
#import "GoodBottomView.h"
#import "NextServiceApi.h"

@interface detailGoodsViewController ()<UIScrollViewDelegate,ZSCycleScrollViewDelegate,GetCouponsViewDelegate,UIWebViewDelegate>{
    NSInteger _couponHeight;
}

@property(nonatomic,strong)UIScrollView *bgscrollow;
@property(nonatomic,strong)ZSCycleScrollView *cycleScroll;

@property(nonatomic,strong)GoodEvaluateView *evaView;
@property(nonatomic,strong)GoodHeadView *headView;
@property(nonatomic,strong)GoodFootView *footView;
@property(nonatomic,strong)GetCouponsCellView *couponCell;
@property(nonatomic,strong)GetCouponsView *couponView;
@property(nonatomic,strong)TourDiyGooddetailView *tourDiyView;
@property(nonatomic,strong)GoodBottomView *bottomView;
@property(nonatomic,strong)GoodDetailRes *result;
@property (strong, nonatomic) UIWebView *webView;
@property(strong,nonatomic)NSMutableArray *evaArr;
@end

@implementation detailGoodsViewController
-(GoodEvaluateView *)evaView{
    if (!_evaView) {
        _evaView = [[GoodEvaluateView alloc]init];
    }
    return _evaView;
}
-(TourDiyGooddetailView *)tourDiyView{
    if (!_tourDiyView) {
        _tourDiyView = [[TourDiyGooddetailView alloc]init];
    }
    return _tourDiyView;
}
-(GoodHeadView *)headView{
    if (!_headView) {
        _headView = [[GoodHeadView alloc]init];
    }
    return _headView;
}
-(GoodFootView *)footView{
    if (!_footView) {
        _footView = [[GoodFootView alloc]init];
    }
    return _footView;
}
-(GoodBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[GoodBottomView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-[self tabBarHeight], SCREENHEIGHT, [self tabBarHeight])];
        
    }
    return _bottomView;
}
-(GetCouponsCellView *)couponCell{
    if (!_couponCell) {
        _couponCell = [[GetCouponsCellView alloc]init];
    }
    return _couponCell;
}
-(GetCouponsView *)couponView{
    if (!_couponView) {
        _couponView = [[GetCouponsView alloc]init];
        _couponView.hidden = YES;
         _couponView.frame = CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT);
        _couponView.delegate = self;
    }
    return _couponView;
}
-(ZSCycleScrollView *)cycleScroll{
    if (!_cycleScroll) {
        _cycleScroll = [[ZSCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 375)];
        _cycleScroll.imageSize = CGSizeMake(SCREENWIDTH, 375);
        _cycleScroll.delegate =self;
        _cycleScroll.autoScrollTimeInterval = 3.0;
        _cycleScroll.dotColor = [UIColor redColor];
    }
    return _cycleScroll;
}
-(UIScrollView *)bgscrollow{
    if (!_bgscrollow) {
        _bgscrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT)];
        _bgscrollow.contentSize = CGSizeMake(0, SCREENHEIGHT*3);
        _bgscrollow.delegate = self;
        _bgscrollow.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _bgscrollow;
}
-(UIWebView *)webView{
    if(!_webView){
        _webView = [[UIWebView alloc]init];
        _webView.delegate = self;
    }
    return _webView;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"商品"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _evaArr = [NSMutableArray array];
    [self.view addSubview:self.bgscrollow];
    [self.bgscrollow addSubview:self.cycleScroll];
    [self.bgscrollow addSubview:self.headView];
    [self.bgscrollow addSubview:self.evaView];
    [self.bgscrollow addSubview:self.footView];
    [self.bgscrollow addSubview:self.couponCell];
    [self.bgscrollow addSubview:self.tourDiyView];
     [self.view addSubview:self.bottomView];
    [self.view addSubview:self.couponView];
    [self.bgscrollow addSubview:self.webView];
    self.headView.frame = CGRectMake(0, self.cycleScroll.ctBottom, SCREENWIDTH, 114);
   __weak typeof(self) _weakSelf = self;
    [self.evaView setSkipBlock:^(NSInteger index) {
        EvaluateViewController *evaVC = [[EvaluateViewController alloc]init];
        [_weakSelf.navigationController pushViewController:evaVC animated:YES];
    }];
    [self.couponCell setPressCoupBlock:^(NSInteger index) {
        _weakSelf.couponView.hidden = NO;
    }];
    [self.tourDiyView setPressGoBlock:^(NSInteger index) {
        DetailGroupController *detailVC = [[DetailGroupController alloc]init];
        [_weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
   
    [self.footView setSelectedCollect:^(NSInteger productId) {
        detailGoodsViewController*detailVC = [[detailGoodsViewController alloc]init];
        [detailVC setProductID:productId];
        [_weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
}

-(void)setProductID:(NSInteger )productID{
    _productID = productID;
    
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    
    req.token = @"eyJleHBpcmVUaW1lIjoxNTYxNjI1OTU3ODc0LCJ1c2VySWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI2Iiwib2JqZWN0SWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI1In0=";
    req.userId = @"1009660103519952898";
    req.version = @"1.0.0";
    req.platform = @"ios";
        req.couponType = @"allProduct";
        req.saleOrderStatus = @"0";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.productId = [NSString stringWithFormat:@"%ld",productID];
        req.pageIndex = @"1";
        req.pageSize = @"10";
    req.productCategoryParentId = @"";
        req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[NextServiceApi share]requestGoodDetailLoadWithParam:req response:^(id response) {
        if(response != nil){
        weakself.result = response;
           
            weakself.cycleScroll.imageUrlGroups = (NSMutableArray*)weakself.result.productImageList;
            [weakself requestEvaluate];
      }
    }];
    
    
}
-(void)requestCoupon{
  
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    
    req.token = @"eyJleHBpcmVUaW1lIjoxNTYxNjI1OTU3ODc0LCJ1c2VySWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI2Iiwib2JqZWN0SWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI1In0=";
    req.userId = @"1009660103519952898";
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.couponType = @"allProduct";
    req.saleOrderStatus = @"0";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.productId = [NSString stringWithFormat:@"%ld",_productID];
    req.pageIndex = @"1";
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[NextServiceApi share]requestCouponListLoadWithParam:req response:^(id response) {
       
    }];
}
-(void)requestEvaluate{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    
    req.token = @"eyJleHBpcmVUaW1lIjoxNTYxNjI1OTU3ODc0LCJ1c2VySWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI2Iiwib2JqZWN0SWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI1In0=";
    req.userId = @"1009660103519952898";
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.couponType = @"allProduct";
    req.saleOrderStatus = @"0";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.productId = [NSString stringWithFormat:@"%ld",_productID];
    req.pageIndex = @"1";
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[NextServiceApi share]requestEvaluateListModelListLoadWithParam:req response:^(id response) {
         [weakself.footView setPruductId:weakself.productID];
         [weakself.evaArr addObjectsFromArray:response];
         [weakself reloadData];
    }];
}
-(void)reloadData{
        [self.headView setModel:self.result];
    
    NSString *html_str = [NSString stringWithFormat:@"<head><style>img{max-width:%fpx !important;}</style></head>%@",SCREENWIDTH,self.result.productContent];
    
    [self.webView loadHTMLString:html_str baseURL:nil];
    NSInteger _tourHeight = 0;
    NSInteger _evaHeight = 0;
    if([self.result.productType isEqualToString:@"normal"]){//正常
       
        [self requestCoupon];
    }else if ([self.result.productType isEqualToString:@"groupon"]){//团购
        _tourHeight = 0;
    }else if ([self.result.productType isEqualToString:@"preSale"]){//预售
        _tourHeight = 0;
    }else {//满减
         [self requestCoupon];
    }
    if (_couponHeight ==0) {
        _couponCell.hidden = YES;
    }
    if (_tourHeight ==0) {
        self.tourDiyView.hidden = YES;
    }
    if (self.evaArr.count ==0) {
        _evaHeight =0;
        _evaView.hidden = YES;
    }else{
        _evaHeight = 50;
        _evaView.hidden = NO;
    }
    self.tourDiyView.frame = CGRectMake(0, self.headView.ctBottom, SCREENWIDTH, _tourHeight);
    self.couponCell.frame = CGRectMake(0, self.tourDiyView.ctBottom, SCREENWIDTH, _couponHeight);
    self.evaView.frame = CGRectMake(0, self.couponCell.ctBottom, SCREENWIDTH, _evaHeight);
    self.footView.frame = CGRectMake(0, self.evaView.ctBottom+5, SCREENWIDTH, 253);
    self.webView.frame = CGRectMake(0, self.footView.ctBottom, SCREENWIDTH, SCREENHEIGHT*3);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self adjustNavigationUI:self.navigationController];
    
}

-(void)cycleScrollView:(ZSCycleScrollView *)cycleScrollView didSelectItemAtRow:(NSInteger)row{
    EvaluateViewController *evaVC = [[EvaluateViewController alloc]init];
    [self.navigationController pushViewController:evaVC animated:YES];
}
-(void)finishCouponView{
    self.couponView.hidden = YES;
}
-(void)getCouponViewWithIndex:(NSInteger)index{
    
}
-(void)pressShareBtn:(UIButton*)sender{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
