//
//  SortViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/19.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "SortViewController.h"
#import "HomeLocationView.h"
#import "SortLeftScrollow.h"
#import "SortCollectionViewCell.h"
#import "SortCollectHeadView.h"
#import "DetailSortController.h"
#import "NextServiceApi.h"


@interface SortViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,SortLeftScrollowDelegate>
@property(nonatomic,strong)HomeLocationView *locView;
@property(nonatomic,strong)SortLeftScrollow *sortLeftView;
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)SortCollectHeadView *headView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end
static NSString *cellId = @"SortCollectionViewCell";
@implementation SortViewController
-(HomeLocationView *)locView{
    if (!_locView) {
        _locView = [[HomeLocationView alloc]init];
        _locView.frame = CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, 45);
    }
    return _locView;
}
-(SortLeftScrollow *)sortLeftView{
    if (!_sortLeftView) {
        _sortLeftView = [[SortLeftScrollow alloc]initWithFrame:CGRectMake(0, [self navHeightWithHeight]+45, 75, SCREENHEIGHT-[self navHeightWithHeight]-45)];
        _sortLeftView.delegate = self;
    }
    return _sortLeftView;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"分类"];
       
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
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
    req.productId = @"1014123154812694529";
//    req.pageIndex = @"1";
//    req.pageSize = @"10";
    req.productCategoryParentId = @"";
//    req.saleOrderId = @"1013703405872041985";
//    req.cityId = @"310100";
    __weak typeof(self)weakself = self;
    [[NextServiceApi share]requestApplyLoadWithParam:req response:^(id response) {
        if (response) {
            
            [weakself.dataArr removeAllObjects];
            [weakself.dataArr addObjectsFromArray:response];
            [weakself.sortLeftView setDataArr:weakself.dataArr];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   [self.view addSubview:self.locView];
   [self.view addSubview:self.sortLeftView];
    _dataArr = [NSMutableArray array];
    [self requestData];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(100, 100);
   
    //设置collectionView滚动方向
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(SCREENWIDTH, 150);
    layout.footerReferenceSize = CGSizeMake(SCREENWIDTH, 5);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(75, [self navHeightWithHeight]+45, SCREENWIDTH-75, SCREENHEIGHT) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[SortCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
     [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    [self.collectionView
     registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footreusableView"];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0, 0,0);
    
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return -10;
}



//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
    
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

   
    _headView = [[SortCollectHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-75, 150)];
    
    [headerView addSubview:_headView];
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SortCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell setImageHeight:75];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailSortController *vc = [DetailSortController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController showViewController:vc sender:nil];
}

#pragma mark--SortLeftScrollowDelegate
-(void)selectedSortIndex:(NSInteger)index{
    StairCategoryRes *model =_dataArr[index];
    _headView.nameLabel.text = model.productCategoryName;
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
