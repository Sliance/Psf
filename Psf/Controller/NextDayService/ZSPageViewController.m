
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
#import "PresaleController.h"
#import "GroupServiceApi.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "BusinessCooperationController.h"
@interface ZSPageViewController ()<ZSCycleScrollViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)ZSCycleScrollView *cycleScroll;
@property(nonatomic,strong)UIScrollView *bgScrollow;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *collectArr;
@property(nonatomic,assign)CGFloat height;
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
        _cycleScroll = [[ZSCycleScrollView alloc] initWithFrame:CGRectZero];
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
    [self requestData:[NSString stringWithFormat:@"%ld",(long)_model.productCategoryId]];
  
}
-(void)getGroupList{
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
    req.productCategoryParentId = @"";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[GroupServiceApi share]getGroupListWithParam:req response:^(id response) {
        if (response!= nil) {
            [weakself.dataArr removeAllObjects];
            [weakself.dataArr addObjectsFromArray:response];
            [weakself.collectionView reloadData];
             CGFloat collecHeight = 0;
            collecHeight = weakself.dataArr.count*260+40;
            weakself.collectionView.frame = CGRectMake(0, weakself.cycleScroll.ctBottom, SCREENWIDTH, collecHeight);
            weakself.bgScrollow.contentSize = CGSizeMake(0,collecHeight+220+weakself.height);
            [self requestBanner];
        }
    }];
}
-(void)requestData:(NSString*)categoryId{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.productId = [categoryId integerValue];
    req.productCategoryParentId = categoryId;
    req.cityId = @"310100";
    __weak typeof(self)weakself = self;
   NSMutableArray *headArr = [[NSMutableArray alloc]init];
    [[NextServiceApi share]requestApplyLoadWithParam:req response:^(id response) {
        if (response) {
            [headArr removeAllObjects];
            [headArr addObjectsFromArray:response];
        
            if (headArr.count%5==0) {
                weakself.height = headArr.count/5*100;
            }else if(headArr.count<11){
                 weakself.height =(headArr.count/5+1)*100;
            }else{
                 weakself.height = 200;
            }
           
            if (weakself.selectedIndex ==0) {
                weakself.cycleScroll.frame = CGRectMake(0, 0,SCREENWIDTH, 340);
            }else if (weakself.selectedIndex ==1){
                weakself.cycleScroll.frame = CGRectMake(0, 0,SCREENWIDTH, 240);
            }else{
                weakself.cycleScroll.frame = CGRectMake(0, 0,SCREENWIDTH, 220+ weakself.height);
            }
             [weakself.cycleScroll setCollectionHeight: weakself.height];
             [weakself.cycleScroll setDataArr:headArr];
           
        }
        if (weakself.selectedIndex ==0) {
            [self reloadTuiJian];
        }else if (weakself.selectedIndex ==1){
            [self getGroupList];
        }else{
            StairCategoryRes *model = [headArr firstObject];
            [weakself getCollectiomData:model];
        }
        
    }];
}
-(void)reloadTuiJian{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
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
        CGFloat collecHeight = 0;
        for (SubjectCategoryModel *model in weakself.dataArr) {
            if (model.subjectCategoryProductList.count%2==0) {
                collecHeight += model.subjectCategoryProductList.count*155;
            }else{
                collecHeight += model.subjectCategoryProductList.count*155+300;
            }
        }
        collecHeight += weakself.dataArr.count*150+40;
        weakself.collectionView.frame = CGRectMake(0, weakself.cycleScroll.ctBottom, SCREENWIDTH, collecHeight);
        weakself.bgScrollow.contentSize = CGSizeMake(0,collecHeight+220+weakself.height);
         [weakself requestBanner];
    }];
}
-(void)getCollectiomData:(StairCategoryRes*)model{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.couponType = @"allProduct";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.productId = model.productCategoryId;
    req.pageIndex = 1;
    req.pageSize = @"4";
    req.productCategoryParentId = model.productCategoryParentId;
    req.cityId = @"310100";
    req.cityName = @"上海市";
//    self.collectArr = [[NSMutableArray alloc]init];
    __weak typeof(self) weakSelf = self;
    [[NextServiceApi share]requestSortListLoadWithParam:req response:^(id response) {
        if(response!=nil){
            [weakSelf.dataArr removeAllObjects];
            [weakSelf.dataArr addObjectsFromArray:response];
            [weakSelf.collectionView reloadData];
        }
        CGFloat collecHeight = 0;
        for (StairCategoryRes *model in weakSelf.dataArr) {
            if (model.productList.count%2==0) {
                collecHeight += model.productList.count*140;
            }else{
                collecHeight += model.productList.count*140+300;
            }
        }
        collecHeight += weakSelf.dataArr.count*150+40;
        weakSelf.collectionView.frame = CGRectMake(0, weakSelf.cycleScroll.ctBottom, SCREENWIDTH, collecHeight);
        weakSelf.bgScrollow.contentSize = CGSizeMake(0,collecHeight+220+weakSelf.height);
        [weakSelf requestBanner];
    }];
}
-(void)requestBanner{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
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
    if (self.selectedIndex ==0) {

        if (index==0) {
            PresaleController *groupVC = [[PresaleController alloc]init];
            groupVC.hidesBottomBarWhenPushed = YES;
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
        }else if (index ==3){
            
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = @"犁小农";
            message.description = @"邀您一起";
            [message setThumbImage:[UIImage imageNamed: @"icon_about"]];
            WXWebpageObject *webobject = [WXWebpageObject object];
            webobject.webpageUrl = @"https://www.baidu.com";
            message.mediaObject = webobject;
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneSession;

            [WXApi sendReq:req];
        }else if (index ==4){
            BusinessCooperationController *bussinessVC = [[BusinessCooperationController alloc]init];
            bussinessVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:bussinessVC animated:YES];
        }
    }else{
        DetailSortController *vc = [DetailSortController new];
        [vc setSelectedIndex:index];
        [vc setDataArr:weakself.dataArr];
        vc.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController showViewController:vc sender:nil];
    }
    }];
     [self.cycleScroll setDataArr:nil];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.selectedIndex ==1) {
        return 1;
    }
    return self.dataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.selectedIndex ==0) {
        SubjectCategoryModel *model = self.dataArr[section];
        return model.subjectCategoryProductList.count;
    }else if (self.selectedIndex ==1){
        return self.dataArr.count;
    }
    StairCategoryRes *model = self.dataArr[section];
    return model.productList.count;
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
    return CGSizeMake(165, 260);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (self.selectedIndex ==0) {
        SubjectCategoryModel *model = self.dataArr[indexPath.section];
        StairCategoryListRes *res = model.subjectCategoryProductList[indexPath.row];
        [cell setModel:res];
    }else if (self.selectedIndex ==1){
        GroupListRes *model = self.dataArr[indexPath.row];
        [cell setGroupmodel:model];
    }else{
        StairCategoryRes *model = self.dataArr[indexPath.section];
        StairCategoryListRes *res = model.productList[indexPath.row];
        [cell setModel:res];
    }
   
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (self.selectedIndex ==1) {
        return CGSizeMake(SCREENWIDTH, 40);
    }
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
    if (self.selectedIndex ==0) {
        SubjectCategoryModel *model = self.dataArr[indexPath.section];
        [validView setModel:model];
    }else if (self.selectedIndex ==1){
        validView.frame = CGRectMake(0, 0, SCREENWIDTH, 40);
        [validView.typeBtn setTitle:@"团购" forState:UIControlStateNormal];
    }else{
        StairCategoryRes *model = self.dataArr[indexPath.section];
        [validView setProductmodel:model];
    }
    
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
    if (self.selectedIndex ==0) {
        SubjectCategoryModel *model = self.dataArr[indexPath.section];
        StairCategoryListRes *res = model.subjectCategoryProductList[indexPath.row];
        [vc setProductID:res.productId];
    }else if (self.selectedIndex ==1){
        GroupListRes *model = self.dataArr[indexPath.row];
        [vc setProductID:model.productId];
    }else{
        StairCategoryRes *model = self.dataArr[indexPath.section];
        StairCategoryListRes *res = model.productList[indexPath.row];
        [vc setProductID:res.productId];
    }
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
