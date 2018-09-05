//
//  OrderDetailViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/27.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderCollectionViewCell.h"
#import "NextCollectionViewCell.h"
#import "detailGoodsViewController.h"
#import "OrderDetailBottomView.h"
#import "OrderDetailFootView.h"
#import "OrderDetailHeadView.h"
#import "NextCollectionHeadView.h"
#import "ShopServiceApi.h"
#import "OrderServiceApi.h"
#import "FillEvaluateController.h"
#import "ChooseServiceTypeController.h"
#import "ZitiMaView.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "PaySuccessController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ChoosePayTypeView.h"

@interface OrderDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)OrderDetailBottomView *bottomView;
@property(nonatomic,strong)NSMutableArray *likeArr;
@property(nonatomic,strong)OrderDetailRes *result;
@property(nonatomic,strong)ZitiMaView *zitiVew;
@property(nonatomic,strong)ChoosePayTypeView *payTypeView;
@property(nonatomic,strong)PlaceOrderRes* resultmodel;
@property(nonatomic,assign)NSInteger type;
@end
static NSString *cellId = @"OrderCollectionViewCell";
static NSString *cellIds = @"NextCollectionViewCell";
@implementation OrderDetailViewController
-(OrderDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[OrderDetailBottomView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-[self tabBarHeight], SCREENWIDTH, [self tabBarHeight])];
    }
    return _bottomView;
}
-(ZitiMaView *)zitiVew{
    if (!_zitiVew) {
        _zitiVew = [[ZitiMaView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _zitiVew.hidden = YES;
    }
   return  _zitiVew;
}
-(ChoosePayTypeView *)payTypeView{
    if (!_payTypeView) {
        _payTypeView = [[ChoosePayTypeView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _payTypeView.hidden = YES;
    }
    return  _payTypeView;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"订单详情"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = NO;
    } else {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
   
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]-[self navHeightWithHeight]) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[OrderCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [self.collectionView registerClass:[NextCollectionViewCell class] forCellWithReuseIdentifier:cellIds];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    [self.collectionView
     registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footreusableView"];
    [self.view addSubview:self.zitiVew];
     [self.view addSubview:self.payTypeView];
    __weak typeof(self)weakself = self;
    [self.bottomView setPayBlock:^(OrderDetailRes *model){//付款
        weakself.resultmodel = [[PlaceOrderRes alloc]init];
        weakself.resultmodel.saleOrderId = model.saleOrderId;
        weakself.resultmodel.saleOrderPayAmount = model.saleOrderPayAmount;
        [weakself.payTypeView setSureBlock:^(NSString * type) {
            [weakself gotoAlipayOrWX:model.saleOrderId Amount:model.saleOrderPayAmount payType:type];
            weakself.payTypeView.hidden = YES;
        }];
        weakself.payTypeView.hidden = NO;
    }];
    [self.payTypeView setCloseBlock:^{
        weakself.payTypeView.hidden = YES;
    }];
    [self.bottomView setBuyBlock:^(OrderDetailRes *model){//再次购买
        
        [weakself againOrder:model.saleOrderId];
       
    }];
    [self.bottomView setLogisticsBlock:^(OrderDetailRes *model){//查看物流
        
    }];
    [self.bottomView setSureBlock:^(OrderDetailRes *model){//确认收货
        if (weakself.type ==1) {
            if ([[UserCacheBean share].userInfo.roleId integerValue] ==1) {
                StairCategoryReq *req = [[StairCategoryReq alloc]init];
                req.updateType = @"delivery";
                req.saleOrderId = model.saleOrderId;
                [weakself deliverOrder:req];
            }else if ([[UserCacheBean share].userInfo.roleId integerValue] ==0&&weakself.model.memberId.length>0){
                StairCategoryReq *req = [[StairCategoryReq alloc]init];
                req.updateType = @"selfLeft";
                req.saleOrderId = model.saleOrderId;
                [weakself deliverOrder:req];
            }else if([[UserCacheBean share].userInfo.roleId integerValue] ==0&&weakself.model.memberId.length==0){
                StairCategoryReq *req = [[StairCategoryReq alloc]init];
                req.updateType = @"confirm";
                req.saleOrderId = model.saleOrderId;
                [weakself deliverOrder:req];
            }
        }else{
           [weakself confirmOrder:model.saleOrderId];
        }
    }];
    [self.bottomView setRefundBlock:^(OrderDetailRes *model){//退款
        
    }];
    
    [self.bottomView setRemindBlock:^(OrderDetailRes *model) {//提醒发货
        [weakself noticeOrder:model.saleOrderId];
    }];
    
    [self.bottomView setEvaBlock:^(OrderDetailRes * model) {
        FillEvaluateController *fillVC = [[FillEvaluateController alloc]init];
        [fillVC setModel:model];
        [weakself.navigationController pushViewController:fillVC animated:YES];
    }];
    [self.bottomView setDeleteBlock:^(OrderDetailRes * model) {//删除订单
        [weakself deleteOrder:model.saleOrderId];
    }];
    [self.bottomView setCancleBlock:^(OrderDetailRes *model) {//取消订单
        [weakself cancleOrder:model.saleOrderId];
    }];
    [self.bottomView setZitiBlock:^(OrderDetailRes *model) {//自提码
        weakself.zitiVew.hidden = NO;
    }];
    [self.zitiVew setCloseBlock:^{
        weakself.zitiVew.hidden = YES;
    }];
    
    [ZSNotification addWeixinPayResultNotification:self action:@selector(weixinPay:)];
    [ZSNotification addAlipayPayResultNotification:self action:@selector(AlipayPay:)];
}
#pragma mark-支付回调通知
-(void)weixinPay:(NSNotification *)notifi{
    NSDictionary *userInfo = [notifi userInfo];
    if ([[userInfo objectForKey:@"weixinpay"] isEqualToString:@"success"]) {
        PaySuccessController *successVC = [[PaySuccessController alloc]init];
        if(self.resultmodel){
            successVC.result = self.resultmodel;
            [self.navigationController pushViewController:successVC animated:YES];
        }
    }
    [self showInfo:[userInfo objectForKey:@"strMsg"]];
}
-(void)AlipayPay:(NSNotification *)notifi{
    NSDictionary *userInfo = [notifi userInfo];
    if ([[userInfo objectForKey:@"strMsg"] isEqualToString:@"支付成功"]) {
        PaySuccessController *successVC = [[PaySuccessController alloc]init];
        if(self.resultmodel){
            successVC.result = self.resultmodel;
            [self.navigationController pushViewController:successVC animated:YES];
        }
    }
    [self showInfo:[userInfo objectForKey:@"strMsg"]];
}
-(void)setOrdertype:(ORDERSTYPE)ordertype{
    _ordertype = ordertype;
}
-(void)setModel:(OrderListRes *)model{
    _model = model;
    _likeArr = [NSMutableArray array];
    
    if (model.saleOrderType.length>0) {
        _type =2;
        [self.bottomView setType:2];
    }else{
        _type = 1;
        [self.bottomView setType:1];
    }
    [self.bottomView setMemberId:model.memberId];
     [self requestDetail];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
-(void)noticeOrder:(NSString*)saleId{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.saleOrderId = saleId;
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[OrderServiceApi share]noticeOrderWithParam:req response:^(id response) {
        if (response) {
            if ([response[@"code"] integerValue] == 200) {
                [weakself showToast:@"已提醒发货！"];
            }
        }
    }];
    
}
-(void)deliverOrder:(StairCategoryReq*)req{
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    __weak typeof(self)weakself = self;
    [[OrderServiceApi share]confirmDeliveryOrderWithParam:req response:^(id response) {
        if (response) {
            if ([response[@"code"] integerValue] ==200) {
                if ([[UserCacheBean share].userInfo.roleId integerValue] ==1) {
                    [self showInfo:@"发货成功"];
                }else if ([[UserCacheBean share].userInfo.roleId integerValue] ==0&&weakself.model.memberId.length>0){
                    [self showInfo:@"自提成功"];
                }else if([[UserCacheBean share].userInfo.roleId integerValue] ==0&&weakself.model.memberId.length==0){
                   [self showInfo:@"收货成功"];
                }
            }else{
                [self showInfo:response[@"message"]];
                
            }
        }
    }];
}
-(void)confirmOrder:(NSString*)orderid{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.saleOrderId = orderid;
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[OrderServiceApi share]confirmOrderWithParam:req response:^(id response) {
        if (response) {
            if ([response[@"code"] integerValue] == 200) {
                [weakself showToast:@"确认收货成功！"];
            }
        }
    }];
    
}
-(void)deleteOrder:(NSString*)orderid{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.saleOrderId = orderid;
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[OrderServiceApi share]deleteOrderWithParam:req response:^(id response) {
        if (response) {
            if ([response[@"code"] integerValue] == 200) {
                [weakself showToast:@"删除订单成功！"];
            }
        }
    }];
}
-(void)cancleOrder:(NSString*)orderid{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.saleOrderId = orderid;
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[OrderServiceApi share]cancleOrderWithParam:req response:^(id response) {
        if (response) {
            if ([response[@"code"] integerValue] == 200) {
                [weakself showToast:@"取消订单成功！"];
            }
        }
    }];
}
-(void)againOrder:(NSString*)orderid{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.saleOrderId = orderid;
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[OrderServiceApi share]againOrderWithParam:req response:^(id response) {
        if (response) {
            if ([response[@"code"] integerValue] ==200) {
                if ([response[@"data"][@"productType"] isEqualToString:@"normal"]) {
                    self.tabBarController.selectedIndex = 1;
                }else if ([response[@"data"][@"productType"] isEqualToString:@"preSale"]){
                    detailGoodsViewController *detailVC = [[detailGoodsViewController alloc]init];
                    [detailVC setProductID:[response[@"data"][@"productId"] integerValue]];
                    [self.navigationController pushViewController:detailVC animated:YES];
                }else if ([response[@"data"][@"productType"] isEqualToString:@"groupon"]){
                    detailGoodsViewController *detailVC = [[detailGoodsViewController alloc]init];
                    [detailVC setProductID:[response[@"data"][@"productId"] integerValue]];
                    [self.navigationController pushViewController:detailVC animated:YES];
                }
            }else{
                [self showInfo:response[@"code"][@"message"]];
            }
        }
    }];
}
-(void)guessLikeList{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.pageIndex = 1;
    req.pageSize = @"10";
    req.goodsCategoryId = @"";
    req.productCategoryParentId = @"";
    req.productCategoryId = @"";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]guessYouLikeWithParam:req response:^(id response) {
        if (response!= nil) {
            [weakself.likeArr removeAllObjects];
            [weakself.likeArr addObjectsFromArray:response];
            if (weakself.result.saleOrderStatus ==2&&weakself.result.saleOrderReceiveType ==0) {
                [weakself.zitiVew setSaleOrderId:weakself.result.saleOrderId];
            }
            [weakself.collectionView reloadData];
           
        }
        
    }];
}
-(void)requestDetail{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.saleOrderStatus = @"2";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.pageIndex = 1;
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.cityName = @"上海市";
    req.saleOrderId = _model.saleOrderId;
    __weak typeof(self)weakself = self;
    weakself.result = [[OrderDetailRes alloc]init];
    [[OrderServiceApi share]getDetailOrderWithParam:req response:^(id response) {
        if (response) {
            weakself.result = response;
            if (weakself.result.saleOrderStatus ==4) {
                weakself.collectionView.frame = CGRectMake(0, [weakself navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[weakself navHeightWithHeight]);
            }else{
                [weakself.view addSubview:weakself.bottomView];
            }
            [weakself.bottomView setStatus:weakself.result];
            
            [weakself.collectionView reloadData];
            
            [self guessLikeList];
        }
    }];
}
-(void)gotoAlipayOrWX:(NSString *)orderstr Amount:(NSString*)amount payType:(NSString*)type{
    UnifiedOrderReq *req =[[UnifiedOrderReq alloc]init];
    
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    
    req.platform = @"ios";
    req.saleOrderId = orderstr;
    if ([type isEqualToString:@"2"]) {
        [[OrderServiceApi share]unifiedOrderWithParam:req response:^(id response) {
            if (response) {
                OrderPayRes *model = response;
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = model.partnerid;
                req.prepayId            = model.prepayid;
                req.nonceStr            = model.noncestr;
                req.timeStamp           = model.timestamp.intValue;
                req.package             = model.packagestr;
                req.sign                = model.sign;
                [WXApi sendReq:req];
                
            }
        }];
    }else{
        [[OrderServiceApi share]alipayOrderWithParam:req response:^(id response) {
            if (response) {
                OrderPayRes *model = response;
                NSString *appScheme = @"LxnScheme";
                [[AlipaySDK defaultService] payOrder:model.body fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    NSLog(@"reslut = %@",resultDic);
                }];
            }
        }];
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section ==0) {
        return self.result.saleOrderProductList.count;
    }
    
    return self.likeArr.count;
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 0, 15);
    
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return -10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==1) {
        return CGSizeMake(165, 260);
    }else{
        if (self.result.saleOrderStatus ==0) {
            return CGSizeMake(SCREENWIDTH+1, 120);
        }
    }
    return CGSizeMake(SCREENWIDTH+1, 120);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return  CGSizeMake(SCREENWIDTH, 125);
    }
    return CGSizeMake(SCREENWIDTH, 50);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section ==0) {
        if ([self.result.saleOrderType isEqualToString:@"preSale"]) {
            return CGSizeMake(SCREENWIDTH, 440);
        }else{
         return CGSizeMake(SCREENWIDTH, 415);
        }
    }
    return CGSizeMake(SCREENWIDTH, 0);
}
//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footreusableView" forIndexPath:indexPath];
        footview.backgroundColor =DSColorFromHex(0xF2F2F2);
        for (UIView *view in footview.subviews) {
            if ([view isKindOfClass:[UIView class]]) {
                [view removeFromSuperview];
            }
        }
        if (indexPath.section ==0) {
            NSInteger height;
            if ([self.result.saleOrderType isEqualToString:@"preSale"]) {
                height = 440;
            }else{
                height = 415;
            }
            OrderDetailFootView*footViews = [[OrderDetailFootView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, height)];
            [footViews setOrdertype:_ordertype];
            [footViews setModel:self.result];
            [footview addSubview:footViews];
            [footViews setPhoneBlock:^{
                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",@"400-821-6094"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                
            }];
        }
        return footview;
    }
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    
    
    for (UIView *view in headerView.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    
    if (indexPath.section ==0) {
        OrderDetailHeadView* orderView = [[OrderDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 125)];
        [orderView setGoodtype:CLAIMGOODSTYPEONESELF];
        orderView.rightTBtn.hidden = YES;
        orderView.rightBBtn.hidden = YES;
        [orderView setAddressBlock:^(NSInteger index) {
            
        }];
        [orderView setOrdermodel:self.result];
        [headerView addSubview:orderView];
    }else if (indexPath.section ==1){
 NextCollectionHeadView* validView = [[NextCollectionHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
        [validView.typeBtn setTitle:@"猜你喜欢" forState:UIControlStateNormal];
        [headerView addSubview:validView];
    }
    
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NextCollectionViewCell *collectcell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIds forIndexPath:indexPath];
    OrderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    if (indexPath.section ==0) {
        CartProductModel *ordermodel = self.result.saleOrderProductList[indexPath.row];
        ordermodel.systemStatus = self.result.saleOrderStatus;
        if (self.model.saleOrderType.length>0) {
            [cell setOrdertype:2];
        }else{
            [cell setOrdertype:1];
        }
        [cell setModel:ordermodel];
        __weak typeof(self)weakself = self;
        [cell setRefundBlock:^(CartProductModel *model){//退款
            ChooseServiceTypeController *chooseVC = [[ChooseServiceTypeController alloc]init];
            [chooseVC setCarmodel:model];
            [weakself.navigationController pushViewController:chooseVC animated:YES];
//             [self ceshi:model.saleOrderId];
        }];
        [cell setBuyBlock:^(CartProductModel *model) {
    
        }];
        [cell setPayBlock:^(CartProductModel *model) {//付款
            weakself.resultmodel = [[PlaceOrderRes alloc]init];
            weakself.resultmodel.saleOrderId = model.saleOrderId;
            [weakself.payTypeView setSureBlock:^(NSString * type) {
                [weakself gotoAlipayOrWX:model.saleOrderId Amount:weakself.resultmodel.saleOrderPayAmount payType:type];
                weakself.payTypeView.hidden = YES;
            }];
            weakself.payTypeView.hidden = NO;
        }];
        
        return cell;
    }
    
    StairCategoryListRes *model = _likeArr[indexPath.row];
    [collectcell setModel:model];
    return collectcell;
}
-(void)ceshi:(NSInteger)orderid{
    RefundOrderReq *req = [[RefundOrderReq alloc]init];
    req.saleOrderId = orderid ;
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    req.refundId = orderid;
    req.totalFee = @"1";
    req.refundFee = @"1";
    req.refundDesc = @"测试";
    [[OrderServiceApi share]ceshirefundOrderWithParam:req response:^(id response) {
        
    }];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    detailGoodsViewController *vc = [detailGoodsViewController new];
    StairCategoryListRes *model = _likeArr[indexPath.row];
    [vc setProductID:model.productId];
    [self.navigationController showViewController:vc sender:nil];
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
