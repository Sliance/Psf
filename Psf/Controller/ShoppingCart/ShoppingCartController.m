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

@interface ShoppingCartController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)ShopFootView *footView;

@end
static NSString *cellId = @"ShoppingCollectionViewCell";
static NSString *cellIds = @"NextCollectionViewCell";
@implementation ShoppingCartController
-(ShopFootView *)footView{
    if (!_footView) {
        _footView = [[ShopFootView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-[self tabBarHeight]-49, SCREENWIDTH, 49)];
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
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section ==0) {
        return 2;
    }else if (section ==1){
        return 2;
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
    if (section ==0) {
       return  CGSizeMake(SCREENWIDTH, 36);
    }else if (section ==1){
         return  CGSizeMake(SCREENWIDTH, 50);
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
    
    if (indexPath.section ==0) {
        ValidShopHeadView* validView = [[ValidShopHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 36)];
        [headerView addSubview:validView];
    }else if (indexPath.section ==1){
        LoseShopHeadView* loseView = [[LoseShopHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
        [headerView addSubview:loseView];
      
    }else if (indexPath.section ==2){
        LikeShopHeadView* likeView = [[LikeShopHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 70)];
        [headerView addSubview:likeView];
    }
   
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NextCollectionViewCell *collectcell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIds forIndexPath:indexPath];
    ShoppingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    if (indexPath.section ==0) {
        [cell setGoodtype:TYPEVALID];
        return cell;
    }else if (indexPath.section ==1){
        [cell setGoodtype:TYPELOSE];
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
