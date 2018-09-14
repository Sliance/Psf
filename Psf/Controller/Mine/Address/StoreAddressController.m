//
//  StoreAddressController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "StoreAddressController.h"
#import "AddressServiceApi.h"
#import "StoreAddressCell.h"
#import "CustomFootView.h"

@interface StoreAddressController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation StoreAddressController
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableview;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"门店地址"];
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
    _dataArr = [NSMutableArray array];
    CustomFootView *footView = [[CustomFootView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 70)];
    self.tableview.tableFooterView = footView;
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
                weakself.storeBlock(model);
            [weakself.navigationController popViewControllerAnimated:YES];
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
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"identify";
    StoreAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[StoreAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = DSColorFromHex(0x464646);
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    StoreRes *model = _dataArr[indexPath.row];
    [cell setIndex:indexPath.row];
    [cell setModel:model];
     __weak typeof(self)weakself = self;
    [cell setSelectedBlock:^(StoreRes * model) {
        model.memberStoreIsDefault = YES;
        [weakself updateAddress:model];
    }];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreRes *model = _dataArr[indexPath.row];
    model.memberStoreIsDefault = 1;
    [self updateAddress:model];
    
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
