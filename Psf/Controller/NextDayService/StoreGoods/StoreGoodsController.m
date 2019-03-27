//
//  StoreGoodsController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/25.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "StoreGoodsController.h"
#import "SortLeftScrollow.h"
#import "PYSearchViewController.h"
#import "StoreGoodsCell.h"
#import "HomeLocationView.h"
#import "GroupServiceApi.h"
#import "ZSSortSelectorView.h"
#import "NextSelectorView.h"
#import "NextServiceApi.h"
#import "detailGoodsViewController.h"
#import "StoreGoodsBuyView.h"
#import "ShopServiceApi.h"

@interface StoreGoodsController ()<SortLeftScrollowDelegate,PYSearchViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,ZSSortSelectorViewDelegate>
@property(nonatomic,strong)SortLeftScrollow *sortLeftView;
@property(nonatomic,strong)NSMutableArray *sortArr;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)HomeLocationView *locView;
@property(nonatomic,strong)ZSSortSelectorView *selectorView;
@property(nonatomic,strong)NextSelectorView *selShowView;
@property(nonatomic,strong)StoreGoodsBuyView *storeBuyView;
@end

@implementation StoreGoodsController
-(ZSSortSelectorView *)selectorView{
    if (!_selectorView) {
        _selectorView = [[ZSSortSelectorView alloc]initWithFrame:CGRectMake(75,  [self navHeightWithHeight]+45, SCREENWIDTH-75, 40)];
        _selectorView.delegate = self;
        [_selectorView setIsShow:NO];
    }
    return _selectorView;
}
-(SortLeftScrollow *)sortLeftView{
    if (!_sortLeftView) {
        _sortLeftView = [[SortLeftScrollow alloc]initWithFrame:CGRectMake(0, [self navHeightWithHeight]+45, 75, SCREENHEIGHT-[self tabBarHeight]-45)];
        _sortLeftView.delegate = self;
    }
    return _sortLeftView;
}
-(HomeLocationView *)locView{
    if (!_locView) {
        _locView = [[HomeLocationView alloc]init];
       [_locView.searchBtn addTarget:self action:@selector(pressSearch:) forControlEvents:UIControlEventTouchUpInside];
        _locView.frame = CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, 45);
        [_locView setStore:@"store"];
    }
    return _locView;
}
-(NextSelectorView *)selShowView{
    if (!_selShowView) {
        _selShowView = [[NextSelectorView alloc]init];
        _selShowView.hidden = YES;
        _selShowView.frame = CGRectMake(75, [self navHeightWithHeight]+85, SCREENWIDTH-75, 130);
    }
    return _selShowView;
}
-(StoreGoodsBuyView *)storeBuyView{
    if (!_storeBuyView) {
        _storeBuyView = [[StoreGoodsBuyView alloc]init];
        _storeBuyView.hidden = YES;
        _storeBuyView.frame = CGRectMake(0,0, SCREENWIDTH, SCREENHEIGHT);
        
        [_storeBuyView setHeight:[self tabBarHeight]];
    }
    return _storeBuyView;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(75, [self navHeightWithHeight]+85, SCREENWIDTH-75, SCREENHEIGHT-85-[self navHeightWithHeight]) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorColor = [UIColor clearColor];
    }
    return _tableview;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        
        [self setTitle:@"门店商品"];
    
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.sortLeftView];
    [self.view addSubview:self.locView];
    [self.view addSubview:self.selectorView];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.selShowView];
    [self.view addSubview:self.storeBuyView];
    _sortArr = [NSMutableArray array];
    _dataArr = [NSMutableArray array];
    
    __weak typeof(self)weakself = self;
    [self.selectorView setSelectedBlock:^(BOOL selected) {
        if (selected ==YES) {
            weakself.selShowView.hidden = NO;
        }else{
            weakself.selShowView.hidden = YES;
        }
    }];
    [self.selShowView setChooseBlock:^(NSInteger index) {
        
        weakself.selShowView.hidden = YES;
        weakself.selectorView.rightBtn.selected = NO;
        weakself.selectorView.currentPage = index;
        weakself.tableview.contentOffset = CGPointMake(0, index*115*5+index*24);
    }];
    [self.storeBuyView setTapBlock:^{
        weakself.storeBuyView.hidden = YES;
    }];
    [self.storeBuyView setSubmitBlock:^(NSString *weight, GoodDetailRes *detailmodel, StairCategoryListRes *resmodel) {
        if ([weight doubleValue]<[[UserCacheBean share].userInfo.productDefaultWeight doubleValue]) {
            [weakself showInfo:[NSString stringWithFormat:@"重量不能低于%@",[UserCacheBean share].userInfo.productDefaultWeight]];
            return ;
        }
        weakself.storeBuyView.hidden = YES;
        [weakself addShopCount:resmodel Quantity:weight];
    }];
    
   
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_type.length>0){
        UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStyleDone target:self action:@selector(didLeftClick)];
        [self.navigationItem setLeftBarButtonItem:leftBar];
    }else{
        UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStyleDone target:self action:@selector(didLeftClick)];
        [self.navigationItem setLeftBarButtonItem:leftBar];
    }
     [self requestSort];
}
-(void)setType:(NSString *)type{
    _type = type;
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStyleDone target:self action:@selector(didLeftClick)];
    [self.navigationItem setLeftBarButtonItem:leftBar];
}
-(void)addShopCount:(StairCategoryListRes *)model  Quantity:(NSString*)quantity{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.couponType = @"allProduct";
    req.saleOrderStatus = @"0";
    req.userLongitude = [UserCacheBean share].userInfo.longitude;
    req.userLatitude = [UserCacheBean share].userInfo.latitude;
    req.productId = model.productId;
    req.pageIndex = 1;
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    req.productSkuId = @"";
    req.productQuantity = quantity;
    req.productType = @"normal";
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]addShopCartCountWithParam:req response:^(id response) {
        
        if (response!= nil) {
            [weakself showInfo:response[@"message"]];
        }
       
    }];
}
-(void)requestSort{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    __weak typeof(self)weakself = self;
    [[GroupServiceApi share]getStoreSortWithParam:req response:^(id response) {
        if (response) {
            [weakself.sortArr removeAllObjects];
            [weakself.sortArr addObjectsFromArray:response];
            [weakself.sortLeftView setDataArr:weakself.sortArr];

            StairCategoryRes *model = [response firstObject];
            [weakself requestGoodList:model.productCategoryId];
        }
    }];
}

-(void)requestGoodList:(NSString*)parentId{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.cityName = @"上海市";
    req.productCategoryId = parentId;
    __weak typeof(self)weakself = self;
    [[GroupServiceApi share]StoreGoodListWithParam:req response:^(id response) {
        if (response) {
            [weakself.dataArr removeAllObjects];
            [weakself.dataArr addObjectsFromArray:response];
            [weakself.selectorView setDataArr:weakself.dataArr];
            [weakself.selShowView setDataArr:weakself.dataArr];
            weakself.selShowView.frame = CGRectMake(75, [self navHeightWithHeight]+85, SCREENWIDTH-75, weakself.dataArr.count/3*35+35);
            [weakself.tableview reloadData];
        }
    }];
}
#pragma mark--SortLeftScrollowDelegate
-(void)selectedSortIndex:(NSInteger)index{
    StairCategoryRes *model =_sortArr[index];
    [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self requestGoodList:model.productCategoryId];
    
}
-(void)chooseButtonType:(NSInteger)type{
//    self.tableview.contentOffset = CGPointMake(0, type*115*5+type*24);
    [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:type] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self.selShowView setCurrentPage:type];
    self.selShowView.hidden = YES;
    self.selectorView.rightBtn.selected = NO;
}
    
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    StairCategoryRes *model = _dataArr[section];
    return model.productList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 24;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-75, 24)];
    headView.backgroundColor = [UIColor whiteColor];
    for (UIView *views in headView.subviews) {
        if ([views isKindOfClass:[UILabel class]]) {
            [views removeFromSuperview];
        }
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREENWIDTH-95, 24)];
    label.backgroundColor = DSColorFromHex(0xFAFAFA);
    StairCategoryRes *model = _dataArr[section];
    label.text = [NSString stringWithFormat:@"   %@",model.productCategoryName];
    label.textColor = DSColorFromHex(0xA3A3A3);
    label.font = [UIFont systemFontOfSize:12];
    
    [headView addSubview:label];
   
    return headView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"StoreGoodsCell";
    StoreGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[StoreGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    StairCategoryRes *model = _dataArr[indexPath.section];
    StairCategoryListRes *res = model.productList[indexPath.row];
    [cell setModel:res];
    __weak typeof(self)weakself = self;
    [cell setAddBlock:^(StairCategoryListRes *model) {
        if ([UserCacheBean share].userInfo.token.length>0) {
            if (model.productStyle==1) {
                [weakself.storeBuyView setCatemodel:model];
                weakself.storeBuyView.countField.text = [UserCacheBean share].userInfo.productDefaultWeight;
                //            weakself.storeBuyView.hidden = NO;
                double price = [model.productPrice doubleValue]*[[UserCacheBean share].userInfo.productDefaultWeight doubleValue];
                model.productPrice = [NSString stringWithFormat:@"%.2f",price];
                [weakself addShopCount:model Quantity:@"1"];
            }else{
                [weakself addShopCount:model Quantity:@"1"];
            }
        }else{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"请您先登录"
                                                                           message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { //响应事件
                weakself.tabBarController.selectedIndex = 4;
            }];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {//响应事件
                
                
            }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [weakself presentViewController:alert animated:YES completion:nil];
        }
        
    }];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    detailGoodsViewController *vc = [[detailGoodsViewController alloc]init];
    StairCategoryRes *model = _dataArr[indexPath.section];
    StairCategoryListRes *res = model.productList[indexPath.row];
    [vc setErpProductId:res.erpProductId];
    [vc setProductID:res.productId];
    vc.hidesBottomBarWhenPushed = YES;
     [vc setProductType:@"normal"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGPoint point = scrollView.contentOffset;
//
//        NSInteger index = point.y/(115*5+24);
//        self.selectorView.currentPage = index;
//        self.selShowView.currentPage = index;
    
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
    req.hotType = @"search";
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
