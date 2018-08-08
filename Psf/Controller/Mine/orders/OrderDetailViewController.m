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

@interface OrderDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)OrderDetailBottomView *bottomView;
@property(nonatomic,strong)NSMutableArray *likeArr;
@property(nonatomic,strong)OrderDetailRes *result;

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
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"订单详情"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    
    __weak typeof(self)weakself = self;
    [self.bottomView setPayBlock:^(OrderListRes *model){//付款
        
    }];
    [self.bottomView setBuyBlock:^(OrderListRes *model){//再次购买
        [weakself againOrder:model.saleOrderId];
    }];
    [self.bottomView setLogisticsBlock:^(OrderListRes *model){//查看物流
        
    }];
    [self.bottomView setSureBlock:^(OrderListRes *model){//确认收货
        [weakself confirmOrder:model.saleOrderId];
    }];
    [self.bottomView setRefundBlock:^(OrderListRes *model){//退款
        
    }];
    
    [self.bottomView setRemindBlock:^(OrderListRes *model) {//提醒发货
        [weakself noticeOrder:model.saleOrderId];
    }];
    
    [self.bottomView setEvaBlock:^(OrderListRes * model) {
        FillEvaluateController *fillVC = [[FillEvaluateController alloc]init];
        [fillVC setModel:model];
        [weakself.navigationController pushViewController:fillVC animated:YES];
    }];
    [self.bottomView setDeleteBlock:^(OrderListRes * model) {//删除订单
        [weakself deleteOrder:model.saleOrderId];
    }];
    [self.bottomView setCancleBlock:^(OrderListRes *model) {//取消订单
        [weakself cancleOrder:model.saleOrderId];
    }];
}
-(void)setOrdertype:(ORDERSTYPE)ordertype{
    _ordertype = ordertype;
}
-(void)setModel:(OrderListRes *)model{
    _model = model;
    _likeArr = [NSMutableArray array];
    
    [self.bottomView setStatus:model];
     [self requestDetail];
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
                [weakself showToast:@"确认发货成功！"];
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
    req.pageIndex = @"1";
    req.pageSize = @"10";
    req.goodsCategoryId = @"";
    req.productCategoryParentId = @"";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]guessYouLikeWithParam:req response:^(id response) {
        if (response!= nil) {
            [weakself.likeArr removeAllObjects];
            [weakself.likeArr addObjectsFromArray:response];
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
    req.pageIndex = @"1";
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.cityName = @"上海市";
    req.saleOrderId = _model.saleOrderId;
    __weak typeof(self)weakself = self;
    weakself.result = [[OrderDetailRes alloc]init];
    [[OrderServiceApi share]getDetailOrderWithParam:req response:^(id response) {
        if (response) {
            weakself.result = response;
            if (self.result.saleOrderStatus ==4) {
                self.collectionView.frame = CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]);
            }else{
                [self.view addSubview:self.bottomView];
            }
            [weakself.collectionView reloadData];
            [self guessLikeList];
        }
    }];
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
        return CGSizeMake(165, 300);
    }else{
        if (self.result.saleOrderStatus ==0) {
            return CGSizeMake(SCREENWIDTH+1, 120);
        }
    }
    return CGSizeMake(SCREENWIDTH+1, 167);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return  CGSizeMake(SCREENWIDTH, 125);
    }
    return CGSizeMake(SCREENWIDTH, 50);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section ==0) {
        if (self.result.saleOrderStatus==0) {
            return CGSizeMake(SCREENWIDTH, 343);
        }else{
         return CGSizeMake(SCREENWIDTH, 317);
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
            if (self.result.saleOrderStatus ==0) {
                height = 343;
            }else{
                height = 317;
            }
            OrderDetailFootView*footViews = [[OrderDetailFootView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, height)];
            [footViews setOrdertype:_ordertype];
            [footViews setModel:self.result];
            [footview addSubview:footViews];
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
        [cell setModel:ordermodel];
        __weak typeof(self)weakself = self;
        [cell setRefundBlock:^(CartProductModel *model){//退款
            ChooseServiceTypeController *chooseVC = [[ChooseServiceTypeController alloc]init];
            [chooseVC setCarmodel:model];
            [weakself.navigationController pushViewController:chooseVC animated:YES];
        }];
        return cell;
    }
    
    StairCategoryListRes *model = _likeArr[indexPath.row];
    [collectcell setModel:model];
    return collectcell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    detailGoodsViewController *vc = [detailGoodsViewController new];
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
