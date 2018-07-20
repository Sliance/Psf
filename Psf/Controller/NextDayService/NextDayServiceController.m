//
//  NextDayServiceController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/14.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "NextDayServiceController.h"

#import "HomeLocationView.h"
#import "ZJScrollPageView.h"
#import "ZSPageViewController.h"
#import <MJRefresh.h>
#import "PYSearchViewController.h"
#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "JFCityViewController.h"
#import "ZSSortSelectorView.h"
#import "MenuInfo.h"
#import "ChooseAddressViewController.h"
#import "detailGoodsViewController.h"
#import "NextSelectorView.h"
#import "NextServiceApi.h"

#define kCurrentCityInfoDefaults [NSUserDefaults standardUserDefaults]
#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]
static CGFloat const segmentViewHeight = 40.0;
static CGFloat const naviBarHeight = 64.0;
static CGFloat const headViewHeight = 240.0;

NSString *const ZJParentTableViewDidLeaveFromTopNotification = @"ZJParentTableViewDidLeaveFromTopNotification";

@interface NextDayServiceController ()<ZJScrollPageViewDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource,PYSearchViewControllerDelegate,JFLocationDelegate, JFCityViewControllerDelegate,CLLocationManagerDelegate,ZSSortSelectorViewDelegate>


@property(nonatomic,strong)HomeLocationView *locView;
@property(nonatomic,strong)NextSelectorView *seclectorView;

@property (nonatomic, strong) CLLocationManager *locationManagers;//定位管理
/** 城市定位管理器*/
@property (nonatomic, strong) JFLocation *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager *manager;
@property (nonatomic, strong) NSString *latitude;//纬度
@property (nonatomic, strong) NSString *longitude;//经度
@property (nonatomic, strong)  NSMutableArray *menuList;
@property (nonatomic, strong)  NSMutableArray *dataArr;
@property (nonatomic, assign)  BOOL autoSwitch;
@end
static NSString * const cellID = @"cellID";
@implementation NextDayServiceController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.locationManagers startUpdatingLocation];
        [self adjustNavigationUI:self.navigationController];
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        _autoSwitch = 0 != self.tabBarController.selectedIndex;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"我的收货地址"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _menuList = [NSMutableArray array];
    _dataArr = [NSMutableArray array];
     [self requestData:@""];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavWithTitle:@"11"];
    
    [self.view addSubview:self.locView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    ///定位
    self.locationManagers = [[CLLocationManager alloc] init];
    self.locationManagers.delegate = self;
    self.locationManagers.desiredAccuracy = kCLLocationAccuracyBest;//选择定位经精确度
    self.locationManagers.distanceFilter = kCLDistanceFilterNone;
    //授权，定位功能必须得到用户的授权
    [self.locationManagers requestAlwaysAuthorization];
    [self.locationManagers requestWhenInUseAuthorization];
    self.locationManager = [[JFLocation alloc] init];
    _locationManager.delegate = self;
    
    self.magicView.itemScale = 1;
    self.magicView.headerHeight = 45;
    self.magicView.navigationHeight = 64+60;
    self.magicView.againstStatusBar = YES;
    self.magicView.navigationInset = UIEdgeInsetsMake(64+30, 0, 0, 0);
    self.magicView.headerView.backgroundColor = [UIColor whiteColor];
    self.magicView.navigationColor = [UIColor whiteColor];
    self.magicView.layoutStyle = VTLayoutStyleDefault;
    self.magicView.sliderColor = DSColorMake(256, 76, 77);
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self integrateComponents];
    [self configSeparatorView];
    
    [self addNotification];
   
    [self.magicView reloadData];
    [self.view addSubview:self.seclectorView];
    
    __weak typeof(self)weakSelf = self;
    [self.seclectorView setPressUpBlock:^(NSInteger index) {
        weakSelf.seclectorView.hidden = YES;
    }];
    [self.seclectorView setChooseBlock:^(NSInteger index) {
        weakSelf.seclectorView.hidden = YES;
        [weakSelf.magicView reloadDataToPage:index];
    }];
   
}
-(void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    [self.magicView reloadDataToPage:selectedIndex];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_autoSwitch) {
        [self.magicView switchToPage:0 animated:YES];
        _autoSwitch = NO;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(NextSelectorView *)seclectorView{
    if (!_seclectorView) {
        _seclectorView = [[NextSelectorView alloc]init];
        _seclectorView.hidden = YES;
        _seclectorView.frame = CGRectMake(0, 64+45, SCREENWIDTH, 130);
    }
    return _seclectorView;
}
-(HomeLocationView *)locView{
    if (!_locView) {
        _locView = [[HomeLocationView alloc]init];
        _locView.frame = CGRectMake(0, 64, SCREENWIDTH, 45);
        [_locView.searchBtn addTarget:self action:@selector(pressSearch:) forControlEvents:UIControlEventTouchUpInside];
        [_locView.locBtn addTarget:self action:@selector(pressHomeLocation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _locView;
}
- (JFAreaDataManager *)manager {
    if (!_manager) {
        _manager = [JFAreaDataManager shareInstance];
        [_manager areaSqliteDBData];
    }
    return _manager;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return NO;
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
    req.token = @"eyJleHBpcmVUaW1lIjoxNTYxNjI1OTU3ODc0LCJ1c2VySWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI2Iiwib2JqZWN0SWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI1In0=";
    req.userId = @"1009660103519952898";
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.productCategoryId = @"" ;
    req.cityId = @"310100";
    req.cityName = @"上海市";
    req.pageIndex = @"1";
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
            req.token = @"eyJleHBpcmVUaW1lIjoxNTYxNjI1OTU3ODc0LCJ1c2VySWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI2Iiwib2JqZWN0SWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI1In0=";
            req.userId = @"1009660103519952898";
            req.version = @"1.0.0";
            req.platform = @"ios";
            req.userLongitude = @"121.4737";
            req.userLatitude = @"31.23037";
            req.productName = searchText;
            req.cityId = @"310100";
            req.cityName = @"上海市";
            req.pageIndex = @"1";
            req.pageSize = @"10";
            __weak typeof(self)weakself = self;
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
    ChooseAddressViewController *cityViewController = [[ChooseAddressViewController alloc] init];
    [self.navigationController pushViewController:cityViewController animated:YES];
}
#pragma mark - JFCityViewControllerDelegate

- (void)cityName:(NSString *)name {
    
    [_locView.locBtn setTitle:name forState:UIControlStateNormal];
}

#pragma mark --- JFLocationDelegate
//定位中...
- (void)locating {
    NSLog(@"定位中...");
    
}
//定位成功
- (void)currentLocation:(NSDictionary *)locationDictionary {
    NSString *city = [locationDictionary valueForKey:@"City"];
    [_locView.locBtn setTitle:city forState:UIControlStateNormal];
    if (![_locView.locBtn.titleLabel.text isEqualToString:city]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",city] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        __weak typeof(self)weakself = self;
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakself.locView.locBtn.titleLabel.text = city;
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"locationCity"];
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"currentCity"];
            [self.manager cityNumberWithCity:city cityNumber:^(NSString *cityNumber) {
                [KCURRENTCITYINFODEFAULTS setObject:cityNumber forKey:@"cityNumber"];
            }];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

/// 拒绝定位
- (void)refuseToUsePositioningSystem:(NSString *)message {
    NSLog(@"%@",message);
}

/// 定位失败
- (void)locateFailure:(NSString *)message {
    NSLog(@"%@",message);
}
#pragma mark---定位
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *loc = [locations firstObject];
    
    //获得地理位置，把经纬度赋给我们定义的属性
    self.latitude = [NSString stringWithFormat:@"%f", loc.coordinate.latitude];
    self.longitude = [NSString stringWithFormat:@"%f", loc.coordinate.longitude];
    //也可以存入NSUserDefaults，方便在工程中方便获取
    [[NSUserDefaults standardUserDefaults] setValue:self.latitude forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setValue:self.longitude forKey:@"longitude"];
    
    //根据获取的地理位置，获取位置信息
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    __weak typeof(self)weakself = self;
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> *_Nullable placemarks, NSError * _Nullable error) {
        
        for (CLPlacemark *place in placemarks) {
            
            NSLog(@"name,%@",place.name);                      // 位置名
            
            NSLog(@"thoroughfare,%@",place.thoroughfare);      // 街道
            
            NSLog(@"subThoroughfare,%@",place.subThoroughfare);// 子街道
            
            NSLog(@"locality,%@",place.locality);              // 市
            
            NSLog(@"subLocality,%@",place.subLocality);        // 区
            
            NSLog(@"country,%@",place.country);                // 国家
            //            if ([JudgeIDAndBankCardisEmptyOrNull:_gpsCityName]) {
            //                _gpsCityName=@"定位失败";
            //            }
            //            WRITE_DATA(place.locality,@"CITY_JC_NAME");
            //            [self.mytableview reloadData];
            if (weakself.locView.locBtn.titleLabel.text.length<1) {
                [weakself.locView.locBtn setTitle:place.locality forState:UIControlStateNormal];
                [kCurrentCityInfoDefaults setObject:place.locality forKey:@"locationCity"];
            }
            
        }
        
    }];
    NSLog(@"纬度=%f，经度=%f",self.latitude,self.longitude);
    
    [self.locationManagers stopUpdatingLocation];
    
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied)
    {
        //访问被拒绝
        NSLog(@"拒绝访问");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        NSLog(@"无法获取位置信息");
    }
}
#pragma mark - NSNotification
- (void)addNotification {
    [self removeNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarOrientationChange:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)statusBarOrientationChange:(NSNotification *)notification {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
}

#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSMutableArray *titleList = [NSMutableArray array];
    for (MenuInfo *menu in _menuList) {
        [titleList addObject:menu.title];
    }
    return titleList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:RGBCOLOR(69, 69, 69) forState:UIControlStateNormal];
        [menuItem setTitleColor:RGBCOLOR(256, 76, 77) forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
    }
    // 默认会自动完成赋值
    //    MenuInfo *menuInfo = _menuList[itemIndex];
    //    [menuItem setTitle:menuInfo.title forState:UIControlStateNormal];
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    
    static NSString *gridId = @"identifier";
    ZSPageViewController *viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
    if (!viewController) {
        viewController = [[ZSPageViewController alloc] init];
       
    }
    viewController.selectedIndex = pageIndex;
    return viewController;
}

#pragma mark - VTMagicViewDelegate
- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    _selectedIndex = pageIndex;
    StairCategoryRes *model = _dataArr[pageIndex];
    [viewController setSelectedIndex:pageIndex];
    [viewController setModel:model];
}

- (void)magicView:(VTMagicView *)magicView viewDidDisappear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    //    NSLog(@"index:%ld viewDidDisappear:%@", (long)pageIndex, viewController.view);
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex {
    //    NSLog(@"didSelectItemAtIndex:%ld", (long)itemIndex);
}

#pragma mark - actions
- (void)subscribeAction {
    self.seclectorView.hidden = NO;
    
}

#pragma mark - functional methods
- (void)generateTestData {
    NSString *title = @"推荐";
    NSMutableArray *menuList = [[NSMutableArray alloc] initWithCapacity:24];
    [menuList addObject:[MenuInfo menuInfoWithTitl:title]];
    [menuList removeAllObjects];
    for (int index = 0; index < _dataArr.count; index++) {
        StairCategoryRes *model = _dataArr[index];
        MenuInfo *menu = [MenuInfo menuInfoWithTitl:model.productCategoryName];
        [menuList addObject:menu];
    }
    _menuList = menuList;
}

- (void)integrateComponents {
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH-50, 64+40, 50, 40)];
    [rightButton addTarget:self action:@selector(subscribeAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"down_icon"] forState:UIControlStateNormal];
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, -10, 0);
   
    UIButton *btn =  [[UIButton alloc] initWithFrame:CGRectMake(0,0, 50, 40)];
    self.magicView.rightNavigatoinItem = btn;
    [self.magicView.navigationView addSubview:rightButton];
    
}

- (void)configSeparatorView {
    //    UIImageView *separatorView = [[UIImageView alloc] init];
    //    [self.magicView setSeparatorView:separatorView];
    self.magicView.separatorHeight = 2.f;
    self.magicView.separatorColor = RGBCOLOR(256, 76, 77);
    self.magicView.navigationView.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.magicView.navigationView.layer.shadowOffset = CGSizeMake(0, 0.5);
    self.magicView.navigationView.layer.shadowOpacity = 0.8;
    self.magicView.navigationView.clipsToBounds = NO;
    
    
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
    [[NextServiceApi share]requestApplyLoadWithParam:req response:^(id response) {
        if (response) {

                [weakself.dataArr removeAllObjects];
                [weakself.dataArr addObjectsFromArray:response];
            [weakself generateTestData];
            [weakself.magicView reloadMenuTitles];
            [weakself.magicView reloadDataToPage:0];
            [weakself.seclectorView setDataArr:weakself.dataArr];
            weakself.seclectorView.frame = CGRectMake(0, 64+45, SCREENWIDTH, (weakself.dataArr.count/4+1)*35+40);
        }
    }];
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
