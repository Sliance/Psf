//
//  ShoppingCartController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/14.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ShoppingCartController.h"
#import "ShoppingCollectionViewCell.h"
#import "detailGoodsViewController.h"
#import "NextCollectionViewCell.h"
#import "ValidShopHeadView.h"
#import "LoseShopHeadView.h"
#import "LikeShopHeadView.h"
#import "ShopFootView.h"
#import "FillOrderViewController.h"
#import "ShopServiceApi.h"
#import "EmptyShoppingHeadView.h"
#import "NextCollectionHeadView.h"
#import "CartProductModel.h"
#import "CustomFootView.h"


#import "ShopAlertView.h"

@interface ShoppingCartController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)ShopFootView *footView;
@property(nonatomic,strong)ShopAlertView *shopAlertView;
@property(nonatomic,strong)ShoppingListRes *result;
@property(nonatomic,strong)ShoppingListRes *jisuanmodel;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *loseArr;
@property(nonatomic,strong)NSMutableArray *likeArr;

@end
static NSString *cellId = @"ShoppingCollectionViewCell";
static NSString *cellIds = @"NextCollectionViewCell";
@implementation ShoppingCartController
-(ShopFootView *)footView{
    if (!_footView) {
        _footView = [[ShopFootView alloc]initWithFrame:CGRectZero];
        
        _footView.hidden = YES;
        [_footView.submitBtn addTarget:self action:@selector(pressSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footView;
}
-(ShopAlertView *)shopAlertView{
    if (!_shopAlertView) {
        _shopAlertView = [[ShopAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _shopAlertView.hidden = YES;
    }
    return _shopAlertView;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"购物车"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]-49) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[ShoppingCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [self.collectionView registerClass:[NextCollectionViewCell class] forCellWithReuseIdentifier:cellIds];
    self.collectionView.backgroundColor = DSColorFromHex(0xF0F0F0);
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    [self.collectionView
     registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footreusableView"];
    [self.view addSubview:self.footView];
    [self.view addSubview:self.shopAlertView];
    _dataArr = [NSMutableArray array];
    _loseArr = [NSMutableArray array];
    _likeArr = [NSMutableArray array];
    __weak typeof(self)weakself = self;
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-[weakself tabBarHeight]);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    
    [self.footView setAllBlock:^(BOOL selected) {
        [weakself selectedAll:selected];
    }];
    [self.shopAlertView setCloseBlcok:^{
        weakself.tabBarController.tabBar.hidden = NO;
        weakself.shopAlertView.hidden = YES;
        
    }];
    [self.shopAlertView setSubmitBlock:^(NSArray *arr,NSString*time) {
         weakself.tabBarController.tabBar.hidden = NO;
        
         weakself.shopAlertView.hidden = YES;
        FillOrderViewController *fillVC = [[FillOrderViewController alloc]init];
        fillVC.hidesBottomBarWhenPushed = YES;
        [fillVC setOrderType:1];
        if (time.length>0) {
            [fillVC setPresaleTime:time];
             [fillVC setGoodstype:GOOGSTYPEPresale];
        }else{
             [fillVC setGoodstype:GOOGSTYPENormal];
        }
       
        [fillVC setProductArr:arr];
        [fillVC setResult:weakself.result];
        [weakself.navigationController pushViewController:fillVC animated:YES];
    }];
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = NO;
        self.collectionView.frame = CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]-[self tabBarHeight]-49);
    } else {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.collectionView.frame = CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]-[self tabBarHeight]-49);
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setLeftButtonWithIcon:[UIImage imageNamed:@""]];
//    self.footView.hidden = YES;
    [self requestData];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    self.footView.hidden = NO;
}
-(void)requestData{
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
    req.pageIndex = 1;
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]requestShopListModelListLoadWithParam:req response:^(id response) {
        if (response) {
             weakself.result = response;
            [weakself.dataArr removeAllObjects];
            [weakself.loseArr removeAllObjects];
            for (CartProductModel *model  in weakself.result.cartProductList) {
                if (model.productIsOnSale ==1) {
                    [weakself.dataArr addObject:model];
                }else{
                    [weakself.loseArr addObject:model];
                }
            }
            if(weakself.result.cartProductList.count ==0){
                
                if (@available(iOS 11.0, *)) {
                    weakself.collectionView.contentInsetAdjustmentBehavior = NO;
                    weakself.collectionView.frame = CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]-[self tabBarHeight]);
                } else {
                    weakself.navigationController.navigationBar.translucent = NO;
                    weakself.automaticallyAdjustsScrollViewInsets = NO;
                    weakself.collectionView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]-[self tabBarHeight]);
                }
                weakself.footView.hidden = YES;
            }else if(weakself.result.cartProductList.count>0){
                weakself.footView.hidden = NO;
                
            }
            [weakself.footView setModel:weakself.result];
            [weakself.collectionView reloadData];
        }
        [self  guessLikeList];
    }];
}
-(void)getShopCount{
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
    
    [[ShopServiceApi share]getShopCartCountWithParam:req response:^(id response) {
        
    }];
}


-(void)changeShopCount:(CartProductModel*)model{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.userLongitude = [UserCacheBean share].userInfo.longitude;
    req.userLatitude = [UserCacheBean share].userInfo.latitude;
    req.cartProductId = model.cartProductId;
    req.productCategoryParentId = @"";
   
    req.cityId = @"310100";
    req.cityName = @"上海市";
    req.productQuantity = model.productQuantity;
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]changeShopCartCountWithParam:req response:^(id response) {
        if (response!= nil) {
            weakself.result = response;
            [weakself.dataArr removeAllObjects];
            [weakself.loseArr removeAllObjects];
            for (CartProductModel *model  in weakself.result.cartProductList) {
                if (model.productIsOnSale ==1) {
                    [weakself.dataArr addObject:model];
                }else{
                    [weakself.loseArr addObject:model];
                }
            }
            if(weakself.result.cartProductList.count ==0){
                weakself.footView.hidden = YES;
            }else{
                weakself.footView.hidden = NO;
            }
            [weakself.footView setModel:weakself.result];
            [weakself.collectionView reloadData];
        }
        [weakself jieSuanData];
    }];
}
-(void)guessLikeList{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    req.userLongitude = [UserCacheBean share].userInfo.longitude;
    req.userLatitude = [UserCacheBean share].userInfo.latitude;
    req.pageIndex = 1;
    req.pageSize = @"10";
    req.goodsCategoryId = @"";
    req.productCategoryParentId = @"";
    req.productCategoryId = @"";
    req.cityName = @"上海市";
    
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]guessYouLikeWithParam:req response:^(id response) {
        [self jieSuanData];
        if ([response isKindOfClass:[NSArray class]]) {
            [weakself.likeArr removeAllObjects];
            [weakself.likeArr addObjectsFromArray:response];
            [weakself.collectionView reloadData];
            
        }
        
    }];
}

-(void)jieSuanData{
    PlaceOrderReq *req = [[PlaceOrderReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]settlementListWithParam:req response:^(id response) {
        if (response) {
            weakself.jisuanmodel = [[ShoppingListRes alloc]init];
            weakself.jisuanmodel = response;
            [weakself.shopAlertView setModel:weakself.jisuanmodel];
        }
    }];
}
-(void)clearGoodCount{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]clearLoseProductWithParam:req response:^(id response) {
        if ([response[@"code"] integerValue] ==200) {
            [self showToast:response[@"message"]];
            self.result.cartProductList = nil;
            [weakself.loseArr removeAllObjects];
            [weakself.collectionView reloadData];
        }
    }];
}
///全选、反选
-(void)selectedAll:(BOOL)selected{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.productCategoryParentId = @"";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    req.cartId = self.result.cartId;
    req.cartProductIsActive = selected;
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]requestShopCartSelectedAllWithParam:req response:^(id response) {
        if (response!= nil) {
            weakself.result = response;
            [weakself.dataArr removeAllObjects];
            [weakself.loseArr removeAllObjects];
            for (CartProductModel *model  in weakself.result.cartProductList) {
                if (model.productIsOnSale ==1) {
                    [weakself.dataArr addObject:model];
                }else{
                    [weakself.loseArr addObject:model];
                }
            }
            if(weakself.result.cartProductList.count ==0){
                weakself.footView.hidden = YES;
            }else{
                weakself.footView.hidden = NO;
            }
            [weakself.footView setModel:weakself.result];
            if (self.result.cartProductList.count==0) {
                
            }
            [weakself.collectionView reloadData];
        }
    }];
}

-(void)selectedSingle:(CartProductModel*)model{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    req.cartProductId = model.cartProductId;
    req.cartProductIsActive = model.cartProductIsActive;
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]requestShopCartSelectedSingleWithParam:req response:^(id response) {
        if (response!= nil) {
            weakself.result = response;
            [weakself.dataArr removeAllObjects];
            [weakself.loseArr removeAllObjects];
            for (CartProductModel *model  in weakself.result.cartProductList) {
                if (model.productIsOnSale ==1) {
                    [weakself.dataArr addObject:model];
                }else{
                    [weakself.loseArr addObject:model];
                }
            }
            if(weakself.result.cartProductList.count ==0){
                weakself.footView.hidden = YES;
            }else{
                weakself.footView.hidden = NO;
            }
            [weakself.footView setModel:weakself.result];
            [weakself.collectionView reloadData];
        }
        [self jieSuanData];
    }];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section ==0) {
        return self.dataArr.count;
    }else if (section ==1){
        return self.loseArr.count;
    }
    return _likeArr.count;
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
    if (indexPath.section ==2) {
       return CGSizeMake(165, 260);
    }
    
     return CGSizeMake(SCREENWIDTH+1, 121);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (self.result.cartProductList.count ==0) {
        if (section ==0) {
         return  CGSizeMake(SCREENWIDTH, 319);
        }else if (section ==1){
            return  CGSizeMake(SCREENWIDTH, 0);
        }
    }else{
        if (section ==0) {
            if (_dataArr.count ==0) {
                return  CGSizeMake(SCREENWIDTH, 0);
            } else {
                return  CGSizeMake(SCREENWIDTH, 0);
            }
            
        }else if (section ==1){
            if (_loseArr.count ==0) {
                 return  CGSizeMake(SCREENWIDTH, 0);
            } else {
                 return  CGSizeMake(SCREENWIDTH, 50);
            }
           
        }
    }
    if (_likeArr.count>0&&section ==2){
         return CGSizeMake(SCREENWIDTH, 50);
    }
    return CGSizeMake(SCREENWIDTH, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section ==2) {
        return CGSizeMake(SCREENWIDTH, SCREENHEIGHT);
    }
    return CGSizeMake(SCREENWIDTH, 0);
}
//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footreusableView" forIndexPath:indexPath];
        footview.backgroundColor =DSColorFromHex(0xF2F2F2);
        
        return footview;
    }
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    
    
    for (UIView *view in headerView.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    
    
    if (self.result.cartProductList.count ==0) {
        if (indexPath.section ==0) {
            EmptyShoppingHeadView *emptyview = [[EmptyShoppingHeadView alloc]init];
            emptyview.frame = CGRectMake(0, 0, SCREENWIDTH, 319);
            [headerView addSubview:emptyview];
        }
    }else{
        if (indexPath.section ==0&&_dataArr.count>0) {
            ValidShopHeadView* validView = [[ValidShopHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0)];
            [headerView addSubview:validView];
        }else if (indexPath.section ==1&&_loseArr.count>0){
            LoseShopHeadView* loseView = [[LoseShopHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
            __weak typeof(self)weakself = self;
            [loseView setClearBlock:^(NSInteger index) {
                [weakself clearGoodCount];
            }];
            [headerView addSubview:loseView];
            
        }
    }
    if (indexPath.section ==2&&_likeArr.count>0){

        NextCollectionHeadView* validView = [[NextCollectionHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
        validView.headImage.hidden = YES;
        [validView.typeBtn setTitle:@"猜你喜欢" forState:UIControlStateNormal];
        
        [validView setPressTypeBlock:^(NSInteger index) {
            
        }];
        [headerView addSubview:validView];
    }
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NextCollectionViewCell *collectcell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIds forIndexPath:indexPath];
    ShoppingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    if (indexPath.section ==0) {
        [cell setGoodtype:TYPEVALID];
        CartProductModel *model = _dataArr[indexPath.row];
        [cell setModel:model];
        __weak typeof(self)weakself = self;
        [cell setAddBlock:^(CartProductModel* req) {
            
            if ([req.productQuantity isEqualToString:@"0"] ) {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"确定删除该商品"
                                                                               message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { //响应事件
                    [weakself changeShopCount:req];
                }];
                UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {//响应事件
                    
                    
                }];
                [alert addAction:defaultAction];
                [alert addAction:cancelAction];
                [weakself presentViewController:alert animated:YES completion:nil];
            }else{
                [weakself changeShopCount:req];
            }
            
        }];
        [cell setChooseBlock:^(CartProductModel *req) {
            [weakself selectedSingle:req];
        }];
        return cell;
    }else if (indexPath.section ==1){
        [cell setGoodtype:TYPELOSE];
        CartProductModel *model = _loseArr[indexPath.row];
        [cell setModel:model];
        return cell;
    }
    StairCategoryListRes *model = _likeArr[indexPath.row];
    
    [collectcell setModel:model];
    return collectcell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   detailGoodsViewController *detailVC = [[detailGoodsViewController alloc]init];
    detailVC.hidesBottomBarWhenPushed = YES;
    
    if (indexPath.section ==0) {
        CartProductModel *model = _dataArr[indexPath.row];
        [detailVC setErpProductId:model.erpProductId];
        [detailVC setProductID:model.productId];
    }else if (indexPath.section ==2){
        StairCategoryListRes *model = _likeArr[indexPath.row];
         [detailVC setErpProductId:model.erpProductId];
         [detailVC setProductID:model.productId];
    }
    if (self.footView.hidden ==YES) {
        detailVC.navStr = @"shop";
    }
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)pressSubmitBtn:(UIButton*)sender{
    
 if(self.jisuanmodel.cartProductList.count>0&&[self.jisuanmodel.preSaleProductList count]>0) {
     self.tabBarController.tabBar.hidden = YES;
     self.shopAlertView.hidden = NO;
 }else if(self.jisuanmodel.cartProductList.count>0&&self.jisuanmodel.nextDayProductList.count>0){
    self.tabBarController.tabBar.hidden = YES;
     self.shopAlertView.hidden = NO;
 }else if([self.jisuanmodel.preSaleProductList count]>0&&self.jisuanmodel.nextDayProductList.count>0){
     self.tabBarController.tabBar.hidden = YES;
     self.shopAlertView.hidden = NO;
 }else if([self.jisuanmodel.preSaleProductList count]>1){
     self.tabBarController.tabBar.hidden = YES;
     self.shopAlertView.hidden = NO;
 }else{
    FillOrderViewController *fillVC = [[FillOrderViewController alloc]init];
    fillVC.hidesBottomBarWhenPushed = YES;
    NSMutableArray *Arr = [NSMutableArray array];
     GOOGSTYPE type = GOOGSTYPENormal;
    for (CartProductModel *model in self.result.cartProductList) {
        if (model.cartProductIsActive ==1) {
            [Arr addObject:model];
        }
        if (model.productIsPreSale==1&&model.cartProductIsActive ==1) {
            type = GOOGSTYPEPresale;
        }else if (model.productIsSaleNextDay==1&&model.cartProductIsActive ==1){
            type = GOOGSTYPENextday;
        }else{
            type = GOOGSTYPENormal;
        }
    }
     if (Arr.count>0) {
         [fillVC setOrderType:1];
          [fillVC setGoodstype:type];
         [fillVC setProductArr:Arr];
         [fillVC setResult:self.result];
         [self.navigationController pushViewController:fillVC animated:YES];
     }else{
         [self showInfo:@"请选择结算商品"];
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
