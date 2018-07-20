//
//  ZSPageViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/26.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ZSPageViewController.h"
#import "ZSCycleScrollView.h"
#import "NextCollectionViewCell.h"
#import "detailGoodsViewController.h"
#import "NextDayServiceController.h"
#import "NextCollectionHeadView.h"
#import "DetailSortController.h"
#import "GroupViewController.h"
#import "RechargeViewController.h"
#import "NextServiceApi.h"

@interface ZSPageViewController ()<ZSCycleScrollViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)ZSCycleScrollView *cycleScroll;
@property(nonatomic,strong)UIScrollView *bgScrollow;
@property(nonatomic,strong)NSMutableArray *dataArr;

@end
static NSString *cellId = @"cellId";
@implementation ZSPageViewController
-(UIScrollView *)bgScrollow{
    if (!_bgScrollow) {
        _bgScrollow = [[UIScrollView alloc]init];
        _bgScrollow.contentSize = CGSizeMake(0, SCREENHEIGHT*10);
        _bgScrollow.delegate = self;
    }
    return _bgScrollow;
}
-(ZSCycleScrollView *)cycleScroll{
    if (!_cycleScroll) {
        _cycleScroll = [[ZSCycleScrollView alloc] init];
        _cycleScroll.imageSize = CGSizeMake(SCREENWIDTH, 200);
        _cycleScroll.delegate =self;
        [_cycleScroll setIndex:0];
        
        _cycleScroll.autoScrollTimeInterval = 3.0;
        _cycleScroll.dotColor = [UIColor redColor];
    }
    return _cycleScroll;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(165, 165);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT*10) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[NextCollectionViewCell class] forCellWithReuseIdentifier:cellId];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    }
    return _collectionView;
}
-(void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    [_cycleScroll setIndex:selectedIndex];
}
-(void)setModel:(StairCategoryRes *)model{
    _model = model;
    _dataArr = [NSMutableArray array];
    if (_selectedIndex ==0) {
        [self reloadTuiJian];
    } else {
          [self requestData:[NSString stringWithFormat:@"%ld",(long)_model.productCategoryId]];
    }
  
}
-(void)requestData:(NSString*)categoryId{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    
    req.token = @"eyJleHBpcmVUaW1lIjoxNTYxNjI1OTU3ODc0LCJ1c2VySWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI2Iiwib2JqZWN0SWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI1In0=";
    req.userId = @"1009660103519952898";
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.productId = [NSNumber numberWithInteger:[categoryId integerValue]];
    req.productCategoryParentId = categoryId;
    req.cityId = @"310100";
    __weak typeof(self)weakself = self;
   NSMutableArray *headArr = [[NSMutableArray alloc]init];
    [[NextServiceApi share]requestApplyLoadWithParam:req response:^(id response) {
        if (response) {
            [headArr removeAllObjects];
            [headArr addObjectsFromArray:response];
           
            CGFloat height=0;
            if (headArr.count%5==0) {
                height = headArr.count/5*100;
            }else if(headArr.count<11){
                height =(headArr.count/5+1)*100;
            }else{
                height = 200;
            }
           
            if (weakself.selectedIndex ==0) {
                weakself.cycleScroll.frame = CGRectMake(0, 0,SCREENWIDTH, 340);
            }else if (weakself.selectedIndex ==1){
                weakself.cycleScroll.frame = CGRectMake(0, 0,SCREENWIDTH, 240);
            }else{
                weakself.cycleScroll.frame = CGRectMake(0, 0,SCREENWIDTH, 220+height);
            }
             [weakself.cycleScroll setCollectionHeight:height];
             [weakself.cycleScroll setDataArr:headArr];
            CGFloat collecHeight = 0;
            
            for (SubjectCategoryModel *model in weakself.dataArr) {
                if (model.subjectCategoryProductList.count%2==0) {
                    collecHeight += model.subjectCategoryProductList.count*155;
                }else{
                     collecHeight += model.subjectCategoryProductList.count*155+300;
                }
            }
            collecHeight += weakself.dataArr.count*150;
            weakself.collectionView.frame = CGRectMake(0, weakself.cycleScroll.ctBottom, SCREENWIDTH, collecHeight);
            weakself.bgScrollow.contentSize = CGSizeMake(0,collecHeight+220+height);
        }
        [weakself requestBanner];
    }];
}
-(void)reloadTuiJian{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = @"eyJleHBpcmVUaW1lIjoxNTYzMzYyNDg4OTkxLCJ1c2VySWQiOiI5OTc0MTE2ODk0ODIyMzU5MDYiLCJvYmplY3RJZCI6IjEwMTY1NjQ2MTkxNTMxNDU4NTgifQ==";
    req.userId = @"1009660103519952898";
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    req.subjectId = @"1014434389965922306";
    __weak typeof(self)weakself = self;
    [[NextServiceApi share]requestHomeLoadWithParam:req response:^(id response) {
        if (response!= nil) {
            [weakself.dataArr removeAllObjects];
            [weakself.dataArr addObjectsFromArray:response];
            [weakself.collectionView reloadData];
        }
        [weakself requestData:[NSString stringWithFormat:@"%ld",(long)weakself.model.productCategoryId]];
        
    }];
}

-(void)requestBanner{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = @"eyJleHBpcmVUaW1lIjoxNTYzMzYyNDg4OTkxLCJ1c2VySWQiOiI5OTc0MTE2ODk0ODIyMzU5MDYiLCJvYmplY3RJZCI6IjEwMTY1NjQ2MTkxNTMxNDU4NTgifQ==";
    req.userId = @"1009660103519952898";
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    req.subjectPosition = @"index_banner";
    [[NextServiceApi share]requestBannerWithParam:req response:^(id response) {
        if (response) {
            NSMutableArray *arr = [NSMutableArray array];
            [arr removeAllObjects];
            
            for (SubjectModel*model in response) {
                if (model.subjectTopImagePath) {
                    [arr addObject:model.subjectTopImagePath];
                }
            }
            [self.cycleScroll setImageUrlGroups:arr];
        }
    }];
}
#pragma 以上三个方法是必须实现的
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgScrollow];
    [self.bgScrollow addSubview:self.cycleScroll];
    [self.bgScrollow addSubview:self.collectionView];
    self.bgScrollow.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    self.cycleScroll.frame = CGRectMake(0, 0,SCREENWIDTH, 340);
    self.collectionView.frame = CGRectMake(0, self.cycleScroll.ctBottom, SCREENWIDTH, SCREENHEIGHT*10);
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self)weakself = self;
    [self.cycleScroll setSelectedItemBlock:^(NSInteger index) {
        if (index==0) {
            GroupViewController *groupVC = [[GroupViewController alloc]init];
            groupVC.hidesBottomBarWhenPushed = YES;
            groupVC.goodtype = GOODTYPEPRESELL;
            [weakself.navigationController pushViewController:groupVC animated:YES];
        }else if (index ==1){
            GroupViewController *groupVC = [[GroupViewController alloc]init];
            groupVC.hidesBottomBarWhenPushed = YES;
            groupVC.goodtype = GOODTYPEGROUP;
            [weakself.navigationController pushViewController:groupVC animated:YES];
        }else if (index ==2){
            RechargeViewController *rechargeVC = [[RechargeViewController alloc]init];
            rechargeVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:rechargeVC animated:YES];
        }
    }];
     [self.cycleScroll setDataArr:nil];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    SubjectCategoryModel *model = self.dataArr[section];
    return model.subjectCategoryProductList.count;
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
    return CGSizeMake(165, 300);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    SubjectCategoryModel *model = self.dataArr[indexPath.section];
    StairCategoryListRes *res = model.subjectCategoryProductList[indexPath.row];
    [cell setModel:res];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREENWIDTH, 150);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    
    
    for (UIView *view in headerView.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    NextCollectionHeadView* validView = [[NextCollectionHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 150)];
    SubjectCategoryModel *model = self.dataArr[indexPath.section];
    [validView setModel:model];
    __weak typeof(self)weakSelf = self;
    [validView setPressTypeBlock:^(NSInteger index) {
        DetailSortController *detailVC = [[DetailSortController alloc]init];
        detailVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    [headerView addSubview:validView];
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    detailGoodsViewController *vc = [[detailGoodsViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//    [self showViewController:nav sender:nil];
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
