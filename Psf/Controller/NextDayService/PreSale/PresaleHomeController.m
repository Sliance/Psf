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

@interface PresaleHomeController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)HomeLocationView *locView;
@end

@implementation PresaleHomeController
-(HomeLocationView *)locView{
    if (!_locView) {
        _locView = [[HomeLocationView alloc]init];
        _locView.frame = CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, 45);
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
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, [self navHeightWithHeight]+45, SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]-45) style:UITableViewStylePlain];
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
        _tableview.separatorColor = [UIColor whiteColor];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
    }
    return _tableview;
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
    req.pageIndex = @"1";
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[GroupServiceApi share]getPresaleListWithParam:req response:^(id response) {
        if (response!= nil) {
            [weakself.dataArr removeAllObjects];
            [weakself.dataArr addObjectsFromArray:response];
            [weakself getBanner:@"preSale"];
            [weakself.tableview reloadData];
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
            NSMutableArray*imagArr = [NSMutableArray array];
            [imagArr addObjectsFromArray:response];
            GroupBannerModel *model = [imagArr firstObject];
            NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.productBannerImagePath];
            [weakself.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
            
        }
    }];
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self setNavWithTitle:@"犁小农"];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
//     [self adjustNavigationUI:self.navigationController];
    [self setLeftButtonWithIcon:[UIImage imageNamed:@""]];
    _dataArr = [NSMutableArray array];
    [self getPresaleList];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    self.navigationController.navigationBar.shadowImage = nil;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.locView];
    self.tableview.tableHeaderView = self.headImage;
    
    [ZSNotification addLocationResultNotification:self action:@selector(location:)];
}
-(void)location:(NSNotification *)notifi{
    NSDictionary *userInfo = [notifi userInfo];
     [_locView.locBtn setTitle:[userInfo objectForKey:@"address"] forState:UIControlStateNormal];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 146;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"GroupTableViewCell";
    PreSaleListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[PreSaleListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    GroupListRes *model = _dataArr[indexPath.row];
    [cell setModel:model];
    __weak typeof(self)weakSelf = self;
    [cell setPressAddBlock:^(NSInteger index) {
        detailGoodsViewController *detailVC = [[detailGoodsViewController alloc]init];
        GroupListRes *model = weakSelf.dataArr[indexPath.row];
        [detailVC setProductID:model.productId];
        detailVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    detailGoodsViewController *detailVC = [[detailGoodsViewController alloc]init];
    GroupListRes *model = _dataArr[indexPath.row];
    [detailVC setProductID:model.productId];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
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
            req.token = [UserCacheBean share].userInfo.token;
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
//    [self showToast:@"目前仅支持上海区域"];
        ChooseAddressViewController *cityViewController = [[ChooseAddressViewController alloc] init];
        cityViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cityViewController animated:YES];
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
