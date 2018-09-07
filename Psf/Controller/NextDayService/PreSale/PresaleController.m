//
//  PresaleController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/31.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "PresaleController.h"
#import "GroupServiceApi.h"
#import "PreSaleListCell.h"
#import "detailGoodsViewController.h"
#import "CustomFootView.h"
@interface PresaleController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)NSInteger pageIndex;

@end

@implementation PresaleController

-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.frame = CGRectMake(0, 0, SCREENWIDTH, 200*SCREENWIDTH/375);
    }
    return _headImage;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
        _tableview.separatorColor = [UIColor whiteColor];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
    }
    return _tableview;
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
                [weakself.tableview.mj_header endRefreshing];
            }else{
                [weakself.dataArr addObjectsFromArray:response];
                [weakself.tableview.mj_header endRefreshing];
                [weakself.tableview.mj_footer endRefreshing];
            }
            
            
            if ([response count] < 10) {
                [weakself.tableview.mj_footer removeFromSuperview];
                CustomFootView *footView = [[CustomFootView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 70)];
                self.tableview.tableFooterView = footView;
            }
            else{
                weakself.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:weakself refreshingAction:@selector(footerRefreshing)];
            }
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
        
            [self setTitle:@"预售商品"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        _tableview.contentInsetAdjustmentBehavior = NO;
    } else {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView = self.headImage;
    self.tableview.tableFooterView = [[UIView alloc]init];
    _dataArr = [NSMutableArray array];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    CustomFootView *footView = [[CustomFootView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 70)];
    self.tableview.tableFooterView = footView;
    self.pageIndex = 1;
     [self getPresaleList];
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
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    detailGoodsViewController *detailVC = [[detailGoodsViewController alloc]init];
    GroupListRes *model = _dataArr[indexPath.row];
    [detailVC setProductID:model.productId];
    [self.navigationController pushViewController:detailVC animated:YES];
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
