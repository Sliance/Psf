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
#import "ZSPageCollectionViewController.h"
#import <MJRefresh.h>
#import "PYSearchViewController.h"
#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "JFCityViewController.h"

#define kCurrentCityInfoDefaults [NSUserDefaults standardUserDefaults]
#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]
static CGFloat const segmentViewHeight = 40.0;
static CGFloat const naviBarHeight = 64.0;
static CGFloat const headViewHeight = 240.0;

NSString *const ZJParentTableViewDidLeaveFromTopNotification = @"ZJParentTableViewDidLeaveFromTopNotification";
@interface ZJCustomGestureTableView : UITableView

@end

@implementation ZJCustomGestureTableView

/// 返回YES同时识别多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}
@end
@interface NextDayServiceController ()<ZJPageViewControllerDelegate,ZJScrollPageViewDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource,PYSearchViewControllerDelegate,JFLocationDelegate, JFCityViewControllerDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) NSArray<NSString *> *titles;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) ZJScrollSegmentView *segmentView;
@property (strong, nonatomic) ZJContentView *contentView;
@property (strong, nonatomic) UIScrollView *childScrollView;
@property(nonatomic,strong)HomeLocationView *locView;
@property (strong, nonatomic) ZJCustomGestureTableView *tableView;
@property (nonatomic, strong) CLLocationManager *locationManagers;//定位管理
/** 城市定位管理器*/
@property (nonatomic, strong) JFLocation *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager *manager;
@property (nonatomic, strong) NSString *latitude;//纬度
@property (nonatomic, strong) NSString *longitude;//经度
@end
static NSString * const cellID = @"cellID";
@implementation NextDayServiceController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.locationManagers startUpdatingLocation];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.sortscrollView];
//    [self.view addSubview:self.cycleScroll];
    [self.view addSubview:self.locView];
    self.title = @"犁小农";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakself = self;
    
    /// 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            typeof(weakself) strongSelf = weakself;
            [strongSelf.tableView.mj_header endRefreshing];
        });
    }];
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
}


-(HomeLocationView *)locView{
    if (!_locView) {
        _locView = [[HomeLocationView alloc]init];
        _locView.frame = CGRectMake(0, self.navHeight, SCREENWIDTH, 45);
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

#pragma ZJScrollPageViewDelegate 代理方法
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (index%2==0) {
        childVc = [[ZSPageCollectionViewController alloc] init];
        ZSPageCollectionViewController *vc = (ZSPageCollectionViewController *)childVc;
        vc.delegate = self;
    } else {
        childVc = [[ZSPageCollectionViewController alloc] init];
        ZSPageCollectionViewController *vc = (ZSPageCollectionViewController *)childVc;
        vc.delegate = self;
        
    }
    
    return childVc;
}

-(CGRect)frameOfChildControllerForContainer:(UIView *)containerView{
    return CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
}
#pragma mark- ZJPageViewControllerDelegate

- (void)scrollViewIsScrolling:(UIScrollView *)scrollView {
    _childScrollView = scrollView;
    if (self.tableView.contentOffset.y < headViewHeight) {
        scrollView.contentOffset = CGPointZero;
        scrollView.showsVerticalScrollIndicator = NO;
    }
    else {
        self.tableView.contentOffset = CGPointMake(0,headViewHeight);
        scrollView.showsVerticalScrollIndicator = YES;
    }
    
}

#pragma mark- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.childScrollView && _childScrollView.contentOffset.y > 0) {
        self.tableView.contentOffset = CGPointMake(0.0f, headViewHeight);
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY < headViewHeight) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ZJParentTableViewDidLeaveFromTopNotification object:nil];

    }
}

#pragma mark- UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView addSubview:self.contentView];
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.segmentView;
}

#pragma mark- setter getter
- (ZJScrollSegmentView *)segmentView {
    if (_segmentView == nil) {
        ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
        style.showCover = NO;
        // 渐变
        style.gradualChangeTitleColor = NO;
        style.showLine = YES;
        style.scrollLineColor = [UIColor colorWithRed:255.0/255.0 green:75/255.0 blue:77/255.0 alpha:1.0];
        // 遮盖背景颜色
        style.coverBackgroundColor = [UIColor whiteColor];
        //标题一般状态颜色 --- 注意一定要使用RGB空间的颜色值
        style.normalTitleColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        //标题选中状态颜色 --- 注意一定要使用RGB空间的颜色值
        style.selectedTitleColor = [UIColor colorWithRed:255.0/255.0 green:75/255.0 blue:77/255.0 alpha:1.0];
        
        self.titles = @[@"推荐",@"周期购",@"蔬菜",@"日百",@"水产",@"乳品",@"肉蛋",@"等等"];
        
        // 注意: 一定要避免循环引用!!
        __weak typeof(self) weakSelf = self;
        ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0,self.navHeight+45, self.view.bounds.size.width, segmentViewHeight) segmentStyle:style delegate:self titles:self.titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
            
            [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:YES];
            
        }];
        segment.backgroundColor = [UIColor whiteColor];
        _segmentView = segment;
        
    }
    return _segmentView;
}

- (ZJContentView *)contentView {
    if (_contentView == nil) {
        ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) segmentView:self.segmentView parentViewController:self delegate:self];
        _contentView = content;
    }
    return _contentView;
}


- (ZJCustomGestureTableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0.0f, self.navHeight+45, self.view.bounds.size.width, SCREENHEIGHT);
        ZJCustomGestureTableView *tableView = [[ZJCustomGestureTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        // 设置tableView的headView
//        tableView.tableFooterView = self.headView;
        tableView.tableFooterView = [UIView new];
        // 设置cell行高为contentView的高度
        tableView.rowHeight = self.contentView.bounds.size.height;
        tableView.delegate = self;
        tableView.dataSource = self;
        // 设置tableView的sectionHeadHeight为segmentViewHeight
        tableView.sectionHeaderHeight = segmentViewHeight;
        tableView.showsVerticalScrollIndicator = false;
        tableView.separatorColor = [UIColor whiteColor];
        _tableView = tableView;
    }

    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return NO;
}

#pragma mark--Action
-(void)pressSearch:(UIButton*)sender{
    NSArray *hotSeaches = @[@"新西兰樱桃", @"妃子笑荔枝", @"金凤凰蜜瓜", @"蜜柚", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    // 2. Create a search view controller
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"请输入商品名称", @"搜索编程语言") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // Called when search begain.
        // eg：Push to a temp view controller
        [searchViewController.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
    }];
    searchViewController.hotSearchStyle = PYHotSearchStyleDefault;
    searchViewController.searchHistoryStyle = 1;
    searchViewController.delegate = self;
    searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowModePush;
    [self.navigationController pushViewController:searchViewController animated:YES];
}
#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"苹果%d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // Refresh and display the search suggustions
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}
///定位
-(void)pressHomeLocation:(UIButton*)sender {
    JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
    cityViewController.delegate = self;
    [self presentViewController:cityViewController animated:YES completion:nil];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
