//
//  AccountBindController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/2.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "AccountBindController.h"
#import "ChangePasswordController.h"

@interface AccountBindController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)UILabel *headView;
@end

@implementation AccountBindController

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
-(UILabel *)headView{
    if (!_headView) {
        _headView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 65)];
        _headView.font = [UIFont systemFontOfSize:18];
        _headView.textColor = DSColorFromHex(0x474747);
        _headView.backgroundColor = [UIColor whiteColor];
        _headView.text = [NSString stringWithFormat:@"   %@",[UserCacheBean share].userInfo.memberMobile];
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(15, 64, SCREENWIDTH-15, 0.5)];
        line.backgroundColor = DSColorFromHex(0xF0F0F0);
        [_headView addSubview:line];
    }
    return _headView;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"设置"];
        self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
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
    _dataArr = @[@"修改密码",@"更换手机号",@"微信登录",@"QQ登录",@"微博登录"];
    _tableview.tableHeaderView = self.headView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 65;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
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
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = DSColorFromHex(0x454545);
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        ChangePasswordController *changeVC = [[ChangePasswordController alloc]init];
        [self.navigationController pushViewController:changeVC animated:YES];
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
