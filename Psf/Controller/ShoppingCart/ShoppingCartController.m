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

@interface ShoppingCartController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)ShopFootView *footView;
@property(nonatomic,strong)ShoppingListRes *result;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *loseArr;

@end
static NSString *cellId = @"ShoppingCollectionViewCell";
static NSString *cellIds = @"NextCollectionViewCell";
@implementation ShoppingCartController
-(ShopFootView *)footView{
    if (!_footView) {
        _footView = [[ShopFootView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-[self tabBarHeight]-49, SCREENWIDTH, 49)];
        _footView.hidden = YES;
        [_footView.submitBtn addTarget:self action:@selector(pressSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footView;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"购物车"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[ShoppingCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [self.collectionView registerClass:[NextCollectionViewCell class] forCellWithReuseIdentifier:cellIds];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    [self.collectionView
     registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footreusableView"];
    [self.view addSubview:self.footView];
    _dataArr = [NSMutableArray array];
    _loseArr = [NSMutableArray array];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}
-(void)requestData{
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
//    req.productId = [NSString stringWithFormat:@"%ld",productID];
    req.pageIndex = @"1";
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]requestShopListModelListLoadWithParam:req response:^(id response) {
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
            [weakself.collectionView reloadData];
        }
    }];
}
-(void)getShopCount{
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
    //    req.productId = [NSString stringWithFormat:@"%ld",productID];
    req.pageIndex = @"1";
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]getShopCartCountWithParam:req response:^(id response) {
        
    }];
}
-(void)addShopCount:(CartProductModel*)model{
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
    //    req.productId = [NSString stringWithFormat:@"%ld",productID];
    req.pageIndex = @"1";
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]addShopCartCountWithParam:req response:^(id response) {
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
            [weakself.collectionView reloadData];
        }
    }];
}
-(void)deleteShopCount:(CartProductModel*)model{
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
    req.cartProductId = [NSString stringWithFormat:@"%@",model.productId];
    req.productSkuId = model.productSkuId;
    req.productQuantity = model.productQuantity;
    req.cartId = model.cartId;
    req.pageIndex = @"1";
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]deleteShopCartCountWithParam:req response:^(id response) {
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
            [weakself.collectionView reloadData];
        }
    }];
}
-(void)changeShopCount{
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
    //    req.productId = [NSString stringWithFormat:@"%ld",productID];
    req.pageIndex = @"1";
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
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
            [weakself.collectionView reloadData];
        }
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
    return 4;
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
       return CGSizeMake(165, 298);
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
                return  CGSizeMake(SCREENWIDTH, 36);
            }
            
        }else if (section ==1){
            if (_loseArr.count ==0) {
                 return  CGSizeMake(SCREENWIDTH, 0);
            } else {
                 return  CGSizeMake(SCREENWIDTH, 50);
            }
           
        }
    }
    return CGSizeMake(SCREENWIDTH, 70);
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
        if (indexPath.section ==0) {
            ValidShopHeadView* validView = [[ValidShopHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 36)];
            [headerView addSubview:validView];
        }else if (indexPath.section ==1){
            LoseShopHeadView* loseView = [[LoseShopHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
            [headerView addSubview:loseView];
            
        }
    }
    if (indexPath.section ==2){
//        LikeShopHeadView* likeView = [[LikeShopHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 70)];
//        [headerView addSubview:likeView];
        NextCollectionHeadView* validView = [[NextCollectionHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 69)];
        [validView.typeBtn setTitle:@"猜你喜欢" forState:UIControlStateNormal];
        __weak typeof(self)weakSelf = self;
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
        [cell setSubBlock:^(NSInteger index) {
            [weakself deleteShopCount:model];
        }];
        [cell setAddBlock:^(NSInteger index) {
            [weakself addShopCount:model];
        }];
        return cell;
    }else if (indexPath.section ==1){
        [cell setGoodtype:TYPELOSE];
        CartProductModel *model = _loseArr[indexPath.row];
        [cell setModel:model];
        return cell;
    }
    return collectcell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    detailGoodsViewController *vc = [detailGoodsViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController showViewController:vc sender:nil];
}
-(void)pressSubmitBtn:(UIButton*)sender{
    FillOrderViewController *fillVC = [[FillOrderViewController alloc]init];
    fillVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fillVC animated:YES];
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
