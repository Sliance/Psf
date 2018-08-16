//
//  PaySuccessController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/15.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "PaySuccessController.h"
#import "NextCollectionViewCell.h"
#import "detailGoodsViewController.h"
#import "ShopServiceApi.h"
#import "PaySuccessHeadView.h"

@interface PaySuccessController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *likeArr;


@end
static NSString *cellIds = @"NextCollectionViewCell";
@implementation PaySuccessController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"下单成功"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
   
    [self.collectionView registerClass:[NextCollectionViewCell class] forCellWithReuseIdentifier:cellIds];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    [self.collectionView
     registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footreusableView"];
    
    _likeArr = [NSMutableArray array];
    [self guessLikeList];
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
    req.productCategoryId = @"";
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
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
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
   
        return CGSizeMake(165, 260);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
   
    
        return CGSizeMake(SCREENWIDTH, 190);
   
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
    
    
    
   
        //        LikeShopHeadView* likeView = [[LikeShopHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 70)];
        //        [headerView addSubview:likeView];
        PaySuccessHeadView* validView = [[PaySuccessHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 190)];
//        validView.headImage.hidden = YES;
//        [validView.typeBtn setTitle:@"猜你喜欢" forState:UIControlStateNormal];
//        __weak typeof(self)weakSelf = self;
//        [validView setPressTypeBlock:^(NSInteger index) {
//
//        }];
        [headerView addSubview:validView];
   
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NextCollectionViewCell *collectcell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIds forIndexPath:indexPath];
   
    
    StairCategoryListRes *model = _likeArr[indexPath.row];
    
    [collectcell setModel:model];
    return collectcell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    detailGoodsViewController *vc = [detailGoodsViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    
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
