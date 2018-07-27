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
#import "ShopServiceApi.h"
#import "ProductSkuModel.h"
#import "CouponServiceApi.h"
#import "GroupServiceApi.h"
#import "GroupGoodBottomView.h"
#import "PresaleGoodBottomView.h"
#import "GroupBuyView.h"
#import "SureOrderViewController.h"

@interface detailGoodsViewController ()<UIScrollViewDelegate,ZSCycleScrollViewDelegate,GetCouponsViewDelegate,UIWebViewDelegate>{
    NSInteger _couponHeight;
    NSInteger _tourHeight;
    NSInteger _evaHeight;
}

@property(nonatomic,strong)UIScrollView *bgscrollow;
@property(nonatomic,strong)ZSCycleScrollView *cycleScroll;

@property(nonatomic,strong)GoodEvaluateView *evaView;
@property(nonatomic,strong)GoodHeadView *headView;
@property(nonatomic,strong)GoodFootView *footView;
@property(nonatomic,strong)GetCouponsCellView *couponCell;
@property(nonatomic,strong)GetCouponsView *couponView;
@property(nonatomic,strong)TourDiyGooddetailView *tourDiyView;
@property(nonatomic,strong)GoodBottomView *normalBView;
@property(nonatomic,strong)PresaleGoodBottomView *preBView;
@property(nonatomic,strong)GroupGoodBottomView *groupBView;
@property(nonatomic,strong)GoodDetailRes *result;
@property (strong, nonatomic) UIWebView *webView;
@property(strong,nonatomic)EvaluateListRes *evaRes;
@property(nonatomic,strong)NSMutableArray *groupArr;
@property(nonatomic,strong)GroupBuyView *groupBuyView;
@property(nonatomic,strong)NSMutableArray *couponArr;


@end

@implementation detailGoodsViewController
-(GoodEvaluateView *)evaView{
    if (!_evaView) {
        _evaView = [[GoodEvaluateView alloc]init];
        _evaView.frame = CGRectMake(0, -100, SCREENWIDTH, 0);
        _evaView.hidden = YES;
    }
    return _evaView;
}
-(TourDiyGooddetailView *)tourDiyView{
    if (!_tourDiyView) {
        _tourDiyView = [[TourDiyGooddetailView alloc]init];
        _tourDiyView.frame = CGRectMake(0,-100, SCREENWIDTH, 0);
        _tourDiyView.hidden = YES;
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
        _footView.hidden = YES;
    }
    return _footView;
}
-(GoodBottomView *)normalBView{
    if (!_normalBView) {
        _normalBView = [[GoodBottomView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-[self tabBarHeight], SCREENHEIGHT, [self tabBarHeight])];
        
    }
    return _normalBView;
}
-(PresaleGoodBottomView *)preBView{
    if (!_preBView) {
        _preBView = [[PresaleGoodBottomView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-[self tabBarHeight], SCREENHEIGHT, [self tabBarHeight])];
        
    }
    return _preBView;
}
-(GroupGoodBottomView *)groupBView{
    if (!_groupBView) {
        _groupBView = [[GroupGoodBottomView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-[self tabBarHeight], SCREENHEIGHT, [self tabBarHeight])];
        
    }
    return _groupBView;
}
-(GetCouponsCellView *)couponCell{
    if (!_couponCell) {
        _couponCell = [[GetCouponsCellView alloc]init];
        _couponCell.frame = CGRectMake(0,-100, SCREENWIDTH, 0);
        _couponCell.hidden = YES;
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
-(GroupBuyView *)groupBuyView{
    if (!_groupBuyView) {
        _groupBuyView = [[GroupBuyView alloc]init];
        _groupBuyView.hidden = YES;
        _groupBuyView.frame = CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT);
        [_groupBuyView setHeight:[self tabBarHeight]];
    }
    return _groupBuyView;
}
-(ZSCycleScrollView *)cycleScroll{
    if (!_cycleScroll) {
        _cycleScroll = [[ZSCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 375)];
        _cycleScroll.imageSize = CGSizeMake(SCREENWIDTH, 375);
        _cycleScroll.delegate =self;
        _cycleScroll.autoScrollTimeInterval = 3.0;
        _cycleScroll.dotColor = [UIColor redColor];
        _cycleScroll.supportBtn.hidden = YES;
        _cycleScroll.returnBtn.hidden = YES;
        _cycleScroll.sendBtn.hidden = YES;
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
    
    [self.view addSubview:self.bgscrollow];
    _groupArr = [NSMutableArray array];
    _couponArr = [NSMutableArray array];
    [self.bgscrollow addSubview:self.cycleScroll];
    [self.bgscrollow addSubview:self.headView];
    [self.bgscrollow addSubview:self.evaView];
    [self.bgscrollow addSubview:self.footView];
    [self.bgscrollow addSubview:self.couponCell];
    [self.bgscrollow addSubview:self.tourDiyView];
    
    [self.bgscrollow addSubview:self.webView];
    self.headView.frame = CGRectMake(0, self.cycleScroll.ctBottom, SCREENWIDTH, 114);
   __weak typeof(self) _weakSelf = self;
    [self.evaView setSkipBlock:^(NSInteger index) {
        EvaluateViewController *evaVC = [[EvaluateViewController alloc]init];
        [evaVC setProductId:_weakSelf.productID];
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
    [self.normalBView setPressAddBlock:^{
        [_weakSelf addShopCount];
       
    }];
    [self.normalBView setShopBlock:^{
        _weakSelf.tabBarController.selectedIndex = 2;
    }];
    [self.preBView setPressAddBlock:^{
        
    }];
    [self.groupBView setSingleBlock:^{
        
    }];
    [self.groupBView setGroupBlock:^{
        _weakSelf.groupBuyView.hidden = NO;
    }];
    [self.groupBuyView setPressAddBlock:^{
        
    }];
    [self.groupBuyView setSubBlock:^{
        
    }];
    [self.groupBuyView setSubmitBlock:^{
        _weakSelf.groupBuyView.hidden = YES;
        SureOrderViewController *sureVC = [[SureOrderViewController alloc]init];
        [_weakSelf.navigationController pushViewController:sureVC animated:YES];
    }];
    [self.groupBuyView setTapBlock:^{
        _weakSelf.groupBuyView.hidden = YES;
    }];
}

-(void)setProductID:(NSInteger )productID{
    _productID = productID;
    
}
-(void)reloadGoodDetail{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.couponType = @"allProduct";
    req.saleOrderStatus = @"0";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.productId = _productID;
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
            NSMutableArray *arr  = [NSMutableArray array];
            for (ImageModel *model in self.result.productImageList) {
                if (model.productImagePath) {
                    [arr addObject:model.productImagePath];
                }
            }
            weakself.cycleScroll.imageUrlGroups = arr;
            [weakself requestEvaluate];
        }
    }];
    
    
}
-(void)requestCoupon{
  
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.couponType = @"allProduct";
    req.saleOrderStatus = @"0";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.productId = _productID;
    req.pageIndex = @"1";
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[CouponServiceApi share]requestCouponListLoadWithParam:req response:^(id response) {
        if (response) {
            [weakself.couponArr removeAllObjects];
            [weakself.couponArr addObjectsFromArray:response];
            [weakself.couponView setDataArr:weakself.couponArr];
            NSString *title= @"";
            for (CouponListRes *model in response) {
                if (title.length<1) {
                    title = model.couponName;
                }else{
                    title = [NSString stringWithFormat:@"%@;%@",title,model.couponName];
                }
            }
            self.couponCell.detailLabel.text = title;
        }
        [weakself.footView setPruductId:weakself.productID];
         [self reloadHeight];

    }];
}
-(void)requestEvaluate{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.couponType = @"allProduct";
    req.saleOrderStatus = @"0";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.productId = _productID;
    req.pageIndex = @"1";
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[NextServiceApi share]requestEvaluateListModelListLoadWithParam:req response:^(id response) {
        
        
        weakself.evaRes = response;
        [weakself.evaView setModel:weakself.evaRes];
        [weakself requestGroup];
    
    }];
}
-(void)addShopCount{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.couponType = @"allProduct";
    req.saleOrderStatus = @"0";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.productId = _productID;
    req.pageIndex = @"1";
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    ProductSkuModel *model =[self.result.productSkuList firstObject];
    req.productSkuId = [NSString stringWithFormat:@"%ld",(long)model.productSkuId];
    req.productQuantity = @1;
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]addShopCartCountWithParam:req response:^(id response) {
        [weakself getShopCount:1];
    }];
}
-(void)getShopCount:(NSInteger)index{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.couponType = @"allProduct";
    req.saleOrderStatus = @"0";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    //    req.productId = [NSString stringWithFormat:@"%ld",productID];
    req.pageIndex = @"1";
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]getShopCartCountWithParam:req response:^(id response) {
        if (response!= nil) {
            NSDictionary* dic= response;
            if ([dic[@"cartProductCount"] integerValue]>0) {
                weakself.normalBView.countLabel.hidden = NO;
                weakself.normalBView.countLabel.text = [NSString stringWithFormat:@"%@",dic[@"cartProductCount"]];
            }
            if (index == 0) {
                 [self reloadGoodDetail];
            }
           
        }
    }];
}
-(void)requestGroup{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.productId = _productID;
    __weak typeof(self)weakself = self;
    [[GroupServiceApi share]spellGroupListWithParam:req response:^(id response) {
        self.footView.hidden = NO;
        if (response != nil) {
            [weakself.groupArr removeAllObjects];
            [weakself.groupArr addObjectsFromArray:response];
        }
         [weakself reloadData];
    }];
    
}
-(void)reloadData{
        [self.headView setModel:self.result];
    
    NSString *html_str = [NSString stringWithFormat:@"<head><style>img{max-width:%fpx !important;}</style></head>%@",SCREENWIDTH,self.result.productContent];
    
    [self.webView loadHTMLString:html_str baseURL:nil];
    
    if([self.result.productType isEqualToString:@"normal"]){//正常
       
        [self requestCoupon];
         [self.view addSubview:self.normalBView];
    }else if ([self.result.productType isEqualToString:@"groupon"]){//团购
        if (self.groupArr.count ==0) {
            _tourHeight = 0;
        }else{
            _tourHeight = 50;
        }
         [self.view addSubview:self.groupBView];
        [self.footView setPruductId:self.productID];
        [self reloadHeight];

    }else if ([self.result.productType isEqualToString:@"preSale"]){//预售
        _tourHeight = 0;
         [self.view addSubview:self.preBView];
        [self.footView setPruductId:self.productID];
         [self reloadHeight];

    }else {//满减
         [self requestCoupon];
         [self.view addSubview:self.normalBView];
    }
    [self.view addSubview:self.couponView];
    [self.view addSubview:self.groupBuyView];
}

-(void)reloadHeight{
    if (self.couponArr.count ==0) {
        _couponCell.hidden = YES;
        _couponHeight = 0;
    }else{
        _couponCell.hidden = NO;
        _couponHeight = 50;
    }
    if (_tourHeight ==0) {
        self.tourDiyView.hidden = YES;
    }else{
        self.tourDiyView.hidden = NO;
    }
    if (self.evaRes.total ==0) {
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
    [self getShopCount:0];
}

-(void)cycleScrollView:(ZSCycleScrollView *)cycleScrollView didSelectItemAtRow:(NSInteger)row{
    EvaluateViewController *evaVC = [[EvaluateViewController alloc]init];
    [self.navigationController pushViewController:evaVC animated:YES];
}
-(void)finishCouponView{
    self.couponView.hidden = YES;
}
-(void)getCouponViewWithIndex:(NSInteger)index{
    CouponListRes *model = self.couponArr[index];
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.couponId = model.couponId;
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.productCategoryParentId = @"";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    [[CouponServiceApi share] saveCouponWithParam:req response:^(id response) {
       
            [self showToast:response[@"message"]];
    
    }];
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
