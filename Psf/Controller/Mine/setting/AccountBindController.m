//
//  AccountBindController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/2.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "AccountBindController.h"
#import "ChangePasswordController.h"
#import "MineServiceApi.h"
#import "WXApi.h"
#import "LoginServiceApi.h"

@interface AccountBindController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)UILabel *headView;
@property(nonatomic,strong)MineInformationReq *result;
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
//    ,@"更换手机号",@"微信登录",@"QQ登录",@"微博登录"
    _dataArr = @[@"修改密码",@"微信登录"];
    _tableview.tableHeaderView = self.headView;
    [self requestData];
    
    [ZSNotification addWeixinLoginResultNotification:self action:@selector(weChartLgin:)];
}

-(void)weChartLgin:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    if ([[userInfo objectForKey:@"type"] isEqualToString:@"bind"]) {
        [self showInfo:@"绑定成功"];
        [self requestData];
    }
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
    [[MineServiceApi share]getMemberInformationWithParam:req response:^(id response) {
        if (response) {
            weakself.result = [[MineInformationReq alloc]init];
            weakself.result = response;
            [weakself.tableview reloadData];
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
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
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    if (indexPath.row ==1) {
        if (self.result.wechatUnionId.length>0) {
             cell.detailTextLabel.text= @"已绑定";
        }else{
             cell.detailTextLabel.text = @"未绑定";
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        ChangePasswordController *changeVC = [[ChangePasswordController alloc]init];
        [self.navigationController pushViewController:changeVC animated:YES];
    }else if (indexPath.row ==1){
        if (self.result.wechatUnionId.length>0) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"你确定解绑“微信”账号吗？"
                                                                           message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { //响应事件
                LoginReq *req = [[LoginReq alloc]init];
                req.appId = @"993335466657415169";
                req.timestamp = @"529675086";
                req.platform = @"ios";
                req.token = [UserCacheBean share].userInfo.token;
                [[LoginServiceApi share]unbindWXWithParam:req response:^(id response) {
                    if (response) {
                        [self showInfo:@"解绑成功"];
                        [self requestData];
                    }
                }];
                
            }];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {//响应事件
                
                
            }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
      
        
    }else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"”犁小农“想要打开”微信“"
                                                                       message:@"绑定微信后，下次可直接使用该账号登录，免去手机号登录等待验证码的时间，快人一步。" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { //响应事件
            [self sendAuthRequest];
            
        }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {//响应事件
            
            
        }];
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
  }
}
-(void)sendAuthRequest
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc]init];
    req.scope = @"snsapi_userinfo";
    req.state = @"Lxn";
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
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
