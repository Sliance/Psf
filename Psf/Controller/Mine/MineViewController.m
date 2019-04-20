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
#import "GroupServiceApi.h"
#import "AfterSalesViewController.h"
#import "OrderServiceApi.h"
#import "ScanQrCodeController.h"
#import "CustomFootView.h"
#import "MembershipCardController.h"
#import "MineCollectController.h"
#import "InviteNewFriendController.h"

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
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}
-(MineHeadView *)headView{
    if (!_headView) {
        _headView = [[MineHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 108)];
    }
    return _headView;
}
-(MineFootView *)footView{
    if (!_footView) {
        _footView = [[MineFootView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 175)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressTap)];
        [_footView.headImage addGestureRecognizer:tap];
    }
    return _footView;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"我的"];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setLeftButtonWithIcon:[UIImage imageNamed:@""]];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    [self setTitle:@"我的"];
    if([UserCacheBean share].userInfo.token.length<1){
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }else{
        if ([[UserCacheBean share].userInfo.token isEqualToString:@"0"]) {
            [UserCacheBean share].userInfo.token = @"";
        }
         [self requestData];
    }
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//     self.navigationController.navigationBar.shadowImage = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        _tableview.contentInsetAdjustmentBehavior = NO;
    } else {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.tableview.frame = CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]-[self tabBarHeight]);
    }
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView = self.headView;
    CustomFootView *footView = [[CustomFootView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 70)];
    self.tableview.tableFooterView = footView;
    self.tableview.separatorColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    [self.headView setSkipBlock:^(NSInteger tag) {
        if([UserCacheBean share].userInfo.token.length<1){
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:loginVC animated:YES];
        }else{
           MineInformationController *infoVC = [[MineInformationController alloc]init];
           infoVC.hidesBottomBarWhenPushed = YES;
           [weakSelf.navigationController pushViewController:infoVC animated:YES];
        }
    }];
    [self.headView setTologinBlock:^{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:loginVC animated:YES];
    }];
    [self.headView setCardBlock:^{
        MembershipCardController *cardVC = [[MembershipCardController alloc]init];
        cardVC.hidesBottomBarWhenPushed = YES;
        [cardVC setErpCustomerNo:weakSelf.result.erpCustomerNo];
        [weakSelf.navigationController pushViewController:cardVC animated:YES];
        
    }];
    [self.footView setSkipMineBlock:^(NSInteger index) {
        if ([UserCacheBean share].userInfo.token.length<1) {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:loginVC animated:YES];
        }else{
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
    }
    }];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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
            weakself.result = response;
            [UserCacheBean share].userInfo.memberMobile = weakself.result.memberMobile;
            [UserCacheBean share].userInfo.roleId = weakself.result.memberRoleType;
            [UserCacheBean share].userInfo.memberNickName = weakself.result.memberNickName;
            [weakself.headView setResult:weakself.result];
            [weakself requestorderData];
            if ([weakself.result.memberRoleType integerValue] ==2) {
                weakself.listArr = @[@"loc_mine",@"qian_mine",@"coupon_mine",@"online_mine",@"collect_mine",@"set_mine"];
                weakself.dataArr = @[@"我的收货地址",@"我的钱包",@"我的优惠券",@"我的客服",@"我的收藏",@"设置"];
            }else{
                weakself.listArr = @[@"loc_mine",@"qian_mine",@"coupon_mine",@"online_mine",@"collect_mine",@"set_mine",@"qr_mine"];
                weakself.dataArr = @[@"我的收货地址",@"我的钱包",@"我的优惠券",@"我的客服",@"我的收藏",@"设置",@"扫码入口"];
            }
            [weakself.tableview reloadData];
        }
    }];
}
-(void)requestorderData{
    UnifiedOrderReq *req = [[UnifiedOrderReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    __weak typeof(self)weakself = self;
    [[OrderServiceApi share]getOrderCountWithParam:req response:^(id response) {
        if (response) {
            NSDictionary *dic = [response firstObject];
                        NSArray *countArr = @[[dic[@"saleOrderUnpayCount"] stringValue],[dic[@"saleOrderUnDeliveryCount"] stringValue] ,[dic[@"saleOrderUnReceivedCount"] stringValue],[dic[@"saleOrderUnevaluateCount"] stringValue],@""];
            
                        [weakself.footView setArr:countArr];
          }
        [weakself getBanner];
    }];
    
}
-(void)getBanner{
    GroupModelReq *req = [[GroupModelReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.cityName = @"上海市";
    req.productBannerPosition = @"my";
    __weak typeof(self)weakself = self;
    [[GroupServiceApi share]getPreAndGroupBannerWithParam:req response:^(id response) {
        if (response!= nil) {
            NSMutableArray*imagArr = [NSMutableArray array];
            [imagArr addObjectsFromArray:response];
            GroupBannerModel *model = [imagArr firstObject];
            NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.productBannerImagePath];
            [weakself.footView.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
            
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
    return 50;
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
        cell.titleLabel.image = [UIImage imageNamed:_listArr[indexPath.row]];
        cell.detailLabel.text = _dataArr[indexPath.row];
    }
    [cell setIndex:indexPath.row];
    cell.detailLabel.textColor = DSColorFromHex(0x464646);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setSection:indexPath.section];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([UserCacheBean share].userInfo.token.length<1) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }else{
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
            case 1:
            {
                MineWalletViewController *walletVC = [[MineWalletViewController alloc]init];
                walletVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:walletVC animated:YES];
            }
                break;

            case 2:
            {
                MyCouponController *couponVC = [[MyCouponController alloc]init];
                couponVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:couponVC animated:YES];
            }
                break;
            case 3:
            {
                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",[UserCacheBean share].userInfo.storeTel];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
                break;
            case 4:
            {
                MineCollectController *walletVC = [[MineCollectController alloc]init];
                walletVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:walletVC animated:YES];
            }
                break;
            case 5:
            {
                SettingViewController *setVC = [[SettingViewController alloc]init];
                setVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:setVC animated:YES];
            }
                break;
            case 6:
            {
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                ScanQrCodeController *qrVC = [story instantiateViewControllerWithIdentifier:@"ScanQrCodeController"];
                qrVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:qrVC animated:YES];
            }
                break;
            default:
                break;
        }
    }
  }
   
}

-(void)pressMinefootBtnWithIndex:(NSInteger)index{
    
}
-(void)pressTap{
    InviteNewFriendController *vc = [[InviteNewFriendController alloc]init];
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
