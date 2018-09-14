//
//  ChooseAddressViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/25.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ChooseAddressViewController.h"
#import "ChooseCityHeadView.h"
#import "ChooseAddressTableViewCell.h"
#import "BottomView.h"
#import "AddressServiceApi.h"
#import "MineAddressCell.h"
#import "EditAddressController.h"
#import "StoreAddressCell.h"

@interface ChooseAddressViewController ()<UITableViewDelegate,UITableViewDataSource,MineAddressCellDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)ChooseCityHeadView *chooseView;
@property(nonatomic,strong)BottomView *bottomView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation ChooseAddressViewController
-(ChooseCityHeadView *)chooseView{
    if (!_chooseView) {
        _chooseView = [[ChooseCityHeadView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 46)];
    }
    return _chooseView;
}
-(BottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[BottomView alloc]init];
        _bottomView.frame = CGRectMake(0, SCREENHEIGHT-[self tabBarHeight], SCREENWIDTH, [self tabBarHeight]);
        [_bottomView.bottomBtn setTitle:@"+ 新建地址" forState:UIControlStateNormal];
        [_bottomView.bottomBtn addTarget:self action:@selector(pressBottom:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]) style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
//        _tableview.separatorColor = [UIColor whiteColor];
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableview;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"选择门店地址"];
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
//    [self.view addSubview:self.bottomView];
     [self setTextFieldLeftView:self.chooseView.searchField :@"search_icon":20];
    [self.view addSubview:self.tableview];
//     [self.view addSubview:self.chooseView];
    self.dataArr = [NSMutableArray array];
    [self setLeftButtonWithIcon:[UIImage imageNamed:@"icon_back"]];
   
  
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestAddressList];
}
-(void)requestAddressList{
    AddressBaeReq *req = [[AddressBaeReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.userLongitude = [UserCacheBean share].userInfo.longitude;
    req.userLatitude = [UserCacheBean share].userInfo.latitude;
    req.token = [UserCacheBean share].userInfo.token;
    req.systemVersion = @"1.0.0";
    req.platform = @"ios";
    __weak typeof(self)weakself = self;
    [[AddressServiceApi share]pickUpAddresListWithParam:req response:^(id response) {
        if (response!= nil) {
            [weakself.dataArr removeAllObjects];
            [weakself.dataArr addObjectsFromArray:response];
            [weakself.tableview reloadData];
        }
    }];
}
-(void)updateAddress:(StoreRes*)model{
    AddressBaeReq *req = [[AddressBaeReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.userLongitude = [UserCacheBean share].userInfo.longitude;
    req.userLatitude = [UserCacheBean share].userInfo.latitude;
    req.token = [UserCacheBean share].userInfo.token;
    req.systemVersion = @"1.0.0";
    req.platform = @"ios";
    req.storeId = model.storeId;
    __weak typeof(self)weakself = self;
    [[AddressServiceApi share]updateStoreAddresWithParam:req response:^(id response) {
        if([response[@"code"] integerValue]==200){
             NSString *address = model.storeName;
            [UserCacheBean share].userInfo.erpStoreId = model.erpStoreId;
             [ZSNotification postLocationResultNotification:@{@"address":address}];
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==1) {
        return self.dataArr.count;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 5;
    }
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    if (section ==0) {
         view.frame = CGRectMake(0, 0, SCREENWIDTH, 5);
        return view;
    }else{
        view.frame = CGRectMake(0, 0, SCREENWIDTH, 20);
        UILabel *titleLabel =  [[UILabel alloc]init];
        titleLabel.frame = CGRectMake(15, 0, SCREENWIDTH, 10);
        titleLabel.textColor = DSColorFromHex(0x464646);
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.text = @"门店地址";
        [view addSubview:titleLabel];
    }
   
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1){
        return 70;
        
    }
    return 44;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section ==1){
        return @"门店地址";
    }
  return @"";
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        
        static NSString *identify = @"identify";
        StoreAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[StoreAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = DSColorFromHex(0x464646);
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        StoreRes *model = _dataArr[indexPath.row];
//        if (indexPath.row) {
//            [cell setIndex:indexPath.row];
//        }
        [cell setModel:model];
        __weak typeof(self)weakself = self;
        [cell setSelectedBlock:^(StoreRes * model) {
            model.memberStoreIsDefault = YES;
            [weakself updateAddress:model];
        }];
        return cell;
    }
    static NSString *identify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (indexPath.section ==0) {
        if ([UserCacheBean share].userInfo.area.length>0) {
             cell.textLabel.text = [NSString stringWithFormat:@"当前：%@%@",[UserCacheBean share].userInfo.area,[UserCacheBean share].userInfo.address];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = DSColorFromHex(0x464646);
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        StoreRes *model = _dataArr[indexPath.row];
       
        [self updateAddress:model];
       
    }
}
-(void)changeAddress:(ChangeAddressReq*)req{
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.memberAddressIsDefault = YES;
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    [[AddressServiceApi share]updateAddressWithParam:req response:^(id response) {
        if ([response[@"code"] integerValue] == 200) {
//            [self showToast:response[@"message"]];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
//            [self showToast:response[@"message"]];
        }
    }];
}
-(void)editAddressIndex:(NSInteger)index{
    EditAddressController *editVC = [[EditAddressController alloc]init];
    ChangeAddressReq *model = _dataArr[index];
    [editVC setChangeReq:model];
    [editVC setType:1];
    [self.navigationController pushViewController:editVC animated:YES];
}
-(void)pressBottom:(UIButton*)sender{
    EditAddressController *editVC = [[EditAddressController alloc]init];
    [editVC setType:0];
    [self.navigationController pushViewController:editVC animated:YES];
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
