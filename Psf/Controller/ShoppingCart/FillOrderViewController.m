//
//  FillOrderViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "FillOrderViewController.h"
#import "FillOrderTableViewCell.h"
#import "OrderDetailHeadView.h"
#import "FillOrderBottomView.h"
#import "FillOrderTypeView.h"
#import "MyReceiveAddressController.h"
#import "UseCouponController.h"
#import "NextReceiveDateView.h"
#import "AddressServiceApi.h"
#import "ShopServiceApi.h"
#import "PointAmountCell.h"
#import "StoreAddressController.h"
#import "CouponServiceApi.h"
#import "GroupServiceApi.h"
#import "DetailGroupController.h"
#import "InvoiceViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApiObject.h"
#import "WXApi.h"
#import "PaySuccessController.h"
#import "OrderServiceApi.h"

@interface FillOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *couponArr;
@property(nonatomic,strong)OrderDetailHeadView *headView;
@property(nonatomic,strong)FillOrderBottomView *bottomView;
@property(nonatomic,strong)FillOrderTypeView *typeView;
@property(nonatomic,strong)NextReceiveDateView *dateView;
@property(nonatomic,strong)CalculateReq *calculateModel;
@property(nonatomic,strong)CalculateThePriceRes* resModel;
@property(nonatomic,strong)StoreRes *storemodel;
@property(nonatomic,strong)ChangeAddressReq *leftModel;
@property(nonatomic,strong)PlaceOrderReq *placemodel;
@property(nonatomic,strong)PlaceOrderRes *resultmodel;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)NSInteger payType;

@end

@implementation FillOrderViewController
-(NextReceiveDateView *)dateView{
    if (!_dateView) {
        _dateView = [[NextReceiveDateView alloc]init];
        _dateView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        
        _dateView.hidden = YES;
    }
    return _dateView;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,46+[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]-46-[self navHeightWithHeight]) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.separatorColor = DSColorFromHex(0xF0F0F0);
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableview;
}
-(FillOrderBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[FillOrderBottomView alloc]init];
        _bottomView.frame = CGRectMake(0, SCREENHEIGHT-[self tabBarHeight], SCREENWIDTH, [self tabBarHeight]);
        [_bottomView.remindBtn addTarget:self action:@selector(pressRemind) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}
-(FillOrderTypeView *)typeView{
    if (!_typeView) {
        _typeView = [[FillOrderTypeView alloc]init];
        _typeView.frame = CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, 46);
    }
    return _typeView;
}
-(OrderDetailHeadView *)headView{
    if (!_headView) {
        _headView = [[OrderDetailHeadView alloc]init];
        _headView.frame = CGRectMake(0, 0, SCREENWIDTH, 165);
    }
    return _headView;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"填写订单"];
        _dataArr = [NSMutableArray array];
        _couponArr = [NSMutableArray array];
        _calculateModel = [[CalculateReq alloc]init];
        _calculateModel.useIsWeChart = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        _tableview.contentInsetAdjustmentBehavior = NO;
    } else {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.placemodel = [[PlaceOrderReq alloc]init];
    self.resultmodel = [[PlaceOrderRes alloc]init];
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView = self.headView;
    [self.view addSubview:self.bottomView];
   
    [self.view addSubview:self.dateView];
    _type = 1;
//    _payType = 0;
    [self.headView setGoodtype:CLAIMGOODSTYPEVISIT];
    __weak typeof(self) weakSelf = self;
    [self.typeView setChooseTypeBlock:^(NSInteger index) {
        weakSelf.type = index;
        if (index ==1) {
            weakSelf.calculateModel.expressEnable = YES;
            [weakSelf calculatePrice:weakSelf.calculateModel];
            [weakSelf.headView setGoodtype:CLAIMGOODSTYPEVISIT];
            weakSelf.headView.frame = CGRectMake(0, 0, SCREENWIDTH, 165);
             [weakSelf.headView setModel:weakSelf.leftModel];
        }else if (index ==2){
            weakSelf.calculateModel.expressEnable = NO;
            [weakSelf calculatePrice:weakSelf.calculateModel];
             [weakSelf.headView setGoodtype:CLAIMGOODSTYPEONESELF];
            [weakSelf.headView setStoremodel:weakSelf.storemodel];
            weakSelf.headView.frame = CGRectMake(0, 0, SCREENWIDTH, 125);
        }
        weakSelf.tableview.tableHeaderView = weakSelf.headView;
    }];
    [self.headView setAddressBlock:^(NSInteger index) {
        if (index ==1) {
            MyReceiveAddressController *addressVC = [[MyReceiveAddressController alloc]init];
            [addressVC setChooseBlock:^(ChangeAddressReq * model) {
                weakSelf.leftModel = model;
                [weakSelf.headView setModel:model];
            }];
            addressVC.type = ADDRESSTYPEOrder;
            [weakSelf.navigationController pushViewController:addressVC animated:YES];
        }else if (index ==2){
            StoreAddressController *addressVC = [[StoreAddressController alloc]init];
            [addressVC setStoreBlock:^(StoreRes * model) {
                [weakSelf.headView setStoremodel:model];
                weakSelf.storemodel = model;
            }];
            [weakSelf.navigationController pushViewController:addressVC animated:YES];
        }
       
    }];
    [self.headView setDateBlock:^(NSInteger index) {
        if (weakSelf.type ==1) {
            weakSelf.dateView.hidden = NO;
        }
    }];
    [self.dateView setCancleBlock:^(NSString* date,NSString *start,NSString* end) {
        weakSelf.dateView.hidden = YES;
        if (date.length>0) {
            weakSelf.headView.dateLabel.text = date;
            weakSelf.calculateModel.saleOrderDistributionStartTime = start;
            weakSelf.calculateModel.saleOrderDistributionEndTime = end ;
            [weakSelf calculatePrice:weakSelf.calculateModel];
        }
    }];
     [ZSNotification addWeixinPayResultNotification:self action:@selector(weixinPay:)];
}
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
-(void)setGoodstype:(GOOGSTYPE )goodstype{
    _goodstype = goodstype;
    if (_goodstype ==GOOGSTYPEPresale) {
        self.type = 2;
        self.calculateModel.expressEnable = NO;
        self.calculateModel.usePointIs = YES;
        self.calculateModel.useIsBalance = YES;
        [self calculatePrice:self.calculateModel];
        [self.headView setGoodtype:CLAIMGOODSTYPEONESELF];
        [self.headView setStoremodel:self.storemodel];
        self.headView.frame = CGRectMake(0, 0, SCREENWIDTH, 125);
    self.tableview.tableHeaderView = self.headView;
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = NO;
            self.tableview.frame =  CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]-[self navHeightWithHeight]);
        } else {
            self.navigationController.navigationBar.translucent = NO;
            self.automaticallyAdjustsScrollViewInsets = NO;
            self.tableview.frame =  CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]-[self navHeightWithHeight]);
        }
    }else{
        self.typeView.frame = CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, 46);
        self.typeView.hidden = NO;
        [self.view addSubview:self.typeView];
        self.tableview.frame = CGRectMake(0,46+[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]-46-[self navHeightWithHeight]);
        
    }
    
}

-(void)setGooddetail:(GoodDetailRes *)gooddetail{
    _gooddetail = gooddetail;
    ProductSkuModel *model;
    if (self.gooddetail.productSkuList.count>1) {
        model = _skumodel;
    }else{
      model = [self.gooddetail.productSkuList firstObject];
    }
    gooddetail.productSkuId = model.productSkuId;
    [_dataArr removeAllObjects];
    [_dataArr addObject:gooddetail];
    [_tableview reloadData];
    [self reloadLeftAddress];
}
-(void)setSkumodel:(ProductSkuModel *)skumodel{
    _skumodel = skumodel;
}
-(void)setProductArr:(NSArray *)productArr{
    _productArr = productArr;
    [_dataArr removeAllObjects];
    [_dataArr addObjectsFromArray:productArr];
    [_tableview reloadData];
    [self reloadLeftAddress];
}
-(void)setResult:(ShoppingListRes *)result{
    _result = result;
    
}

-(void)reloadLeftAddress{
    AddressBaeReq *req = [[AddressBaeReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    __weak typeof(self)weakself = self;
    [[AddressServiceApi share]getSingleDefaultAddresWithParam:req response:^(id response) {
        if (response!=nil) {
            weakself.leftModel = [[ChangeAddressReq alloc]init];
            weakself.leftModel = response;
            [weakself.headView setModel:weakself.leftModel];
        
        }else{
             weakself.headView.centerLabel.hidden = NO;
        }
       
        [self fetchCoupon];
    }];
}

-(void)fetchCoupon{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    req.saleOrderProductList = self.dataArr;
    
    __weak typeof(self)weakself = self;
    [[CouponServiceApi share]fillOrderCouponWithParam:req response:^(id response) {
        if (response) {
            [weakself.couponArr removeAllObjects];
            [weakself.couponArr addObjectsFromArray:response];
        }
         [weakself pickUpStoreData];
    }];
}
-(void)calculatePrice:(CalculateReq*)req{
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    
    if (_goodstype ==GOOGSTYPENormal) {
        NSMutableArray *arr = [NSMutableArray array];
        for (CartProductModel *model in _productArr) {
            if (model.productQuantity) {
                model.saleOrderProductQty = model.productQuantity;
                [arr addObject:model];
            }
        }
        req.productList = arr;
        [self calculateNormal:req];
    }else if (_goodstype ==GOOGSTYPEGroup){
        req.productId = self.gooddetail.productId;
        req.saleOrderProductQty = self.gooddetail.saleOrderProductQty;
        req.productList = self.dataArr;
        __weak typeof(self)weakself = self;
        [[GroupServiceApi share]getGroupPriceWithParam:req response:^(id response) {
            if (response) {
                weakself.resModel = [[CalculateThePriceRes alloc]init];
                weakself.resModel = response;
                weakself.bottomView.payableLabel.text = [NSString stringWithFormat:@"应付款：￥%@",weakself.resModel.saleOrderPayAmount];
                [weakself.tableview reloadData];
            }
        }];
    }else if (_goodstype ==GOOGSTYPESingle){
        req.productId = self.gooddetail.productId;
        req.saleOrderProductQty = self.gooddetail.saleOrderProductQty;
        req.productList = self.dataArr;
        [self calculateNormal:req];
    }else if (_goodstype ==GOOGSTYPEPresale){
        req.productId = self.gooddetail.productId;
        req.saleOrderProductQty = self.gooddetail.saleOrderProductQty;
        req.productSkuId = self.gooddetail.productSkuId;
        req.productList = self.dataArr;
        __weak typeof(self)weakself = self;
        [[GroupServiceApi share]getPresalePriceWithParam:req response:^(id response) {
            if (response) {
                weakself.resModel = [[CalculateThePriceRes alloc]init];
                weakself.resModel = response;
                weakself.bottomView.payableLabel.text = [NSString stringWithFormat:@"应付款：￥%@",weakself.resModel.saleOrderPayAmount];
                [weakself.tableview reloadData];
            }
        }];
    }
    
}

-(void)calculateNormal:(CalculateReq*)req{
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]CalculateThePriceWithParam:req response:^(id response) {
        if (response) {
            weakself.resModel = [[CalculateThePriceRes alloc]init];
            weakself.resModel = response;
            weakself.bottomView.payableLabel.text = [NSString stringWithFormat:@"应付款：￥%@",weakself.resModel.saleOrderPayAmount];
            [weakself.tableview reloadData];
        }
    }];
}

-(void)pickUpStoreData{
    AddressBaeReq *req = [[AddressBaeReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    __weak typeof(self)weakself = self;
    [[AddressServiceApi share]pickUpSingleDefaultAddresWithParam:req response:^(id response) {
        if (response) {
            weakself.storemodel = response;
            if (weakself.goodstype ==GOOGSTYPEPresale) {
                self.type =2;
                self.calculateModel.expressEnable = NO;
                [self calculatePrice:self.calculateModel];
                [self.headView setGoodtype:CLAIMGOODSTYPEONESELF];
                [self.headView setStoremodel:self.storemodel];
            }
        }
        weakself.calculateModel.usePointIs = YES;
        weakself.calculateModel.productList = weakself.productArr;
        weakself.calculateModel.useIsBalance = YES;
        weakself.calculateModel.expressEnable = YES;
        NSDate *date = [[[NSDate alloc]init]dateByAddingDays:1];
        NSString *next = [date stringWithFormat:@"yyyy-MM-dd"];
        NSString *end = [NSString stringWithFormat:@"%@ 12:00:00",next];
        next = [NSString stringWithFormat:@"%@ 09:00:00",next];
        weakself.calculateModel.couponId = @"";
        weakself.calculateModel.saleOrderDistributionStartTime = next;
        weakself.calculateModel.saleOrderDistributionEndTime = end ;
        [weakself calculatePrice:weakself.calculateModel];
    }];
}
-(void)placeOrder{
    PlaceOrderReq *req = [[PlaceOrderReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    req.cityName = @"上海市";
    
    req.couponId = @"";
    req.useIsBalance = self.calculateModel.useIsBalance;
    req.usePointIs = self.calculateModel.usePointIs;
    req.saleOrderPointAmount = self.resModel.saleOrderPointAmount;
   
    if (self.payType ==1) {
        req.saleOrderPayType = @"3";
    }else if(self.payType ==0){
         req.saleOrderPayType = @"2";
    }
    req.saleOrderIsInvoice = self.placemodel.saleOrderIsInvoice;
    req.saleOrderInvoiceType = self.placemodel.saleOrderInvoiceType;
    req.saleOrderPlatform = @"ios";
    if (req.saleOrderInvoiceType==0&&req.saleOrderIsInvoice ==YES) {
        req.saleOrderInvoiceUserName = self.placemodel.saleOrderInvoiceUserName;
    }else{
       req.saleOrderInvoiceUserName = @"";
    }
    if (req.saleOrderInvoiceType==1&&req.saleOrderIsInvoice ==YES) {
        req.saleOrderInvoiceCompanyName = self.placemodel.saleOrderInvoiceCompanyName;
        req.saleOrderInvoiceCompanyTax = self.placemodel.saleOrderInvoiceCompanyTax;
    }else{
       req.saleOrderInvoiceCompanyName = @"";
       req.saleOrderInvoiceCompanyTax = @"";
    }
    req.saleOrderInvoiceContent = @"";
    req.saleOrderInvoiceEmail = @"";
    if (self.type ==1) {
        req.saleOrderReceiveType = @"1";
        req.saleOrderReceiveName = self.leftModel.memberAddressName;
        req.saleOrderReceiveProvince = self.leftModel.memberAddressProvince;
        req.saleOrderReceiveCity = self.leftModel.memberAddressCity;
        req.saleOrderReceiveArea = self.leftModel.memberAddressArea;
        req.saleOrderReceiveAddress = self.leftModel.memberAddressDetail;
        req.saleOrderReceiveMobile = self.leftModel.memberAddressMobile;
        req.merchantStoreName = @"";
         req.merchantStoreId = @"";
        if (self.leftModel.memberAddressName.length<1) {
            [self showInfo:@"请填写收货地址"];
            return;
        }
        
    }else if (self.type ==2){
        req.saleOrderReceiveName = @"";
        req.saleOrderReceiveType = @"0";
        if (self.storemodel.storeName.length<1) {
            req.merchantStoreName = @"";
        }else{
            req.merchantStoreName = self.storemodel.storeName;
        }
        if (self.storemodel.storeProvinces.length<1) {
            req.saleOrderReceiveProvince = @"";
        }else{
            req.saleOrderReceiveProvince = self.storemodel.storeProvinces;
        }
        if (self.storemodel.storeCity.length<1) {
            req.saleOrderReceiveCity = @"";
        }else{
           req.saleOrderReceiveCity = self.storemodel.storeCity;
        }
        if (self.storemodel.storeArea.length<1) {
            req.saleOrderReceiveArea = @"";
        }else{
            req.saleOrderReceiveArea = self.storemodel.storeArea;
        }
        if (self.storemodel.storeAddress.length<1) {
            req.saleOrderReceiveAddress = @"";
        }else{
            req.saleOrderReceiveAddress = self.storemodel.storeAddress;
        }
        if (self.storemodel.storeTel.length<1) {
            req.saleOrderReceiveMobile = @"";
        }else{
            req.saleOrderReceiveMobile = self.storemodel.storeTel;
        }
        
        if (self.storemodel.storeId ==nil) {
            req.merchantStoreId = @"";
        }else{
            req.merchantStoreId = self.storemodel.storeId;
        }
        if (req.merchantStoreId.length<1) {
            [self showInfo:@"请选择自提门店"];
            return;
        }
    }
    
    req.saleOrderDistributionStartTime = self.calculateModel.saleOrderDistributionStartTime;
    req.saleOrderDistributionEndTime = self.calculateModel.saleOrderDistributionEndTime;
    NSMutableArray *arr = [NSMutableArray array];
    
    
    if (_goodstype == GOOGSTYPENormal) {
        for (CartProductModel *model in self.productArr) {
            if (model.productQuantity) {
                model.saleOrderProductQty = model.productQuantity;
                req.saleOrderTotalQuantity = req.saleOrderTotalQuantity + model.productQuantity ;
                [arr addObject:model];
            }
        }
        req.productList = arr;
        req.saleOrderType = @"normal";
        [self placeNormalOrder:req];
    }else if (_goodstype == GOOGSTYPESingle){
        req.saleOrderType = @"normal";
        req.productList = self.dataArr;
        [self placeNormalOrder:req];
    }else if (_goodstype == GOOGSTYPEGroup){
        req.saleOrderType = @"group";
        req.grouponActiveType = 0;
        req.grouponActivityId = @"";
        req.grouponId = self.gooddetail.grouponId;
        req.productList = self.dataArr;
        [self placeGroupOrder:req];
    }else if (_goodstype ==GOOGSTYPEPresale){
        req.saleOrderType = @"presale";
        req.preSaleId = self.gooddetail.preSaleId;
        req.productList = self.dataArr;
        [self placePresaleOrder:req];
    }
}
///正常下单
-(void)placeNormalOrder:(PlaceOrderReq*)req{
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]placeThePriceWithParam:req response:^(id response) {
        if (response) {
            if ([response isKindOfClass:[NSDictionary class]]) {
                [weakself showToast:response[@"message"]];
            }else{
                PlaceOrderRes *result = [[PlaceOrderRes alloc]init];
                result= response;
                self.resultmodel = result ;
                if ([result.saleOrderPayAmount isEqualToString:@"0"]) {
                    PaySuccessController *successVC = [[PaySuccessController alloc]init];
                    successVC.result = result;
                    [self.navigationController pushViewController:successVC animated:YES];
                }else{
                    [self gotoAlipayOrWX:result.saleOrderId Amount:result.saleOrderPayAmount payType:req.saleOrderPayType];
                    
                }
                
            }
        }
    }];
}
///团购下单
-(void)placeGroupOrder:(PlaceOrderReq*)req{
    __weak typeof(self)weakself = self;
    [[GroupServiceApi share]saveGroupWithParam:req response:^(id response) {
        if (response) {
            if ([response isKindOfClass:[NSDictionary class]]) {
                [weakself showToast:response[@"message"]];
            }else{
                PlaceOrderRes *result = [[PlaceOrderRes alloc]init];
                result= response;
                self.resultmodel = result ;
                if ([result.saleOrderPayAmount isEqualToString:@"0"]) {
                    PaySuccessController *successVC = [[PaySuccessController alloc]init];
                    successVC.result = result;
                    [self.navigationController pushViewController:successVC animated:YES];
                }else{
                    [self gotoAlipayOrWX:result.saleOrderId Amount:result.saleOrderPayAmount payType:req.saleOrderPayType];
                    
                }
                
            }
        }
    }];
}
///预售下单
-(void)placePresaleOrder:(PlaceOrderReq*)req{
    __weak typeof(self)weakself = self;
    [[GroupServiceApi share]savePresaleWithParam:req response:^(id response) {
        if (response) {
            if ([response isKindOfClass:[NSDictionary class]]) {
                [weakself showToast:response[@"message"]];
            }else{
                PlaceOrderRes *result = [[PlaceOrderRes alloc]init];
                result= response;
                self.resultmodel = result ;
                if ([result.saleOrderPayAmount isEqualToString:@"0"]) {
                    PaySuccessController *successVC = [[PaySuccessController alloc]init];
                    successVC.result = result;
                    [self.navigationController pushViewController:successVC animated:YES];
                }else{
                    [self gotoAlipayOrWX:result.saleOrderId Amount:result.saleOrderPayAmount payType:req.saleOrderPayType];
                    
                }
                
            }
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
   if (self.payType ==0) {
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section ==0){
        return self.dataArr.count;
    }else if (section ==1){
        return 8;
    }
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1||indexPath.section ==2) {
        if (indexPath.section ==1) {
                if (([self.resModel.saleOrderRewardAmount isEqualToString:@"0"]||self.resModel.saleOrderRewardAmount.length ==0)&&indexPath.row ==3) {
                    return 0;
                }
                if (self.couponArr.count ==0&&indexPath.row ==1) {
                return 0;
              }
        }
        return 45;
    }
    return 120;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView;
    if (section ==1||section ==2) {
         headView= [[UIView alloc]init];
        headView.frame = CGRectMake(0, 0, SCREENWIDTH, 5);
        headView.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return headView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        static NSString *identify = @"FillOrderTableViewCell";
        FillOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[FillOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_goodstype ==GOOGSTYPENormal) {
            CartProductModel *model = _dataArr[indexPath.row];
            [cell setModel:model];
        }else{
            GoodDetailRes *model = _dataArr[indexPath.row];
            [cell setRes:model];
        }
       
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
    if (indexPath.row ==5||indexPath.row ==6) {
        static NSString *identify = @"PointAmountCell";
        PointAmountCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[PointAmountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setIndex:indexPath.row];
        if(indexPath.row ==5) {
            if (self.resModel.saleOrderPointAmount) {
                cell.nameLabel.text = [NSString stringWithFormat:@"积分抵扣￥%@",self.resModel.saleOrderPointAmount];
            }else{
                cell.nameLabel.text = @"积分抵扣￥0";
            }
            
            
            if (self.calculateModel) {
                cell.yuEswitch.selected = self.calculateModel.usePointIs;
            }else{
                cell.yuEswitch.selected = YES;
                self.calculateModel.usePointIs = YES;
            }
            
        }else if(indexPath.row ==6) {
            if (self.resModel.useMemberBalance.length>0) {
                 cell.nameLabel.text = [NSString stringWithFormat:@"余额抵扣￥%@",self.resModel.useMemberBalance];
            }else{
                 cell.nameLabel.text = @"余额抵扣￥0";
            }
           
            if (self.calculateModel) {
                cell.yuEswitch.selected = self.calculateModel.useIsBalance;
            }else{
                cell.yuEswitch.selected = YES;
                self.calculateModel.useIsBalance = YES;
            }
            
        }
        __weak typeof(self)weakself = self;
        [cell setYuEBlock:^(NSInteger index) {
            if (index ==6) {
                weakself.calculateModel.useIsBalance = !weakself.calculateModel.useIsBalance;
                [weakself calculatePrice:weakself.calculateModel];
            }else if (index ==5){
                weakself.calculateModel.usePointIs = !weakself.calculateModel.usePointIs;
                [weakself calculatePrice:weakself.calculateModel];
            }
        }];
        return cell;
    }
    static NSString *identify = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
   cell.imageView.image = [UIImage imageNamed:@""];
   cell.accessoryType = UITableViewCellAccessoryNone;
    for (UIView*view in cell.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    if (indexPath.section ==1) {
        if (indexPath.row ==0) {
            cell.textLabel.text = @"商品总价";
            
            if (self.resModel.saleOrderTotalAmount.length>0) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@",self.resModel.saleOrderTotalAmount];
            }
            cell.detailTextLabel.textColor = DSColorFromHex(0x464646);
        }else if (indexPath.row ==1) {
            if (self.couponArr.count ==0) {
                cell.hidden = YES;
            }else{
                cell.textLabel.text = @"优惠券：暂无可用";
                cell.detailTextLabel.text = @"0张";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }else if(indexPath.row ==4) {
            cell.textLabel.text = @"运费";
            if (self.resModel.saleOrderExpressAmount.length>0) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@",self.resModel.saleOrderExpressAmount];
            }
            cell.detailTextLabel.textColor = DSColorFromHex(0x464646);
        }else if(indexPath.row ==2) {
            cell.textLabel.text = @"电子发票";
            if (self.placemodel.saleOrderIsInvoice ==NO) {
                 cell.detailTextLabel.text = @"不需要";
            }else{
                if (self.placemodel.saleOrderInvoiceType==0) {
                    cell.detailTextLabel.text = @"个人";
                }else if (self.placemodel.saleOrderInvoiceType==1){
                    cell.detailTextLabel.text = @"单位";
                }
            }
           
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
        }else if(indexPath.row ==7) {
            cell.textLabel.text = @"合计";
            if (self.resModel.saleOrderPayAmount.length>0) {
               cell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %@",self.resModel.saleOrderPayAmount];
            }
            cell.detailTextLabel.textColor = DSColorFromHex(0x464646);
        }else if (indexPath.row ==3){
            if ([self.resModel.saleOrderRewardAmount isEqualToString:@"0"]||self.resModel.saleOrderRewardAmount.length ==0) {
                cell.hidden = YES;
            }else{
                cell.textLabel.text = @"满减";
                cell.detailTextLabel.textColor = DSColorFromHex(0xFF4C4D);
                 if (self.resModel.saleOrderRewardAmount.length>0) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"-¥ %@",self.resModel.saleOrderRewardAmount];
                 }
            }
            
        }
    }else if (indexPath.section ==2){
        static NSString *identify = @"PointAmountCell";
        PointAmountCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[PointAmountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setIndex:indexPath.row];
        if (_payType ==0) {
            if (indexPath.row ==0) {
                cell.nameLabel.text = @"微信支付";
                cell.yuEswitch.selected = YES;
            }else if (indexPath.row ==1){
                cell.nameLabel.text = @"支付宝支付";
                cell.yuEswitch.selected = NO;
            }
        }else if (_payType ==1){
            if (indexPath.row ==0) {
                cell.nameLabel.text = @"微信支付";
                cell.yuEswitch.selected = NO;
            }else if (indexPath.row ==1){
                cell.nameLabel.text = @"支付宝支付";
                cell.yuEswitch.selected = YES;
            }
        }
        __weak typeof(self)weakself = self;
        [cell setYuEBlock:^(NSInteger index) {
            if (index ==0) {
                weakself.payType =0;
                [weakself.tableview reloadData];
                
            }else if (index ==1){
                weakself.payType =1;
                 [weakself.tableview reloadData];
            }
        }];
        
        return cell;
    }
    cell.textLabel.textColor = DSColorFromHex(0x464646);
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)pressWeChart:(UIButton*)sender{
    sender.selected = !sender.selected;
    self.calculateModel.useIsWeChart = sender.selected;
}
///下单
-(void)pressRemind{
    [self placeOrder];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        if (indexPath.row ==0) {
            UseCouponController *useVC = [[UseCouponController alloc]init];
            [self.navigationController pushViewController:useVC animated:YES];
        }
        if (indexPath.row ==2) {
            InvoiceViewController *invoiceVC = [[InvoiceViewController alloc]init];
            
            [invoiceVC setPlacemodel:self.placemodel];
            __weak typeof(self)weakself = self;
            [invoiceVC setSubmintBlock:^(PlaceOrderReq *model) {
                weakself.placemodel = model;
                [weakself.tableview reloadData];
            }];
            [self.navigationController pushViewController:invoiceVC animated:YES];
        }
    }
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
