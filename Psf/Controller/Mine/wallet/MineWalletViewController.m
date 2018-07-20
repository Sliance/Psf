//
//  MineWalletViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/2.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MineWalletViewController.h"
#import "MineWalletCell.h"
#import "TradingDetailController.h"
#import "RechargeViewController.h"
#import "MyIntegralController.h"
#import "MineServiceApi.h"

@interface MineWalletViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIButton *detailBtn;

@end

@implementation MineWalletViewController
-(UIButton *)detailBtn{
    if (!_detailBtn) {
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailBtn setTitle:@"交易明细" forState:UIControlStateNormal];
        [_detailBtn setTitleColor:DSColorFromHex(0x969696) forState:UIControlStateNormal];
        _detailBtn.backgroundColor = DSColorFromHex(0xF0F0F0);
        _detailBtn.frame = CGRectMake(0, 0, SCREENWIDTH, 30);
        [_detailBtn addTarget:self action:@selector(pressDetail:) forControlEvents:UIControlEventTouchUpInside];
        _detailBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _detailBtn;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-69) style:UITableViewStylePlain];
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
    }
    return _tableview;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"我的钱包"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.tableFooterView = self.detailBtn;
     [self.view addSubview:self.tableview];
    [self requestData];
}

-(void)requestData{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    
    req.token = @"eyJleHBpcmVUaW1lIjoxNTYxNjI1OTU3ODc0LCJ1c2VySWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI2Iiwib2JqZWN0SWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI1In0=";
    req.userId = @"1009660103519952898";
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]getMemberBalanceWithParam:req response:^(id response) {
        
    }];
}
-(void)pressDetail:(UIButton*)sender{
    TradingDetailController *detailVC = [[TradingDetailController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 122;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"MineWalletCell";
    MineWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[MineWalletCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (indexPath.row ==1) {
        cell.titleLabel.text = @"积分";
        cell.contentLabel.text = @"满额积分自动抵扣现金";
        cell.priceLabel.text = @"200";
        cell.rechargeBtn.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    __weak typeof(self)weakSelf = self;
    [cell setChargeBlock:^(NSInteger index) {
        RechargeViewController *rechargeVC = [[RechargeViewController alloc]init];
        [weakSelf.navigationController pushViewController:rechargeVC animated:YES];
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==1) {
        MyIntegralController *myVC = [[MyIntegralController alloc]init];
        [self.navigationController pushViewController:myVC animated:YES];
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
