//
//  WaitEvaluateController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/27.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "WaitEvaluateController.h"
#import "OrderDetailViewController.h"
#import "OrderServiceApi.h"
#import "FillEvaluateController.h"
#import "ChooseServiceTypeController.h"
#import "EmptyShoppingHeadView.h"
#import "detailGoodsViewController.h"
#import "CustomFootView.h"

@interface WaitEvaluateController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)EmptyShoppingHeadView *emptyView;
@property(nonatomic,assign)NSInteger pageIndex;

@end

@implementation WaitEvaluateController

-(EmptyShoppingHeadView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[EmptyShoppingHeadView alloc]init];
        _emptyView.headImage.image = [UIImage imageNamed:@"order_nodata"];
        _emptyView.titleLabel.text = @"还没有相关订单哦";
        _emptyView.frame = CGRectMake(0,0, SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]-30);
        _emptyView.hidden = YES;
    }
    return _emptyView;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]-30) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.separatorColor = DSColorFromHex(0xF0F0F0);
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableview;
}
-(void)setOrdertype:(ORDERSTYPE)ordertype{
    _ordertype = 0;
    _ordertype = ordertype;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self.tableview reloadData];
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
    [self.view addSubview:self.emptyView];
   _dataArr = [NSMutableArray array];
   
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.pageIndex = 1;
    [self requestData];
}
-(void)headerRefreshing
{
    self.pageIndex = 1;
    [self requestData];
}
/**
 *  上拉刷新
 */
-(void)footerRefreshing
{
    
    self.pageIndex++;
    [self requestData];
}
-(void)requestData{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.saleOrderStatus = @"3";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.pageIndex = self.pageIndex;
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[OrderServiceApi share]getOrderListWithParam:req response:^(id response) {
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
            
            if (weakself.dataArr.count ==0) {
                weakself.emptyView.hidden = NO;
            }
            if ([response count] < 10) {
                [weakself.tableview.mj_footer removeFromSuperview];
                CustomFootView *footView = [[CustomFootView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 70)];
                self.tableview.tableFooterView = footView;
            }
            else{
                weakself.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:weakself refreshingAction:@selector(footerRefreshing)];
            }
            [weakself.tableview reloadData];
        }
    }];
}
-(void)noticeOrder:(NSString*)saleId{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.saleOrderId = saleId;
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[OrderServiceApi share]noticeOrderWithParam:req response:^(id response) {
        if (response) {
            if ([response[@"code"] integerValue] == 200) {
                [weakself showToast:@"已提醒发货！"];
            }
        }
    }];
    
}
-(void)confirmOrder:(NSString*)orderid{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.saleOrderId = orderid;
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[OrderServiceApi share]confirmOrderWithParam:req response:^(id response) {
        if (response) {
            if ([response[@"code"] integerValue] == 200) {
                [weakself showToast:@"确认收货成功！"];
            }
        }
    }];
    
}
-(void)deleteOrder:(NSString*)orderid{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.saleOrderId = orderid;
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[OrderServiceApi share]deleteOrderWithParam:req response:^(id response) {
        if (response) {
            if ([response[@"code"] integerValue] == 200) {
                [weakself showToast:@"删除订单成功！"];
            }
        }
    }];
}
-(void)againOrder:(NSString*)orderid{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.saleOrderId = orderid;
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[OrderServiceApi share]againOrderWithParam:req response:^(id response) {
        if (response) {
            if ([response[@"code"] integerValue] ==200) {
                if ([response[@"data"][@"productType"] isEqualToString:@"normal"]) {
                    weakself.tabBarController.selectedIndex = 1;
                }else if ([response[@"data"][@"productType"] isEqualToString:@"preSale"]){
                    detailGoodsViewController *detailVC = [[detailGoodsViewController alloc]init];
                    [detailVC setProductID:[response[@"data"][@"productId"] integerValue]];
                    [weakself.navigationController pushViewController:detailVC animated:YES];
                }else if ([response[@"data"][@"productType"] isEqualToString:@"groupon"]){
                    detailGoodsViewController *detailVC = [[detailGoodsViewController alloc]init];
                    [detailVC setProductID:[response[@"data"][@"productId"] integerValue]];
                    [weakself.navigationController pushViewController:detailVC animated:YES];
                }
            }else{
                [weakself showInfo:response[@"code"][@"message"]];
            }
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 202;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"WaitPaymentCell";
    WaitPaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[WaitPaymentCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    OrderListRes *model = self.dataArr[indexPath.row];
    [cell setModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self)weakself = self;
    [cell setPayBlock:^(OrderListRes *model){//付款
        
    }];
    [cell setBuyBlock:^(OrderListRes *model){//再次购买
        [weakself againOrder:model.saleOrderId];
    }];
    [cell setLogisticsBlock:^(OrderListRes *model){//查看物流
        
    }];
    [cell setSureBlock:^(OrderListRes *model){//确认收货
        [weakself confirmOrder:model.saleOrderId];
    }];
    [cell setRefundBlock:^(OrderListRes *model){//退款
        ChooseServiceTypeController *chooseVC = [[ChooseServiceTypeController alloc]init];
        [chooseVC setModel:model];
        [weakself.navigationController pushViewController:chooseVC animated:YES];
    }];
    
    [cell setRemindBlock:^(OrderListRes *model) {//提醒发货
        [weakself noticeOrder:model.saleOrderId];
    }];
    
    [cell setEvaBlock:^(OrderListRes * model) {
        FillEvaluateController *fillVC = [[FillEvaluateController alloc]init];
        [fillVC setModel:model];
        [weakself.navigationController pushViewController:fillVC animated:YES];
    }];
    [cell setDeleteBlock:^(OrderListRes * model) {//删除订单
        [weakself deleteOrder:model.saleOrderId];
    }];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailViewController *detailVC = [[OrderDetailViewController alloc]init];
    detailVC.ordertype = _ordertype;
    OrderListRes *model = self.dataArr[indexPath.row];
    [detailVC setModel:model];
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
