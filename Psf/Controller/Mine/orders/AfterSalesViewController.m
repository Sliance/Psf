//
//  AfterSalesViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/27.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "AfterSalesViewController.h"
#import "OrderDetailViewController.h"
#import "OrderServiceApi.h"
#import "FillEvaluateController.h"
#import "ChooseServiceTypeController.h"
@interface AfterSalesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation AfterSalesViewController


-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.separatorColor = DSColorFromHex(0xF0F0F0);
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableview;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self setNavWithTitle:@"售后服务"]; 
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    
    _dataArr = [NSMutableArray array];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}

-(void)requestData{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.saleOrderStatus = @"4";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.pageIndex = @"1";
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[OrderServiceApi share]getOrderListWithParam:req response:^(id response) {
        if (response!= nil) {
            [weakself.dataArr removeAllObjects];
            [weakself.dataArr addObjectsFromArray:response];
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
                [weakself showToast:@"确认发货成功！"];
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
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
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
        OrderDetailViewController *detailVC = [[OrderDetailViewController alloc]init];
        [detailVC setModel:model];
        [self.navigationController pushViewController:detailVC animated:YES];
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
