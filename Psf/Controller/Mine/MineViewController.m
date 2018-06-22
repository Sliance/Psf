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
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *listArr;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)MineHeadView *headView;
@property(nonatomic,strong)MineFootView *footView;
@end

@implementation MineViewController
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-self.navHeight-49) style:UITableViewStylePlain];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    _listArr = @[@"\U0000e906",@"\U0000e915",@"\U0000e92c",@"\U0000e90c",@"\U0000e910"];
    _dataArr = @[@"我的收货地址",@"我的消息",@"我的优惠券",@"我的客服",@"设置"];
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView = self.headView;
    self.tableview.separatorColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    [self.headView setSkipBlock:^(NSInteger tag) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:loginVC animated:YES];
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
