//
//  MineViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/14.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "MineHeadView.h"
#import "MineFootView.h"
#import "LoginViewController.h"
#import "MyReceiveAddressController.h"
#import "MessageCenterController.h"
#import "MyCouponController.h"
#import "SettingViewController.h"
#import "MineInformationController.h"
#import "BaseOrdersController.h"
#import "MineWalletViewController.h"
#import "ChooseServiceTypeController.h"
#import "MineServiceApi.h"
#import "AfterSalesViewController.h"
#import "OrderServiceApi.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *listArr;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)MineHeadView *headView;
@property(nonatomic,strong)MineFootView *footView;

@property(nonatomic,strong)MineInformationReq *result;
@end

@implementation MineViewController
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc]init];
        
    }
    return _tableview;
}
-(MineHeadView *)headView{
    if (!_headView) {
        _headView = [[MineHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 167)];
    }
    return _headView;
}
-(MineFootView *)footView{
    if (!_footView) {
        _footView = [[MineFootView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 175)];
        
    }
    return _footView;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"我的"];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    [self setNavWithTitle:@"我的"];
    if([UserCacheBean share].userInfo.token.length<1){
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self showViewController:loginVC sender:nil];
    }else{
         [self requestData];
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//     self.navigationController.navigationBar.shadowImage = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _listArr = @[@"\U0000e907",@"\U0000e905",@"\U0000e90b",@"\U0000e906",@"\U0000e909",@"\U0000e908"];
    _dataArr = @[@"我的收货地址",@"我的钱包",@"我的消息",@"我的优惠券",@"我的客服",@"设置"];
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView = self.headView;
    self.tableview.separatorColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    [self.headView setSkipBlock:^(NSInteger tag) {
        MineInformationController *infoVC = [[MineInformationController alloc]init];
        infoVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:infoVC animated:YES];
    }];
    [self.footView setSkipMineBlock:^(NSInteger index) {
        if (index ==5) {
            AfterSalesViewController *chooseVC = [[AfterSalesViewController alloc]init];
            chooseVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:chooseVC animated:YES];
        }else{
            BaseOrdersController *orderVC = [[BaseOrdersController alloc]init];
            orderVC.hidesBottomBarWhenPushed = YES;
            [orderVC setSelectedIndex:index];
            [weakSelf.navigationController pushViewController:orderVC animated:YES];
        }
    }];
    
}

-(void)requestData{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    self.result = [[MineInformationReq alloc]init];
    [[MineServiceApi share]getMemberInformationWithParam:req response:^(id response) {
        if (response) {
            self.result = response;
            [UserCacheBean share].userInfo.memberMobile = self.result.memberMobile;
            [weakself.headView setResult:self.result];
            [weakself requestorderData];
        }
    }];
}
-(void)requestorderData{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.saleOrderStatus = @"";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.pageIndex = @"1";
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[OrderServiceApi share]getOrderListWithParam:req response:^(id response) {
        if (response!= nil) {
            NSMutableArray *payArr = [NSMutableArray array];
            NSMutableArray *deliverArr = [NSMutableArray array];
            NSMutableArray *receliveArr = [NSMutableArray array];
            NSMutableArray *evaArr = [NSMutableArray array];
            NSMutableArray *afterArr = [NSMutableArray array];
            for (OrderListRes *model in response) {
                if (model.saleOrderStatus ==0) {
                    [payArr addObject:model];
                }else if (model.saleOrderStatus ==1){
                    [deliverArr addObject:model];
                }else if (model.saleOrderStatus ==2){
                    [receliveArr addObject:model];
                }else if (model.saleOrderStatus ==3){
                    [evaArr addObject:model];
                }else if (model.saleOrderStatus ==4){
                    [afterArr addObject:model];
                }
            }
            
            NSArray *countArr = @[[NSString stringWithFormat:@"%ld",payArr.count],[NSString stringWithFormat:@"%ld",deliverArr.count],[NSString stringWithFormat:@"%ld",receliveArr.count],[NSString stringWithFormat:@"%ld",evaArr.count],[NSString stringWithFormat:@"%ld",afterArr.count]];
            
            [self.footView setArr:countArr];
           
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }
    return _listArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 0;
    }
    return 175;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section ==1) {
        if (!_footView) {
            _footView = [[MineFootView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 175)];
        }
    }
   
    return _footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"identify";
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[MineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (indexPath.section ==0) {
        cell.detailLabel.text = @"全部订单";
    }else{
        cell.titleLabel.text = _listArr[indexPath.row];
        cell.titleLabel.textColor = DSColorFromHex(0x969696);
        cell.detailLabel.text = _dataArr[indexPath.row];
    }
   
    cell.detailLabel.textColor = DSColorFromHex(0x464646);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setSection:indexPath.section];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        BaseOrdersController *baseOrderVC = [[BaseOrdersController alloc]init];
        baseOrderVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:baseOrderVC animated:YES];
        
    }else if (indexPath.section ==1) {
        switch (indexPath.row) {
            case 0:
                {
                    MyReceiveAddressController *addressVC = [[MyReceiveAddressController alloc]init];
                    addressVC.hidesBottomBarWhenPushed = YES;
                    addressVC.type = ADDRESSTYPEMine;
                    [self.navigationController pushViewController:addressVC animated:YES];
                }
                break;
            case 2:
            {
                MessageCenterController *messageVC = [[MessageCenterController alloc]init];
                messageVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:messageVC animated:YES];
            }
                break;
            case 3:
            {
                MyCouponController *couponVC = [[MyCouponController alloc]init];
                couponVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:couponVC animated:YES];
            }
                break;
            case 4:
            {
            }
                break;
            case 5:
            {
                SettingViewController *setVC = [[SettingViewController alloc]init];
                setVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:setVC animated:YES];
            }
                break;
            case 1:
            {
                MineWalletViewController *walletVC = [[MineWalletViewController alloc]init];
                walletVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:walletVC animated:YES];
            }
                break;
            default:
                break;
        }
    }
   
}
-(void)pressMinefootBtnWithIndex:(NSInteger)index{
    
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
