//
//  PresaleSController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/5.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "PresaleSController.h"
#import "ZSCycleScrollView.h"
#import "NextCollectionViewCell.h"
#import "detailGoodsViewController.h"
#import "GroupServiceApi.h"
@interface PresaleSController ()<ZSCycleScrollViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;


@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *imageArr;
@property(nonatomic,assign)NSInteger pageIndex;

@end
static NSString *cellId = @"cellId";
@implementation PresaleSController

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(165, 165);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[NextCollectionViewCell class] forCellWithReuseIdentifier:cellId];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
   
    self.collectionView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArr = [NSMutableArray array];
    self.imageArr = [NSMutableArray array];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    self.pageIndex = 1;
    [self getPresaleList];
}
-(void)headerRefreshing
{
    self.pageIndex = 1;
    [self getPresaleList];
}
/**
 *  上拉刷新
 */
-(void)footerRefreshing
{
    
    self.pageIndex++;
    [self getPresaleList];
}
-(void)getPresaleList{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.pageIndex = self.pageIndex;
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[GroupServiceApi share]getPresaleListWithParam:req response:^(id response) {
        if (response!= nil) {
            
            if (self.pageIndex ==1) {
                [weakself.dataArr removeAllObjects];
                [weakself.dataArr addObjectsFromArray:response];
                [weakself.collectionView.mj_header endRefreshing];
            }else{
                [weakself.dataArr addObjectsFromArray:response];
                [weakself.collectionView.mj_header endRefreshing];
                [weakself.collectionView.mj_footer endRefreshing];
            }
            
            
            if ([response count] < 10) {
                [weakself.collectionView.mj_footer removeFromSuperview];
               
            }
            else{
                weakself.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:weakself refreshingAction:@selector(footerRefreshing)];
            }
            [weakself getBanner:@"preSale"];
            [weakself.collectionView reloadData];
        }
    }];
}

-(void)getBanner:(NSString*)type{
    GroupModelReq *req = [[GroupModelReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.cityName = @"上海市";
    req.productBannerPosition = type;
    __weak typeof(self)weakself = self;
    [[GroupServiceApi share]getPreAndGroupBannerWithParam:req response:^(id response) {
        if (response!= nil) {
            
            
            [weakself.imageArr removeAllObjects];
            
            for (GroupBannerModel*model in response) {
                if (model.productBannerImagePath) {
                    [weakself.imageArr addObject:model.productBannerImagePath];
                }
            }
            
            [weakself.collectionView reloadData];
            
        }
    }];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return self.dataArr.count;
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


////设置每个item垂直间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0;
//}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(165, 250);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
        GroupListRes *model = self.dataArr[indexPath.row];
        [cell setGroupmodel:model];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREENWIDTH, 200);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    
    
    for (UIView *view in headerView.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    ZSCycleScrollView *cycleScroll = [[ZSCycleScrollView alloc] initWithFrame:CGRectMake(0, 0,SCREENWIDTH, 200)];
    cycleScroll.imageSize = CGSizeMake(SCREENWIDTH, 200);
    cycleScroll.delegate =self;
    [cycleScroll setIndex:1];
    
    cycleScroll.autoScrollTimeInterval = 3.0;
    cycleScroll.dotColor = [UIColor redColor];
    [headerView addSubview:cycleScroll];
    [cycleScroll setImageUrlGroups:self.imageArr];
    [cycleScroll setDataArr:nil];
    [cycleScroll setCollectionHeight:0];
    cycleScroll.supportBtn.hidden = YES;
    cycleScroll.returnBtn.hidden = YES;
    cycleScroll.sendBtn.hidden = YES;
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    detailGoodsViewController *vc = [[detailGoodsViewController alloc]init];
    
        GroupListRes *model = self.dataArr[indexPath.row];
        [vc setProductID:model.productId];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
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
