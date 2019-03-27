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
#import "PresaleBuyView.h"
#import "StoreGoodsBuyView.h"
#import "GoodRecipesView.h"

#import "FillOrderViewController.h"
#import "SpellGroupListController.h"
#import "NextDayServiceController.h"
#import "SortViewController.h"
#import "ShoppingCartController.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "ZSCycleScrollView.h"

#import "ServiceViewController.h"
#import "PresaleHomeController.h"
#import "NextDayServiceController.h"
#import "MineViewController.h"
#import "StoreGoodsController.h"
#import "DetailRecipeController.h"
#import "CircleController.h"

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
@property(nonatomic,strong)GoodRecipesView *recipeView;
@property(nonatomic,strong)GetCouponsCellView *couponCell;
@property(nonatomic,strong)GetCouponsView *couponView;
@property(nonatomic,strong)TourDiyGooddetailView *tourDiyView;
@property(nonatomic,strong)GoodBottomView *normalBView;
@property(nonatomic,strong)PresaleGoodBottomView *preBView;
@property(nonatomic,strong)GroupGoodBottomView *groupBView;
@property(nonatomic,strong)GoodDetailRes *result;
@property(nonatomic,strong)GoodDetailRes *resmodel;
@property (strong, nonatomic) UIWebView *webView;
@property(strong,nonatomic)EvaluateListRes *evaRes;

@property(nonatomic,strong)GroupBuyView *groupBuyView;
@property(nonatomic,strong)PresaleBuyView *presaleBuyView;
@property(nonatomic,strong)StoreGoodsBuyView *storeBuyView;

@property(nonatomic,strong)NSMutableArray *groupArr;
@property(nonatomic,strong)NSMutableArray *couponArr;
@property(nonatomic,assign)NSInteger recipeHeight;
@property(strong,nonatomic)UIImageView *bgimageview;
@property(strong,nonatomic)NSData *shareData;

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
        WEAKSELF;
        [_headView setShareBlock:^{
            [weakSelf pressShare];
        }];
        
    }
    return _headView;
}
-(GoodFootView *)footView{
    if (!_footView) {
        _footView = [[GoodFootView alloc]initWithFrame:CGRectMake(SCREENHEIGHT, 0, SCREENWIDTH, 10)];
        _footView.hidden = YES;
    }
    return _footView;
}
-(GoodRecipesView *)recipeView{
    if (!_recipeView) {
        _recipeView = [[GoodRecipesView alloc]initWithFrame:CGRectMake(SCREENHEIGHT, 0, SCREENWIDTH, 0)];
        WEAKSELF;
        [_recipeView setSelectedCollect:^(NSString * str) {
            DetailRecipeController *detailVC = [[DetailRecipeController alloc]init];
            detailVC.hidesBottomBarWhenPushed = YES;
            [detailVC setEpicureId:str];
            [weakSelf.navigationController pushViewController:detailVC animated:YES];
        }];
    }
    return _recipeView;
}
-(GoodBottomView *)normalBView{
    if (!_normalBView) {
        _normalBView = [[GoodBottomView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-[self tabBarHeight], SCREENHEIGHT, [self tabBarHeight])];
        _normalBView.hidden = YES;
        
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
         _couponView.frame = CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT);
        _couponView.delegate = self;
    }
    return _couponView;
}
-(GroupBuyView *)groupBuyView{
    if (!_groupBuyView) {
        _groupBuyView = [[GroupBuyView alloc]init];
        _groupBuyView.hidden = YES;
        
        
             _groupBuyView.frame = CGRectMake(0,0, SCREENWIDTH, SCREENHEIGHT);
    
         [_groupBuyView setHeight:[self tabBarHeight]];
    }
    return _groupBuyView;
}
-(PresaleBuyView *)presaleBuyView{
    if (!_presaleBuyView) {
        _presaleBuyView = [[PresaleBuyView alloc]init];
        _presaleBuyView.hidden = YES;
            _presaleBuyView.frame = CGRectMake(0,0, SCREENWIDTH, SCREENHEIGHT);
        
        [_presaleBuyView setHeight:[self tabBarHeight]];
    }
    return _presaleBuyView;
}
-(StoreGoodsBuyView *)storeBuyView{
    if (!_storeBuyView) {
        _storeBuyView = [[StoreGoodsBuyView alloc]init];
        _storeBuyView.hidden = YES;
        _storeBuyView.frame = CGRectMake(0,0, SCREENWIDTH, SCREENHEIGHT);
        
        [_storeBuyView setHeight:[self tabBarHeight]];
    }
    return _storeBuyView;
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
        [_cycleScroll setIndex:1];
    }
    return _cycleScroll;
}
-(UIScrollView *)bgscrollow{
    if (!_bgscrollow) {
        _bgscrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight])];
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
        _webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"商品"];
    }
    return self;
}
-(void)setNavStr:(NSString *)navStr{
    _navStr = navStr;
    if ([navStr isEqualToString:@"shop"]) {
         if (@available(iOS 11.0, *)) {
             
         }else{
        self.preBView.frame = CGRectMake(0, SCREENHEIGHT-[self tabBarHeight]-[self navHeightWithHeight], SCREENHEIGHT, [self tabBarHeight]);
        self.normalBView.frame = CGRectMake(0, SCREENHEIGHT-[self tabBarHeight]-[self navHeightWithHeight], SCREENHEIGHT, [self tabBarHeight]);
        self.groupBView.frame = CGRectMake(0, SCREENHEIGHT-[self tabBarHeight]-[self navHeightWithHeight], SCREENHEIGHT, [self tabBarHeight]);
        _presaleBuyView.frame = CGRectMake(0,-[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT);
        _groupBuyView.frame = CGRectMake(0,-[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT);
         }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.bgscrollow.contentInsetAdjustmentBehavior = NO;
        self.bgscrollow.frame =  CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]);
    } else {

         self.bgscrollow.frame =  CGRectMake(0,0, SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]);
    }
    [self.view addSubview:self.bgscrollow];
    [self setLeftButtonWithIcon:[UIImage imageNamed:@"icon_back"]];
    _groupArr = [NSMutableArray array];
    _couponArr = [NSMutableArray array];
    [self.bgscrollow addSubview:self.cycleScroll];
    [self.bgscrollow addSubview:self.headView];
    [self.bgscrollow addSubview:self.evaView];
    [self.bgscrollow addSubview:self.recipeView];
    [self.bgscrollow addSubview:self.footView];
    [self.bgscrollow addSubview:self.couponCell];
    [self.bgscrollow addSubview:self.tourDiyView];
    
    [self.bgscrollow addSubview:self.webView];
    [self.view addSubview:self.normalBView];
    [self.view addSubview:self.storeBuyView];
   __weak typeof(self) _weakSelf = self;
    [self.tourDiyView setPressAllBlock:^(NSInteger index) {
        SpellGroupListController *spellVC = [[SpellGroupListController alloc]init];
        [spellVC setProductID:_weakSelf.productID];
        [_weakSelf.navigationController pushViewController:spellVC animated:YES];
    }];
    [self.evaView setSkipBlock:^(NSInteger index) {
        EvaluateViewController *evaVC = [[EvaluateViewController alloc]init];
        [evaVC setProductId:_weakSelf.productID];
        [_weakSelf.navigationController pushViewController:evaVC animated:YES];
    }];
    [self.couponCell setPressCoupBlock:^(NSInteger index) {
        _weakSelf.couponView.hidden = NO;
        [_weakSelf requestCoupon];
    }];
    [self.tourDiyView setPressGoBlock:^(NSInteger index) {
        
        FillOrderViewController *detailVC = [[FillOrderViewController alloc]init];
        [detailVC setOrderType:2];
        [detailVC setNavStr:_weakSelf.navStr];
        [_weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
   
    [self.footView setSelectedCollect:^(NSInteger productId, NSString *erpproductId) {
        detailGoodsViewController*detailVC = [[detailGoodsViewController alloc]init];
        [detailVC setProductID:productId];
        [detailVC setErpProductId:erpproductId];
        [detailVC setNavStr:_weakSelf.navStr];
        [_weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    [self.normalBView setPressAddBlock:^{
        if ([UserCacheBean share].userInfo.token.length>0) {
            if([_weakSelf.result.productType isEqualToString:@"normal"]){
                if (_weakSelf.result.productStyle ==1) {
//                    _weakSelf.storeBuyView.hidden = NO;
                    _weakSelf.storeBuyView.countField.text = [UserCacheBean share].userInfo.productDefaultWeight;
                    GoodDetailRes *model = _weakSelf.result;
//                    double price = [model.productPrice doubleValue]*[[UserCacheBean share].userInfo.productDefaultWeight doubleValue];
//                    model.productPrice = [NSString stringWithFormat:@"%.2f",price];
                    [_weakSelf addShopCount:nil Quantity:@"1"];
                }else{
                    if (_weakSelf.result.productSkuList.count>1) {
                        _weakSelf.presaleBuyView.hidden = NO;
                        [_weakSelf.presaleBuyView.submitBtn setTitle:@"加购物车" forState:UIControlStateNormal];
                        [_weakSelf.presaleBuyView setType:1];
                    }else{
                        ProductSkuModel *model = [_weakSelf.result.productSkuList firstObject];
                        [_weakSelf addShopCount:model Quantity:@"1"];
                    }
                 }
            }else{
                if (_weakSelf.result.productSkuList.count>1) {
                    _weakSelf.presaleBuyView.hidden = NO;
                    [_weakSelf.presaleBuyView.submitBtn setTitle:@"加购物车" forState:UIControlStateNormal];
                    [_weakSelf.presaleBuyView setType:1];
                }else{
                    ProductSkuModel *model = [_weakSelf.result.productSkuList firstObject];
                    [_weakSelf addShopCount:model Quantity:@"1"];
                }
            }
        
    }else{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"请您先登录"
            message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { //响应事件
                _weakSelf.tabBarController.selectedIndex = 4;
                }];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {//响应事件
                
               
            }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [_weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
    }];
    [self.normalBView setShopBlock:^{
        for (UIViewController *controller in _weakSelf.navigationController.viewControllers) {
            if ([controller isKindOfClass:[ShoppingCartController class]]) {
                [_weakSelf.navigationController popToViewController:controller animated:YES];
            }else if ([controller isKindOfClass:[PresaleHomeController class]]){
                _weakSelf.tabBarController.selectedIndex = 3;
                [_weakSelf.navigationController popToViewController:controller animated:YES];
                
            }else if ([controller isKindOfClass:[StoreGoodsController class]]){
                _weakSelf.tabBarController.selectedIndex = 3;
                [_weakSelf.navigationController popToViewController:controller animated:YES];
                
            }else if ([controller isKindOfClass:[CircleController class]]){
                _weakSelf.tabBarController.selectedIndex = 3;
                [_weakSelf.navigationController popToViewController:controller animated:YES];
                
            }else{
                _weakSelf.tabBarController.selectedIndex = 3;
            }
        }
        
    }];
    [self.preBView setPressAddBlock:^{
        if ([UserCacheBean share].userInfo.token.length>0) {
       ProductSkuModel *model= [_weakSelf.result.productSkuList firstObject];
            FillOrderViewController *sureVC = [[FillOrderViewController alloc]init];
            _weakSelf.result.saleOrderProductQty = 1;
            
            NSString *time  = [NSDate cStringFromTimestamp:_weakSelf.result.preSaleDeliveryTime Formatter:@"yyyy-MM-dd"];
            [sureVC setPresaleTime:time];
            [sureVC setGoodstype:GOOGSTYPEPresale];
            [sureVC setSkumodel:model];
            [sureVC setGooddetail:_weakSelf.resmodel];
            [sureVC setNavStr:_weakSelf.navStr];
            [sureVC setOrderType:2];
            [_weakSelf.navigationController pushViewController:sureVC animated:YES];
        }else{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"请您先登录"
                                                                           message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { //响应事件
                _weakSelf.tabBarController.selectedIndex = 4;
                for (UIViewController *controller in _weakSelf.navigationController.viewControllers) {
                    
                    
                        [_weakSelf.navigationController popToViewController:controller animated:YES];
                        return ;
                }
                
            }];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {//响应事件
                
                
            }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [_weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
    }];
    [self.preBView setPressshopBlock:^{
         if ([UserCacheBean share].userInfo.token.length>0) {
            ProductSkuModel *model= [_weakSelf.result.productSkuList firstObject];
            [_weakSelf addShopCount:model Quantity:@"1"];
         } else{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"请您先登录"
                                                                           message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { //响应事件
                _weakSelf.tabBarController.selectedIndex = 4;
                for (UIViewController *controller in _weakSelf.navigationController.viewControllers) {
                    
                   
                        [_weakSelf.navigationController popToViewController:controller animated:YES];
                        return ;
                    
                }
                
            }];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {//响应事件
                
                
            }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [_weakSelf presentViewController:alert animated:YES completion:nil];
        }
    }];
    [self.preBView setGoShopeBlock:^{
        for (UIViewController *controller in _weakSelf.navigationController.viewControllers) {
            if ([controller isKindOfClass:[ShoppingCartController class]]) {
                [_weakSelf.navigationController popToViewController:controller animated:YES];
            }else if ([controller isKindOfClass:[PresaleHomeController class]]){
                _weakSelf.tabBarController.selectedIndex = 3;
                [_weakSelf.navigationController popToViewController:controller animated:YES];
                
            }else if ([controller isKindOfClass:[SortViewController class]]){
                _weakSelf.tabBarController.selectedIndex = 3;
                [_weakSelf.navigationController popToViewController:controller animated:YES];
                
            }else if ([controller isKindOfClass:[CircleController class]]){
                _weakSelf.tabBarController.selectedIndex = 3;
                [_weakSelf.navigationController popToViewController:controller animated:YES];
                
            }else{
                _weakSelf.tabBarController.selectedIndex = 3;
            }
        }
    }];
    [self.groupBView setSingleBlock:^{
        [_weakSelf.groupBuyView setType:1];
        _weakSelf.groupBuyView.hidden = NO;
    }];
    [self.groupBView setGroupBlock:^{
        [_weakSelf.groupBuyView setType:2];
        _weakSelf.groupBuyView.hidden = NO;
    }];
    
    
    [self.groupBuyView setSubmitBlock:^(NSInteger type,NSInteger count){
        _weakSelf.groupBuyView.hidden = YES;
        if ([UserCacheBean share].userInfo.token.length>0) {
            FillOrderViewController *sureVC = [[FillOrderViewController alloc]init];
            _weakSelf.result.saleOrderProductQty = count;
            _weakSelf.result.productPrice = _weakSelf.result.grouponPrice;
            if (type ==1) {
                [sureVC setGoodstype:GOOGSTYPESingle];
            }else if (type ==2){
                [sureVC setGoodstype:GOOGSTYPEGroup];
            }
            [sureVC setOrderType:2];
            [sureVC setGooddetail:_weakSelf.result];
            [sureVC setNavStr:_weakSelf.navStr];
            [_weakSelf.navigationController pushViewController:sureVC animated:YES];
        }else{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"请您先登录"
                                                                           message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { //响应事件
                _weakSelf.tabBarController.selectedIndex = 4;
                for (UIViewController *controller in _weakSelf.navigationController.viewControllers) {
                    
                    if ([controller isKindOfClass:[NextDayServiceController class]]) {
                        [_weakSelf.navigationController popToViewController:controller animated:YES];
                        return ;
                    }
                }
                
            }];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {//响应事件
                
                
            }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [_weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
    }];
    [self.groupBuyView setTapBlock:^{
        _weakSelf.groupBuyView.hidden = YES;
    }];
   
    [self.presaleBuyView setSubmitBlock:^(NSInteger count,NSInteger index,NSInteger _type){
        if ([UserCacheBean share].userInfo.token.length>0) {
            ProductSkuModel *skumodel = _weakSelf.resmodel.productSkuList[index];
            _weakSelf.presaleBuyView.hidden = YES;
            if(_type ==0){
                FillOrderViewController *sureVC = [[FillOrderViewController alloc]init];
                _weakSelf.result.saleOrderProductQty = count;
                [sureVC setGoodstype:GOOGSTYPEPresale];
                [sureVC setSkumodel:skumodel];
                [sureVC setGooddetail:_weakSelf.resmodel];
                [sureVC setNavStr:_weakSelf.navStr];
                [sureVC setOrderType:2];
                [_weakSelf.navigationController pushViewController:sureVC animated:YES];
            }else if (_type ==1){
                [_weakSelf addShopCount:skumodel Quantity:@"1"];
            }
        }else{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"请您先登录"
                                                                           message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { //响应事件
                _weakSelf.tabBarController.selectedIndex = 4;
                for (UIViewController *controller in _weakSelf.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[PresaleHomeController class]]) {
                        [_weakSelf.navigationController popToViewController:controller animated:YES];
                        return ;
                    }
                    if ([controller isKindOfClass:[NextDayServiceController class]]) {
                        [_weakSelf.navigationController popToViewController:controller animated:YES];
                        return ;
                    }
                }
                
            }];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {//响应事件
                
                
            }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [_weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
    }];
    [self.presaleBuyView setTapBlock:^{
        _weakSelf.presaleBuyView.hidden = YES;
    }];
    [self.preBView setServiceBlock:^{
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",@"400-821-6094"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
     }];
    [self.storeBuyView setTapBlock:^{
        _weakSelf.storeBuyView.hidden = YES;
    }];
    [self.storeBuyView setSubmitBlock:^(NSString *weight, GoodDetailRes *detailmodel, StairCategoryListRes *resmodel) {
        _weakSelf.storeBuyView.hidden = YES;
        [_weakSelf addShopCount:nil Quantity:weight];
    }];
    [self getShopCount:0];
}

-(void)setProductID:(NSInteger )productID{
    _productID = productID;
    
}
-(void)setErpProductId:(NSString*)erpProductId{
    _erpProductId = erpProductId;
}
-(void)setProductType:(NSString *)productType{
    _productType = productType;
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
    req.userLongitude = [UserCacheBean share].userInfo.longitude;
    req.userLatitude = [UserCacheBean share].userInfo.latitude;
    req.productId = _productID;
    req.pageIndex = 1;
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    req.erpProductId = _erpProductId;
    req.productType = _productType;
    __weak typeof(self)weakself = self;
    [[NextServiceApi share]requestGoodDetailLoadWithParam:req response:^(id response) {
        if([response isKindOfClass:[GoodDetailRes class]]){
            weakself.result = response;
            weakself.resmodel = response;
            
            [weakself.storeBuyView setModel:response];
            NSMutableArray *arr  = [NSMutableArray array];
            for (ImageModel *model in weakself.result.productImageList) {
                if (model.productImagePath) {
                    [arr addObject:model.productImagePath];
                }
            }
            weakself.bgimageview = [[UIImageView alloc]init];
            ImageModel *model1 = [weakself.result.productImageList firstObject];
            [weakself.bgimageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEHOST,model1.productImagePath]]];
            weakself.cycleScroll.imageUrlGroups = arr;
            weakself.shareData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEHOST,model1.productImagePath]]];
            [weakself requestEvaluate];
        }else{
            NSString *message=response[@"data"][@"message"];
            if (message.length >0) {
                
            }
            [self showInfo:message];
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
    req.userLongitude = [UserCacheBean share].userInfo.longitude;
    req.userLatitude = [UserCacheBean share].userInfo.latitude;
    req.productId = _productID;
    req.pageIndex = 1;
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
        [weakself requestRecipeData];

    }];
}
-(void)requestRecipeData{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    req.appId = @"993335466657415169";
    req.cityName = @"上海市";
    req.cityId = @"310100";
    req.timestamp = @"0";
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    req.pageIndex = 1;
    req.pageSize = @"10";
    req.sign = @"ffc18def63af3916f4d39165697f228f";
    req.productId = self.productID;
    WEAKSELF;
    [[NextServiceApi share]getRecipeListWithParam:req response:^(id response) {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        [arr addObjectsFromArray:response];
        if (arr.count>0) {
            [weakSelf.recipeView setDataArr:arr];
            weakSelf.recipeHeight = 220;
        }else{
            weakSelf.recipeHeight = 0;
        }
        [weakSelf.footView setPruductId:weakSelf.productID];
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
    req.userLongitude = [UserCacheBean share].userInfo.longitude;
    req.userLatitude = [UserCacheBean share].userInfo.latitude;
    req.productId = _productID;
    req.pageIndex = 1;
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[NextServiceApi share]requestEvaluateListModelListLoadWithParam:req response:^(id response) {
        
        
        weakself.evaRes = response;
        [weakself.evaView setModels:self.evaRes];
        [weakself requestGroup];
    
    }];
}
-(void)addShopCount:(ProductSkuModel *)model Quantity:(NSString*)quantity{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.couponType = @"allProduct";
    req.saleOrderStatus = @"0";
    req.userLongitude = [UserCacheBean share].userInfo.longitude;
    req.userLatitude = [UserCacheBean share].userInfo.latitude;
    req.productId = _productID;
    req.pageIndex = 1;
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    req.productSkuId = [NSString stringWithFormat:@"%ld",(long)model.productSkuId];
    req.productQuantity = quantity;
    req.productType = self.productType;
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]addShopCartCountWithParam:req response:^(id response) {
       
        if (response!= nil) {
            [weakself showInfo:response[@"message"]];
        }
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
    req.userLongitude = [UserCacheBean share].userInfo.longitude;
    req.userLatitude = [UserCacheBean share].userInfo.latitude;
    //    req.productId = [NSString stringWithFormat:@"%ld",productID];
    req.pageIndex = 1;
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
                weakself.preBView.countLabel.hidden = NO;
                weakself.preBView.countLabel.text = [NSString stringWithFormat:@"%@",dic[@"cartProductCount"]];
                
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
        
        if (response != nil) {
            [weakself.groupArr removeAllObjects];
            [weakself.groupArr addObjectsFromArray:response];
        }
         [weakself reloadData];
    }];
    
}
-(void)reloadData{
     [self.headView setModel:self.result];
    if ([self.result.productType isEqualToString:@"groupon"]){
        self.headView.frame = CGRectMake(0, self.cycleScroll.ctBottom, SCREENWIDTH, 96);
    }else if([self.result.productType isEqualToString:@"normal"]||[self.result.productType isEqualToString:@"nextDay"]||[self.result.productType isEqualToString:@"reward"]){
        self.headView.frame = CGRectMake(0, self.cycleScroll.ctBottom, SCREENWIDTH, 114);
    }else if ([self.result.productType isEqualToString:@"preSale"]) {
        self.headView.frame = CGRectMake(0, self.cycleScroll.ctBottom, SCREENWIDTH, 160);
    }
    
    
    NSString *html_str = [NSString stringWithFormat:@"<head><style>img{width:%fpx !important;}</style></head>%@",SCREENWIDTH-15,self.result.productContent];
  
    [self.webView loadHTMLString:html_str baseURL:nil];
    
    if([self.result.productType isEqualToString:@"normal"]){//正常
        [self requestCoupon];
        self.normalBView.hidden = NO;
        if (self.result.productSkuList.count>1) {
            [self.presaleBuyView setType:1];
            [self.presaleBuyView setModel:self.result];
            [self.view addSubview:self.presaleBuyView];
        }
         _tourHeight = 0;
        
    }else if ([self.result.productType isEqualToString:@"groupon"]){//团购
        if (self.groupArr.count ==0) {
            _tourHeight = 0;
        }else{
            if (self.groupArr.count<4) {
                _tourHeight = 80+self.groupArr.count*71;
            }else{
                _tourHeight = 80+3*71;
            }
            [self.tourDiyView setDataArr:self.groupArr];
        }
         [self.view addSubview:self.groupBView];
        [self.groupBView setModel:self.result];
        [self.footView setPruductId:self.productID];
       
    [self.view addSubview:self.groupBuyView];
    }else if ([self.result.productType isEqualToString:@"preSale"]){//预售
        [self requestCoupon];
        _tourHeight = 0;
         [self.view addSubview:self.preBView];
        [self.presaleBuyView setType:0];
        [self.presaleBuyView setModel:self.result];
        [self.preBView setPreSaleIsComplete:self.result.preSaleIsComplete];
        [self.footView setPruductId:self.productID];
        
      [self.view addSubview:self.presaleBuyView];
    }else if([self.result.productType isEqualToString:@"nextDay"]){//次日达
        [self requestCoupon];
         _tourHeight = 0;
        self.normalBView.hidden = NO;
        if (self.result.productSkuList.count>1) {
            [self.presaleBuyView setType:1];
            [self.presaleBuyView setModel:self.result];
            [self.view addSubview:self.presaleBuyView];
        }
    }else if([self.result.productType isEqualToString:@"reward"]){//满减
         [self requestCoupon];
         _tourHeight = 0;
        self.normalBView.hidden = NO;
        if (self.result.productSkuList.count>1) {
            [self.presaleBuyView setType:1];
            [self.presaleBuyView setModel:self.result];
            [self.view addSubview:self.presaleBuyView];
        }
    }
     [self reloadHeight];
    [self.view addSubview:self.couponView];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.webView.frame = CGRectMake(0, self.footView.ctBottom, SCREENWIDTH, self.webView.scrollView.contentSize.height);
    _bgscrollow.contentSize = CGSizeMake(0, self.webView.ctBottom+100);
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
        _evaHeight = 50+[GoodEvaluateView getCellHeightWithData:self.evaRes];
        _evaView.hidden = NO;
    }
    
    self.tourDiyView.frame = CGRectMake(0, self.headView.ctBottom, SCREENWIDTH, _tourHeight);
    self.couponCell.frame = CGRectMake(0, self.tourDiyView.ctBottom, SCREENWIDTH, _couponHeight);
    self.evaView.frame = CGRectMake(0, self.couponCell.ctBottom, SCREENWIDTH, _evaHeight);
    if (self.recipeHeight ==0) {
        self.recipeView.frame = CGRectMake(0, self.evaView.ctBottom, SCREENWIDTH, 0);
        self.recipeView.hidden = YES;
    }else{
        self.recipeView.frame = CGRectMake(0, self.evaView.ctBottom+5, SCREENWIDTH, 220);
        self.recipeView.hidden = NO;
    }
    
    self.footView.frame = CGRectMake(0, self.recipeView.ctBottom+5, SCREENWIDTH, 253);
    self.webView.frame = CGRectMake(0, self.footView.ctBottom, SCREENWIDTH, 100);
    if (self.result.productContent.length<1) {
        self.webView.frame = CGRectMake(0, self.footView.ctBottom, SCREENWIDTH, 50);
    }
    self.footView.hidden = NO;
     _bgscrollow.contentSize = CGSizeMake(0, self.webView.ctBottom+100);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self adjustNavigationUI:self.navigationController];
    
}

-(void)cycleScrollView:(ZSCycleScrollView *)cycleScrollView didSelectItemAtRow:(NSInteger)row{
//    EvaluateViewController *evaVC = [[EvaluateViewController alloc]init];
//    [self.navigationController pushViewController:evaVC animated:YES];
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
    req.couponId = [model.couponId integerValue];
    req.userLongitude = [UserCacheBean share].userInfo.longitude;
    req.userLatitude = [UserCacheBean share].userInfo.latitude;
    req.productCategoryParentId = @"";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    [[CouponServiceApi share] saveCouponWithParam:req response:^(id response) {
       
            [self showToast:response[@"message"]];
    
    }];
}
-(void)pressShare{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.result.productName;
    UIImage *image = [UIImage compressImageQuality:self.bgimageview.image toByte:30];
    if (!self.shareData) {
        NSData *data = [NSData dataWithHexString:@"11111"];
        message.thumbData = data;
    }else{
        NSData *data = UIImageJPEGRepresentation(image, 1);;
        message.thumbData = data;
    }

    message.description = @"邀您一起";
    if (!image) {
        [message setThumbImage:[UIImage imageNamed:@"qr_icon"]];
    }else{
        [message setThumbImage:image];
    }
    WXWebpageObject *webpage = [WXWebpageObject object];
    NSString*url =[NSString stringWithFormat:@"http://xcxb.lxnong.com/share/index.html#/?erpStoreId=%@&erpProductId=%@&productId=%ld",[UserCacheBean share].userInfo.erpStoreId,self.result.erpProductId,(long)self.result.productId];
    webpage.webpageUrl = url;
    message.mediaObject = webpage;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
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
