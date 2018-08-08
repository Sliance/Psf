//
//  SettingViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/26.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutViewController.h"
#import "AccountBindController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)UIButton *loginOutBtn;


@end

@implementation SettingViewController
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
-(UIButton *)loginOutBtn{
    if (!_loginOutBtn) {
        _loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        _loginOutBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _loginOutBtn.frame = CGRectMake(0, 0, SCREENWIDTH, 45);
        _loginOutBtn.backgroundColor =[UIColor whiteColor];
        [_loginOutBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_loginOutBtn addTarget:self action:@selector(pressLogionOut) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginOutBtn;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"设置"];
        self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    _dataArr = @[@"清除缓存",@"意见反馈",@"关于我们",@"分享应用"];
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
    footView.backgroundColor = DSColorFromHex(0xF0F0F0);
    [footView addSubview:self.loginOutBtn];
    _tableview.tableFooterView = footView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 10;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = DSColorFromHex(0xF0F0F0);
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = DSColorFromHex(0xF0F0F0);
    return view;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    if (indexPath.row ==0&&indexPath.section ==1) {
        cell.detailTextLabel.text = @"0.0M";
        cell.detailTextLabel.textColor = DSColorFromHex(0x979797);
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
         cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
       cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = DSColorFromHex(0x454545);
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    if (indexPath.section==1) {
        cell.textLabel.text = _dataArr[indexPath.row];
    }else if (indexPath.section ==0){
        cell.textLabel.text = @"账号/绑定设置";
    }
    

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==2&&indexPath.section ==1) {
        AboutViewController *aboutVC = [[AboutViewController alloc]init];
        [self.navigationController pushViewController:aboutVC animated:YES];
        
    }else if (indexPath.section ==0){
        AccountBindController *bindVC = [[AccountBindController alloc]init];
        [self.navigationController pushViewController:bindVC animated:YES];
    }
}
-(void)pressLogionOut{
    [[UserCacheBean share]loginOut];
    [self.navigationController popViewControllerAnimated:YES];
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
