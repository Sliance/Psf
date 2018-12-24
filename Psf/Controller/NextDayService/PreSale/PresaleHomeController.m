//
//  PresaleHomeController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/14.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "PresaleHomeController.h"
#import "GroupServiceApi.h"
#import "PreSaleListCell.h"
#import "detailGoodsViewController.h"
#import "HomeLocationView.h"
#import "NextServiceApi.h"
#import "PYSearchViewController.h"
#import "ChooseAddressViewController.h"
#import "GroupServiceApi.h"
#import "HomeTableViewCell.h"
#import "PresaleController.h"
#import "PresaleSController.h"
#import "CustomFootView.h"
#import "NextDayListController.h"
#import "StoreGoodsController.h"
#import "HomeHeadView.h"
#import "HomeSubHeadView.h"
#import "NextCollectionViewCell.h"
#import "BusinessCooperationController.h"
#import "RechargeViewController.h"
#import "TopicsController.h"


@interface PresaleHomeController ()<UICollectionViewDelegate, UICollectionViewDataSource,PYSearchViewControllerDelegate>
@property(nonatomic,strong)UIImageView *headImage;
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *bannerArr;
@property(nonatomic,strong)HomeLocationView *locView;
@end
static NSString *cellId = @"cellId";
@implementation PresaleHomeController
-(HomeLocationView *)locView{
    if (!_locView) {
        _locView = [[HomeLocationView alloc]init];
        _locView.frame = CGRectMake(0, [self navHeightWithHeight]-44, SCREENWIDTH, 45);
        [_locView.searchBtn addTarget:self action:@selector(pressSearch:) forControlEvents:UIControlEventTouchUpInside];
        [_locView.locBtn addTarget:self action:@selector(pressHomeLocation:) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return _locView;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.frame = CGRectMake(0, 0, SCREENWIDTH, 200);
    }
    return _headImage;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(165, 165);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT*10) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[NextCollectionViewCell class] forCellWithReuseIdentifier:cellId];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    }
    return _collectionView;
}

-(void)getPresaleList{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"";
    req.platform = @"ios";
    req.userLongitude = [UserCacheBean share].userInfo.longitude;
    req.userLatitude = [UserCacheBean share].userInfo.latitude;
    req.pageIndex = 1;
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[GroupServiceApi share]getPresaleListWithParam:req response:^(id response) {
        if (response!= nil) {
            [weakself.dataArr removeAllObjects];
            [weakself.dataArr addObjectsFromArray:response];
           
            [weakself.collectionView reloadData];
        }
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
    __weak typeof(self)weakself = self;
    [[NextServiceApi share]requestBannerWithParam:req response:^(id response) {
        if (response) {
            [weakself.bannerArr removeAllObjects];
            [weakself.bannerArr addObjectsFromArray:response];
            [weakself.collectionView reloadData];
        }
        [weakself getDefautWeight];
    }];
}
-(void)getDefautWeight{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"";
    req.platform = @"ios";
    req.businessParamKey = @"productDefaultWeight";
    [[NextServiceApi share]getDefaultWeightWithParam:req response:^(id response) {
        if (response) {
            [UserCacheBean share].userInfo.productDefaultWeight = response[@"data"][@"businessParamValue"];
            [self getDefautDes];
        }
    }];
}
-(void)getDefautDes{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"";
    req.platform = @"ios";
    req.businessParamKey = @"productDefaultWeightSuffixDesc";
    [[NextServiceApi share]getDefaultWeightWithParam:req response:^(id response) {
        if (response) {
            [UserCacheBean share].userInfo.productDefaultDes = response[@"data"][@"businessParamValue"];
        }
        [self reloadTuiJian];
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
        
    }];
}
-(void)getErp{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"";
    req.platform = @"ios";
    if ([UserCacheBean share].userInfo.longitude.length>0) {
        req.userLongitude = [UserCacheBean share].userInfo.longitude;
    }else{
        req.userLongitude = @"0";
    }
    if ([UserCacheBean share].userInfo.latitude.length>0) {
        req.userLatitude = [UserCacheBean share].userInfo.latitude;
    }else{
        req.userLatitude = @"0";
    }
    req.pageIndex = 1;
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[NextServiceApi share]getErpWithParam:req response:^(id response) {
        if ([response[@"code"]integerValue] ==200) {
            if ([response[@"data"] count] ==0) {
                ChooseAddressViewController *cityViewController = [[ChooseAddressViewController alloc] init];
                cityViewController.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:cityViewController animated:YES];
            }else{
                [UserCacheBean share].userInfo.erpStoreId = response[@"data"][@"erpStoreId"];
                [UserCacheBean share].userInfo.storeName = response[@"data"][@"storeName"];
                [weakself.locView.locBtn setTitle:response[@"data"][@"storeName"] forState:UIControlStateNormal];
            }
        }
        [self requestBanner];
    }];
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        [self setTitle:@""];
       
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setLeftButtonWithIcon:[UIImage imageNamed:@"11"]];
    self.navigationController.navigationBar.hidden = YES;
    [self getErp];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
  self.navigationController.navigationBar.hidden = NO;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
     _dataArr = [NSMutableArray array];
    _bannerArr = [NSMutableArray array];
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = NO;
        self.collectionView.frame= CGRectMake(0, self.locView.ctBottom, SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]-1-[self tabBarHeight]);
    } else {
        
        self.collectionView.frame = CGRectMake(0, self.locView.ctBottom, SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]-[self tabBarHeight]-1);
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.locView];
    [ZSNotification addLocationResultNotification:self action:@selector(location:)];
    [ZSNotification addRefreshPushResultNotification:self action:@selector(refreshPushResult:)];
}
-(void)refreshPushResult:(NSNotification *)notifi{
    NSDictionary *userInfo = [notifi userInfo];
    if ([[userInfo objectForKey:@"iosUrl"] isEqualToString:@"preSale"]) {
        PresaleSController *detailVC = [[PresaleSController alloc]init];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([[userInfo objectForKey:@"iosUrl"] isEqualToString:@"nextDay"]){
        NextDayListController *nextVC= [[NextDayListController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}
    
-(void)location:(NSNotification *)notifi{
    
    
    [self getErp];
    
}


-(void)didClickCancel:(PYSearchViewController *)searchViewController{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)didClickBack:(PYSearchViewController *)searchViewController{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark--Action
-(void)pressSearch:(UIButton*)sender{
    NSMutableArray *hotSeaches = [NSMutableArray array];
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.productCategoryId = @"" ;
    req.cityId = @"310100";
    req.cityName = @"上海市";
    req.pageIndex = 1;
    req.pageSize = @"10";
    __weak typeof(self)weakself = self;
    [[NextServiceApi share]requestHotListLoadWithParam:req response:^(id response) {
        [hotSeaches removeAllObjects];
        for (GoodDetailRes *model in response) {
            if (model.productName) {
                [hotSeaches addObject:model.productName];
            }
        }
        PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"请输入商品名称", @"搜索编程语言") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
            //        [searchViewController.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
        }];
        searchViewController.hotSearchStyle = PYHotSearchStyleDefault;
        searchViewController.searchHistoryStyle = 1;
        searchViewController.delegate = self;
        searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowModePush;
        searchViewController.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:searchViewController animated:YES];
        
    }];
    
    
    
}
#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            StairCategoryReq *req = [[StairCategoryReq alloc]init];
            req.appId = @"993335466657415169";
            req.timestamp = @"529675086";
            req.token = [UserCacheBean share].userInfo.token;
            req.version = @"1.0.0";
            req.platform = @"ios";
            req.userLongitude = [UserCacheBean share].userInfo.longitude;
            req.userLatitude = [UserCacheBean share].userInfo.latitude;
            req.productName = searchText;
            req.cityId = @"310100";
            req.cityName = @"上海市";
            req.pageIndex = 1;
            req.pageSize = @"10";
           
            [[NextServiceApi share]SearchHintListWithParam:req response:^(id response) {
                if (response) {
                    [searchSuggestionsM removeAllObjects];
                    [searchSuggestionsM addObjectsFromArray:response];
                    searchViewController.searchSuggestions = searchSuggestionsM;
                }
            }];
            
        });
    }
}
///定位
-(void)pressHomeLocation:(UIButton*)sender {
//    [self showToast:@"目前仅支持上海区域"];
        ChooseAddressViewController *cityViewController = [[ChooseAddressViewController alloc] init];
        cityViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cityViewController animated:YES];
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

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(165, 260);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
       NextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
       cell.addBtn.hidden = NO;
        SubjectCategoryModel *model = self.dataArr[indexPath.section];
        StairCategoryListRes *res = model.subjectCategoryProductList[indexPath.row];
        [cell setModel:res];
    [cell setAddBlock:^{
        
    }];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return CGSizeMake(SCREENWIDTH, 320*SCREENWIDTH/375+160);
    }
    return CGSizeMake(SCREENWIDTH, 120*SCREENWIDTH/375+50);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    
    
    for (UIView *view in headerView.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    SubjectCategoryModel *model = self.dataArr[indexPath.section];
    if (indexPath.section ==0) {
        HomeHeadView* validView = [[HomeHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 320*SCREENWIDTH/375+160)];
        NSMutableArray*arr = [[NSMutableArray alloc]init];
        for (SubjectModel*model in self.bannerArr) {
            if (model.subjectTopImagePath) {
                [arr addObject:model.subjectTopImagePath];
            }
        }
        [validView.cycleScroll setImageUrlGroups:arr];
        [validView setModel:model];
        [headerView addSubview:validView];
        __weak typeof(self)weakself = self;
        [validView setSelected:^(NSInteger index) {
            if (index ==0) {
                PresaleSController*VC = [[PresaleSController alloc]init];
                VC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:VC animated:YES];
            }else if (index ==1){
                BusinessCooperationController*VC = [[BusinessCooperationController alloc]init];
                VC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:VC animated:YES];
            }else if (index ==2){
                RechargeViewController*VC = [[RechargeViewController alloc]init];
                VC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:VC animated:YES];
            }else if (index ==3){
                
            }
            
        }];
        [validView setImageBlock:^(NSInteger index) {
            TopicsController *vc = [[TopicsController alloc]init];
            SubjectModel*model = weakself.bannerArr[index];
            [vc setSubjectId:model.subjectId];
            vc.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:vc animated:YES];
        }];
    }else{
        HomeSubHeadView*subView = [[HomeSubHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 120*SCREENWIDTH/375+50)];
        [subView setModel:model];
        [headerView addSubview:subView];
        
    }
  
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
        detailGoodsViewController *vc = [[detailGoodsViewController alloc]init];
        SubjectCategoryModel *model = self.dataArr[indexPath.section];
        StairCategoryListRes *res = model.subjectCategoryProductList[indexPath.row];
        [vc setProductID:res.productId];
        vc.hidesBottomBarWhenPushed = YES;
       [self.navigationController pushViewController:vc animated:YES];
    
}






@end
